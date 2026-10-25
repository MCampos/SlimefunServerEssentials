# SlimefunServerEssentials (SlimefunCore / Paper 26.3 port)

A plugin that exports Slimefun items and recipes to `.json` files and streams them to clients
running the [Slimefun Essentials](https://github.com/MCampos/SlimefunEssentials) mod over plugin
messages (`slimefun_server_essentials:loading_state`, `items`, `component_types`,
`recipe_categories` and `recipe_displays`).

This fork of [JustAHuman-xD/SlimefunServerEssentials](https://github.com/JustAHuman-xD/SlimefunServerEssentials)
targets:

- **Paper 26.3** (`io.papermc.paper:paper-api:26.3.build.222-stable`), compiled for **Java 25**
- **[SlimefunCore](https://modrinth.com/plugin/slimefuncore)** build 2880, the community fork of
  Slimefun4 for Minecraft 26.x (plugin name is still `Slimefun`)

The plugin-message wire format is unchanged from upstream `main`, so the Minecraft 26.3 build of the
Slimefun Essentials client mod works with it as-is.

## Building

SlimefunCore is not published to a Maven repository, so the exact Modrinth jar is used as a
compile-only dependency from a project-local file repository under `libs/` (the jar is git-ignored).

```bash
sh scripts/fetch-slimefuncore.sh   # or: pwsh scripts/fetch-slimefuncore.ps1
mvn clean package
```

Requires JDK 25 and Maven 3.9+. The shaded plugin jar is written to `target/`.

## What changed from upstream

- Build: Paper API 26.3 instead of Spigot 1.20.6; Java 25; SlimefunCore jar instead of the
  Slimefun4 JitPack artifact; dropped the `dough-api` and PaperLib dependencies; NBT-API 2.16.1
  (adds Minecraft 26.3 item support), bStats 3.2.1, Lombok 1.18.48; annotation processing
  enabled explicitly (`-proc:full`) because javac 23+ disables it by default.
- `CustomItemStack` is now taken from Slimefun's shaded dough
  (`io.github.thebusybiscuit.slimefun4.libraries.dough.items.CustomItemStack`), whose static
  `create(...)` factories return plain `ItemStack`s. The 0.2.0 release used
  `new CustomItemStack(...)`, which fails with a `VerifyError` on SlimefunCore.
- `javax.annotation` (JSR-305) is no longer provided by the Paper API, so `@Nonnull` became
  JetBrains `@NotNull` and `@ParametersAreNonnullByDefault` was removed.
- `plugin.yml` declares `api-version: '26.1'`.
