#!/usr/bin/env bash

# WARNING: this will reset the project to the Kickstart template!

# Update Academic
source ../update_academic.sh

#################################################

# Install demo config
rsync -av ../themes/academic/exampleSite/config/ ../config/

# Install demo user
rsync -av ../themes/academic/exampleSite/content/author/ ../content/author/

# Install an example instance of each widget type
rsync -av --exclude gallery/ ../themes/academic/exampleSite/content/home/ ../content/home/

# Install indices
rsync -av ../themes/academic/exampleSite/content/post/_index.md ../content/post/_index.md
rsync -av ../themes/academic/exampleSite/content/publication/_index.md ../content/publication/_index.md
rsync -av ../themes/academic/exampleSite/content/talk/_index.md ../content/talk/_index.md

# Skip static dir - do not import the demo's media library

#################################################

# Post processing

# Deactivate Hero
sed -i '' -e 's/active = true/active = false/' ../content/home/hero.md

# Manual Steps:
# - content/home/project.md: Re-comment out project widget filters
# - content/home/teaching.md: Re-modify title and content & set gradient background instead of image
# - content/home/hero.md: Clear `hero_media` value & set gradient background instead of image
