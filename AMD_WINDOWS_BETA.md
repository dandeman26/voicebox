# Voicebox 0.5.1 AMD Windows Beta 2

This is an unsigned experimental Windows build for AMD Radeon RX 7000-series GPUs. It uses AMD's official PyTorch 2.9.1 + ROCm 7.2.1 Windows wheels instead of DirectML.

## Target system

- Windows 11 x64
- AMD Radeon RX 7900 XT (`gfx1100`)
- AMD Adrenalin 26.2.2 or a newer compatible driver
- About 10 GB of free disk space for the app, ROCm runtime, and temporary downloads, plus model storage

AMD's Windows matrix explicitly lists the RX 7900 XTX but not the RX 7900 XT. Both use the same `gfx1100` architecture, and Voicebox's ROCm implementation was tested upstream on another RDNA 3 card, the RX 7800 XT. Treat this build as experimental until it is verified on the RX 7900 XT.

## Install and enable AMD acceleration

1. Install `Voicebox_0.5.1_AMD_Beta_2_x64-setup.exe` from this release. Windows may show an unknown-publisher warning because this personal beta is not code-signed.
2. Open Voicebox and go to **Settings → GPU**.
3. Under **AMD ROCm Backend**, choose **Download**. The app downloads and verifies the ROCm server and runtime archives from this release.
4. When the download finishes, choose **Switch to ROCm backend**. Voicebox restarts its local server.
5. Confirm the GPU page shows **ROCm (AMD Radeon RX 7900 XT)**.

To verify from PowerShell while Voicebox is open:

```powershell
powershell -ExecutionPolicy Bypass -File .\verify-windows-rocm.ps1
```

If the server fails to start, switch back to the CPU backend from the GPU page. Voice profiles and generated audio remain in the normal Voicebox data folder.

## Security and scope

- All inference remains local, matching Voicebox's normal behavior.
- Downloads are checked against SHA-256 files before extraction.
- This beta does not include a trusted publisher signature or automatic updater artifacts.
- The build is based on upstream commit `f2cf2a729d733acd7c759d85c6ace2d602f50d6e` plus the AMD beta packaging fixes in this branch.
