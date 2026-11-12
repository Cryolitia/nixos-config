{ lib, ... }:

{
  # macOS 15+ requires a configuration profile to manage Gatekeeper globally.
  # After rebuilding, run `open /etc/gatekeeper.mobileconfig` and install it in
  # System Settings > General > Device Management. Installation is only needed once.
  # https://developer.apple.com/documentation/devicemanagement/systempolicycontrol
  environment.etc."gatekeeper.mobileconfig".text = lib.generators.toPlist { escape = true; } {
    PayloadType = "Configuration";
    PayloadVersion = 1;
    PayloadIdentifier = "io.github.cryolitia.gatekeeper";
    PayloadUUID = "EF702A30-3348-4B61-B334-F046E661DCC0";
    PayloadDisplayName = "Allow apps from anywhere";
    PayloadDescription = "Allow applications from any source by disabling Gatekeeper assessments.";
    PayloadScope = "System";
    PayloadRemovalDisallowed = false;
    PayloadContent = [
      {
        PayloadType = "com.apple.systempolicy.control";
        PayloadVersion = 1;
        PayloadIdentifier = "io.github.cryolitia.gatekeeper.policy";
        PayloadUUID = "377D0AFE-6D78-4CEC-8CCB-61D0AE7107AC";
        PayloadDisplayName = "Gatekeeper policy";
        EnableAssessment = false;
      }
    ];
  };
}
