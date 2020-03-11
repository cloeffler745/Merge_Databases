#!/bin/bash

cat assembly.raw.fa hold.fa > master_ref.fa

gzip master_ref.fa

echo "Done!"
