# outputs.tf

output "load_balancer_ip" {
  description = "The IP address of the load balancer"
  value       = kubernetes_service.simple_time_service.status[0].load_balancer[0].ingress[0].ip
}