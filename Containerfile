FROM registry.redhat.io/ubi9/nodejs-24:latest

USER 1001

# Set working directory
WORKDIR /opt/app-root/src

RUN mkdir -p /opt/app-root/src/workdir
# Install cline
RUN npm install -g cline

RUN mkdir -p /opt/app-root/src/.cline/settings

COPY cline-mcp-test.json /opt/app-root/src/.cline/settings/cline_mcp_settings.json

WORKDIR /opt/app-root/src/

ENV LLM_BASE="empty"
ENV LLM_API_KEY="empty"
ENV LLM_NAME="empty"
ENV LLM_PROVIDER=openai

CMD cline auth -k $LLM_API_KEY -b $LLM_BASE/v1 -m $LLM_NAME -p $LLM_PROVIDER && cd /opt/app-root/src/workdir && cline --verbose