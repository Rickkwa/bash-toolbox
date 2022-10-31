function print_usage() {
    echo "MyScript - Does a thing."
    echo ""
    echo "Usage: ./$(basename $0) [OPTIONS] arg1 arg2"
    echo ""
    echo "Options:"
    echo -e "
    --help\tShow usage information.
    -f, --foo <value>\tFoo.
    -b, --bar <value>\tBar.
    -v, --verbose\tPrints more things." | column -t -s $'\t'
}


export POSIXLY_CORRECT=1  # Stop parsing at first occurrence of non-option. ie. options are BEFORE the args.

OPTIONS=$(getopt -l "help,foo:,bar:,verbose" -o "vf:b:" -- "$@")

if [ $? -ne 0 ]; then
    print_usage
    exit 1
fi

eval set -- "$OPTIONS"
while [ $# -ge 1 ]; do
    case "$1" in
        --)
            # No more options left.
            shift
            break
            ;;
        --help)
            print_usage
            exit 0
            ;;
        -f|--foo)
            FOO_VALUE="$2"
            shift
            ;;
        -b|--bar)
            BAR_VALUE="$2"
            shift
            ;;
        -v|--verbose)
            VERBOSE=1
            ;;
    esac
    shift
done

echo $#
