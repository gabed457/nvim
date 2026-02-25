local ls = require('luasnip')
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  -- Kubernetes Deployment
  s('deploy', {
    t({ 'apiVersion: apps/v1', 'kind: Deployment', 'metadata:', '  name: ' }),
    i(1, 'app-name'),
    t({ '', '  labels:', '    app: ' }),
    i(2, 'app-name'),
    t({ '', 'spec:', '  replicas: ' }),
    i(3, '3'),
    t({ '', '  selector:', '    matchLabels:', '      app: ' }),
    i(4, 'app-name'),
    t({ '', '  template:', '    metadata:', '      labels:', '        app: ' }),
    i(5, 'app-name'),
    t({ '', '    spec:', '      containers:', '        - name: ' }),
    i(6, 'app-name'),
    t({ '', '          image: ' }),
    i(7, 'image:tag'),
    t({ '', '          ports:', '            - containerPort: ' }),
    i(8, '3000'),
  }),

  -- Kubernetes Service
  s('svc', {
    t({ 'apiVersion: v1', 'kind: Service', 'metadata:', '  name: ' }),
    i(1, 'app-name'),
    t({ '', 'spec:', '  selector:', '    app: ' }),
    i(2, 'app-name'),
    t({ '', '  ports:', '    - protocol: TCP', '      port: ' }),
    i(3, '80'),
    t({ '', '      targetPort: ' }),
    i(4, '3000'),
    t({ '', '  type: ' }),
    i(5, 'ClusterIP'),
  }),

  -- Kubernetes Pod
  s('pod', {
    t({ 'apiVersion: v1', 'kind: Pod', 'metadata:', '  name: ' }),
    i(1, 'pod-name'),
    t({ '', '  labels:', '    app: ' }),
    i(2, 'app-name'),
    t({ '', 'spec:', '  containers:', '    - name: ' }),
    i(3, 'container-name'),
    t({ '', '      image: ' }),
    i(4, 'image:tag'),
    t({ '', '      ports:', '        - containerPort: ' }),
    i(5, '3000'),
  }),

  -- Kubernetes ConfigMap
  s('cm', {
    t({ 'apiVersion: v1', 'kind: ConfigMap', 'metadata:', '  name: ' }),
    i(1, 'config-name'),
    t({ '', 'data:', '  ' }),
    i(2, 'KEY'),
    t(': '),
    i(3, 'value'),
  }),
}

-- vim: ts=2 sts=2 sw=2 et
