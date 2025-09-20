{ ... }:
{
  enable = true;
  settings = {
    alias.daily = "zk new --no-input \"$ZK_NOTEBOOK_DIR/journal/daily\"";
    group.daily = {
      paths = [ "journal/daily" ];
      note = {
        filename = "{{format-date now '%Y-%m-%d'}}";
        template = "daily.md";
      };
    };
    notebook.dir = "~/Data/zk-notebook";
    note = {
      filename = "{{id}}-{{slug title}}";
      template = "default.md";
    };
    format.markdown = {
      multiword-tags = true;
    };
  };
}
