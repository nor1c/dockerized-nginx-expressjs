import express from 'express'

const app = express()

app.get('/', (_, res) => {
  res.send('Sup bitch!')
})

app.listen(2021, '0.0.0.0', () => {
  console.log('App running on port 2021')
})