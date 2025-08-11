resource "apstra_raw_json" "service_registry" {
  url = "/api/telemetry-service-registry"
  id = "${var.name}"
  payload = jsonencode(
    {
      description        = "Interface flap service registry"
      application_schema = {
        properties = {
          key = {
            properties = {
              Interface ={
                type = "string"
              },
            },
            required = [
              "Interface"
            ],
            type = "object"
          },
          value = {
            type = "integer"
          }
        }
          required = [
            "key",
            "value"
          ],
          type = "object"
        },
        service_name = "${var.name}",
        storage_schema_path = "aos.sdk.telemetry.schemas.iba_integer_data",
      }
  )
}