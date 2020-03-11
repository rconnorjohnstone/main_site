{-# LANGUAGE DeriveDataTypeable         #-}
{-# LANGUAGE FlexibleContexts           #-}
{-# LANGUAGE GADTs                      #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE QuasiQuotes       #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE ViewPatterns #-}
{-# LANGUAGE ExplicitForAll #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE InstanceSigs #-}

module Foundation where

import Network.HaskellNet.Auth
import Network.HaskellNet.SMTP
import qualified Network.HaskellNet.SMTP.SSL as SSL
import System.Environment
import qualified Yesod.Auth.Message       as Msg
import Control.Applicative      ((<$>), (<*>))
import Control.Monad            (join)
import Data.Maybe               (isJust)
import Data.Text                (Text)
import Database.Persist.Sqlite
import Yesod
import Yesod.Auth
import Import.NoFoundation hiding (unpack)
import Database.Persist.Sql (ConnectionPool, runSqlPool, fromSqlKey)
import Text.Hamlet          (hamletFile)
import Text.Jasmine         (minifym)
import Control.Monad.Logger (LogSource)
import Yesod.Auth.Email
import Yesod.Default.Util   (addStaticContentExternal)
import Yesod.Core.Types     (Logger)
import qualified Yesod.Core.Unsafe as Unsafe
import qualified Data.CaseInsensitive as CI
import qualified Data.Text.Encoding as TE

-- | The foundation datatype for your application. This can be a good place to
-- keep settings and values requiring initialization before your application
-- starts running, such as database connections. Every handler will have
-- access to the data present here.
data App = App
    { appSettings    :: AppSettings
    , appStatic      :: Static -- ^ Settings for static file serving.
    , appConnPool    :: ConnectionPool -- ^ Database connection pool.
    , appHttpManager :: Manager
    , appLogger      :: Logger
    }

data MenuItem = MenuItem
    { menuItemLabel :: Text
    , menuItemRoute :: Route App
    , menuItemAccessCallback :: Bool
    }

data MenuTypes
    = NavbarLeft MenuItem
    | NavbarRight MenuItem

-- This is where we define all of the routes in our application. For a full
-- explanation of the syntax, please see:
-- http://www.yesodweb.com/book/routing-and-handlers
--
-- Note that this is really half the story; in Application.hs, mkYesodDispatch
-- generates the rest of the code. Please see the following documentation
-- for an explanation for this split:
-- http://www.yesodweb.com/book/scaffolding-and-the-site-template#scaffolding-and-the-site-template_foundation_and_application_modules
--
-- This function also generates the following type synonyms:
-- type Handler = HandlerT App IO
-- type Widget = WidgetT App IO ()
mkYesodData "App" $(parseRoutesFile "config/routes")

-- | A convenient synonym for creating forms.
type Form x = Html -> MForm (HandlerFor App) (FormResult x, Widget)

-- | A convenient synonym for database access functions.
type DB a = forall (m :: * -> *).
    (MonadIO m) => ReaderT SqlBackend m a

-- Please see the documentation for the Yesod typeclass. There are a number
-- of settings which can be configured by overriding methods here.
instance Yesod App where

    -- Controls the base of generated URLs. For more information on modifying,
    -- see: https://github.com/yesodweb/yesod/wiki/Overriding-approot
    approot :: Approot App
    approot = ApprootRequest $ \app req ->
        case appRoot $ appSettings app of
            Nothing -> getApprootText guessApproot app req
            Just root -> root

    -- Store session data on the client in encrypted cookies,
    -- default session idle timeout is 120 minutes
    makeSessionBackend :: App -> IO (Maybe SessionBackend)
    makeSessionBackend _ = Just <$> defaultClientSessionBackend
        120    -- timeout in minutes
        "config/client_session_key.aes"

    -- Yesod Middleware allows you to run code before and after each handler function.
    -- The defaultYesodMiddleware adds the response header "Vary: Accept, Accept-Language" and performs authorization checks.
    -- Some users may also want to add the defaultCsrfMiddleware, which:
    --   a) Sets a cookie with a CSRF token in it.
    --   b) Validates that incoming write requests include that token in either a header or POST parameter.
    -- To add it, chain it together with the defaultMiddleware: yesodMiddleware = defaultYesodMiddleware . defaultCsrfMiddleware
    -- For details, see the CSRF documentation in the Yesod.Core.Handler module of the yesod-core package.
    yesodMiddleware :: ToTypedContent res => Handler res -> Handler res
    yesodMiddleware = defaultCsrfMiddleware . defaultYesodMiddleware

    defaultLayout :: Widget -> Handler Html
    defaultLayout widget = do
        master <- getYesod
        mmsg <- getMessage

        --muser <- maybeAuth
        mcurrentRoute <- getCurrentRoute

        -- Get the breadcrumbs, as defined in the YesodBreadcrumbs instance.
        --(title, parents) <- breadcrumbs

        maid <- maybeAuthId

        pc <- widgetToPageContent $ do
            --addStylesheet $ StaticR css_bootstrap_css
            let navbar = $(widgetFile "navbar/navbar")
            let footer = $(widgetFile "footer/footer")
            $(widgetFile "old-layout")
        withUrlRenderer $(hamletFile "templates/old-layout-wrapper.hamlet")

    -- The page to be redirected to when authentication is required.
    authRoute
        :: App
        -> Maybe (Route App)
    authRoute _ = Just $ AuthR LoginR

    isAuthorized
        :: Route App  -- ^ The route the user is visiting.
        -> Bool       -- ^ Whether or not this is a "write" request.
        -> Handler AuthResult
    -- Routes not requiring authentication.
    isAuthorized (AuthR _) _ = return Authorized
    isAuthorized CommentR _ = return Authorized
    isAuthorized HomeR _ = return Authorized
    isAuthorized FaviconR _ = return Authorized
    isAuthorized RobotsR _ = return Authorized
    isAuthorized ContactR _ = return Authorized
    isAuthorized AboutR _ = return Authorized
    isAuthorized XmasR _ = return Authorized
    isAuthorized ResourcesR _ = return Authorized
    isAuthorized AllPostsR _ = return Authorized
    isAuthorized (ViewPostR _) _ = return Authorized
    isAuthorized (StaticR _) _ = return Authorized

    -- the profile route requires that the user is authenticated, so we
    -- delegate to that function
    isAuthorized ProfileR _ = isAuthenticated
    isAuthorized AllDraftsR _ = return Authorized
    isAuthorized (ViewDraftR _) _ = isAuthenticated
    isAuthorized (EditPostR _) _ = isAuthenticated
    isAuthorized (PreviewDraftR _) _ = isAuthenticated
    isAuthorized NewPostR _ = isAuthenticated

    maximumContentLength _ (Just (ViewDraftR _)) = Just (2 * 1024 * 1024 * 1024) -- 2 gigabytes
    maximumContentLength _ (Just (EditPostR _)) = Just (2 * 1024 * 1024 * 1024) -- 2 gigabytes
    maximumContentLength _ (Just (NewPostR)) = Just (2 * 1024 * 1024 * 1024) -- 2 gigabytes
    maximumContentLength _ _ = Just (2 * 1024 * 1024) -- 2 megabytes

    -- This function creates static content files in the static folder
    -- and names them based on a hash of their content. This allows
    -- expiration dates to be set far in the future without worry of
    -- users receiving stale content.
    addStaticContent
        :: Text  -- ^ The file extension
        -> Text -- ^ The MIME content type
        -> LByteString -- ^ The contents of the file
        -> Handler (Maybe (Either Text (Route App, [(Text, Text)])))
    addStaticContent ext mime content = do
        master <- getYesod
        let staticDir = appStaticDir $ appSettings master
        addStaticContentExternal
            minifym
            genFileName
            staticDir
            (StaticR . flip StaticRoute [])
            ext
            mime
            content
      where
        -- Generate a unique filename based on the content itself
        genFileName lbs = "autogen-" ++ base64md5 lbs

    -- What messages should be logged. The following includes all messages when
    -- in development, and warnings and errors in production.
    shouldLogIO :: App -> LogSource -> LogLevel -> IO Bool
    shouldLogIO app _source level =
        return $
        appShouldLogAll (appSettings app)
            || level == LevelWarn
            || level == LevelError

    makeLogger :: App -> IO Logger
    makeLogger = return . appLogger

-- Define breadcrumbs.
instance YesodBreadcrumbs App where
    -- Takes the route that the user is currently on, and returns a tuple
    -- of the 'Text' that you want the label to display, and a previous
    -- breadcrumb route.
    breadcrumb
        :: Route App  -- ^ The route the user is visiting currently.
        -> Handler (Text, Maybe (Route App))
    breadcrumb HomeR = return ("Home", Nothing)
    breadcrumb (AuthR _) = return ("Login", Just HomeR)
    breadcrumb ProfileR = return ("Profile", Just HomeR)
    breadcrumb  _ = return ("home", Nothing)

-- How to run database actions.
instance YesodPersist App where
    type YesodPersistBackend App = SqlBackend
    runDB :: SqlPersistT Handler a -> Handler a
    runDB action = do
        master <- getYesod
        runSqlPool action $ appConnPool master

instance YesodPersistRunner App where
    getDBRunner :: Handler (DBRunner App, Handler ())
    getDBRunner = defaultGetDBRunner appConnPool

instance YesodAuth App where
    type AuthId App = UserId

    -- Where to send a user after successful login
    loginDest :: App -> Route App
    loginDest _ = HomeR
    -- Where to send a user after logout
    logoutDest :: App -> Route App
    logoutDest _ = HomeR
    -- Override the above two destinations when a Referer: header is present
    redirectToReferer :: App -> Bool
    redirectToReferer _ = True

    -- Need to find the UserId for the given email address.
    authenticate creds = liftHandler $ runDB $ do
        x <- insertBy $ User (credsIdent creds) Nothing Nothing False
        return $ Authenticated $
            case x of
                Left (Entity userid _) -> userid -- existing user
                Right userid -> userid -- newly added user

    -- You can add other plugins like Google Email, email or OAuth here
    authPlugins :: App -> [AuthPlugin App]
    authPlugins _ = [authEmail] ++ extraAuthPlugins
        where extraAuthPlugins = []


-- Here's all of the email-specific code
instance YesodAuthEmail App where
    confirmationEmailSentResponse :: Text -> AuthHandler site TypedContent
    confirmationEmailSentResponse identifier = do
        mr <- getMessageRender
        selectRep $ do
            provideJsonMessage (mr msg)
            provideRep $ authLayout $ do
              setTitleI Msg.ConfirmationEmailSentTitle
              [whamlet|
                <div .article>
                  <h2 .centered>_{msg}|]
      where
        msg = Msg.ConfirmationEmailSent identifier

    type AuthEmailId App = UserId

    emailLoginHandler = myEmailLoginHandler
    registerHandler = myRegisterHandler
    setPasswordHandler = mySetPasswordHandler
    forgotPasswordHandler = myForgotPasswordHandler

    afterPasswordRoute _ = HomeR

    addUnverified email verkey =
        liftHandler $ runDB $ insert $ User email Nothing (Just verkey) False

    sendVerifyEmail email _ verurl = do
        -- Send email.
        liftIO $ SSL.doSMTPSSL "smtp.gmail.com" $ \connection -> do
          robotPass <- getEnv "ROBOT_PASS"
          succeeded <- SSL.authenticate LOGIN
                                        "robot@richardconnorjohnstone.com"
                                        robotPass
                                        connection
          when succeeded $
            sendPlainTextMail (show email)
                              "robot@richardconnorjohnstone.com" 
                              "Please Verify Your E-mail" 
                              (fromStrict ("Please click the link below to verify:\n" ++ verurl))
                              connection
    getVerifyKey = liftHandler . runDB . fmap (join . fmap userVerkey) . get
    setVerifyKey uid key = liftHandler $ runDB $ update uid [UserVerkey =. Just key]
    verifyAccount uid = liftHandler $ runDB $ do
        mu <- get uid
        case mu of
            Nothing -> return Nothing
            Just _ -> do
                update uid [UserVerified =. True, UserVerkey =. Nothing]
                return $ Just uid
    getPassword = liftHandler . runDB . fmap (join . fmap userPassword) . get
    setPassword uid pass = liftHandler . runDB $ update uid [UserPassword =. Just pass]
    getEmailCreds email = liftHandler $ runDB $ do
        mu <- getBy $ UniqueUser email
        case mu of
            Nothing -> return Nothing
            Just (Entity uid u) -> return $ Just EmailCreds
                { emailCredsId = uid
                , emailCredsAuthId = Just uid
                , emailCredsStatus = isJust $ userPassword u
                , emailCredsVerkey = userVerkey u
                , emailCredsEmail = email
                }
    getEmail = liftHandler . runDB . fmap (fmap userEmail) . get

-- | Access function to determine if a user is logged in.
isAuthenticated :: Handler AuthResult
isAuthenticated = do
    muid <- maybeAuthId
    return $ case muid of
        Nothing -> Unauthorized "You must login to access this page"
        Just _ -> Authorized

instance YesodAuthPersist App

-- This instance is required to use forms. You can modify renderMessage to
-- achieve customized and internationalized form validation messages.
instance RenderMessage App FormMessage where
    renderMessage :: App -> [Lang] -> FormMessage -> Text
    renderMessage _ _ = defaultFormMessage

-- Useful when writing code that is re-usable outside of the Handler context.
-- An example is background jobs that send email.
-- This can also be useful for writing code that works across multiple Yesod applications.
instance HasHttpManager App where
    getHttpManager :: App -> Manager
    getHttpManager = appHttpManager

unsafeHandler :: App -> Handler a -> IO a
unsafeHandler = Unsafe.fakeHandlerGetLogger appLogger

-- Note: Some functionality previously present in the scaffolding has been
-- moved to documentation in the Wiki. Following are some hopefully helpful
-- links:
--
-- https://github.com/yesodweb/yesod/wiki/Sending-email
-- https://github.com/yesodweb/yesod/wiki/Serve-static-files-from-a-separate-domain
data ForgotPasswordForm = ForgotPasswordForm { _forgotEmail :: Text }
data PasswordForm = PasswordForm { _passwordCurrent :: Text, _passwordNew :: Text, _passwordConfirm :: Text }
data UserForm = UserForm { _userFormEmail :: Text }
data UserLoginForm = UserLoginForm { _loginEmail :: Text, _loginPassword :: Text }
myEmailLoginHandler :: YesodAuthEmail site => (Route Auth -> Route site) -> WidgetFor site ()
myEmailLoginHandler toParent = do
      (widget, enctype) <- generateFormPost loginForm
      [whamlet|
        <div .article .centered>
          <h1 .login_header .centered #login_header> Log In
          <form method="post" action="@{toParent loginR}" enctype=#{enctype} .centered>
            <div .centered id="emailLoginForm">
              ^{widget}
              <div #login_buttons>
                <button .centered .round_button #login_button type=submit .btn .btn-success>
                  _{Msg.LoginViaEmail}
                &nbsp;
                <a href="@{toParent registerR}" .round_button #login_button .btn .btn-default>
                  _{Msg.RegisterLong}
      |]
  where
    loginForm extra = do
      emailMsg <- renderMessage' Msg.Email
      (emailRes, emailView) <- mreq emailField (emailSettings emailMsg) Nothing
      passwordMsg <- renderMessage' Msg.Password
      (passwordRes, passwordView) <- mreq passwordField (passwordSettings passwordMsg) Nothing
      let userRes = UserLoginForm Control.Applicative.<$> emailRes
                                  Control.Applicative.<*> passwordRes
      let widget = [whamlet|
            #{extra}
            <div>
                ^{fvInput emailView}
            <div>
                ^{fvInput passwordView}
        |]      
      return (userRes, widget)
    emailSettings emailMsg = do
      FieldSettings {
          fsLabel = SomeMessage Msg.Email,
          fsTooltip = Nothing,
          fsId = Just "email",
          fsName = Just "email",
          fsAttrs = [("autofocus", ""), ("placeholder", emailMsg)]
      }
    passwordSettings passwordMsg =
       FieldSettings {
          fsLabel = SomeMessage Msg.Password,
          fsTooltip = Nothing,
          fsId = Just "password",
          fsName = Just "password",
          fsAttrs = [("placeholder", passwordMsg)]
      }
    renderMessage' msg = do
      langs <- languages
      master <- getYesod
      return $ renderAuthMessage master langs msg

-------------------------------------------------------------------------------

myRegisterHandler :: YesodAuthEmail site => AuthHandler site Html
myRegisterHandler = do
  (widget, enctype) <- generateFormPost registrationForm
  toParentRoute <- getRouteToParent
  authLayout $ do
    setTitleI Msg.RegisterLong
    [whamlet|
      <div .article>
        <h1 #login_header .centered>_{Msg.EnterEmail}
        <form method="post" action="@{toParentRoute registerR}" enctype=#{enctype}>
          <div id="registerForm">
            ^{widget}
          <div #register_buttons>
            <button #register_button .round_button .centered .btn>_{Msg.Register}
    |]
  where
    registrationForm extra = do
      let emailSettings = FieldSettings {
        fsLabel = SomeMessage Msg.Email,
        fsTooltip = Nothing,
        fsId = Just "email",
        fsName = Just "email",
        fsAttrs = [("autofocus", "")]
      }
      (emailRes, emailView) <- mreq emailField emailSettings Nothing
      let userRes = UserForm <$> emailRes
      let widget = [whamlet|
          #{extra}
          ^{fvInput emailView}
        |]
      return (userRes, widget)

-------------------------------------------------------------------------------

mySetPasswordHandler :: YesodAuthEmail master => Bool -> AuthHandler master TypedContent
mySetPasswordHandler needOld = do
    messageRender <- getMessageRender
    toParent <- getRouteToParent
    selectRep $ do
        provideJsonMessage $ messageRender Msg.SetPass
        provideRep $ authLayout $ do
            (widget, enctype) <- generateFormPost setPasswordForm
            setTitleI Msg.SetPassTitle
            [whamlet|
                <div .article>
                  <h2 .centered>_{Msg.SetPass}
                  <form .centered method="post" action="@{toParent setpassR}" enctype=#{enctype}>
                      ^{widget}
            |]
  where
    setPasswordForm extra = do
        (currentPasswordRes, currentPasswordView) <- mreq passwordField currentPasswordSettings Nothing
        (newPasswordRes, newPasswordView) <- mreq passwordField newPasswordSettings Nothing
        (confirmPasswordRes, confirmPasswordView) <- mreq passwordField confirmPasswordSettings Nothing

        let passwordFormRes = PasswordForm <$> currentPasswordRes <*> newPasswordRes <*> confirmPasswordRes
        let widget = [whamlet|
                #{extra}
                <table>
                    $if needOld
                        <tr>
                            <th>
                                ^{fvLabel currentPasswordView}
                            <td>
                                ^{fvInput currentPasswordView}
                    <tr>
                        <th>
                            ^{fvLabel newPasswordView}
                        <td>
                            ^{fvInput newPasswordView}
                    <tr>
                        <th>
                            ^{fvLabel confirmPasswordView}
                        <td>
                            ^{fvInput confirmPasswordView}
                    <tr>
                        <td colspan="2">
                            <input type=submit value=_{Msg.SetPassTitle}>
            |]

        return (passwordFormRes, widget)
    currentPasswordSettings =
         FieldSettings {
             fsLabel = SomeMessage Msg.CurrentPassword,
             fsTooltip = Nothing,
             fsId = Just "currentPassword",
             fsName = Just "current",
             fsAttrs = [("autofocus", "")]
         }
    newPasswordSettings =
        FieldSettings {
            fsLabel = SomeMessage Msg.NewPass,
            fsTooltip = Nothing,
            fsId = Just "newPassword",
            fsName = Just "new",
            fsAttrs = [("autofocus", ""), (":not", ""), ("needOld:autofocus", "")]
        }
    confirmPasswordSettings =
        FieldSettings {
            fsLabel = SomeMessage Msg.ConfirmPass,
            fsTooltip = Nothing,
            fsId = Just "confirmPassword",
            fsName = Just "confirm",
            fsAttrs = [("autofocus", "")]
        }

myForgotPasswordHandler :: YesodAuthEmail site => AuthHandler site Html
myForgotPasswordHandler = do
    (widget, enctype) <- generateFormPost forgotPasswordForm
    toParent <- getRouteToParent
    authLayout $ do
        setTitleI Msg.PasswordResetTitle
        [whamlet|
            <div .article>
            <h2 .centered>_{Msg.PasswordResetPrompt}
              <form .centered method=post action=@{toParent forgotPasswordR} enctype=#{enctype}>
                  <div id="forgotPasswordForm">
                      ^{widget}
                      <button .round_button #forgot_pass_button .btn>_{Msg.SendPasswordResetEmail}
        |]
  where
    forgotPasswordForm extra = do
        (emailRes, emailView) <- mreq emailField emailSettings Nothing

        let forgotPasswordRes = ForgotPasswordForm <$> emailRes
        let widget = [whamlet|
                #{extra}
                ^{fvInput emailView}
            |]
        return (forgotPasswordRes, widget)

    emailSettings =
        FieldSettings {
            fsLabel = SomeMessage Msg.ProvideIdentifier,
            fsTooltip = Nothing,
            fsId = Just "forgotPassword",
            fsName = Just "email",
            fsAttrs = [("autofocus", "")]
        }
