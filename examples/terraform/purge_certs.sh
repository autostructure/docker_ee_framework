#!/bin/sh

ssh puppet
sudo puppetserver ca list --all
sudo puppet node purge worker001.autostructure.io worker002.autostructure.io worker003.autostructure.io worker004.autostructure.io manager001.autostructure.io manager002.autostructure.io manager003.autostructure.io nfs.autostructure.io
sudo puppetserver ca list --all
sudo puppet agent -t
