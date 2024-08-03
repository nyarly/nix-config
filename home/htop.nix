{config}:
{
  enable = true;
  settings = with config.lib.htop.fields;{
    ccount_guest_in_cpu_meter=0;
    color_scheme=0;
    delay=15;
    detailed_cpu_time=0;
    cpu_count_from_zero = false;
    fields =  [
      PID USER PRIORITY NICE
      M_SIZE M_RESIDENT M_SHARE
      STATE PERCENT_CPU PERCENT_MEM
      UTIME COMM
    ];
    hide_threads = true;
    hide_userland_threads = true;
    shadow_other_users = false;
    show_program_path = false;
    sort_key = PERCENT_MEM;
  } // (with config.lib.htop; leftMeters [
    (bar "AllCPUs2")
    (bar "Memory")
    (bar "Swap")
    (text "Zram")
  ]) // (with config.lib.htop; rightMeters [
    (text "Tasks")
    (text "LoadAverage")
    (text "Uptime")
    (text "Systemd")
  ]);
}
