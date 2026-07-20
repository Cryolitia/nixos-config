{
  security.rtkit.enable = true;

  services.pipewire.extraConfig.pipewire."20-virtual-mono-cable" = {
    "context.modules" = [
      {
        name = "libpipewire-module-loopback";
        args = {
          "node.description" = "IC-705 RX";
          "audio.rate" = 48000;
          "audio.channels" = 1;
          "audio.position" = [ "MONO" ];

          "capture.props" = {
            "node.name" = "ic705_rx_sink";
            "node.description" = "IC-705 RX Sink";
            "media.class" = "Audio/Sink";
            "node.virtual" = true;
          };

          "playback.props" = {
            "node.name" = "ic705_rx_source";
            "node.description" = "IC-705 RX Source";
            "media.class" = "Audio/Source";
            "node.virtual" = true;
          };
        };
      }

      {
        name = "libpipewire-module-loopback";
        args = {
          "node.description" = "IC-705 TX";
          "audio.rate" = 48000;
          "audio.channels" = 1;
          "audio.position" = [ "MONO" ];

          "capture.props" = {
            "node.name" = "ic705_tx_sink";
            "node.description" = "IC-705 TX Sink";
            "media.class" = "Audio/Sink";
            "node.virtual" = true;
          };

          "playback.props" = {
            "node.name" = "ic705_tx_source";
            "node.description" = "IC-705 TX Source";
            "media.class" = "Audio/Source";
            "node.virtual" = true;
          };
        };
      }

      {
        name = "libpipewire-module-loopback";
        args = {
          "node.description" = "SDR RX";
          "audio.rate" = 48000;
          # Internal layout used for remixing/downmixing.
          "audio.position" = [
            "FL"
            "FR"
          ];
          "capture.props" = {
            "node.name" = "sdr_rx_sink";
            "node.description" = "SDR RX Sink";
            "media.class" = "Audio/Sink";
            "node.virtual" = true;
            # What SDR++ sees: stereo output device.
            "audio.position" = [
              "FL"
              "FR"
            ];
          };
          "playback.props" = {
            "node.name" = "sdr_rx_source";
            "node.description" = "SDR RX Source";
            "media.class" = "Audio/Source";
            "node.virtual" = true;
            # What decoder apps see: mono input device.
            "audio.position" = [ "MONO" ];
          };
        };
      }
    ];
  };

}
