provider "google" {
  project = "sergiopaulo-devops-iac"
  region  = "us-west1"
  zone    = "us-west1-c"
  credentials = "${file("serviceaccount.yaml")}"
}

resource "google_folder" "Comercial" {
  display_name = "Comercial"
  parent       = "organizations/12345678910"
}

resource "google_folder" "Web" {
  display_name = "Web"
  parent       = google_folder.Comercial.name
}

resource "google_folder" "Desenvolvimento" {
  display_name = "Desenvolvimento"
  parent       = google_folder.Web.name
}

resource "google_folder" "Producao" {
  display_name = "Producao"
  parent       = google_folder.Web.name
}


resource "google_project" "sergiopaulo-web-dev" {
  name       = "Web-Dev"
  project_id = "sergiopaulo-web-dev"
  folder_id  = google_folder.Desenvolvimento.name
  auto_create_network = false
  billing_account = "12345-54321-123456"

}


resource "google_project" "sergiopaulo-web-prod" {
  name       = "Web-Prod"
  project_id = "sergiopaulo-web-prod"
  folder_id  = google_folder.Producao.name
  auto_create_network = false
  billing_account = "12345-54321-123456"

}
