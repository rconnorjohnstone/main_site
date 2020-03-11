{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}

module Handler.ViewDraft where

import Layouts.HomeLayout
import Import
import Yesod.Form.Types ()
import Database.Persist.Sql

uploadDirectory :: FilePath
uploadDirectory = "static/img"

-------------------------------------------------------------------------------

draftForm :: BlogDraft -> Html -> MForm Handler (FormResult (Text, FileInfo, UTCTime, Textarea), Widget)
draftForm blogDraft = renderDivs $ (,,,) 
    <$> areq textField "Title" (Just (blogDraftTitle blogDraft))
    <*> fileAFormReq "Cover Image"
    <*> lift (liftIO getCurrentTime)
    <*> areq textareaField "Article" (Just (blogDraftArticle blogDraft))

-------------------------------------------------------------------------------

getViewDraftR :: BlogDraftId -> Handler Html
getViewDraftR blogDraftId = do
  maid <- maybeAuthId
  blogDraft <- runDB $ get404 blogDraftId
  recentBlog <- runDB $ selectList [] [Desc BlogDraftId, LimitTo 1]
  let Entity recentId _ = Prelude.head recentBlog
  firstBlog <- runDB $ selectList [] [Asc BlogDraftId, LimitTo 1]
  let Entity firstId _ = Prelude.head firstBlog
  previousBlog <- runDB $ selectList [BlogDraftId <. blogDraftId] [Desc BlogDraftId, LimitTo 1]
  let Entity previousId _ = case previousBlog of
                    [] -> Prelude.head firstBlog
                    x -> Prelude.head x
  nextBlog <- runDB $ selectList [BlogDraftId >. blogDraftId] [Asc BlogDraftId, LimitTo 1]
  let Entity nextId _ = case nextBlog of
                    [] -> Prelude.head recentBlog
                    x -> Prelude.head x
  (blogDraftWidget, enctype) <- generateFormPost (draftForm blogDraft)
  homeLayout $ do
    setTitle (toHtml $ blogDraftTitle blogDraft)
    $(widgetFile "navbar/navbar")
    $(widgetFile "posts/view_draft")
    $(widgetFile "footer/footer")

-------------------------------------------------------------------------------

postViewDraftR :: BlogDraftId -> Handler Html
postViewDraftR blogDraftId = do
  foundBlogDraft <- runDB $ get404 blogDraftId
  ((res, _), _) <- runFormPost (draftForm foundBlogDraft)
  action <- lookupPostParam "action"
  case (res, action) of 
    (FormSuccess (title, image, date, article), Just "save") -> do
      imageLoc <- writeToServer image
      let blogDraft = BlogDraft title imageLoc date article
      runDB $ replace blogDraftId $ blogDraft
      redirect $ ViewDraftR blogDraftId
    (FormSuccess (title, image, date, article), Just "preview") -> do
      imageLoc <- writeToServer image
      let blogDraft = BlogDraft title imageLoc date article
      runDB $ replace blogDraftId $ blogDraft
      redirect $ PreviewDraftR blogDraftId
    (FormSuccess _, Just "delete") -> do
      runDB $ delete blogDraftId
      redirect $ AllPostsR
    (FormSuccess (title, image, date, article), Just "publish") -> do
      imageLoc <- writeToServer image
      let blogPost = BlogPost title imageLoc date article
      blogPostId <- runDB $ insert blogPost
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
