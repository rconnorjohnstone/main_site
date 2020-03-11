{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}

module Handler.AllDrafts where

import Layouts.HomeLayout
import Import 
import Handler.Home
import Hakyll.Web.Html
import Data.Text (append)
import CMarkGFM
import Database.Persist.Sql (fromSqlKey)

-------------------------------------------------------------------------------

recentParams' :: BlogDraft -> BlogDraftId -> Bool -> PreviewCardParams
recentParams' recentDraft blogDraftId flipped = PreviewCardParams 
               (blogDraftTitle recentDraft) 
               ((pack $ stripTags $ Prelude.take 450 $ unpack $ commonmarkToHtml [] [] $ unTextarea $ (blogDraftArticle recentDraft)) `append` "...")
               (pack $ blogDraftCoverName recentDraft) 
               flipped 
               "recent" 
               ("/drafts/" `append` (pack $ show $ fromSqlKey blogDraftId))

-------------------------------------------------------------------------------

getAllDraftsR :: Handler Html
getAllDraftsR = do
  maid <- maybeAuthId
  allEntities <- runDB $ selectList [] [Desc BlogDraftId]
  let allBlogDrafts = Prelude.map entityVal allEntities
      allIds = Prelude.map entityKey allEntities
      allRecentParams = Prelude.map (\(a,b,c) -> recentParams' a b c) $ Prelude.zip3 allBlogDrafts allIds [((mod x 2)==1) | x <- [1..] :: [Int]]
  homeLayout $ do
    setTitle "All Drafts"
    $(widgetFile "navbar/navbar")
    $(widgetFile "posts/all_drafts")
    _ <- Prelude.mapM previewCard allRecentParams
    $(widgetFile "footer/footer")
