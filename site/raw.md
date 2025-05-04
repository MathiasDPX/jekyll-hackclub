---
---

<title>Raw tests - Jekyll-HackClub</title>
<link rel="stylesheet" href="./assets/styles.css">

[Go back home](./)

## Mentions
Classic: {% mention U080HHYN0JD %} | {% mention C08K7ARJ58U %}<br>
Renamed: {% mention U080HHYN0JD ; MathiasDPX %} | {% mention C08K7ARJ58U ; get-a-cool-hat-ysws %}<br>
Unknown: {% mention C08N35P7LCT %} {% mention U1234567890 %}

## Emojis
GIF: {% emoji yay %}<br>
PNG: {% emoji errors %}

## Raw user
Name (root key): <code>{% user U080HHYN0JD name %}</code><br>
Pronouns (nested key): <code>{% user U080HHYN0JD profile.pronouns %}</code><br>
Is Admin (bool value): <code>{% user U080HHYN0JD is_admin %}</code><br>
TZ Offset (int value): <code>{% user U080HHYN0JD tz_offset %}</code><br>
Dog (unknown value): <code>{% user U080HHYN0JD dog %}</code>

## Raw channel
Name (root key): <code>{% channel C08P0L0GQJU name %}</code><br>
Purpose (nested key): <code>{% channel C08P0L0GQJU purpose.value %}</code><br>
Is Archived (bool value): <code>{% channel C08P0L0GQJU is_archived %}</code><br>
Updated (int value): <code>{% channel C08P0L0GQJU updated %}</code><br>
Cat (unknown value): <code>{% channel C08P0L0GQJU cat %}</code>