= Running Nuclei in Docker 

Commands are not fully tested, use at your own risk!

# Create a volume
docker volume create nuclei-templates

# Populate with latest templates
docker run --rm -v nuclei-templates:/root/nuclei-templates projectdiscovery/nuclei:latest -update-templates

# Scan using the volume
docker run --rm -v nuclei-templates:/root/nuclei-templates projectdiscovery/nuclei:latest -u https://example.com

# Running All Templates (Community + Custom)
docker run --rm \
  -v nuclei-templates:/root/nuclei-templates \
  -v ~/my-templates:/app/custom-templates \
  projectdiscovery/nuclei:latest \
  -u https://example.com \
  -t /root/nuclei-templates \
  -t /app/custom-templates


# Example: Host directory "~/my-templates" mapped to "/app/templates" in the container
docker run --rm -v ~/my-templates:/app/templates projectdiscovery/nuclei:latest -u https://example.com -t /app/templates/custom.yaml


