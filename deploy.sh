#!/bin/sh

git add . && git commit -m update && git push

if [[ $(git status -s) ]]
then
    echo "The working directory is dirty. Please commit any pending changes."
    exit 1;
fi

echo "Deleting old publication"
rm -rf public
mkdir public
git worktree prune
rm -rf .git/worktrees/public/

echo "Checking out gh-pages branch into public"
git worktree add -B gh-pages public gh-pages

echo "Removing existing files"
rm -rf public/*

echo "Generating site"
hugo

echo "Updating gh-pages branch"
cd public && git add --all && git commit -m "Publishing to gh-pages (publish.sh)" && git push

cd ..


#      [[params.shows.list]]
#        date = "4/19/2019 "
#        venue = "Xazmin Garza headlines The Gas, Great Scott, Allston, MA."
#
#      [[params.shows.list]]
#        date = "4/18/2019 8pm"
#        venue = "The Laugh Shack, Portland, ME"
#
#      [[params.shows.list]]
#        date = "4/17/2019 8pm"
#        venue = "Xazmin Garza with Liz Hall, The Shaskeen Pub, Manchester, NH"
#
#      [[params.shows.list]]
#        date = "4/16/2019 5pm"
#        venue = "Ignite AI Conference, Midtown Hilton"
#
#      [[params.shows.list]]
#        date = "4/16/2019 8pm"
#        venue = "Hard Pass, The Grisly Pear"
#
#      [[params.shows.list]]
#        date = "4/15/2019 9pm"
#        venue = "LApDAnceSAloon, 2A Bar"
