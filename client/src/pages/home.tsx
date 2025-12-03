import { useState, useEffect } from "react";
import { Button } from "@/components/ui/button";
import { Card } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import {
  Megaphone,
  TrendingUp,
  Newspaper,
  Users,
  ArrowUpRight,
  Building2,
  Network,
  Quote,
  Linkedin,
  Twitter,
} from "lucide-react";
import magnorLogo from "@shared/Logo1.svg";
import type { Brand } from "@shared/schema";

export default function Home() {
  const [clients, setClients] = useState<Brand[]>([]);

  useEffect(() => {
    fetchBrands();
  }, []);

  const fetchBrands = async () => {
    try {
      const response = await fetch("/api/brands");
      const data = await response.json();
      setClients(data);
    } catch (error) {
      console.error("Failed to fetch brands:", error);
      // Fallback to default brands if API fails
      setClients([
        { id: "1", name: "Markchain", color: "bg-purple-500", logo: null, createdAt: null },
        { id: "2", name: "Disence", color: "bg-blue-500", logo: null, createdAt: null },
        { id: "3", name: "Artrade", color: "bg-green-500", logo: null, createdAt: null },
      ]);
    }
  };

  const scrollToSection = (sectionId: string) => {
    const element = document.querySelector(
      `[data-section="${sectionId}"]`,
    );
    if (element) {
      const headerOffset = 80;
      const elementPosition = element.getBoundingClientRect().top;
      const offsetPosition =
        elementPosition + window.pageYOffset - headerOffset;

      window.scrollTo({
        top: offsetPosition,
        behavior: "smooth",
      });
    }
  };

  const services = [
    {
      icon: <Megaphone className="w-8 h-8" />,
      title: "KOL Marketing",
      description:
        "Access to our network of 600+ verified influencers with proven track records across all major Web3 platforms.",
    },
    {
      icon: <Users className="w-8 h-8" />,
      title: "Community Growth",
      description:
        "We cultivate quality Web3 community members, driving meaningful growth and lasting brand loyalty.",
    },
    {
      icon: <Network className="w-8 h-8" />,
      title: "Community Management",
      description:
        "We expertly manage Web3 communities with effective channel moderation, interactive discussions, and engaging events.",
    },
    {
      icon: <TrendingUp className="w-8 h-8" />,
      title: "Partnership Management",
      description:
        "We establish strategic blockchain partnerships aligned with your project's long-term growth objectives.",
    },
  ];

  return (
    <div className="min-h-screen text-white relative">
      {/* Animated Background Orbs */}
      <div className="floating-orb orb-1"></div>
      <div className="floating-orb orb-2"></div>
      <div className="floating-orb orb-3"></div>
      <div className="gradient-mesh"></div>

      {/* Header */}
      <header className="fixed top-0 left-0 right-0 z-50 border-b border-white/5 backdrop-blur-md bg-black/50">
        <div className="max-w-7xl mx-auto px-6 py-5">
          <div className="flex items-center justify-between">
            {/* Logo */}
            <div className="flex items-center gap-3">
              <img
                src={magnorLogo}
                alt="Magnor Logo"
                className="h-8"
                style={{
                  filter: 'brightness(0) invert(1)'
                }}
              />
            </div>

            {/* Navigation */}
            <nav className="hidden md:flex items-center gap-8">
              <button
                onClick={() => scrollToSection("services")}
                className="text-sm text-gray-400 hover:text-white transition-colors"
              >
                Services
              </button>
              <button
                onClick={() => scrollToSection("clients")}
                className="text-sm text-gray-400 hover:text-white transition-colors"
              >
                Clients
              </button>
              <button
                onClick={() => scrollToSection("contact")}
                className="text-sm text-gray-400 hover:text-white transition-colors"
              >
                Contact
              </button>
            </nav>

            {/* CTA */}
            <Button
              size="sm"
              variant="outline"
              className="border-white/20 hover:bg-white/10 text-white"
              asChild
            >
              <a
                href="https://t.me/emirweb3"
                target="_blank"
                rel="noopener noreferrer"
              >
                Get In Touch
              </a>
            </Button>
          </div>
        </div>
      </header>

      {/* Hero Section */}
      <section className="relative pt-32 pb-20 px-6 flex items-center justify-center min-h-screen">
        <div className="max-w-5xl mx-auto text-center">
          <Badge
            variant="outline"
            className="mb-8 border-white/20 text-white/80 bg-white/5"
          >
            MAGNOR AGENCY
          </Badge>
          <h1 className="text-5xl md:text-7xl font-bold mb-6 leading-tight">
            The last Web3 marketing agency you will ever need.
          </h1>
          <p className="text-xl text-gray-400 mb-12 max-w-3xl mx-auto">
            -We Mean it.
          </p>
          <Button
            size="lg"
            className="bg-white text-black hover:bg-gray-200"
            asChild
          >
            <a
              href="https://t.me/emirweb3"
              target="_blank"
              rel="noopener noreferrer"
            >
              Get In Touch
            </a>
          </Button>
        </div>
      </section>

      {/* Stats Section with Flowing Logos */}
      <section className="py-32 px-6 relative overflow-hidden" data-section="clients">
        <div className="max-w-6xl mx-auto text-center relative">

          <div>
            <Badge
              variant="outline"
              className="mb-12 border-white/20 text-white/80 bg-white/5"
            >
              TRUSTED BY
            </Badge>
          </div>
          {/* Top flowing row - moving right */}
          <div className="mb-12 relative z-10">
            <div className="flex gap-4 animate-scroll-right">
              {[...clients, ...clients].map((client, index) => (
                <div
                  key={`top-${index}`}
                  className="group flex-shrink-0 w-16 h-16 rounded-lg border border-white/10 flex flex-col items-center justify-center transition-all duration-300 hover:scale-[2] cursor-pointer overflow-visible relative hover:z-50"
                >
                  <div className="absolute inset-0 bg-white opacity-0 group-hover:opacity-10 transition-opacity duration-300 blur-xl z-0"></div>
                  <div className="flex flex-col items-center justify-center w-full h-full">
                    {client.logo ? (
                      <img
                        src={client.logo}
                        alt={client.name}
                        className="relative z-20 w-full h-full object-cover"
                      />
                    ) : (
                      <span className="relative z-20 text-xs font-bold text-white text-center">
                        {client.name.substring(0, 2).toUpperCase()}
                      </span>
                    )}
                  </div>
                  <div className="absolute -bottom-8 left-1/2 -translate-x-1/2 opacity-0 group-hover:opacity-100 transition-opacity duration-300 whitespace-nowrap">
                    <span className="text-xs font-semibold text-white bg-black/80 px-2 py-1 rounded">
                      {client.name}
                    </span>
                  </div>
                </div>
              ))}
            </div>
          </div>

          {/* Center content */}

          <div className="my-16">


            {/* 3D Rotating Stats Cube */}
            <div className="stat-cube mt-16">
              <div className="stat-cube-inner">
                {/* Front Face */}
                <div className="stat-face stat-face-front">
                  <h2 className="text-6xl md:text-7xl font-bold mb-4">+200</h2>
                  <p className="text-2xl text-gray-400">Campaigns Launched</p>
                </div>

                {/* Right Face */}
                <div className="stat-face stat-face-right">
                  <h2 className="text-6xl md:text-7xl font-bold mb-4">$80M+</h2>
                  <p className="text-2xl text-gray-400">Volume Generated</p>
                </div>

                {/* Back Face */}
                <div className="stat-face stat-face-back">
                  <h2 className="text-6xl md:text-7xl font-bold mb-4">+200</h2>
                  <p className="text-2xl text-gray-400">KOLs Network</p>
                </div>

                {/* Left Face */}
                <div className="stat-face stat-face-left">
                  <h2 className="text-6xl md:text-7xl font-bold mb-4">+100</h2>
                  <p className="text-2xl text-gray-400">Happy Clients</p>
                </div>
              </div>
            </div>
          </div>

          {/* Bottom flowing row - moving left */}
          <div className="mt-24 relative z-10">
            <div className="flex gap-4 animate-scroll-left">
              {[...clients, ...clients].map((client, index) => (
                <div
                  key={`bottom-${index}`}
                  className="group flex-shrink-0 w-16 h-16 rounded-lg border border-white/10 flex flex-col items-center justify-center transition-all duration-300 hover:scale-[2] cursor-pointer overflow-visible relative hover:z-50"
                >
                  <div className="absolute inset-0 bg-white opacity-0 group-hover:opacity-10 transition-opacity duration-300 blur-xl z-0"></div>
                  <div className="flex flex-col items-center justify-center w-full h-full">
                    {client.logo ? (
                      <img
                        src={client.logo}
                        alt={client.name}
                        className="relative z-20 w-full h-full object-cover"
                      />
                    ) : (
                      <span className="relative z-20 text-xs font-bold text-white text-center">
                        {client.name.substring(0, 2).toUpperCase()}
                      </span>
                    )}
                  </div>
                  <div className="absolute -bottom-8 left-1/2 -translate-x-1/2 opacity-0 group-hover:opacity-100 transition-opacity duration-300 whitespace-nowrap">
                    <span className="text-xs font-semibold text-white bg-black/80 px-2 py-1 rounded">
                      {client.name}
                    </span>
                  </div>
                </div>
              ))}
            </div>
          </div>


        </div>
      </section>


      {/* Services Section */}
      <section className="py-32 px-6 " data-section="services">
        <div className="max-w-6xl mx-auto">
          <div className="text-center mb-16">
            <Badge
              variant="outline"
              className="mb-8 border-white/20 text-white/80 bg-white/5"
            >
              SERVICES
            </Badge>
            <h2 className="text-4xl md:text-5xl font-bold mb-4">
              How We Scale Your Project
            </h2>
          </div>

          <div className="grid md:grid-cols-2 gap-8">
            <Card className="p-8 bg-zinc-900/50 border-white/10 hover:border-white/20 transition-all hover:bg-zinc-900/80">
              <div className="mb-6">
                <div className="w-16 h-16 rounded-full bg-white/5 flex items-center justify-center text-white mb-4">
                  <Megaphone className="w-8 h-8" />
                </div>
              </div>
              <h3 className="text-2xl font-bold mb-4 text-white">
                KOL Marketing
              </h3>
              <p className="text-gray-400 leading-relaxed">
                Access to our network of 600+ verified influencers with proven track records across all major Web3 platforms.
              </p>
            </Card>

            <Card className="p-8 bg-zinc-900/50 border-white/10 hover:border-white/20 transition-all hover:bg-zinc-900/80">
              <div className="mb-6">
                <div className="w-16 h-16 rounded-full bg-white/5 flex items-center justify-center text-white mb-4">
                  <Users className="w-8 h-8" />
                </div>
              </div>
              <h3 className="text-2xl font-bold mb-4 text-white">
                Community Growth
              </h3>
              <p className="text-gray-400 leading-relaxed">
                We cultivate quality Web3 community members, driving meaningful growth and lasting brand loyalty.
              </p>
            </Card>

            <Card className="p-8 bg-zinc-900/50 border-white/10 hover:border-white/20 transition-all hover:bg-zinc-900/80">
              <div className="mb-6">
                <div className="w-16 h-16 rounded-full bg-white/5 flex items-center justify-center text-white mb-4">
                  <Network className="w-8 h-8" />
                </div>
              </div>
              <h3 className="text-2xl font-bold mb-4 text-white">
                Community Management
              </h3>
              <p className="text-gray-400 leading-relaxed">
                We expertly manage Web3 communities with effective channel moderation, interactive discussions, and engaging events.
              </p>
            </Card>

            <Card className="p-8 bg-zinc-900/50 border-white/10 hover:border-white/20 transition-all hover:bg-zinc-900/80">
              <div className="mb-6">
                <div className="w-16 h-16 rounded-full bg-white/5 flex items-center justify-center text-white mb-4">
                  <TrendingUp className="w-8 h-8" />
                </div>
              </div>
              <h3 className="text-2xl font-bold mb-4 text-white">
                Partnership Management
              </h3>
              <p className="text-gray-400 leading-relaxed">
                We establish strategic blockchain partnerships aligned with your project's long-term growth objectives.
              </p>
            </Card>

            <Card className="p-8 bg-zinc-900/50 border-white/10 hover:border-white/20 transition-all">
              <div className="mb-6">
                <div className="w-16 h-16 rounded-full bg-white/5 flex items-center justify-center text-white mb-4">
                  <Newspaper className="w-8 h-8" />
                </div>
              </div>
              <h3 className="text-2xl font-bold mb-4 text-white">
                PR & Media Marketing
              </h3>
              <p className="text-gray-400 leading-relaxed">
                Top crypto media, guaranteed coverage. Direct relationships with major publications and journalists.
              </p>
            </Card>

            <Card className="p-8 bg-zinc-900/50 border-white/10 hover:border-white/20 transition-all">
              <div className="mb-6">
                <div className="w-16 h-16 rounded-full bg-white/5 flex items-center justify-center text-white mb-4">
                  <Building2 className="w-8 h-8" />
                </div>
              </div>
              <h3 className="text-2xl font-bold mb-4 text-white">
                Tier-1 Exchange Listing
              </h3>
              <p className="text-gray-400 leading-relaxed">
                Direct access to Binance, OKX, Upbit and more. Navigate the complex listing process with expert guidance.
              </p>
            </Card>

            <Card className="p-8 bg-zinc-900/50 border-white/10 hover:border-white/20 transition-all">
              <div className="mb-6">
                <div className="w-16 h-16 rounded-full bg-white/5 flex items-center justify-center text-white mb-4">
                  <Users className="w-8 h-8" />
                </div>
              </div>
              <h3 className="text-2xl font-bold mb-4 text-white">
                VC Network
              </h3>
              <p className="text-gray-400 leading-relaxed">
                Direct line to top VCs and investment groups. Access to our network of strategic investors.
              </p>
            </Card>

            <Card className="p-8 bg-zinc-900/50 border-white/10 hover:border-white/20 transition-all">
              <div className="mb-6">
                <div className="w-16 h-16 rounded-full bg-white/5 flex items-center justify-center text-white mb-4">
                  <ArrowUpRight className="w-8 h-8" />
                </div>
              </div>
              <h3 className="text-2xl font-bold mb-4 text-white">
                Market Making
              </h3>
              <p className="text-gray-400 leading-relaxed">
                Professional market making through trusted partners. Ensure healthy liquidity and price discovery.
              </p>
            </Card>

            <Card className="p-8 bg-zinc-900/50 border-white/10 hover:border-white/20 transition-all">
              <div className="mb-6">
                <div className="w-16 h-16 rounded-full bg-white/5 flex items-center justify-center text-white mb-4">
                  <Network className="w-8 h-8" />
                </div>
              </div>
              <h3 className="text-2xl font-bold mb-4 text-white">
                Unlock the Power of Asian Market
              </h3>
              <p className="text-gray-400 leading-relaxed">
                Dominate the narrative in the world's most active crypto hubs. Leverage our exclusive network of influential voices in China and throughout Asia to amplify your reach.
              </p>
            </Card>
          </div>
        </div>
      </section>


      {/* Testimonials Section */}
      <section className="py-32 px-6" data-section="testimonials">
        <div className="max-w-6xl mx-auto">
          <div className="text-center mb-16">
            <Badge
              variant="outline"
              className="mb-8 border-white/20 text-white/80 bg-white/5"
            >
              TESTIMONIALS
            </Badge>
            <h2 className="text-4xl md:text-5xl font-bold mb-4">
              What Our Partners Say
            </h2>
          </div>

          <div className="grid md:grid-cols-2 gap-8">
            <Card className="p-8 bg-zinc-900/50 border-white/10 hover:border-white/20 transition-all flex flex-col">
              <div className="mb-6">
                <Quote className="w-12 h-12 text-white/20" />
              </div>
              <p className="text-gray-300 leading-relaxed mb-6 flex-grow">
                Partnering with Magnor has been an exceptional experience. Their professionalism and efficiency make every collaboration productive. They are incredibly responsive, vital in closing campaigns, and provide detailed insights that add real value for us and our clients. Their expertise establishes them as a truly reliable partner. We highly value their work and look forward to many more projects together!
              </p>
              <div className="flex items-center justify-between mt-auto">
                <div>
                  <p className="font-bold text-white">Evgeny Gorbunov</p>
                  <p className="text-sm text-gray-400">CEO of Disence</p>
                </div>
                <a
                  href="https://www.linkedin.com/in/evgenii-gorbunov/"
                  target="_blank"
                  rel="noopener noreferrer"
                  className="text-gray-400 hover:text-blue-400 transition-colors"
                >
                  <Linkedin className="w-5 h-5" />
                </a>
              </div>
            </Card>

            <Card className="p-8 bg-zinc-900/50 border-white/10 hover:border-white/20 transition-all flex flex-col">
              <div className="mb-6">
                <Quote className="w-12 h-12 text-white/20" />
              </div>
              <p className="text-gray-300 leading-relaxed mb-6 flex-grow">
                Magnor has been a great help in navigating our entry into the Turkish market the right way. We highly recommend them for their professionalism and their strong network in Turkiye
              </p>
              <div className="flex items-center justify-between mt-auto">
                <div>
                  <p className="font-bold text-white">Quentin</p>
                  <p className="text-sm text-gray-400">CEO of Markchain</p>
                </div>
                <a
                  href="https://www.linkedin.com/in/marketing-blockchain/"
                  target="_blank"
                  rel="noopener noreferrer"
                  className="text-gray-400 hover:text-blue-400 transition-colors"
                >
                  <Linkedin className="w-5 h-5" />
                </a>
              </div>
            </Card>

            <Card className="p-8 bg-zinc-900/50 border-white/10 hover:border-white/20 transition-all flex flex-col">
              <div className="mb-6">
                <Quote className="w-12 h-12 text-white/20" />
              </div>
              <p className="text-gray-300 leading-relaxed mb-6 flex-grow">
                Magnor is a reliable and results-driven KOL marketing agency with exceptional expertise in the Turkish GEO. Their team consistently delivers impactful collaborations with top regional influencers, boosting visibility and engagement. Professional, fast, and effective — highly recommended.
              </p>
              <div className="flex items-center justify-between mt-auto">
                <div>
                  <p className="font-bold text-white">Julian</p>
                  <p className="text-sm text-gray-400">Ad Infinitium Agency</p>
                </div>
              </div>
            </Card>

            <Card className="p-8 bg-zinc-900/50 border-white/10 hover:border-white/20 transition-all flex flex-col">
              <div className="mb-6">
                <Quote className="w-12 h-12 text-white/20" />
              </div>
              <p className="text-gray-300 leading-relaxed mb-6 flex-grow">
                I am extremely selective about the partners I work with and the projects I introduce to my community. Magnor is a rare exception. Their strategic understanding of the Web3 landscape and professional execution set them apart from the noise. A truly top-tier team.
              </p>
              <div className="flex items-center justify-between mt-auto">
                <div>
                  <p className="font-bold text-white">Veli Mutlu</p>
                  <p className="text-sm text-gray-400">Leading Web3 KOL</p>
                </div>
                <a
                  href="https://x.com/vemutlu"
                  target="_blank"
                  rel="noopener noreferrer"
                  className="text-gray-400 hover:text-blue-400 transition-colors"
                >
                  <Twitter className="w-5 h-5" />
                </a>
              </div>
            </Card>
          </div>
        </div>
      </section>

      {/* Contact Section */}
      <section className="py-32 px-6 " data-section="contact">
        <div className="max-w-4xl mx-auto text-center">
          <h2 className="text-4xl md:text-5xl font-bold mb-8">
            Ready to elevate your Web3 project?
          </h2>
          <p className="text-xl text-gray-400 mb-12">
            Get in touch with our team to discuss your project
          </p>
          <Button
            size="lg"
            className="bg-white text-black hover:bg-gray-200"
            asChild
          >
            <a
              href="https://t.me/emirweb3"
              target="_blank"
              rel="noopener noreferrer"
            >
              Contact Us
            </a>
          </Button>
        </div>
      </section>

      {/* Footer */}
      <footer className="py-12 px-6 border-t border-white/5">
        <div className="max-w-7xl mx-auto">
          <div className="flex flex-col md:flex-row items-center justify-between gap-6">
            <div className="flex items-center gap-3">
              <img
                src={magnorLogo}
                alt="Magnor Logo"
                className="h-6"
                style={{
                  filter: 'brightness(0) invert(1)'
                }}
              />
            </div>

            <p className="text-sm text-gray-500">
              © 2025 Magnor Agency. All rights reserved.
            </p>

            <div className="flex items-center gap-6">
              <button
                onClick={() => scrollToSection("services")}
                className="text-sm text-gray-400 hover:text-white transition-colors"
              >
                Services
              </button>
              <button
                onClick={() => scrollToSection("contact")}
                className="text-sm text-gray-400 hover:text-white transition-colors"
              >
                Contact
              </button>
            </div>
          </div>
        </div>
      </footer>
    </div>
  );
}
