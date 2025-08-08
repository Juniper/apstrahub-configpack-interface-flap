resource "apstra_raw_json" "probe" {
  url = format("/api/blueprints/%s/probes",var.blueprint_id)
  depends_on = [
    apstra_raw_json.collector
  ]
  payload   = <<-EOT
  {
      "label": "Interface Flap",
      "description": "",
      "processors": [
        {
          "name": "Interface_Flap",
          "type": "extensible_data_collector",
          "properties": {
            "service_name": "Interface_Flap_${var.blueprint_id}",
            "service_interval": "60",
            "value_map": {},
            "graph_query": [
              "match(node('system', name='system', system_type='switch', deploy_mode='deploy').out('hosted_interfaces').node('interface', name='iface', if_name=not_none(), operation_state='up').out('link').node('link', link_type='ethernet', name='link').in_('link').node('interface', name='remote_iface').in_('hosted_interfaces').node('system', name='remote_system')).ensure_different('system', 'remote_system')"
            ],
            "service_input": "''",
            "Link_Speed": "str(link.speed)",
            "query_group_by": [],
            "keys": [
              "Interface"
            ],
            "Remote_iface": "str(remote_iface.if_name)",
            "ingestion_filter": {},
            "data_type": "static",
            "Remote_System": "str(remote_system.label)",
            "query_tag_filter": {
              "filter": {},
              "operation": "and"
            },
            "Interface": "str(iface.if_name)",
            "execution_count": "-1",
            "system_id": "system.system_id",
            "query_expansion": {},
            "enable_streaming": false,
            "Link_Role": "str(link.role)"
          },
          "inputs": {},
          "outputs": {
            "out": "Interface_Flap"
          }
        },
        {
          "name": "New_Flaps_Per_Collection_Interval",
          "type": "periodic_change",
          "properties": {
            "graph_query": [],
            "period": 60,
            "enable_streaming": false
          },
          "inputs": {
            "in": {
              "stage": "Interface_Flap",
              "column": "value"
            }
          },
          "outputs": {
            "out": "New_Flaps_Per_Collection_Interval"
          }
        },
        {
          "name": "Interface_With_Excessive_Flap_Count",
          "type": "range_check",
          "properties": {
            "property": "value",
            "raise_on_nan": false,
            "raise_anomaly": true,
            "graph_query": [],
            "anomaly_retention_duration": 86400,
            "range": {
              "min": ${var.minimum_flap}
            },
            "enable_streaming": false,
            "anomaly_retention_size": 1073741824,
            "enable_anomaly_logging": false
          },
          "inputs": {
            "in": {
              "stage": "New_Flaps_Per_Collection_Interval",
              "column": "value"
            }
          },
          "outputs": {
            "out": "Interface_With_Excessive_Flap_Count"
          }
        }
      ],
      "stages": [
        {
          "name": "Interface_With_Excessive_Flap_Count",
          "description": "",
          "units": {
            "value": ""
          },
          "enable_metric_logging": false,
          "retention_duration": 86400,
          "retention_size": 0,
          "graph_annotation_properties": {}
        },
        {
          "name": "New_Flaps_Per_Collection_Interval",
          "description": "",
          "units": {
            "value": ""
          },
          "enable_metric_logging": false,
          "retention_duration": 86400,
          "retention_size": 0,
          "graph_annotation_properties": {}
        },
        {
          "name": "Interface_Flap",
          "description": "",
          "units": {
            "value": ""
          },
          "enable_metric_logging": false,
          "retention_duration": 86400,
          "retention_size": 0,
          "graph_annotation_properties": {}
        }
      ]
    }
EOT
}