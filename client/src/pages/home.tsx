import { Button } from "@/components/ui/button";
import { Card } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
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
  ShieldCheck,
  Network,
  Rocket,
  CheckCircle2,
  Shield,
  Target,
  Wallet
} from "lucide-react";
import heroBackground from "@assets/generated_images/Web3_blockchain_network_hero_background_61ab6b4a.png";
import logoPlaceholder from "@assets/stock_images/simple_minimal_compa_419400b5.jpg";

export default function Home() {
  const keyStrengths = [
    {
      icon: <ShieldCheck className="w-12 h-12" />,
      title: "Trust & Transparency Focus",
      description: "Every step is measurable—clear reporting, clear outcomes, no guesswork."
    },
    {
      icon: <Network className="w-12 h-12" />,
      title: "Deep, trusted KOL/investor network",
      description: "Strong relationships with influential KOLs and investment groups."
    },
    {
      icon: <Rocket className="w-12 h-12" />,
      title: "Growth Partner, Not Just a Marketing Agency",
      description: "We take ownership, think strategically, and act like part of your team."
    }
  ];

  const statistics = [
    { value: "600+", label: "KOLs" },
    { value: "100+", label: "PROJECTS" },
    { value: "5-20X", label: "ROI AVERAGE" }
  ];

  const partners = [
    "Markchain", "Disence", "Artrade", "Cmedia",
    "Concordium", "Fatty", "LimeWire", "Lingo",
    "My Lovely Planet", "Opulous", "SpaceCatch", "Partner"
  ];

  const services = [
    {
      icon: <Megaphone className="w-12 h-12" />,
      title: "KOL Marketing",
      description: "Only verified influencers with proven results"
    },
    {
      icon: <TrendingUp className="w-12 h-12" />,
      title: "Token Value Creation",
      description: "Strategic buy pressure that delivers 3X buy volume, zero risk"
    },
    {
      icon: <Newspaper className="w-12 h-12" />,
      title: "PR & Media Marketing",
      description: "Top crypto media, guaranteed coverage"
    },
    {
      icon: <Building2 className="w-12 h-12" />,
      title: "Tier-1 Exchange Listing",
      description: "Direct access to Binance, OKX, and more"
    },
    {
      icon: <Users className="w-12 h-12" />,
      title: "VC Network",
      description: "Direct line to top VCs and investment groups"
    },
    {
      icon: <ArrowUpRight className="w-12 h-12" />,
      title: "Market Making",
      description: "Professional market making through trusted partners"
    }
  ];

  const tokenBenefits = [
    {
      title: "Guaranteed Buy Volume",
      description: "Every campaign generates 3x the investment in guaranteed trading volume."
    },
    {
      title: "Risk Management",
      description: "Advanced protection mechanisms prevent excessive market volatility."
    },
    {
      title: "Managed Exit Strategy",
      description: "Coordinated profit-taking preserves market stability and long-term growth."
    },
    {
      title: "Investment Allocation",
      description: "Partner investment groups commit capital based on project potential."
    }
  ];

  const processSteps = [
    {
      number: 1,
      title: "Process project",
      description: "Understanding goals and ecosystem"
    },
    {
      number: 2,
      title: "Strategic plan",
      description: "Creating custom marketing strategy"
    },
    {
      number: 3,
      title: "KOL network",
      description: "Matching with verified influencers"
    },
    {
      number: 4,
      title: "Execute",
      description: "Implementation with monitoring"
    },
    {
      number: 5,
      title: "Results",
      description: "Detailed reporting and optimization"
    }
  ];

  return (
    <div className="min-h-screen">
      <section 
        className="relative min-h-screen flex items-center justify-center overflow-hidden"
        data-testid="section-hero"
      >
        <div 
          className="absolute inset-0 z-0"
          style={{
            backgroundImage: `url(${heroBackground})`,
            backgroundSize: 'cover',
            backgroundPosition: 'center',
          }}
        />
        <div className="absolute inset-0 z-0 bg-gradient-to-br from-purple-900/90 via-blue-900/85 to-black/90" />
        
        <div className="relative z-10 max-w-7xl mx-auto px-6 py-20 text-center">
          <h1 
            className="font-serif text-6xl md:text-7xl lg:text-8xl font-bold text-white mb-6"
            data-testid="text-hero-title"
          >
            Empowering Web3 Projects
          </h1>
          <p 
            className="text-3xl md:text-4xl text-purple-200 mb-12"
            data-testid="text-hero-subtitle"
          >
            Trust & Strategy
          </p>
          <div className="flex flex-col sm:flex-row gap-4 justify-center items-center">
            <Button 
              size="lg" 
              className="text-lg rounded-full"
              data-testid="button-get-started"
            >
              Get Started
            </Button>
            <Button 
              size="lg" 
              variant="outline" 
              className="text-lg rounded-full backdrop-blur-sm bg-white/10 border-white/20 text-white"
              data-testid="button-view-services"
            >
              View Services
            </Button>
          </div>
        </div>
      </section>

      <section className="py-20 bg-background" data-testid="section-key-strengths">
        <div className="max-w-7xl mx-auto px-6">
          <div className="grid md:grid-cols-3 gap-12 mb-20">
            {keyStrengths.map((strength, index) => (
              <Card 
                key={index} 
                className="p-8 text-center hover-elevate"
                data-testid={`card-strength-${index}`}
              >
                <div className="flex justify-center mb-6 text-primary">
                  {strength.icon}
                </div>
                <h3 className="text-2xl font-bold mb-4" data-testid={`text-strength-title-${index}`}>
                  {strength.title}
                </h3>
                <p className="text-muted-foreground" data-testid={`text-strength-description-${index}`}>
                  {strength.description}
                </p>
              </Card>
            ))}
          </div>

          <div className="flex flex-wrap justify-center gap-8">
            {statistics.map((stat, index) => (
              <div 
                key={index} 
                className="text-center min-w-[200px]"
                data-testid={`stat-${index}`}
              >
                <div className="text-5xl md:text-6xl font-serif font-bold text-primary mb-2" data-testid={`text-stat-value-${index}`}>
                  {stat.value}
                </div>
                <div className="text-lg text-muted-foreground font-semibold" data-testid={`text-stat-label-${index}`}>
                  {stat.label}
                </div>
              </div>
            ))}
          </div>
        </div>
      </section>

      <section className="py-20 bg-gradient-to-br from-purple-50 to-blue-50 dark:from-purple-950/20 dark:to-blue-950/20" data-testid="section-partners">
        <div className="max-w-7xl mx-auto px-6">
          <h2 className="text-4xl md:text-5xl font-serif font-bold text-center mb-4" data-testid="text-partners-title">
            Trusted by Our Partners
          </h2>
          <p className="text-center text-muted-foreground mb-16" data-testid="text-partners-subtitle">
            Building the future of Web3 together with trusted partners
          </p>
          
          <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-8">
            {partners.map((partner, index) => (
              <Card 
                key={index}
                className="p-8 flex items-center justify-center hover-elevate overflow-visible"
                data-testid={`card-partner-${index}`}
              >
                <div className="w-full h-16 flex items-center justify-center">
                  <img 
                    src={logoPlaceholder} 
                    alt={partner}
                    className="h-12 object-contain grayscale hover:grayscale-0 transition-all duration-300"
                    data-testid={`img-partner-logo-${index}`}
                  />
                </div>
              </Card>
            ))}
          </div>
        </div>
      </section>

      <section className="py-20 bg-background" data-testid="section-services">
        <div className="max-w-7xl mx-auto px-6">
          <h2 className="text-4xl md:text-5xl font-serif font-bold text-center mb-4" data-testid="text-services-title">
            Our Services
          </h2>
          <p className="text-center text-muted-foreground mb-16" data-testid="text-services-subtitle">
            Our comprehensive service suite is designed to provide end-to-end solutions for Web3 projects at every stage of development
          </p>
          
          <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-8">
            {services.map((service, index) => (
              <Card 
                key={index}
                className="p-8 hover-elevate transition-all duration-300"
                data-testid={`card-service-${index}`}
              >
                <div className="text-primary mb-6">
                  {service.icon}
                </div>
                <h3 className="text-2xl font-bold mb-4" data-testid={`text-service-title-${index}`}>
                  {service.title}
                </h3>
                <p className="text-muted-foreground" data-testid={`text-service-description-${index}`}>
                  {service.description}
                </p>
              </Card>
            ))}
          </div>
        </div>
      </section>

      <section className="py-20 bg-gradient-to-br from-purple-50 to-blue-50 dark:from-purple-950/20 dark:to-blue-950/20" data-testid="section-token-value">
        <div className="max-w-7xl mx-auto px-6">
          <h2 className="text-4xl md:text-5xl font-serif font-bold text-center mb-16" data-testid="text-token-title">
            Token Value Creation — Key Benefits
          </h2>
          
          <div className="grid lg:grid-cols-2 gap-12 mb-16">
            <Card className="p-12 flex flex-col items-center justify-center bg-gradient-to-br from-primary/5 to-blue-500/5" data-testid="card-campaign-budget">
              <div className="text-center">
                <Badge className="mb-6 text-sm" data-testid="badge-campaign-budget">
                  CAMPAIGN BUDGET
                </Badge>
                <div className="text-7xl font-serif font-bold text-primary mb-4" data-testid="text-budget-amount">
                  $50K
                </div>
                <div className="flex items-center justify-center gap-4 my-8">
                  <div className="w-16 h-1 bg-primary" />
                  <div className="text-3xl font-bold text-primary">3X</div>
                  <div className="w-16 h-1 bg-primary" />
                </div>
                <Badge variant="secondary" className="mb-6 text-sm" data-testid="badge-market-activity">
                  TOTAL MARKET ACTIVITY
                </Badge>
                <div className="text-7xl font-serif font-bold text-primary" data-testid="text-market-amount">
                  $150K
                </div>
              </div>
            </Card>

            <div className="grid gap-6">
              {tokenBenefits.map((benefit, index) => (
                <Card 
                  key={index}
                  className="p-6 hover-elevate"
                  data-testid={`card-benefit-${index}`}
                >
                  <div className="flex gap-4">
                    <CheckCircle2 className="w-6 h-6 text-primary flex-shrink-0 mt-1" />
                    <div>
                      <h4 className="text-xl font-bold mb-2" data-testid={`text-benefit-title-${index}`}>
                        {benefit.title}
                      </h4>
                      <p className="text-muted-foreground" data-testid={`text-benefit-description-${index}`}>
                        {benefit.description}
                      </p>
                    </div>
                  </div>
                </Card>
              ))}
            </div>
          </div>

          <div className="text-center">
            <h3 className="text-2xl font-bold mb-4" data-testid="text-sustainable-growth">
              Sustainable Growth
            </h3>
            <p className="text-muted-foreground max-w-3xl mx-auto" data-testid="text-sustainable-description">
              Strategic investment patterns create healthy long-term price appreciation. Projects undergo strict filtering criteria to ensure quality and potential.
            </p>
          </div>
        </div>
      </section>

      <section className="py-20 bg-background" data-testid="section-how-we-work">
        <div className="max-w-7xl mx-auto px-6">
          <h2 className="text-4xl md:text-5xl font-serif font-bold text-center mb-16" data-testid="text-process-title">
            How We Work
          </h2>
          
          <div className="relative mb-16">
            <div className="hidden md:block absolute top-1/2 left-0 right-0 h-1 bg-primary/20 -translate-y-1/2" />
            
            <div className="grid md:grid-cols-5 gap-8 relative">
              {processSteps.map((step, index) => (
                <div 
                  key={index}
                  className="relative"
                  data-testid={`step-${index}`}
                >
                  <div className="flex flex-col items-center text-center">
                    <div className="w-20 h-20 rounded-full bg-primary text-primary-foreground flex items-center justify-center text-3xl font-bold mb-6 relative z-10 hover-elevate" data-testid={`badge-step-number-${index}`}>
                      {step.number}
                    </div>
                    <h3 className="text-xl font-bold mb-3" data-testid={`text-step-title-${index}`}>
                      {step.title}
                    </h3>
                    <p className="text-muted-foreground" data-testid={`text-step-description-${index}`}>
                      {step.description}
                    </p>
                  </div>
                </div>
              ))}
            </div>
          </div>

          <div className="flex flex-wrap justify-center gap-12 pt-8">
            {statistics.map((stat, index) => (
              <div 
                key={index}
                className="text-center"
                data-testid={`process-stat-${index}`}
              >
                <div className="text-4xl font-serif font-bold text-primary mb-1" data-testid={`text-process-stat-value-${index}`}>
                  {stat.value}
                </div>
                <div className="text-sm text-muted-foreground font-semibold" data-testid={`text-process-stat-label-${index}`}>
                  {stat.label}
                </div>
              </div>
            ))}
          </div>
        </div>
      </section>

      <section className="py-20 bg-gradient-to-br from-purple-900 to-blue-900 text-white" data-testid="section-contact">
        <div className="max-w-7xl mx-auto px-6">
          <h2 className="text-4xl md:text-5xl font-serif font-bold text-center mb-4" data-testid="text-contact-title">
            Let's Elevate Your Web3 Project
          </h2>
          <p className="text-center text-purple-200 mb-16" data-testid="text-contact-subtitle">
            Get in touch with our team
          </p>
          
          <div className="grid md:grid-cols-3 gap-8 max-w-4xl mx-auto">
            <Card className="p-8 bg-white/10 backdrop-blur-sm border-white/20 hover-elevate" data-testid="card-contact-email">
              <div className="flex flex-col items-center text-center">
                <Mail className="w-12 h-12 mb-4 text-purple-300" />
                <h3 className="text-xl font-bold mb-2 text-white" data-testid="text-contact-email-label">
                  EMAIL
                </h3>
                <a 
                  href="mailto:info@magnor.agency" 
                  className="text-purple-200 hover:text-white transition-colors"
                  data-testid="link-email"
                >
                  info@magnor.agency
                </a>
              </div>
            </Card>

            <Card className="p-8 bg-white/10 backdrop-blur-sm border-white/20 hover-elevate" data-testid="card-contact-website">
              <div className="flex flex-col items-center text-center">
                <Globe className="w-12 h-12 mb-4 text-purple-300" />
                <h3 className="text-xl font-bold mb-2 text-white" data-testid="text-contact-website-label">
                  WEBSITE
                </h3>
                <a 
                  href="https://www.magnor.agency" 
                  target="_blank" 
                  rel="noopener noreferrer"
                  className="text-purple-200 hover:text-white transition-colors"
                  data-testid="link-website"
                >
                  www.magnor.agency
                </a>
              </div>
            </Card>

            <Card className="p-8 bg-white/10 backdrop-blur-sm border-white/20 hover-elevate" data-testid="card-contact-telegram">
              <div className="flex flex-col items-center text-center">
                <Send className="w-12 h-12 mb-4 text-purple-300" />
                <h3 className="text-xl font-bold mb-2 text-white" data-testid="text-contact-telegram-label">
                  TELEGRAM
                </h3>
                <a 
                  href="https://t.me/emirweb3" 
                  target="_blank" 
                  rel="noopener noreferrer"
                  className="text-purple-200 hover:text-white transition-colors"
                  data-testid="link-telegram"
                >
                  @emirweb3
                </a>
              </div>
            </Card>
          </div>
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
