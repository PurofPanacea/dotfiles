function fish_greeting
    echo ""
    # Your ASCII text
    set lines \
    "            ██████╗ ███████╗███╗   ██╗ ██████╗ ██╗   ██╗██║███╗   ██╗    ███╗   ██╗ █████╗ ████████╗██╗ ██████╗ ███╗   ██║            " \
    "            ██╔══██╗██╔════╝████╗  ██║██╔════╝ ██║   ██║██║████╗  ██║    ████╗  ██║██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║            " \
    "            ██████╔╝█████╗  ██╔██╗ ██║██║  ███╗██║   ██║██║██╔██╗ ██║    ██╔██╗ ██║███████║   ██║   ██║██║   ██║██╔██╗ ██║            " \
    "            ██╔═══╝ ██╔══╝  ██║╚██╗██║██║   ██║██║   ██║██║██║╚██╗██║    ██║╚██╗██║██╔══██║   ██║   ██║██║   ██║██║╚██╗██║            " \
    "            ██║     ███████╗██║ ╚████║╚██████╔╝╚██████╔╝██║██║ ╚████║    ██║ ╚████║██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║            " \
    "            ╚═╝     ╚══════╝╚═╝  ╚═══╝ ╚═════╝  ╚═════╝ ╚═╝╚═╝  ╚═══╝    ╚═╝  ╚═══╝╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝            "

    # Define palette: Pink -> White -> Blue
    set palette F5A9B8 F7B7C4 F9C5D0 FBD3DC FDE1E8 FFFFFF E8F4FC D0E9F9 B8DFF6 A0D4F3 88CAF0 70BFE8 5BCEFA
    set palette_size (count $palette)

    # Render loop
    for y in (seq (count $lines))
        set line $lines[$y]
        set length (string length $line)

        for x in (seq $length)
            set char (string sub --start $x --length 1 $line)
            
            # Calculate index using only pre-defined variables
            # We use math to get a 1-based index
            set color_index (math -s0 "(($x - 1) * $palette_size / $length) + 1")
            
            # Clamp index to be safe
            if test $color_index -gt $palette_size
                set color_index $palette_size
            end
            
            set_color $palette[$color_index]
            printf "%s" $char
        end
        printf "\n"
    end

    set_color normal
    echo ""
end
