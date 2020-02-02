(
  (.started?   | values | "Build starting in \(.nix_file.shell)"),
  (.completed? | values | "Build complete in \(.nix_file.shell)"),
  (.failure?   | values | "Build failed in \(.nix_file.shell)")
)
