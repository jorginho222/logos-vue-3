FROM node:20-slim

ARG USER_ID=1000
ARG GROUP_ID=1000

RUN apt-get update && apt-get install -y git \
    && (groupadd -g ${GROUP_ID} developer || groupmod -n developer $(getent group ${GROUP_ID} | cut -d: -f1)) \
    && (useradd -l -u ${USER_ID} -g ${GROUP_ID} -m developer || usermod -l developer $(getent passwd ${USER_ID} | cut -d: -f1))

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN chown -R developer:developer /app && chmod +x entrypoint.sh

USER developer

EXPOSE 3000

ENTRYPOINT ["./entrypoint.sh"]

CMD ["npm", "run", "dev", "--", "--host"]
