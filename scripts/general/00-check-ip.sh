#!/bin/bash

ip a

ping -c 1 -W 10 8.8.8.8 && \
ping -c 1 -W 10 dns.google.com
