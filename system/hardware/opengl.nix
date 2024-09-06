{pkgs, ...}: {
  # graphics drivers / HW accel
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [nvidia-vaapi-driver];
  };
}
