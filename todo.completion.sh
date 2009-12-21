_todo() {
  local cur prev commands opts
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD-1]}"

  commands="add a addto app append archive birdseye command del \
            rm depri dp do help list ls listall lsa listcon  \
            lsc listfile lf listpri lsp listproj lsproj move \
            mv prepend prep pri p replace report whatdid"

  opts="-@ -@@ -+ -d -f -h -p -P -a -n -t -v -vv -V"

  case "${prev}" in
    # start whatdid specific options
    whatdid)
      local whatdidopts
      whatdidopts="--dates --last"
      COMPREPLY=( $(compgen -W "${whatdidopts}" -- ${cur}) )
      return 0
    ;;
    # dates and last can both exist and should short circut
    --dates)
      local second
      second="${COMP_WORDS[COMP_CWORD-2]}"
      if [[ ${second} == whatdid ]]
      then
        local dateopt
        dateopt="--last"
        COMPREPLY=( $(compgen -W "${dateopt}" -- ${cur}) )
      fi
      return 0
    ;;
    --last)
      return 0
    ;;
    # all other completions
    # TODO add a short circut to only allow one command
    *)
      if [[ ${cur} == -* ]]
      then
        # return the option args
        COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
        return 0
      else
        # everything else is a command
        COMPREPLY=( $(compgen -W "${commands}" -- ${cur}) )
        return 0
      fi
    ;;
  esac
}
complete -F _todo todo.sh
