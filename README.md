# Haskell Backend for My Website

I made the joke on my last repository that I hadn't even finished redesigning my website before porting it all over to React. Then I realized I'm gonna need some real backend functionality that React can't provide... So here we are.

This is purely a Yesod app now, and coming along pretty nicely. This is mostly meant to be a learning experience for me, so I'm just trying to get my feet wet in Haskell in general and backend Haskell in particular. But I guess also backend programming in particular, and really, I'm still pretty new to web development in general, as everything else I've done so far has been a program intended for the command line. So go easy on me, I'm learning.

To go to the actual website, visit rconnorjohnstone.com or richardcjohnstone.com

## Features

### Ported Over
I think literally everything that was on the React site is now ported over. Don't quote me on that.

### New Stuff
One of the "backend" type capabilities I needed was to get the email form to actually email me something. It works now. Also, I've got a lot of new stuff. The ability to create and view blog posts, store them to the database, and authorization through the form of an email/password combo.

### Not Yet Implemented
Still needs SSL, comments, a post save/review area, and some other odds and ends

## To Build
This is a Yesod app, so if you do want to build it (for whatever reason) it's:

```bash
stack exec -- yesod devel
```

## To Modify the Production Server
This is entirely for my own reference, so if you're cloning my repository or something, don't even bother. You don't have the certificate to do this anyway.

```bash
# To connect over SSH
ssh -i /path/to/certificate.pem ubuntu@ec2-3-133-251-235.us-east-2.compute.amazonaws.com

# To push a new keter bundle to the server only
stack exec -- yesod keter
scp -i /path/to/certificate.pem /path/to/hackend.keter ubuntu@ec2-3-133-251-235.us-east-2.compute.amazonaws.com:/opt/keter/incoming
```
