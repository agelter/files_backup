#!/usr/bin/env bash

# newt
curl -q -sL 'https://go.prod.netflix.net/newt-install' | bash

# metatron
curl -s 'https://artifacts.netflix.com/devtools/metatron-cli/install-script' | bash
