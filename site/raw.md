---
---

<title>Raw tests - Jekyll-HackClub</title>
<link rel="stylesheet" href="./assets/styles.css">
<link rel="shortcut icon" type="image/x-icon" href="{{ '/assets/favicon.ico' | relative_url }}">

[Go back home](./)

## Mentions
Classic: {% mention U080HHYN0JD %} {% mention C08K7ARJ58U %} {% mention S05RNTN07SN %}<br>
Renamed: {% mention U080HHYN0JD ; MathiasDPX %} {% mention C08K7ARJ58U ; get-a-cool-hat-ysws %} {% mention S05RNTN07SN ; free-birds %} <br>
Unknown: {% mention C08N35P7LCT %} {% mention U1234567890 %} {% mention S0123456789 %}

With pipes: {% mention U080HHYN0JD | capitalize %} {% mention C08K7ARJ58U | uppercase | [0:-2] %} {% mention S05RNTN07SN | [0:-2] %}

## Emojis
GIF: {% emoji yay %}<br>
PNG: {% emoji errors %}

## Files
No args: {% file F07PV2SSJ64 %}<br>
Permalink: <code>{% file F07PV2SSJ64 ; permalink %}</code><br>
with pipe: <code>{% file F07PV2SSJ64 ; title ; [0:-6] | downcase %}

## Raw user
name (root key): <code>{% user U080HHYN0JD ; name %}</code><br>
profile.pronouns (nested key): <code>{% user U080HHYN0JD ; profile.pronouns %}</code><br>
is_admin (bool value): <code>{% user U080HHYN0JD ; is_admin %}</code><br>
tz_offset (int value): <code>{% user U080HHYN0JD ; tz_offset %}</code><br>
dog (unknown value): <code>{% user U080HHYN0JD ; dog %}</code><br>
with pipes: <code>{% user U080HHYN0JD ; name ; capitalize %}</code><br>

## Raw channel
name (root key): <code>{% channel C08P0L0GQJU ; name %}</code><br>
purpose.value (nested key): <code>{% channel C08P0L0GQJU ; purpose.value %}</code><br>
is_archived (bool value): <code>{% channel C08P0L0GQJU ; is_archived %}</code><br>
updated (int value): <code>{% channel C08P0L0GQJU ; updated %}</code><br>
cat (unknown value): <code>{% channel C08P0L0GQJU ; cat %}</code><br>
with pipes: <code>{% channel C08P0L0GQJU ; name ; [-4:-1] %}</code><br>

## Raw usergroup
id (root key): <code>{% usergroup S05RNTN07SN ; id %}</code><br>
channels (nested key): <code>{% usergroup S05RNTN07SN ; prefs.channels ; first %}</code><br>
name: <code>{% usergroup S05RNTN07SN ; name %}</code><br>

## Parser
Simple: <code>{% _parser hello james! %}</code><br>
Size: <code>{% _parser hello james! | size %}</code><br>
Substring: <code>{% _parser hello james! | [0:4] %}</code><br>
Negative substring: <code>{% _parser hello james! | [6:-1] %}</code><br>
Multiple pipes: <code>{% _parser hello james! | uppercase | [0:4] %}</code><br>
Multiple args: <code>{% _parser hello james! ; joe dalton %}</code><br>
Multiple args + pipe: <code>{% _parser hello james! | uppercase ; joe dalton | capitalize %}</code><br>
To int: <code>{% _parser 42 | to_int | multiply 2 %}</code><br>