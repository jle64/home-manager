{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      sunshine
      wayvr
    ];
  };
}
