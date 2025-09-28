#let title = "iperf3"
#let author = "Cryolitia"

= iperf3

公开提供 `iperf3` 网络测速服务，请合理使用。

== 端点

位于 Site-01 的测速服务部署终端与自治系统出口间以 10Gbps 链路连接，不保证自治系统出口至其他自治系统的网络质量。

在 `5201` 端口开放 `TCP` 、 `UDP` 连接。

- `kp920.internal`
- `kp920.site-01.cryolitia.dn42`

== 参考链接

- #link("https://github.com/esnet/iperf")
- #link("https://man.archlinux.org/man/extra/iperf3/iperf3.1.en")
