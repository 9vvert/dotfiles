#!/bin/bash

hyprctl activeworkspace | grep "monitorID" | head -n 1 | awk '{print $2}'
