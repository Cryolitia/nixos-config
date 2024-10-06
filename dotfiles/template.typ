#let conf(
    title: none,
    author: "Cryolitia",
    doc
  ) = {
    set page("a4")
    set par(leading: 1.5em, first-line-indent: 1.8em, justify: true)
    show par: set block(spacing: 1.5em)
    show heading: set block(above: 2.4em, below: 0em)

    set text(font: (
      "Source Han Serif",
      "JetBrainsMono NF"
    ), size: 12pt)
    show raw: text.with(font: ("等距更紗黑體 CL", "JetBrainsMono NF"))
    show heading: text.with(font: (
      "Source Han Sans SC",
      "JetBrainsMono NF"
    ))

    set heading(numbering: "1.")
    set list(indent: 2em)
    set enum(indent: 2em)

    let fake_par = {
      v(0em)
      box()
    }
    show heading: it => {
      it
      fake_par
    }

    set document(title: title, author: author)

    if title != none {
      set align(center)
      text(font: ("Source Han Serif"), 17pt, title)
    }

    if author != none {
      v(1em)
      set align(right)
      text(font: ("Source Han Serif"), author)
    }

    v(2em)

    doc
}

#let sans(body) = {
  set text(font: ("Source Han Serif"))
  [#body]
}


#show: doc => conf(
  title: "Title",
  doc,
)

= Introduction
#lorem(90)

== Motivation
#raw({lorem(50)})

= 岳阳楼记

豫章故郡，洪都新府。星分翼轸，地接衡庐。襟三江而带五湖，控蛮荆而引瓯越。物华天宝，龙光射牛斗之墟；人杰地灵，徐孺下陈蕃之榻。雄州雾列，俊采星驰。

台隍枕夷夏之交，宾主尽东南之美。都督阎公之雅望，棨戟遥临；宇文新州之懿范，襜帷暂驻。

十旬休假，胜友如云；千里逢迎，高朋满座。腾蛟起凤，孟学士之词宗；紫电青霜，王将军之武库。家君作宰，路出名区；童子何知，躬逢胜饯。

== 二级标题

#sans[

时维九月，序属三秋。潦水尽而寒潭清，烟光凝而暮山紫。俨骖騑于上路，访风景于崇阿。临帝子之长洲，得天人之旧馆。

层峦耸翠，上出重霄；飞阁流丹，下临无地。鹤汀凫渚，穷岛屿之萦回；桂殿兰宫，即冈峦之体势。

]
