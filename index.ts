import express from 'express'

const app = express()

app.get('/', (_, res) => {
  res.send('API working!')
})

app.listen(2021, () => {
  console.log('App running on port 2021')
})

