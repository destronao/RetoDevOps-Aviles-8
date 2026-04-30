FROM node:18-alpine
ENV PUERTO=8080
ENV NOMBRE_PARQUE='Eólica Naranco S.L.'
WORKDIR /app
COPY app.js .
RUN mkdir -p /data
EXPOSE 8080
CMD ["node", "app.js"]