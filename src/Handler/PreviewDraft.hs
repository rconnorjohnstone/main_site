{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}

module Handler.PreviewDraft where

import Layouts.HomeLayout
import Import
import Text.HTML.SanitizeXSS
import Text.Blaze.Html
import Database.Persist.Sql (fromSqlKey)
import CMarkGFM

-------------------------------------------------------------------------------

getPreviewDraftR :: BlogDraftId -> Handler Html
getPreviewDraftR blogDraftId = do
  maid <- maybeAuthId
  blogDraft <- runDB $ get404 blogDraftId
  homeLayout $ do
    setTitle (toHtml $ blogDraftTitle blogDraft)
    let articleHtml = sanitize $ commonmarkToHtml [] [] (unTextarea $ blogDraftArticle blogDraft)
    $(widgetFile "navbar/navbar")
    $(widgetFile "posts/preview")
    $(widgetFile "footer/footer")
