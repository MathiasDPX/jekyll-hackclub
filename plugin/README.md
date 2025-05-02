# jekyll-hackclub
![Gem Downloads](https://img.shields.io/gem/dt/jekyll-hackclub?label=downloads)
![Gem Version](https://img.shields.io/gem/v/jekyll-hackclub?label=latest)

This jekyll plugin can resolve channel id / user id to a \<a> link

jekyll-hackclub add class to the a tag for custom CSS:
- `hackclub-mention`: for both channels and user.
- `hackclub-user`: for users
- `hackclub-channel`: for channel

## Examples
<sub>class attribute isn't showed here but is present has described above</sub>

### Resolve a mention
#channel and @user are consider mentions. The plugin will detect if it's a channel or a user with the first character (U or C) and give the correct url/displayname

Unknown users/private channels will have "unavailable" as the display name, but still have a working link.

```markdown
{% hackclub U080HHYN0JD %}
```
while resolve to
```html
<a href="https://hackclub.slack.com/team/U080HHYN0JD">@mathias</a>
```

You can add an argument for the display name like
```markdown
{% hackclub C08K7ARJ58U ; get-a-cool-hat-ysws %}
```
```html
<a href="https://hackclub.slack.com/archives/C08K7ARJ58U">#get-a-cool-hat-ysws</a>
```