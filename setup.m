# Introduction
## macOS Setup Guide
This note covers the basics of setting up a development environment on a New Mac. Main contents are following the guide of [sourabhbajaj](sourabhbajaj.com)

# System Preference

##First Time Setup

first thing for a new mac is update your system.
The following are what I am choose to config.

## Users and group

* login: change fast user switching meanu as Icon
* Set up Password, Apple ID, Picture, etc

## Trackpad

* Point&Click
    - Enable light tap to single click

## Dock

* Visual Settings
    - make the size of icons Smaller.
    - auto-hide the dock
    - I used to change the position to the left, but later I found it is easily wrong touch when you close the window.

## Finder

* General
    - Change New finder window show to open in your Home Directory.
* Sidebar
    - Add Home and my work directory
    - Uncheck all Shared boxes
## Menubar

* Change battery to show percentage symbols.

## Spotlight

* Uncheck fonts, images, files etc;
* Uncheck the keyboard shortcuts as we'll replacing them with alfred

## Accounts

* *Add an icloud account and sync Calender, Find my Mac, Contact etc*

## User Default

* enable repeating keys by pressing and holding down keys: `defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false`

* Change the default folder for screenshots

- Open the terminal and create the folder where you would like to store your screenshots
- Then run the following command: `defaults write com.apple.screencapture location /path/to/screenshots/ && killall SystemUIServer`

## how to write to NTFS on macOS Yosemite(10.10) and EI Caption

Currently I am not encount this need.

# Xcode

Xcode is what you need to develop multi-language on mac. It is an integrated development environment for macOS containg a suite of software development tools developed by Apple for developint software for macOS, iOS, watchOS and tvOS.

## XQuartz

XQuartz is Apple Inc.'s version of the X server, a component of the X Window System for macOS. It might be useful if your are developing software for macOS

# Homebrew

Strongly recommend this commandline tool as a package management for macOS.

## Installtion 

Before you can run Homebrew you need to have the Command Line Tools for Xcode installed.

## Using Homebrew

To install a package, simple type

`brew install <formula>`

To update Homebrew's directory for fomulae, run:

` brew update`

Note: if that command fails you can manually download the directory of formulae like this:

` cd /usr/local/Homebrew/
  git fetch origin
  git reset --hard origin/master
`
To see if any formulas need to be updated:

` brew outdated`

To update a formula

` brew upgrade <formula>`

homebrew keep older version of formula installed on your system, in case you want to roll back to an old version. That rarely is necessary, so you can do some clean up to get rid of those old versions:

` brew cleanup`

If you want to see what formula Homebrew would delete without actually deleting them, you can type:

` brew cleanup --dry-run`

To see what you have installed(with their version numbers):

` brew list --version` or for cask
` brew cask list --version`

To search for formula you run:

` brew search <formula>`

To get more information about a formula you run:

` brew info <formula>`

To uninstall a formula:

` brew uninstall <formula>`

## Homebrew-Cask

Homebrew-cask extends homebrew and allows you to install large binary files via a command-line tool. You can for example intall applications like Google Chorme, Dropbox, VLC and spectacle etc.

### Installation

You need homebrew on your system to use Cask, and you make Cask avaliable by adding it as a tap:

` brew tap caskroom/cask`

###  Search

To search if an app is available on Cask:

` brew cask search <package>`

### Example Applications

#### Quick look plugins

These plugins add support for the corresponding file type to Mac Quick Look.

The plugins includes features like syntax highlighting, Markdown rendering, preview of JSON, patch files, CSV, ZIP files and more.

`
brew cask install \
    qlcolorcode \
    qlstephen \
    qlmarkdown \
    quicklook-json \
    qlprettypatch \
    quicklook-csv \
    betterzipql \
    webpquicklook \
    suspicious-package
`


#### App Suggestions

Here are some useful apps that are available on Cask.

` brew cask install \
    alfred \
    android-file-transfer \
    asepsis \
    appcleaner \
    caffeine \
    cheatsheet \
    docker \
    doubletwist \
    dropbox \
    google-chrome \
    google-drive \
    google-hangouts \
    flux \
    latexian \
    1password \
    pdftk \
    spectacle \
    sublime-text \
    superduper \
    totalfinder \
    transmission \
    valentina-studio \
    vlc
`

later I will try those apps.

# iTerm2

iTerm2 is an open source replacement for Apple's Terminal. I highly recommand to install this tool.

## Installation

You can get this from homebrew

`cask install iterm2`

## Customization

iterm2 is highly customizable and there are a lot of amazing features waiting for you. The following is something basics.

### colors and Fonts Settings

Here are some suggested setting you can apply, they are optional.

* I set the hot-key to open and close the terminal to :
`control + option + t` using the system automation tools.

* Go to profiles->Default->Terminal->Check silence bell to disable the terminal session from making any sound.

* Download one of the iTerm2 color schemes and then set these as the default profile colors.(I recommend solarized)

* Change the cursor text and cursor color to yellow make it more visilbe.

* Change the font to 14pt Source Code Pro Lite.

## Zsh

The Z shell is a Unix shell that is built on top of `bash`

The configuration file for `zsh` is called `.zshrc` and lives in your home folder(`~/.zshrc`)

## Oh My Zsh

Oh My Zsh is an open source, community-driven framework for managing your `zsh` configuration.

## tree

tree is a recursive directory listing command that produce a depth indented listing of files.

### Installation

To install the latest version, use homebrew:

`brew install tree`

### Usage 

Running `tree` will produce output like 

To limit the recursion you can pass an `-L` flag and specify the maximum depth.

` tree -L 1`

## fzf

fzf is a general-purpose comman-line fuzzy finder. it becomes very powerful when combined with other tools.

### Installation

Use homebrew

` brew install fzf`

### Example Usages

Add any of these function to your shell configuration file and apply the changes to try them out.

```
# fd - cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

```
```
# fh - search in your command history and execute selected command
fh() {
  eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}
```

### Chorme history from your terminal

```
# ch - browse chrome history
ch() {
  local cols sep
  cols=$(( COLUMNS / 3 ))
  sep='{::}'

  cp -f ~/Library/Application\ Support/Google/Chrome/Profile\ 1/History /tmp/h

  sqlite3 -separator $sep /tmp/h \
    "select substr(title, 1, $cols), url
     from urls order by last_visit_time desc" |
  awk -F $sep '{printf "%-'$cols's  \x1b[36m%s\x1b[m\n", $1, $2}' |
  fzf --ansi --multi | sed 's#.*\(https*://\)#\1#' | xargs open
}
```

## ack 

ack is a search tool designed for code. It's built to be a replacement for grep with higher speed and more options.

Fecture:
* Faster
* Skips unimportant files by default
* It searches recursively by default
* Customize

` brew install ack`

### Usage

` ack [OPTION] ... PATTERN [FILES OR DIRECTOR]`

# Git

`brew install git`
` git --version`
`which git` should output `/usr/local/bin/git`

Next, define your Git user(should be the same name and email you use for GitHub)

```
$ git config --global user.name "Your Name Here"
$ git config --global user.email "your_email@youremail.com"
```

## SSH Config for GitHub

check for existing SSH keys

` ls -al ~/.ssh` # list the files in your .ssh directory, if they exists.

if you don't have either `id_rsa.pub` or ` id_dsa.pub`, read on. Otherwise skip the next section.

## Generate a new SSH key

```
ssh-keygen -t rsa -C "your_email@example.com"
# Creates a new ssh key, using the provided email as a label
```
## Add your SSH key to the ssh-agent

Run the follow commands to add your SSH key to the `ssh-agent`

` eval "$(ssh-agent) -s"`

If you're running macOS Sierra 10.12.2 or later, you will need to modify your `~/.ssh/config` file to automatically load keys into the ssh-agent and store passphrases in your keychain:

```
Host *
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_rsa
```

No matter what operating system version you run you need to run this command to complete this step:

` ssh-add -K ~/.ssh/id_rsa`

## Adding a new SSH key to your GitHub account

The last step is to let GitHub know about your SSH key. Run this command to copy your key to your clipboard:

` pbcopy < ~/.ssh/id_rsa.pub`

# TextEdit

## vim

## Emacs

## Sublime Text
Sublime Text is a widely used editor that describes it self as a sophisticated text editor for code, markup and prose.

### Installation

Download from the official website.

### Use CLI to open file

### Preferences

This is an example of User Setting for a basic development. But fell free to modify or update as per your choice.

```
{
    "auto_complete_delay": 5,
    "auto_complete_selector": "source, text",
    "color_scheme": "Packages/User/Monokai (SL).tmTheme",
    "create_window_at_startup": false,
    "folder_exclude_patterns":
    [
        ".svn",
        ".git",
        ".DS_Store",
        "__pycache__",
        "*.pyc",
        "*.pyo",
        "*.exe",
        "*.dll",
        "*.obj",
        "*.o",
        "*.a",
        "*.lib",
        "*.so",
        "*.dylib",
        "*.ncb",
        "*.sdf",
        "*.suo",
        "*.pdb",
        "*.idb",
        "*.psd"
    ],
    "font_face": "Source Code Pro",
    "font_size": 13,
    "ignored_packages":
    [
        "Markdown",
        "Vintage"
    ],
    "open_files_in_new_window": false,
    "rulers":
    [
        80
    ],
    "translate_tabs_to_spaces": true,
    "word_wrap": true
}
```

### Packages

* Install Package control

* Recommend plugins

- Alignment: Easy alignment of multiple selections and multi-line selections
- All Autocomplete: Extend Sublime Text 2 auto-completion to find matches in all open files of the current window
- AutoFileName: Plugin that auto-completes filenames
- Bootstrap 3 Snippets: Twitter Bootstrap 3 snippets plugin for Sublime Text 2 and 3
- BracketHighlighter: Bracket and tag highlighter
- Dictionaries: Hunspell UTF8 dictionaries
- DictionaryAutoComplete: Plugin that adds dictionary entries to the completions inside comments
- EncodingHelper: Guess encoding of files, show in status bar, convert to UTF-8 from a variety of encodings
- FileDiffs: Shows diffs between the current file, or selection(s) in the current file, and clipboard, another file, or unsaved changes
- Git: Plugin for some Git integration
- GitGutter: A Sublime Text 2 and 3 plugin to see git diff in gutter
- IndentXML: Plugin for re-indenting XML and JSON files
Jade: A comprehensive bundle for the Jade template language
Jedi - Python autocompletion: Jedi is an autocompletion tool for Python
- Jekyll: A plugin for Jekyll static sites
- LaTeXTools: A LaTeX Plugin for Sublime Text 2 and 3
- Python Auto-Complete: Sublime Text 2 plugin which adds additional auto-completion capability to Python scripts
- Python Imports Sorter: Sublime Text 2 plugin to organize your imports easily
- Python PEP8 Autoformat: Python PEP8 auto-format is a plugin to interactively reformat Python source code according to PEP-8
- PythonTraceback: Easy navigation in your python tracebacks
- SideBarEnhancements: Enhancements to sidebar. Files and folders.
- SublimeCodeIntel: Full-featured code intelligence and smart auto-complete engine
- SublimeLinter: Interactive code linting framework for Sublime Text 3
- SublimeLinter-pep8: Linter plugin for python using PEP8
TrailingSpaces: Highlight trailing spaces and delete them in a flash

### SublimeLinter Setting

```
{
    "user": {
        "debug": false,
        "delay": 0.25,
        "error_color": "D02000",
        "gutter_theme": "none",
        "gutter_theme_excludes": [],
        "lint_mode": "background",
        "linters": {
            "pep8": {
                "@disable": false,
                "args": [],
                "disable": "",
                "enable": "",
                "excludes": [],
                "ignore": "",
                "max-line-length": null,
                "rcfile": "",
                "select": ""
            }
        },
        "mark_style": "outline",
        "no_column_highlights_line": false,
        "paths": {
            "linux": [],
            "osx": [
                "/usr/local/bin/"
            ],
            "windows": []
        },
        "python_paths": {
            "linux": [],
            "osx": [
                "/usr/local/bin/"
            ],
            "windows": []
        },
        "rc_search_limit": 3,
        "shell_timeout": 10,
        "show_errors_on_save": false,
        "show_marks_in_minimap": true,
        "syntax_map": {
            "html (django)": "html",
            "html (rails)": "html",
            "html 5": "html",
            "php": "html",
            "python django": "python"
        },
        "warning_color": "DDB700",
        "wrap_find": true
    }
}
```

# Python

use anaconda
` brew intall anaconda`

# CPlusPlus

Make sure you have installed Xcode command line tools. Check the C++ version to make sure ti is Clang 4.0+

```
C++ --version

```

To be able to compile files from your terminal you can add the following alias in you `env.sh` file:

`alias cppcompile='c++ -std=c++11 -stdlib=libc++'`

Then you can run all cpp file directly using `cppcompile main.cpp`

# LaTeX

## Installation

Texlive+Texstudio

# Other Free Apps 

## Procuctivity

* Alfred 3 for Mac. Alfred is an award-winning app for Mac OS X which boosts your efficiency with hotkeys, keywords, text expansion and more. Search your Mac and the web, and be more productive with custom actions to control your Mac.

* AppCleaner: Unistall apps

* Caffeine: Stops the machine from going into sleep mode.

* DoubleTwist: Import your playlists, ratingsm, musics and viedos. Create new playlists to your heart's content. Rate your songs and videos. Play your music and videos and view all of your photos.

* Dropbox File syncing to the cloud. It syncs files across all devices (laptop, mobile, tablet), and serves as a backup as well!

* Google drive 

* Notebooks

* PDF Toolkit+

* Spectacle

* Timing

* Total Finder. Adds tabs and improves the Finder to a great deal

* Transmission: A fast, easy and free BitTorrent client.

* Unarchiver: extremely powerful compress/uncompress app.

## Office Apps

- Wiznote
- Microsoft Office
- Numbers
- Pages

## Others 

* Asepsis: Get rid of the annoying DS_Store files. It stops them from being created anywhere on the system.

* Cheatsheet: Tap command key for long to see all the keyboard shortcut.

* Mou: Markdown editor for developers.

* typora: Readable and Writable with a seamless express. What You see is What You Mean. Best markdown editor I have seen.

* skim a PDF reader and note-taker for Academic paper on OS X. 

* superduper Take backup of your disk and use the backup disk to restore failure.

* Timeout: scheduled work breaks to prevent stree injuries.

* VLC: VLC Media Player.

* Voila: Record your screen with audio, mouse highlight and other features.





