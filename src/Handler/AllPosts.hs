{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}

module Handler.AllPosts where

import Layouts.HomeLayout
import Import 
import Handler.Home
import Database.Persist.Sql (fromSqlKey)

-------------------------------------------------------------------------------

getAllPostsR :: Handler Html
getAllPostsR = do
  maid <- maybeAuthId
  allEntities <- runDB $ selectList [] [Desc BlogPostId]
  let allBlogPosts = Prelude.map entityVal allEntities
      allIds = Prelude.map entityKey allEntities
      allRecentParams = Prelude.map (\(a,b,c) -> recentParams a b c) $ Prelude.zip3 allBlogPosts allIds [((mod x 2)==1) | x <- [1..] :: [Int]]
  homeLayout $ do
    setTitle "All Posts"
    $(widgetFile "navbar/navbar")
    $(widgetFile "posts/all")
    _ <- Prelude.mapM previewCard allRecentParams
    $(widgetFile "footer/footer")
