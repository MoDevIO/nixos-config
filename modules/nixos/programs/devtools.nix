{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    pnpm
    nodejs
    python3
    typescript
    tsx
  ];
}
