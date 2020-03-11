{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}

module Handler.About where

import Import 
import Database.Persist.Sql (fromSqlKey)
import Layouts.HomeLayout

-------------------------------------------------------------------------------

getAboutR :: Handler Html
getAboutR = homeLayout $ do
    maid <- maybeAuthId
    setTitle "About Me - Richard Connor Johnstone"
    $(widgetFile "navbar/navbar")
    $(widgetFile "about/about")
