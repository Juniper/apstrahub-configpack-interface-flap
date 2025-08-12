resource "apstra_raw_json" "dashboard" {
  url = format("/api/blueprints/%s/iba/dashboards",var.blueprint_id)
  payload = jsonencode({
    label = "${var.name}",
    description = "",
    grid = [
      [
        {
          label = "Excessive Interface - Fabric Interfaces",
          description = "",
          type = "stage",
          probe_id = apstra_raw_json.probe.id,
          stage_name = "Interface_With_Excessive_Flap_Count",
          filter = "properties.Link_Role = \"spine_leaf\"",
          visible_columns = [
            "properties.system_id",
            "properties.Interface",
            "properties.Link_Role",
            "properties.Link_Speed",
            "properties.Remote_System",
            "properties.Remote_iface",
            "value"
          ],
          orderby = "",
          max_items = 100,
          anomalous_only = false,
          show_context = false,
          spotlight_mode = false,
          data_source = "real_time",
          time_series_duration = 86400,
          aggregation_period = 300,
          aggregation_type = "unset",
          combine_graphs = "none"
        }
      ],
      [
        {
          label = "Excessive Interface - Server facing Interfaces",
          description = "",
          type = "stage",
          probe_id = apstra_raw_json.probe.id,
          stage_name = "Interface_With_Excessive_Flap_Count",
          filter = "properties.Link_Role = \"to_generic\"",
          visible_columns = [
            "properties.system_id",
            "properties.Interface",
            "properties.Link_Role",
            "properties.Link_Speed",
            "properties.Remote_System",
            "properties.Remote_iface",
            "value"
          ],
          orderby = "value:ASC",
          max_items = 100,
          anomalous_only = false,
          show_context = false,
          spotlight_mode = false,
          data_source = "real_time",
          time_series_duration = 86400,
          aggregation_period = 300,
          aggregation_type = "unset",
          combine_graphs = "none"
        }
      ]
    ],
    default = false,
  }
  )
}