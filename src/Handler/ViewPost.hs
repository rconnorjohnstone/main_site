{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}

module Handler.ViewPost where

import Layouts.HomeLayout
import Import
import Database.Persist.Sql
import CMarkGFM
import Text.HTML.SanitizeXSS
import Text.Blaze.Html

-------------------------------------------------------------------------------

getViewPostR :: BlogPostId -> Handler Html
getViewPostR blogPostId = do
  maid <- maybeAuthId
  blogPost <- runDB $ get404 blogPostId
  recentBlog <- runDB $ selectList [] [Desc BlogPostId, LimitTo 1]
  let Entity recentId _ = Prelude.head recentBlog
  firstBlog <- runDB $ selectList [] [Asc BlogPostId, LimitTo 1]
  let Entity firstId _ = Prelude.head firstBlog
  previousBlog <- runDB $ selectList [BlogPostId <. blogPostId] [Desc BlogPostId, LimitTo 1]
  let Entity previousId _ = case previousBlog of
                    [] -> Prelude.head firstBlog
                    x -> Prelude.head x
  nextBlog <- runDB $ selectList [BlogPostId >. blogPostId] [Asc BlogPostId, LimitTo 1]
  let Entity nextId _ = case nextBlog of
                    [] -> Prelude.head recentBlog
                    x -> Prelude.head x
  homeLayout $ do
    setTitle (toHtml $ blogPostTitle blogPost)
    let articleHtml = sanitize $ commonmarkToHtml [] [] (unTextarea $ blogPostArticle blogPost)
    $(widgetFile "navbar/navbar")
    $(widgetFile "posts/view")
    $(widgetFile "footer/footer")
