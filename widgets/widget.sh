#!/bin/bash

ADJECTIVES[0]='Green'
ADJECTIVES[1]='Blue'
ADJECTIVES[2]='Red'
ADJECTIVES[3]='Transparent'
ADJECTIVES[4]='Humongous'

while true;
do
    WORD_INDEX=$(( $RANDOM % ${#ADJECTIVES[@]} ))

    logger "Made a ${ADJECTIVES[${WORD_INDEX}]} widget! - WidgetMaker(TM) number $1"
    sleep 5
done

