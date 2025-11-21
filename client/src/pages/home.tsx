import { useState } from "react";
import { Button } from "@/components/ui/button";
import { Card } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { 
  Megaphone, 
  TrendingUp, 
  Newspaper, 
  Building2, 
  Users, 
  ArrowUpRight,
  Mail,
  Globe,
  Send,
  Network,
  Mic,
  Edit,
  Presentation,
  ChevronDown,
  ChevronUp
} from "lucide-react";
import logoPlaceholder from "@assets/stock_images/simple_minimal_compa_419400b5.jpg";

export default function Home() {
  const [expandedService, setExpandedService] = useState<number | null>(null);

  const caseStudyCategories = [
    {
      id: "exchanges",
      label: "Exchanges",
      clients: [
        {
          name: "Markchain",
          logo: logoPlaceholder,
          description: "Complete Web3 marketing strategy and KOL network management",
          metrics: [
            { value: "50+", label: "KOLs managed" },
            { value: "15M+", label: "Total reach" },
            { value: "8X", label: "ROI achieved" }
          ]
        },
        {
          name: "Disence",
          logo: logoPlaceholder,
          description: "Token launch marketing and community growth",
          metrics: [
            { value: "$2.5M", label: "Raised in presale" },
            { value: "25K", label: "Community members" },
            { value: "12X", label: "Token performance" }
          ]
        }
      ],
      otherPartners: ["Cmedia", "Concordium", "Fatty"]
    },
    {
      id: "defi",
      label: "DeFi Projects",
      clients: [
        {
          name: "Artrade",
          logo: logoPlaceholder,
          description: "NFT marketplace launch and growth marketing",
          metrics: [
            { value: "$5M", label: "Trading volume" },
            { value: "10K+", label: "Active users" },
            { value: "150+", label: "Media mentions" }
          ]
        },
        {
          name: "LimeWire",
          logo: logoPlaceholder,
          description: "Brand revival and Web3 community building",
          metrics: [
            { value: "100K+", label: "Community growth" },
            { value: "5X", label: "Engagement increase" },
            { value: "50+", label: "Strategic partnerships" }
          ]
        }
      ],
      otherPartners: ["Lingo", "My Lovely Planet", "Opulous"]
    },
    {
      id: "gaming",
      label: "Gaming & Metaverse",
      clients: [
        {
          name: "SpaceCatch",
          logo: logoPlaceholder,
          description: "Mobile Web3 game launch and user acquisition",
          metrics: [
            { value: "200K+", label: "Downloads" },
            { value: "40K", label: "Daily active users" },
            { value: "20X", label: "Growth rate" }
          ]
        }
      ],
      otherPartners: ["Partner", "Partner", "Partner"]
    }
  ];

  const services = [
    {
      icon: <Megaphone className="w-10 h-10" />,
      title: "KOL Marketing",
      description: "Only verified influencers with proven results. Access to our network of 600+ trusted KOLs across all major platforms.",
      details: [
        "Verified influencers with proven track records",
        "Detailed performance analytics and ROI tracking",
        "Multi-platform reach (Twitter, YouTube, Telegram)",
        "Transparent pricing and clear deliverables"
      ]
    },
    {
      icon: <TrendingUp className="w-10 h-10" />,
      title: "Token Value Creation",
      description: "Strategic buy pressure that delivers 3X buy volume, zero risk. Investment groups commit capital based on project potential.",
      details: [
        "Guaranteed 3X trading volume vs campaign budget",
        "Advanced risk management mechanisms",
        "Coordinated market making strategies",
        "Long-term growth focus, not pump & dump"
      ]
    },
    {
      icon: <Newspaper className="w-10 h-10" />,
      title: "PR & Media Marketing",
      description: "Top crypto media, guaranteed coverage. Direct relationships with major publications and journalists.",
      details: [
        "Coverage in tier-1 crypto publications",
        "Press release distribution and amplification",
        "Interview coordination with key journalists",
        "Media kit preparation and pitch strategy"
      ]
    },
    {
      icon: <Building2 className="w-10 h-10" />,
      title: "Tier-1 Exchange Listing",
      description: "Direct access to Binance, OKX, and more. Navigate the complex listing process with expert guidance.",
      details: [
        "Direct relationships with top exchanges",
        "Listing application support and optimization",
        "Post-listing marketing coordination",
        "Market maker introductions"
      ]
    },
    {
      icon: <Users className="w-10 h-10" />,
      title: "VC Network",
      description: "Direct line to top VCs and investment groups. Access to our network of strategic investors.",
      details: [
        "Warm introductions to relevant VCs",
        "Pitch deck review and optimization",
        "Investment round strategy",
        "Due diligence preparation support"
      ]
    },
    {
      icon: <ArrowUpRight className="w-10 h-10" />,
      title: "Market Making",
      description: "Professional market making through trusted partners. Ensure healthy liquidity and price discovery.",
      details: [
        "Trusted market maker partnerships",
        "Liquidity provision strategies",
        "Price stability mechanisms",
        "Exchange relationship management"
      ]
    }
  ];

  return (
    <div className="min-h-screen">
      <section 
        className="relative py-32 flex items-center justify-center"
        data-testid="section-hero"
      >
        <div className="max-w-7xl mx-auto px-6 text-center">
          <div className="mb-8">
            <Badge variant="outline" className="mb-4" data-testid="badge-founded">
              Founded in 2020
            </Badge>
            <p className="text-muted-foreground mb-2" data-testid="text-location">
              Based in Dubai
            </p>
          </div>
          <h1 
            className="text-4xl md:text-5xl lg:text-6xl font-bold mb-8 max-w-4xl mx-auto leading-tight"
            data-testid="text-hero-title"
          >
            Empowering Web3 Projects with Trust & Strategy
          </h1>
          <p className="text-xl text-muted-foreground mb-12" data-testid="text-tagline">
            — Your Growth Partner in Web3
          </p>
          <div className="flex flex-col sm:flex-row gap-4 justify-center items-center">
            <Button 
              size="lg"
              data-testid="button-apply"
            >
              Get Started
            </Button>
            <Button 
              size="lg" 
              variant="outline"
              asChild
              data-testid="button-telegram"
            >
              <a href="https://t.me/emirweb3" target="_blank" rel="noopener noreferrer">
                Contact Us
              </a>
            </Button>
          </div>
        </div>
      </section>

      <section className="py-20 bg-background" data-testid="section-case-studies">
        <div className="max-w-7xl mx-auto px-6">
          <h2 className="text-3xl md:text-4xl font-bold text-center mb-4" data-testid="text-case-studies-title">
            Trusted by Leading Web3 Projects
          </h2>
          <p className="text-center text-muted-foreground mb-16">
            Proven results across exchanges, DeFi, and gaming sectors
          </p>
          
          <Tabs defaultValue="exchanges" className="w-full" data-testid="tabs-case-studies">
            <TabsList className="w-full flex flex-wrap justify-center mb-12 h-auto gap-2">
              {caseStudyCategories.map((category) => (
                <TabsTrigger 
                  key={category.id} 
                  value={category.id}
                  data-testid={`tab-${category.id}`}
                >
                  {category.label}
                </TabsTrigger>
              ))}
            </TabsList>

            {caseStudyCategories.map((category) => (
              <TabsContent key={category.id} value={category.id} data-testid={`tab-content-${category.id}`}>
                <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-8 mb-12">
                  {category.clients.map((client, idx) => (
                    <Card 
                      key={idx} 
                      className="p-8 hover-elevate"
                      data-testid={`card-client-${idx}`}
                    >
                      <div className="mb-6 flex items-center justify-center">
                        <img 
                          src={client.logo} 
                          alt={client.name}
                          className="h-12 object-contain"
                          data-testid={`img-client-logo-${idx}`}
                        />
                      </div>
                      <h3 className="text-2xl font-bold mb-4" data-testid={`text-client-name-${idx}`}>
                        {client.name}
                      </h3>
                      <p className="text-muted-foreground mb-6" data-testid={`text-client-description-${idx}`}>
                        {client.description}
                      </p>
                      {client.metrics.length > 0 && (
                        <div className="grid grid-cols-1 gap-4">
                          {client.metrics.map((metric, mIdx) => (
                            <div key={mIdx} data-testid={`metric-${idx}-${mIdx}`}>
                              <div className="text-3xl font-bold text-primary mb-1" data-testid={`text-metric-value-${idx}-${mIdx}`}>
                                {metric.value}
                              </div>
                              <div className="text-sm text-muted-foreground" data-testid={`text-metric-label-${idx}-${mIdx}`}>
                                {metric.label}
                              </div>
                            </div>
                          ))}
                        </div>
                      )}
                    </Card>
                  ))}
                </div>

                {category.otherPartners.length > 0 && (
                  <div>
                    <h4 className="text-lg font-semibold mb-6 text-center" data-testid="text-more-partners">
                      More of our partners
                    </h4>
                    <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-5 gap-6">
                      {category.otherPartners.map((partner, pIdx) => (
                        <div 
                          key={pIdx}
                          className="p-4 rounded-md border bg-card flex items-center justify-center"
                          data-testid={`partner-logo-${pIdx}`}
                        >
                          <img 
                            src={logoPlaceholder} 
                            alt={partner}
                            className="h-8 object-contain grayscale opacity-70"
                            data-testid={`img-partner-${pIdx}`}
                          />
                        </div>
                      ))}
                    </div>
                  </div>
                )}
              </TabsContent>
            ))}
          </Tabs>
        </div>
      </section>

      <section className="py-20 bg-muted/30" data-testid="section-services">
        <div className="max-w-5xl mx-auto px-6">
          <h2 className="text-3xl md:text-4xl font-bold text-center mb-4" data-testid="text-services-title">
            Comprehensive Web3 Marketing Solutions
          </h2>
          <p className="text-center text-muted-foreground mb-16">
            End-to-end services designed for Web3 projects at every stage
          </p>
          
          <div className="space-y-6">
            {services.map((service, index) => (
              <Card 
                key={index}
                className="overflow-hidden"
                data-testid={`card-service-${index}`}
              >
                <button
                  onClick={() => setExpandedService(expandedService === index ? null : index)}
                  className="w-full p-6 flex items-start gap-6 text-left hover-elevate"
                  data-testid={`button-service-toggle-${index}`}
                >
                  <div className="text-primary flex-shrink-0 mt-1">
                    {service.icon}
                  </div>
                  <div className="flex-1">
                    <h3 className="text-xl font-bold mb-2" data-testid={`text-service-title-${index}`}>
                      {service.title}
                    </h3>
                    <p className="text-muted-foreground" data-testid={`text-service-description-${index}`}>
                      {service.description}
                    </p>
                  </div>
                  <div className="flex-shrink-0">
                    {expandedService === index ? (
                      <ChevronUp className="w-5 h-5" />
                    ) : (
                      <ChevronDown className="w-5 h-5" />
                    )}
                  </div>
                </button>
                
                {expandedService === index && (
                  <div 
                    className="px-6 pb-6 pt-0 border-t"
                    data-testid={`service-details-${index}`}
                  >
                    <ul className="space-y-3 mt-4">
                      {service.details.map((detail, dIdx) => (
                        <li 
                          key={dIdx} 
                          className="flex items-start gap-2"
                          data-testid={`service-detail-${index}-${dIdx}`}
                        >
                          <span className="text-primary mt-1">✓</span>
                          <span className="text-muted-foreground">{detail}</span>
                        </li>
                      ))}
                    </ul>
                  </div>
                )}
              </Card>
            ))}
          </div>
        </div>
      </section>

      <section className="py-20 bg-background" data-testid="section-contact">
        <div className="max-w-4xl mx-auto px-6 text-center">
          <h2 className="text-3xl md:text-4xl font-bold mb-8" data-testid="text-contact-title">
            Ready to elevate your Web3 project?
          </h2>
          <div className="flex flex-col sm:flex-row gap-6 justify-center items-center mb-8">
            <Button 
              size="lg"
              asChild
              data-testid="button-contact-email"
            >
              <a href="mailto:info@magnor.agency">
                <Mail className="w-4 h-4 mr-2" />
                Email Us
              </a>
            </Button>
            <Button 
              size="lg" 
              variant="outline"
              asChild
              data-testid="button-contact-telegram"
            >
              <a href="https://t.me/emirweb3" target="_blank" rel="noopener noreferrer">
                <Send className="w-4 h-4 mr-2" />
                Telegram
              </a>
            </Button>
            <Button 
              size="lg" 
              variant="outline"
              asChild
              data-testid="button-contact-website"
            >
              <a href="https://www.magnor.agency" target="_blank" rel="noopener noreferrer">
                <Globe className="w-4 h-4 mr-2" />
                Website
              </a>
            </Button>
          </div>
          <p className="text-muted-foreground">
            info@magnor.agency | @emirweb3 | www.magnor.agency
          </p>
        </div>
      </section>

      <footer className="py-8 bg-background border-t">
        <div className="max-w-7xl mx-auto px-6 text-center">
          <p className="text-muted-foreground" data-testid="text-footer">
            © 2024 Magnor Agency. Empowering Web3 Projects.
          </p>
        </div>
      </footer>
    </div>
  );
}
