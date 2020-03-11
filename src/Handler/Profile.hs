{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Profile where

import Import
import Layouts.HomeLayout

getProfileR :: Handler Html
getProfileR = do
    (_, user) <- requireAuthPair
    homeLayout $ do
        setTitle . toHtml $ userEmail user <> "'s User page"
        $(widgetFile "profile")
