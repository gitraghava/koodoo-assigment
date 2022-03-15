data "template_file" "mongo" {
  template = "${./service_configuration.json}"
}


data "mongodbatlas_cluster" "this"{
    project_id = var.mongoatlas_project_id
}

data "mongodbatlas_cluster" "this"{
    for_each = toset(data.mongodbatlas_cluster.this.result[*].name)
    project_id = var.mongoatlas_project_id
    name = each.value

    connection_strings = {
        for serviceName in var.service_configuration:
        "mongodb+srv://""${mongodbatlas_database_user.dbuser}":"var.password}"@"${mongodbatlas_cluster.cluster.name}"/"${each.value.mongooDatabase}"/"${roles.value}"
    }
}


