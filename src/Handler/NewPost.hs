{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}

module Handler.NewPost where

import Layouts.HomeLayout
import Import 
import Database.Persist.Sql (fromSqlKey)

uploadDirectory :: FilePath
uploadDirectory = "static/img"

-------------------------------------------------------------------------------

blogPostForm :: Html -> MForm Handler (FormResult (Text, FileInfo, UTCTime, Textarea), Widget)
blogPostForm = renderDivs $ (,,,)
    <$> areq textField "Title" Nothing
    <*> fileAFormReq "Cover Image"
    <*> lift (liftIO getCurrentTime)
    <*> areq textareaField "Article" Nothing
    
-------------------------------------------------------------------------------

getNewPostR :: Handler Html
getNewPostR = do
  maid <- maybeAuthId
  (blogPostWidget, enctype) <- generateFormPost blogPostForm
  homeLayout $ do
    setTitle "Create a New Blog Post"
    $(widgetFile "navbar/navbar")
    $(widgetFile "posts/new")
    $(widgetFile "footer/footer")

postNewPostR :: Handler Html
postNewPostR = do
  ((res, _), _) <- runFormPost blogPostForm
  case res of 
    FormSuccess (title, image, date, article) -> do
      imageLocation <- writeToServer image
      let blogDraft = BlogDraft title imageLocation date article
      _ <- runDB $ insert blogDraft
      redirect $ AllDraftsR
    _ -> getNewPostR

writeToServer :: FileInfo -> Handler FilePath
writeToServer file = do
    let filename = unpack $ fileName file
        imagePath = imageFilePath filename
    liftIO $ fileMove file imagePath
    return imagePath

imageFilePath :: String -> FilePath
imageFilePath f = uploadDirectory </> f
