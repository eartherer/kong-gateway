FROM kong:latest

# Ensure any patching steps are executed as root user
USER root

# Add custom plugin to the image
COPY my-custom-plugin /usr/local/bin/my-custom-plugin
ENV KONG_PLUGINS=bundled,my-custom-plugin
ENV KONG_LUA_PACKAGE_PATH=/usr/local/bin/my-custom-plugin/?.lua;;

# Ensure kong user is selected for image execution
USER kong

# Run kong
ENTRYPOINT ["/docker-entrypoint.sh"]
EXPOSE 8000 8443 8001 8444
STOPSIGNAL SIGQUIT
HEALTHCHECK --interval=10s --timeout=10s --retries=10 CMD kong health
CMD ["kong", "docker-start"]