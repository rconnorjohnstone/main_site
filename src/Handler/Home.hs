{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}

module Handler.Home where

import Network.HaskellNet.Auth
import Network.HaskellNet.SMTP
import Network.HaskellNet.SMTP.SSL
import Data.Text (append)
import System.Environment
import Import hiding (authenticate)
import Layouts.HomeLayout
import Database.Persist.Sql
import Hakyll.Web.Html
import CMarkGFM

-------------------------------------------------------------------------------

data PreviewCardParams = PreviewCardParams {previewTitle :: Text,
                                            previewText :: Text,
                                            previewImage :: Text,
                                            previewOffset :: Bool,
                                            previewId :: Text,
                                            previewR :: Text} deriving (Show, Read)

data ProjectCard = ProjectCard {projectTitle :: Text,
                                projectImage :: Text,
                                projectUrl :: Text} deriving (Show, Read)

data Contacter = Contacter {name :: Text,
                            email :: Text,
                            message :: Textarea} deriving (Show, Read)

-------------------------------------------------------------------------------

aboutMeParams :: PreviewCardParams
aboutMeParams = PreviewCardParams "About Me"  "I am an Aerospace Engineering Master's Student at the University of Colorado - Boulder as well as a Systems Engineer at Palski and Associates. Click the link below to learn a little bit more about my story." "/static/img/about.jpg" False "about" "/about"

recentParams :: BlogPost -> BlogPostId -> Bool -> PreviewCardParams
recentParams recentPost blogPostId flipped = PreviewCardParams 
               (blogPostTitle recentPost) 
               ((pack $ stripTags $ Prelude.take 450 $ unpack $ commonmarkToHtml [] [] $ unTextarea $ (blogPostArticle recentPost)) `append` "...")
               (pack $ blogPostCoverName recentPost) 
               flipped 
               "recent" 
               ("/posts/" `append` (pack $ show $ fromSqlKey blogPostId))

resourceParams :: PreviewCardParams
resourceParams = PreviewCardParams "Resources" "A section for my resume, gallery, CAD examples, and whatever else I feel like uploading." "/static/img/resources.jpg" False "resources" "/resources"

-------------------------------------------------------------------------------

imdProject :: ProjectCard
imdProject = ProjectCard "Interplanetary Mission Design Toolbox" "/static/img/imd.jpg"  "https://www.github.com/rconnorjohnstone/IMD_module"

attProject :: ProjectCard
attProject = ProjectCard "Attitude and Kinematics Module" "/static/img/att.jpg"  "https://www.github.com/rconnorjohnstone/Attitude-Control-Module"

wmsProject :: ProjectCard
wmsProject = ProjectCard "Where's My Satellite?" "/static/img/wms.jpg"  "https://www.github.com/rconnorjohnstone/WheresMySat"

-------------------------------------------------------------------------------

previewCard :: PreviewCardParams -> Widget
previewCard params = $(widgetFile "preview_card/preview_card")

projects :: [ProjectCard] -> Widget
projects cards = $(widgetFile "projects/projects")

-------------------------------------------------------------------------------

contacterForm :: Html -> MForm Handler (FormResult Contacter, Widget)
contacterForm = renderDivs $ Contacter
    <$> areq textField "Name" Nothing
    <*> areq emailField "Email" Nothing
    <*> areq textareaField "Message" Nothing

-------------------------------------------------------------------------------

getHomeR :: Handler Html
getHomeR = do
  recentBlogPosts <- runDB $ selectList [] [Desc BlogPostId, LimitTo 1]
  let (Entity recentId recentBlog) = Prelude.head recentBlogPosts
  (contactWidget, enctype) <- generateFormPost contacterForm
  homeLayout $ do
    setTitle "Richard Connor Johnstone"
    $(widgetFile "banner/banner")
    previewCard aboutMeParams
    previewCard (recentParams recentBlog recentId True)
    previewCard resourceParams
    projects [imdProject, attProject, wmsProject]
    $(widgetFile "contact/contact")
    $(widgetFile "footer/footer")

postContactR :: Handler Html
postContactR = do
  ((result, _), _) <- runFormPost contacterForm
  case result of
    FormSuccess contacter -> do
      let body = (name contacter) `append` 
                 "\n\n" `append` 
                 (email contacter) `append` 
                 "\n\n" `append` (unTextarea $ message contacter)
      liftIO $ doSMTPSSL "smtp.gmail.com" $ \connection -> do
        robotPass <- getEnv "ROBOT_PASS"
        succeeded <- authenticate LOGIN
                                  "robot@richardconnorjohnstone.com"
                                  robotPass
                                  connection
        when succeeded $
          sendPlainTextMail "connor@richardconnorjohnstone.com" 
                            "robot@richardconnorjohnstone.com" 
                            "New Contact" 
                            (fromStrict body)
                            connection
      redirect HomeR
    _ -> getHomeR
