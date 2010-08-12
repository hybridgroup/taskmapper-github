Factory.define :issue, :class => Octopi::Issue do |p|
  p.repository 'test-juange'
  p.user  'juanespinosa'
  p.updated_at  ''
  p.votes  ''
  p.number  '1'
  p.title  'test'
  p.body  'test ticket body'
  p.closed_at  ''
  p.labels  ''
  p.state  'open'
  p.created_at  ''
end