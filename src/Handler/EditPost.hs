{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}

module Handler.EditPost where

import Layouts.HomeLayout
import Import
import Yesod.Form.Types ()
import Database.Persist.Sql (fromSqlKey)

uploadDirectory :: FilePath
uploadDirectory = "static/img"

-------------------------------------------------------------------------------

draftForm :: BlogPost -> Html -> MForm Handler (FormResult (Text, FileInfo, UTCTime, Textarea), Widget)
draftForm blogPost = renderDivs $ (,,,) 
    <$> areq textField "Title" (Just (blogPostTitle blogPost))
    <*> fileAFormReq "Cover Image"
    <*> lift (liftIO getCurrentTime)
    <*> areq textareaField "Article" (Just (blogPostArticle blogPost))

-------------------------------------------------------------------------------

getEditPostR :: BlogPostId -> Handler Html
getEditPostR blogPostId = do
  maid <- maybeAuthId
  blogPost <- runDB $ get404 blogPostId
  (blogDraftWidget, enctype) <- generateFormPost (draftForm blogPost)
  homeLayout $ do
    setTitle (toHtml $ blogPostTitle blogPost)
    $(widgetFile "navbar/navbar")
    $(widgetFile "posts/edit")
    $(widgetFile "footer/footer")

-------------------------------------------------------------------------------

postEditPostR :: BlogPostId -> Handler Html
postEditPostR blogPostId = do
  foundBlogPost <- runDB $ get404 blogPostId
  ((res, _), _) <- runFormPost (draftForm foundBlogPost)
  action <- lookupPostParam "action"
  case (res, action) of 
    (FormSuccess _, Just "delete") -> do
      runDB $ delete blogPostId
      redirect $ AllPostsR
    (FormSuccess (title, image, date, article), Just "publish") -> do
      imageLoc <- writeToServer image
      let blogPost = BlogPost title imageLoc date article
      runDB $ replace blogPostId blogPost
      redirect $ ViewPostR blogPostId
    _ -> redirect $ AllPostsR

writeToServer :: FileInfo -> Handler FilePath
writeToServer file = do
    let filename = unpack $ fileName file
        imagePath = imageFilePath filename
    liftIO $ fileMove file imagePath
    return ("/" Prelude.++ imagePath)

imageFilePath :: String -> FilePath
imageFilePath f = uploadDirectory </> f
