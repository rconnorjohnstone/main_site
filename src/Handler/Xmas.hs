{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE QuasiQuotes       #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}

module Handler.Xmas where

import Layouts.HomeLayout
import Database.Persist.Sql
import Import 

-------------------------------------------------------------------------------

getXmasR :: Handler Html
getXmasR = homeLayout $ do
    maid <- maybeAuthId
    setTitle "Christmas List - Richard Connor Johnstone"
    $(widgetFile "navbar/navbar")
    $(widgetFile "christmas/christmas")
    $(widgetFile "footer/footer")
