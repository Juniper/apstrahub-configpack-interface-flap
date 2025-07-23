resource "apstra_raw_json" "collector" {
  depends_on = [
    apstra_raw_json.service_registry
  ]
  url = "/api/telemetry/collectors"
  id = "Interface_Flap"
  payload = jsonencode({
    service_name = "Interface_Flap",
    collectors = [
      {
        platform = {
          os_type = "junos",
          os_version =  "21.2r2",
          family = "junos,junos-ex,junos-qfx",
          model = ""
        },
        source_type = "cli",
        cli = "show interfaces extensive",
        query = {
          accessors = {
            Interface = "/interface-information/physical-interface/name",
            value = "/interface-information/physical-interface/output-error-list/carrier-transitions"
          },
          keys = {
            Interface = "Interface",
          },
          values = {
            value = "int(value or 0)"
          },
          filter = "keys['Interface'].startswith([\"et-\", \"xe-\", \"ge-\"])"  },
        relaxed_schema_validation = true,
      }
    ],
  }
  )
}