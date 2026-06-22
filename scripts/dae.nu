def dae [option: string] {
    match $option {
        # NOTE: the command should be the same as those defined in configuration.nix, to prevent sudo password.
        "on" => { sudo /usr/bin/systemctl start dae.service }
        "off" => { sudo /usr/bin/systemctl stop dae.service }
        "stat" => { /usr/bin/systemctl status dae.service }
        "test" => {
            let start = date now
            # NOTE: use http rather than https to improve test effenciency
            let result = (curl --max-time 10 -o /dev/null -sS http://google.com out+err>| complete)
            # let result = (curl --max-time 10 http://google.com | complete)
            let duration = (date now) - $start

            if $result.exit_code == 28 {
                print $"(ansi red_bold)Timeout after 10s(ansi reset)"
                print ""
            } else if $result.exit_code == 0 {
                print $"curl google.com returned within (ansi green_bold)($duration)(ansi reset)"
            } else {
                print $"(ansi red_bold)curl failed, exit code = ($result.exit_code)(ansi reset)"
            }
        }
        _ => {
        }
    }
}
