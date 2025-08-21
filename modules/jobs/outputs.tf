output "jobs" {
  value = {
    for job in scaleway_job_definition.this : job => {
      id                 = job.id
      name               = job.name
      description        = job.description
      region             = job.region
      command            = job.command
      cpu_limit          = job.cpu_limit
      memory_limit       = job.memory_limit
      image_uri          = job.image_uri
      job_schedule       = job.cron[0].schedule
      job_timezone       = job.cron[0].timezone
      secret_id          = job.secret_reference[0].secret_id
      secret_version     = job.secret_reference[0].secret_version
      secret_file        = job.secret_reference[0].file
      secret_environment = job.secret_reference[0].environment
    }
  }
}