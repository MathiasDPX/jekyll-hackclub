---
---

<title>Raw tests - Jekyll-HackClub</title>
<link rel="stylesheet" href="./assets/styles.css">

[Go back home](./)

## Mentions
Classic: {% mention U080HHYN0JD %} {% mention C08K7ARJ58U %}<br>
Renamed: {% mention U080HHYN0JD ; MathiasDPX %} {% mention C08K7ARJ58U ; get-a-cool-hat-ysws %}<br>
Unknown: {% mention C08N35P7LCT %} {% mention U1234567890 %}

With pipes: {% mention U080HHYN0JD | capitalize %} {% mention C08K7ARJ58U | uppercase | [0:-2] %}

## Emojis
GIF: {% emoji yay %}<br>
PNG: {% emoji errors %}

## Raw user
name (root key): <code>{% user U080HHYN0JD ; name %}</code><br>
profile.pronouns (nested key): <code>{% user U080HHYN0JD ; profile.pronouns %}</code><br>
is_admin (bool value): <code>{% user U080HHYN0JD ; is_admin %}</code><br>
tz_offset (int value): <code>{% user U080HHYN0JD ; tz_offset %}</code><br>
dog (unknown value): <code>{% user U080HHYN0JD ; dog %}</code><br>

## Raw channel
name (root key): <code>{% channel C08P0L0GQJU name %}</code><br>
purpose.value (nested key): <code>{% channel C08P0L0GQJU purpose.value %}</code><br>
is_archived (bool value): <code>{% channel C08P0L0GQJU is_archived %}</code><br>
updated (int value): <code>{% channel C08P0L0GQJU updated %}</code><br>
cat (unknown value): <code>{% channel C08P0L0GQJU cat %}</code>

## Parser
Simple: <code>{% _parser hello james! %}</code><br>
Size: <code>{% _parser hello james! | size %}</code><br>
Substring: <code>{% _parser hello james! | [0:4] %}</code><br>
Negative substring: <code>{% _parser hello james! | [6:-1] %}</code><br>
Multiple pipes: <code>{% _parser hello james! | uppercase | [0:4] %}</code><br>
Multiple args: <code>{% _parser hello james! ; joe dalton %}</code><br>
Multiple args + pipe: <code>{% _parser hello james! | uppercase ; joe dalton | capitalize %}</code><br>