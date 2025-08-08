# Interface Flap Config Pack

## What does this Config Pack Do

This config pack creates the iba elements required to track how many interface flaps occur.
It also raises anomalies if the interface flaps cross a threshold.

## JunOS Compatibility
This Config Pack will work with version 21.2r2 on JunOS families junos, junos-ex and junos-qfx

## Components

| Component | Name                            | Description                                                                             |
|-----------|---------------------------------|-----------------------------------------------------------------------------------------|
|Service Registry | Interface_Flap_<blueprint_id>   | Service description for the DDOS collector                                              |
|Custom Collector| Interface_Flap_<blueprint_id>   | Custom Collector that reads the policer-violation-count in the ddos-system-statistics   |
|Probe| Interface_Flap                  | Probe that consumes the collector output and raises an anomaly if the count is not zero |
|Dashboard| Interface Flap                  | Dashboard that consumes the Probe|                                              |

