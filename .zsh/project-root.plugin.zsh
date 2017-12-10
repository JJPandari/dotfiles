# A list of files considered to mark the root of a project.
# The bottommost (parentmost) match has precedence.
project_root_files_bottom_up=(
    ".projectile" # projectile project marker
    ".git"        # Git VCS root dir
    ".hg"         # Mercurial VCS root dir
    ".fslckout"   # Fossil VCS root dir
    "_FOSSIL_"    # Fossil VCS root DB on Windows
    ".bzr"        # Bazaar VCS root dir
    "_darcs"      # Darcs VCS root dir
)


# A list of files considered to mark the root of a project.
# The topmost match has precedence.
project_root_files=(
    "rebar.config"       # Rebar project file
    "project.clj"        # Leiningen project file
    "build.boot"         # Boot-clj project file
    "SConstruct"         # Scons project file
    "pom.xml"            # Maven project file
    "build.sbt"          # SBT project file
    "gradlew"            # Gradle wrapper script
    "build.gradle"       # Gradle project file
    ".ensime"            # Ensime configuration file
    "Gemfile"            # Bundler file
    "requirements.txt"   # Pip file
    "setup.py"           # Setuptools file
    "tox.ini"            # Tox file
    "composer.json"      # Composer project file
    "Cargo.toml"         # Cargo project file
    "mix.exs"            # Elixir mix project file
    "stack.yaml"         # Haskell's stack tool based project
    "info.rkt"           # Racket package description file
    "DESCRIPTION"        # R package description file
    "TAGS"               # etags/ctags are usually in the root of project
    "GTAGS"              # GNU Global tags
)

# A list of files considered to mark the root of a project.
# The search starts at the top and descends down till a directory
# that contains a match file but its parent does not.  Thus, it's a
# bottommost match in the topmost sequence of directories
# containing a root file."
project_root_files_top_down_recurring=(
     ".svn" # Svn VCS root dir
     "CVS"  # Csv VCS root dir
    "Makefile"
)

project_root_bottom_up() {
    local segments=(${(s:/:)PWD} '')
    local dir=/
    for seg in ${segments[@]}; do
        for f in ${project_root_files_bottom_up[@]}; do
            if [ -e "$dir/$f" ]; then
              echo $dir
              return
            fi
        done
        dir="$dir/$seg"
    done
}

project_root_top_down() {
    local pwd=$PWD
    while [ -n "$pwd" ]; do
        for f in ${project_root_files[@]}; do
            if [ -e "$pwd/$f" ]; then
              echo $pwd
              return
            fi
        done
        pwd=${pwd%/*}
    done
}

project_root_top_down_recurring() {
    local pwd=$PWD
    while [ -n "$pwd" ]; do
        for f in ${project_root_files_top_down_recurring[@]}; do
            if [ -e "$pwd/$f" ]; then
              if [ ! -e "$pwd/../$f" ]; then
                echo $pwd
                return
              fi
            else
              return
            fi
        done
        pwd=${pwd%/*}
    done
}

project_root() {
    local root=''
    for fun in project_root_bottom_up project_root_top_down project_root_top_down_recurring; do
        root=$($fun)
        if [ -n "$root" ]; then
          echo "$root"
          return
        fi
    done
}


project_root_widget() {
    local root=$(project_root)
    if [ -n "$root" ]; then
        cd "$root"
        local ret=$?
        zle redisplay
        typeset -f zle-line-init >/dev/null && zle zle-line-init
        return $ret
    fi
}


zle -N project_root_widget

