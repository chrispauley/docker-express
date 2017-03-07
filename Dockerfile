FROM mhart/alpine-node
COPY index.js .
EXPOSE 8000
CMD node index.js
