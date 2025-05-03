# jekyll-hackclub
![Gem Downloads](https://img.shields.io/gem/dt/jekyll-hackclub?label=downloads)
![Gem Version](https://img.shields.io/gem/v/jekyll-hackclub?label=latest)

This jekyll plugin can resolve channel id / user id to a \<a> link

jekyll-hackclub add class to the a tag for custom CSS:
- `hackclub-mention`: for both channels and users.
- `hackclub-user`: for users
- `hackclub-channel`: for channels
- `hackclub-emoji`: for emojis

## Examples
<sub>class attribute isn't showed here but is present has described above</sub>

### Resolve a mention
#channel and @user are consider mentions. The plugin will detect if it's a channel or a user with the first character (U or C) and give the correct url/displayname

Unknown users/private channels will have "unavailable" as the display name, but still have a working link.

```markdown
{% mention U080HHYN0JD %}
```
while resolve to
```html
<a href="https://hackclub.slack.com/team/U080HHYN0JD">@mathias</a>
```

You can add an argument for the display name like
```markdown
{% mention C08K7ARJ58U ; get-a-cool-hat-ysws %}
```
```html
<a href="https://hackclub.slack.com/archives/C08K7ARJ58U">#get-a-cool-hat-ysws</a>
```

### Add an emoji
No preprocessing while be applied to emoji, that mean if an emoji is 512x512, it will be 512x512 on your page, however you can copy css from `site/_sass/base.scss`

```
{% emoji errors %}
```
while resolve to
```html
<img src="https://emoji.slack-edge.com/T0266FRGM/errors/5f5a9514ccf00c85.png" title=":errors:" alt=":errors:" class="hackclub-emoji">
```

If a emoji isnt found, :alibaba-question: while be given because it's funny
<img src="https://emoji.slack-edge.com/T0266FRGM/alibaba-question/c5ba32ce553206b8.png" style="height:1.25em;vertical-align:middle;">