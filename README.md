# microvm-examples
Extremely simple examples for [microvm](https://github.com/astro/microvm.nix), easily appliable to your configs

I only started playing around with microvms the day before making this repo, so im no expert.

> [!WARNING]
> This is a simplified snippet of my current homelab.
> 
> Most vm configs can be safely applied, host configurations are in ./nixos

## Rebuilding
Rebuilding is as easy as `sudo nixos-rebuild switch --flake .#Avalanche`
> [!NOTE]
> This will apply the changes to the microvms as well since i implemented [declarative deployment](https://astro.github.io/microvm.nix/declarative.html#declarative-deployment)

## Updating VMs
Did you change some vm configuration? When rebuilding the host (#Avalanche) it may say the microvms didnt restart.

Restarting the microvms requires `sudo microvm -Ru (microvm name)`
>For example, you can restart the Minecraft microvm after tweaking its configs and rebuilding the host with:
`sudo microvm -Ru Minecraft`

## Extra
Not sure why but removal of microvms is iffy. These may help:

>https://github.com/astro/microvm.nix/issues/181
>
>[removing-microvms](https://astro.github.io/microvm.nix/microvm-command.html#removing-microvms)

## Useful links:
https://astro.github.io/microvm.nix/

https://github.com/astro/microvm.nix

You can message me on discord: soikr
