# play

A keyboard-driven terminal music player. Search YouTube, Spotify, or SoundCloud,
stream the audio through [mpv](https://mpv.io), and control everything from a
compact TUI — with first-class support for **WSL** (audio plays through a Windows
`mpv.exe` while the UI runs in Linux).

```
  ♪ Lofi Hip Hop Radio - beats to relax/study to
  3:21:07  [2/10]
  ←→:seek ↑↓:vol Space:pause n/p:trk l:list s:settings q:quit
  00:42/3:21:07 [████████░░░░░░░░░░░░░░░░] 21%
```

## Features

- **Three providers** — YouTube (default), Spotify (search → played via YouTube
  audio), and SoundCloud.
- **Instant controls** — seek, volume, pause, next/prev, an arrow-navigable
  track list, and an in-app settings menu.
- **Background prefetch** — the next track's stream URL is resolved while the
  current one plays, so skips are near-instant.
- **tmux split UI** — when tmux is available, `play` opens in a split pane so
  your shell stays usable. The pane lives in a `music` session.
- **WSL-aware** — detects WSL and routes audio through Windows `mpv.exe`,
  bridging mpv's IPC over a named pipe. Closing the pane/terminal cleanly stops
  the Windows player (SIGHUP is trapped — no orphaned `mpv.exe`).

## Requirements

| Tool | Why | Install |
|------|-----|---------|
| `yt-dlp` | search + stream URL resolution | `pip install yt-dlp` |
| `mpv` | playback | Linux: `apt install mpv` / `brew install mpv` · WSL: install `mpv.exe` on Windows (mpv.io or `scoop install mpv`) |
| `tmux` | optional split-pane UI | `apt install tmux` |
| `python3` | native-audio IPC bridge + Spotify search | usually preinstalled |

## Install

```bash
git clone https://github.com/Sylveex/play.git
cd play
./install.sh        # copies bin/play to ~/.local/bin and lists deps
```

Make sure `~/.local/bin` is on your `PATH`.

## Usage

```bash
play lofi hip hop                 # search and play
play --provider soundcloud vaporwave
play --pos bottom --size 30 jazz  # pane position / size (% of terminal)
play --audio native ambient       # force Linux mpv instead of WSL mpv.exe
```

### Flags

| Flag | Values | Default |
|------|--------|---------|
| `--size N` | pane size, % of terminal | `20` |
| `--pos` | `top` `bottom` `left` `right` | `top` |
| `--audio` | `wsl` `native` | auto (`wsl` under WSL) |
| `--provider` | `youtube` `spotify` `soundcloud` | `youtube` |

### Keybindings

| Key | Action |
|-----|--------|
| `←` / `→` | seek −10s / +10s |
| `↑` / `↓` | volume +5 / −5 |
| `Space` | pause / resume |
| `n` / `p` | next / previous track |
| `l` | open track list (type to search again) |
| `s` | settings (provider, audio, size, position, Spotify keys) |
| `q` | quit |

## Configuration

Settings persist to `~/.config/play.conf` (written by the settings menu). It is
not tracked by this repo. Spotify search needs free API credentials from
[developer.spotify.com/dashboard](https://developer.spotify.com/dashboard);
add them in the settings menu (`s`) or directly in the config file:

```ini
PLAY_PROVIDER=youtube
PLAY_SIZE=20
PLAY_POS=top
PLAY_AUDIO=wsl
SPOTIFY_CLIENT_ID=...
SPOTIFY_CLIENT_SECRET=...
```

Binary/temp path overrides (env vars): `PLAY_MPV_LINUX`, `PLAY_MPV_WIN`,
`PLAY_WIN_TEMP`.

## License

MIT — see [LICENSE](LICENSE).
