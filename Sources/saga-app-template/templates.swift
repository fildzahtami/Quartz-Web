import Foundation
import HTML
import Saga
import SagaPathKit
import SagaSwimRenderer

func baseHtml(title pageTitle: String, @NodeBuilder children: () -> NodeConvertible) -> Node {
  html(lang: "en-US") {
    head {
      meta(charset: "utf-8")
      meta(content: "width=device-width, initial-scale=1", name: "viewport")
      meta(content: "Quartz is a gamified screen-time manager and digital wellness sanctuary that helps you break the infinite scrolling loop.", name: "description")
      title { pageTitle }
      
      // Load Google Fonts (Outfit and Inter)
      link(href: "https://fonts.googleapis.com", rel: "preconnect")
      link(crossorigin: "true", href: "https://fonts.gstatic.com", rel: "preconnect")
      link(href: "https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&family=Outfit:wght@600;700;800&display=swap", rel: "stylesheet")
      
      link(href: Saga.hashed("./static/style.css"), rel: "stylesheet")
    }
    body {
      header(class: "site-header") {
        nav(class: "site-nav") {
          a(class: "site-title", href: "/") {
            span(class: "text-neon-purple mr-1") { "◆" }
            span { SiteMetadata.name }
          }
          div(class: "nav-links hidden md:flex") {
            a(href: "/#quota") { "Doomscroll Quota" }
            a(href: "/#gym") { "Attention Gym" }
            a(href: "/#economy") { "Focus Economy" }
            a(href: "/#rank") { "Leaderboard" }
            a(href: "/#faq") { "FAQ" }
          }
          div {
            a(class: "inline-flex items-center justify-center rounded-full bg-neon-purple/20 border border-neon-purple/30 px-4 py-1.5 text-xs font-semibold text-white no-underline hover:bg-neon-purple/40 transition-colors", href: "https://testflight.apple.com/join/G8ufCuTB") {
              "TestFlight"
            }
          }
        }
      }
      main {
        children()
      }
      footer {
        nav(class: "footer-nav") {
          a(class: "flex items-center gap-1 font-bold text-ink no-underline hover:text-white", href: "/") {
            span(class: "text-neon-purple") { "◆" }
            span { SiteMetadata.name }
          }
          div(class: "nav-links") {
            a(href: "/privacy-policy") { "Privacy Policy" }
          }
        }
        p {
          "Built with "
          a(href: "https://github.com/loopwerk/Saga") { "Saga." }
          " Quartz Website © 2026."
        }
      }
    }
  }
}

func renderArticle(context: ItemRenderingContext<ArticleMetadata>) -> Node {
  baseHtml(title: context.item.title) {
    article {
      h1 { context.item.title }
      ul(class: "tags") {
        context.item.metadata.tags.map { tag in
          li {
            a(href: "/articles/tag/\(tag.slugified)/") { tag }
          }
        }
      }
      Node.raw(context.item.body)
    }
  }
}

func renderArticles(context: ItemsRenderingContext<ArticleMetadata>) -> Node {
  baseHtml(title: "Articles") {
    h1 { "Articles" }
    context.items.map { article in
      div(class: "article-card") {
        h2 {
          a(href: article.url) { article.title }
        }
        if let summary = article.metadata.summary {
          p { summary }
        }
      }
    }
  }
}

func renderTag<T>(context: PartitionedRenderingContext<T, ArticleMetadata>) -> Node {
  baseHtml(title: "Articles tagged \(context.key)") {
    h1 { "Articles tagged \(context.key)" }
    context.items.map { article in
      div(class: "article-card") {
        h2 {
          a(href: article.url) { article.title }
        }
      }
    }
  }
}

func renderPage(context: ItemRenderingContext<EmptyMetadata>) -> Node {
  // Use the full landing page layout for the homepage
  if context.item.url == "/" || context.item.url.hasSuffix("/index") {
    return renderHomePage(context: context)
  }
  // Generic page layout for privacy policy, etc.
  return baseHtml(title: "\(context.item.title) — \(SiteMetadata.name)") {
    div(class: "mx-auto max-w-3xl px-6 py-20") {
      h1(class: "mb-8 font-display") { context.item.title }
      div(class: "prose-content") {
        Node.raw(context.item.body)
      }
    }
  }
}

func renderHomePage(context: ItemRenderingContext<EmptyMetadata>) -> Node {
  baseHtml(title: "Reduce Noise. Regain Focus. — \(SiteMetadata.name)") {

    // ─── HERO ───────────────────────────────────────────────────────────────
    section(class: "relative overflow-hidden min-h-screen flex items-center") {
      // Background glow orbs
      div(class: "bg-orb w-[600px] h-[600px] -top-40 -right-40 bg-neon-purple") {}
      div(class: "bg-orb w-[400px] h-[400px] top-1/2 -left-20 bg-neon-blue") {}

      div(class: "container-custom relative z-10 flex flex-col items-center text-center gap-10 md:flex-row md:text-left md:gap-16") {
        // Left: text block
        div(class: "flex-1 flex flex-col gap-6") {
          div(class: "inline-flex items-center self-center md:self-start gap-2 rounded-full border border-neon-purple/30 bg-neon-purple/10 px-4 py-1.5 text-xs font-semibold text-neon-purple") {
            span { "◆" }
            span { "Now on TestFlight" }
          }

          h1(class: "font-display text-5xl font-extrabold leading-tight tracking-tight md:text-7xl") {
            span(class: "gradient-text-purple-blue") { "Reduce Noise." }
            Node.raw("<br>")
            "Regain Focus."
          }

          p(class: "max-w-lg text-lg text-muted leading-relaxed") {
            "Break the infinite doomscroll loop. Shield your feeds, complete focus arcade challenges to earn screen time, and stack Prismas as you master your attention."
          }

          div(class: "flex flex-col sm:flex-row items-center self-center md:self-start gap-4 mt-2") {
            Node.raw("""
            <a class="glowing-btn gap-2" href="https://testflight.apple.com/join/G8ufCuTB">
              <svg class="w-4 h-4 inline mr-1" fill="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path d="M18.71 19.5c-.83 1.24-1.71 2.45-3.05 2.47-1.34.03-1.77-.79-3.29-.79-1.53 0-2 .77-3.27.82-1.31.05-2.3-1.32-3.14-2.53C4.25 17 2.94 12.45 4.7 9.39c.87-1.52 2.43-2.48 4.12-2.51 1.28-.02 2.5.87 3.29.87.78 0 2.26-1.07 3.8-.91.65.03 2.47.26 3.64 1.98-.09.06-2.17 1.28-2.15 3.81.03 3.02 2.65 4.03 2.68 4.04-.03.07-.42 1.44-1.38 2.83M13 3.5c.73-.83 1.94-1.46 2.94-1.5.13 1.17-.34 2.35-1.04 3.19-.69.85-1.83 1.51-2.95 1.42-.15-1.15.41-2.35 1.05-3.11z"/></svg>
              Download on TestFlight
            </a>
            """)
            a(class: "btn-secondary", href: "#quota") {
              "How it Works"
            }
          }
        }

        // Right: floating crystal visual
        div(class: "flex-shrink-0 flex items-center justify-center w-72 h-72 md:w-96 md:h-96") {
          img(alt: "Quartz Crystal — your focus currency", class: "w-full h-full object-contain pulse-breathing drop-shadow-2xl", src: "/static/assets/crystal.png")
        }
      }
    }

    // ─── SECTION 1: DOOMSCROLL QUOTA ────────────────────────────────────────
    section(class: "relative py-20 md:py-32 bg-surface/30", id: "quota") {
      div(class: "bg-orb w-[400px] h-[400px] -left-40 top-20 bg-neon-blue opacity-10") {}

      div(class: "container-custom relative z-10") {
        div(class: "flex flex-col md:flex-row items-center gap-12 md:gap-16") {
          // Left copy block
          div(class: "flex-1 order-2 md:order-1") {
            p(class: "text-xs font-bold tracking-widest text-neon-blue uppercase mb-3") { "01 — Doomscroll Quota" }
            h2(class: "font-display text-3xl md:text-4xl font-bold mb-5") {
              "Social feeds are designed to "
              span(class: "gradient-text-cyan-blue") { "trap your attention." }
              " We break the loop."
            }
            p(class: "text-muted text-base mb-6 leading-relaxed") {
              "Quartz integrates natively with iOS Screen Time to set a hard daily doomscroll quota. Once your allotted time runs out, your selected apps are natively locked — no VPN workaround, no browser loophole. Your shield is at the OS level."
            }
            div(class: "flex flex-col gap-4") {
              div(class: "flex items-start gap-3") {
                span(class: "flex-shrink-0 w-8 h-8 rounded-full bg-neon-blue/20 border border-neon-blue/30 flex items-center justify-center text-neon-blue text-sm font-bold") { "✓" }
                div {
                  p(class: "text-ink font-semibold text-sm mb-0.5") { "Set your daily quota" }
                  p(class: "text-muted text-sm") { "Define exactly how many minutes of scroll time you allow yourself each day." }
                }
              }
              div(class: "flex items-start gap-3") {
                span(class: "flex-shrink-0 w-8 h-8 rounded-full bg-neon-purple/20 border border-neon-purple/30 flex items-center justify-center text-neon-purple text-sm font-bold") { "✓" }
                div {
                  p(class: "text-ink font-semibold text-sm mb-0.5") { "Native OS-level shielding" }
                  p(class: "text-muted text-sm") { "Quartz uses Apple's Screen Time API to block selected apps at the system level — unbypassable." }
                }
              }
              div(class: "flex items-start gap-3") {
                span(class: "flex-shrink-0 w-8 h-8 rounded-full bg-neon-green/20 border border-neon-green/30 flex items-center justify-center text-neon-green text-sm font-bold") { "✓" }
                div {
                  p(class: "text-ink font-semibold text-sm mb-0.5") { "Track remaining quota live" }
                  p(class: "text-muted text-sm") { "A real-time countdown ring shows your remaining scroll budget at all times." }
                }
              }
            }
          }
          // Right screenshot
          div(class: "flex-1 order-1 md:order-2 flex justify-center") {
            div(class: "relative glass-card glow-blue p-2 max-w-xs w-full") {
              img(alt: "Quartz home screen showing the doomscroll quota timer ring", class: "w-full rounded-xl", src: "/static/assets/06_home page_play.png")
            }
          }
        }
      }
    }

    // ─── SECTION 2: ATTENTION GYM ───────────────────────────────────────────
    section(class: "relative py-20 md:py-32", id: "gym") {
      div(class: "bg-orb w-[500px] h-[500px] -right-40 bottom-20 bg-neon-magenta opacity-10") {}

      div(class: "container-custom relative z-10") {
        div(class: "text-center mb-14") {
          p(class: "text-xs font-bold tracking-widest text-neon-magenta uppercase mb-3") { "02 — Attention Gym" }
          h2(class: "font-display text-3xl md:text-4xl font-bold mb-4") {
            "Don't quit cold turkey. "
            span(class: "gradient-text-purple-blue") { "Train instead." }
          }
          p(class: "text-muted max-w-2xl mx-auto") {
            "When your quota runs low, don't panic. Head to the Attention Gym and earn +10 minutes of scroll time by completing focus-based arcade challenges. One game at a time."
          }
        }

        div(class: "flex flex-col lg:flex-row gap-10 items-start") {
          // Game cards grid
          div(class: "flex-1 grid grid-cols-2 gap-4") {
            // Memory Pattern
            div(class: "glass-card glow-magenta flex flex-col gap-3") {
              div(class: "w-10 h-10 rounded-full bg-neon-magenta/20 border border-neon-magenta/30 flex items-center justify-center text-lg") { "🧠" }
              h3(class: "font-display text-base font-bold text-ink") { "Memory Pattern" }
              p(class: "text-muted text-xs leading-relaxed") { "Remember the sequence on the grid, then recreate it exactly before time runs out." }
              span(class: "mt-auto text-xs font-semibold text-neon-magenta") { "+10 min quota" }
            }
            // Word Search
            div(class: "glass-card glow-green flex flex-col gap-3") {
              div(class: "w-10 h-10 rounded-full bg-neon-green/20 border border-neon-green/30 flex items-center justify-center text-lg") { "🔍" }
              h3(class: "font-display text-base font-bold text-ink") { "Word Search" }
              p(class: "text-muted text-xs leading-relaxed") { "Hunt hidden words hidden inside a scrambled letter grid. Beat the clock to win." }
              span(class: "mt-auto text-xs font-semibold text-neon-green") { "+10 min quota" }
            }
            // Connect Dots
            div(class: "glass-card glow-cyan flex flex-col gap-3") {
              div(class: "w-10 h-10 rounded-full bg-neon-cyan/20 border border-neon-cyan/30 flex items-center justify-center text-lg") { "🔗" }
              h3(class: "font-display text-base font-bold text-ink") { "Connect Dots" }
              p(class: "text-muted text-xs leading-relaxed") { "Match colors and connect all the dots on the board. Paths can't cross." }
              span(class: "mt-auto text-xs font-semibold text-neon-cyan") { "+10 min quota" }
            }
            // Wave Runner
            div(class: "glass-card glow-purple flex flex-col gap-3") {
              div(class: "w-10 h-10 rounded-full bg-neon-purple/20 border border-neon-purple/30 flex items-center justify-center text-lg") { "🌊" }
              h3(class: "font-display text-base font-bold text-ink") { "Wave Runner" }
              p(class: "text-muted text-xs leading-relaxed") { "Ride the wave path and dodge incoming spikes. Reaction time is everything." }
              span(class: "mt-auto text-xs font-semibold text-neon-purple") { "+10 min quota" }
            }
          }

          // Gym screenshot
          div(class: "flex-1 max-w-sm mx-auto lg:mx-0 flex justify-center lg:justify-end") {
            div(class: "glass-card glow-purple p-2") {
              img(alt: "Quartz Attention Gym arcade game grid", class: "w-full rounded-xl", src: "/static/assets/07_game.png")
            }
          }
        }
      }
    }

    // ─── SECTION 3: FOCUS ECONOMY ─────────────────────────────────────────
    section(class: "relative py-20 md:py-32 bg-surface/30", id: "economy") {
      div(class: "bg-orb w-[400px] h-[400px] left-1/2 -translate-x-1/2 top-0 bg-neon-purple opacity-10") {}

      div(class: "container-custom relative z-10") {
        div(class: "text-center mb-14") {
          p(class: "text-xs font-bold tracking-widest text-neon-purple uppercase mb-3") { "03 — Focus Economy" }
          h2(class: "font-display text-3xl md:text-4xl font-bold mb-4") {
            "Dopamine balancing "
            span(class: "gradient-text-purple-blue") { "by design." }
          }
          p(class: "text-muted max-w-xl mx-auto") {
            "Focus isn't just about blocking. It earns. The longer your focus session runs uninterrupted, the more your attention multiplier compounds — reaching up to 2.0× at 5 hours. Your remaining quota converts to Prismas at midnight."
          }
        }

        div(class: "glass-card glow-purple max-w-2xl mx-auto") {
          div(class: "mb-6") {
            h3(class: "font-display text-lg font-bold text-ink mb-1") { "Compounding Effect Table" }
            p(class: "text-muted text-sm") { "Prisma rewards scale with your focus time. End early and the surge multiplier is voided." }
          }
          div(class: "overflow-x-auto") {
            table(class: "economy-table") {
              thead {
                tr {
                  th { "Focus Time" }
                  th { "Multiplier" }
                  th { "Quota Saved" }
                  th { "Est. Reward" }
                }
              }
              tbody {
                tr {
                  td { "0 min" }
                  td { span(class: "text-muted") { "1.00×" } }
                  td { "45 min" }
                  td { span(class: "text-neon-green font-bold") { "45 Prismas" } }
                }
                tr {
                  td { "60 min" }
                  td { span(class: "text-neon-cyan") { "1.20×" } }
                  td { "40 min" }
                  td { span(class: "text-neon-green font-bold") { "48 Prismas" } }
                }
                tr {
                  td { "120 min" }
                  td { span(class: "text-neon-blue") { "1.40×" } }
                  td { "35 min" }
                  td { span(class: "text-neon-green font-bold") { "49 Prismas" } }
                }
                tr {
                  td { "180 min" }
                  td { span(class: "text-neon-purple") { "1.60×" } }
                  td { "30 min" }
                  td { span(class: "text-neon-green font-bold") { "48 Prismas" } }
                }
                tr {
                  td { "240 min" }
                  td { span(class: "text-neon-magenta") { "1.80×" } }
                  td { "25 min" }
                  td { span(class: "text-neon-green font-bold") { "45 Prismas" } }
                }
                tr {
                  td { "300 min ⚡" }
                  td { span(class: "gradient-text-purple-blue font-extrabold") { "2.00× MAX" } }
                  td { "20 min" }
                  td { span(class: "text-neon-green font-extrabold text-base") { "40 Prismas" } }
                }
              }
            }
          }
          p(class: "mt-4 text-xs text-muted italic") {
            "⚠︎ Turning off your focus monitor early voids the compounding multiplier and resets your streak."
          }
        }
      }
    }

    // ─── SECTION 4: LEADERBOARD ──────────────────────────────────────────────
    section(class: "relative py-20 md:py-32", id: "rank") {
      div(class: "bg-orb w-[400px] h-[400px] -right-20 top-0 bg-neon-green opacity-10") {}

      div(class: "container-custom relative z-10") {
        div(class: "flex flex-col md:flex-row items-center gap-12 md:gap-16") {
          // Left: screenshot
          div(class: "flex-1 flex justify-center md:justify-start") {
            div(class: "glass-card glow-green p-2 max-w-xs w-full") {
              img(alt: "Quartz leaderboard showing ranked users and streak badges", class: "w-full rounded-xl", src: "/static/assets/08_rank.png")
            }
          }
          // Right: copy block
          div(class: "flex-1") {
            p(class: "text-xs font-bold tracking-widest text-neon-green uppercase mb-3") { "04 — Leaderboard" }
            h2(class: "font-display text-3xl md:text-4xl font-bold mb-5") {
              "Mindful phone use is better "
              span(class: "text-neon-green") { "with stakes." }
            }
            p(class: "text-muted text-base mb-6 leading-relaxed") {
              "Stack your active streak days. Climb the Prisma leaderboard. Reflect daily on your digital habits. Quartz turns screen-time discipline into something worth competing for."
            }
            div(class: "flex flex-col gap-4") {
              div(class: "flex items-start gap-3") {
                span(class: "flex-shrink-0 text-xl") { "🔥" }
                div {
                  p(class: "text-ink font-semibold text-sm mb-0.5") { "Daily Streaks" }
                  p(class: "text-muted text-sm") { "Keep your focus monitor active every day to build a streak. Miss a day and it resets." }
                }
              }
              div(class: "flex items-start gap-3") {
                span(class: "flex-shrink-0 text-xl") { "🏆" }
                div {
                  p(class: "text-ink font-semibold text-sm mb-0.5") { "Prisma Rankings" }
                  p(class: "text-muted text-sm") { "Your Prisma balance determines your rank on the global leaderboard." }
                }
              }
              div(class: "flex items-start gap-3") {
                span(class: "flex-shrink-0 text-xl") { "📊" }
                div {
                  p(class: "text-ink font-semibold text-sm mb-0.5") { "Reflect & Improve" }
                  p(class: "text-muted text-sm") { "Weekly reflections and daily habit snapshots help you understand your scrolling patterns." }
                }
              }
            }
          }
        }
      }
    }

    // ─── SECTION 5: CTA BANNER ──────────────────────────────────────────────
    section(class: "relative py-20 md:py-28 overflow-hidden") {
      div(class: "bg-orb w-full h-full top-0 left-0 opacity-5 bg-gradient-to-br from-neon-purple to-neon-blue") {}
      div(class: "container-custom relative z-10 flex flex-col items-center text-center gap-6") {
        h2(class: "font-display text-3xl md:text-5xl font-extrabold tracking-tight") {
          "Ready to take your "
          span(class: "gradient-text-purple-blue") { "attention back?" }
        }
        p(class: "text-muted max-w-md text-lg") {
          "Join Quartz on TestFlight and start breaking the loop today."
        }
        a(class: "glowing-btn text-base px-10 py-4", href: "https://testflight.apple.com/join/G8ufCuTB") {
          "Download Quartz on TestFlight"
        }
      }
    }

    // ─── SECTION 6: FAQ ─────────────────────────────────────────────────────
    section(class: "relative py-20 md:py-28 bg-surface/30", id: "faq") {
      div(class: "container-custom relative z-10 max-w-3xl mx-auto") {
        div(class: "text-center mb-14") {
          p(class: "text-xs font-bold tracking-widest text-neon-purple uppercase mb-3") { "05 — FAQ" }
          h2(class: "font-display text-3xl md:text-4xl font-bold") { "Frequently asked questions." }
        }

        div(class: "glass-card divide-y divide-line") {
          div(class: "faq-item") {
            button(class: "faq-question w-full text-left py-1 border-none bg-transparent cursor-pointer", id: "faq-1-btn") {
              "What is Quartz?"
              span(class: "text-muted") { "+" }
            }
            p(class: "faq-answer") {
              "Quartz is a focus and digital wellness app that helps you understand and reduce excessive scrolling habits through gamification, native app shielding, and compounding rewards."
            }
          }
          div(class: "faq-item") {
            button(class: "faq-question w-full text-left py-1 border-none bg-transparent cursor-pointer", id: "faq-2-btn") {
              "How does Quartz help me focus?"
              span(class: "text-muted") { "+" }
            }
            p(class: "faq-answer") {
              "Quartz provides screen-time monitoring, focus-building arcade activities, daily streaks, a compounding reward economy (Prismas), and reflection tools to help you build healthier digital habits over time."
            }
          }
          div(class: "faq-item") {
            button(class: "faq-question w-full text-left py-1 border-none bg-transparent cursor-pointer", id: "faq-3-btn") {
              "Who is Quartz for?"
              span(class: "text-muted") { "+" }
            }
            p(class: "faq-answer") {
              "Anyone who finds themselves stuck in endless scrolling and wants to be more intentional with their time and attention — especially Gen Z users who know the doomscroll trap all too well."
            }
          }
          div(class: "faq-item") {
            button(class: "faq-question w-full text-left py-1 border-none bg-transparent cursor-pointer", id: "faq-4-btn") {
              "Does Quartz sell my data?"
              span(class: "text-muted") { "+" }
            }
            p(class: "faq-answer") {
              "Absolutely not. Quartz operates natively on your device via Apple's Screen Time protocols. Your usage data never leaves your phone. We have zero access to your personal information."
            }
          }
          div(class: "faq-item") {
            button(class: "faq-question w-full text-left py-1 border-none bg-transparent cursor-pointer", id: "faq-5-btn") {
              "Can I bypass the app shield?"
              span(class: "text-muted") { "+" }
            }
            p(class: "faq-answer") {
              "Not easily. Because Quartz uses Apple's native Screen Time Restrictions API, the block happens at the OS level. There are no browser workarounds or VPN bypasses. The only built-in override is the Emergency Unpause, which resets your streak as a consequence."
            }
          }
        }
      }
    }

    // ─── FAQ ACCORDION JAVASCRIPT ─────────────────────────────────────────
    Node.raw("""
    <script>
    document.querySelectorAll('.faq-question').forEach(function(btn) {
      btn.addEventListener('click', function() {
        var item = this.closest('.faq-item');
        var wasActive = item.classList.contains('active');
        document.querySelectorAll('.faq-item').forEach(function(el) {
          el.classList.remove('active');
          var arrow = el.querySelector('.faq-question span');
          if (arrow) arrow.textContent = '+';
        });
        if (!wasActive) {
          item.classList.add('active');
          var arrow = this.querySelector('span');
          if (arrow) arrow.textContent = '−';
        }
      });
    });
    </script>
    """)
  }
}
