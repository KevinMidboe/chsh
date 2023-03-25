#!/bin/sh

CAPS_KEY=0x700000039
F10_KEY=0x700000043

DATA=$(printf '{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":%s,"HIDKeyboardModifierMappingDst":%s}]}' $CAPS_KEY $F10_KEY)
hidutil property --set $DATA

echo "Successfully overwrote CAPS KEY to F10!"

