{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}

module Handler.Resources where

import Layouts.HomeLayout
import Database.Persist.Sql (fromSqlKey)
import Import 

-------------------------------------------------------------------------------

getResourcesR :: Handler Html
getResourcesR = homeLayout $ do
    maid <- maybeAuthId
    setTitle "Resources - Richard Connor Johnstone"
    $(widgetFile "navbar/navbar")
    $(widgetFile "resources/resources")
    $(widgetFile "footer/footer")
