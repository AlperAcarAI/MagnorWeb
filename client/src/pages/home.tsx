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
import { Link } from "wouter";
import magnorLogo from "@shared/Logo1.svg";
import { useQuery } from "@tanstack/react-query";

// Static logo imports
import antixLogo from "/logos/Antix.png";
import artradeLogo from "/logos/Artrade.png";
import binanceLogo from "/logos/Binance.png";
import bitgetLogo from "/logos/Bitget.png";
import cmediaLogo from "/logos/CMedia.jpeg";
import castrumLogo from "/logos/Castrum Capital.jpg";
import coinscoutLogo from "/logos/Coinscout.jpg";
import disenceLogo from "/logos/Disence.jpg";
import fattyLogo from "/logos/Fatty.png";
import kolzLogo from "/logos/KOLZ.png";
import limewireLogo from "/logos/Limewire.png";
import lingoLogo from "/logos/Lingo.png";
import markchainLogo from "/logos/Markchain.jpg";
import metronLogo from "/logos/Metron Trading.jpg";
import mylovelyplanetLogo from "/logos/My Lovely Planet.png";
import okxLogo from "/logos/OKX.jpg";
import opulousLogo from "/logos/Opulous.png";
import spacecatchLogo from "/logos/Space Catch.png";
import triangleLogo from "/logos/Triangle.png";
import upxLogo from "/logos/UPX.jpeg";
import xboLogo from "/logos/XBO.png";
import zetariumLogo from "/logos/Zetarium.png";
import zkverifyLogo from "/logos/Zkverify.png";

// Static KOL Ecosystem list with profile images
// YouTube kullanıcıları için Twitter hesapları üzerinden avatar çekiliyor
const kolEcosystem = [
  { name: "rorovevo", handle: "@rorovevo", platform: "youtube", link: "https://www.youtube.com/@rorovevo", avatar: "https://unavatar.io/twitter/rorovevo" },
  { name: "The House Of Crypto", handle: "@TheHouseOfCrypto", platform: "youtube", link: "https://www.youtube.com/@TheHouseOfCrypto", avatar: "https://unavatar.io/twitter/THouseOfCrypto" },
  { name: "Umut Aktu Kripto", handle: "@UmutAktuKripto", platform: "youtube", link: "https://www.youtube.com/@Umut-Aktu", avatar: "https://unavatar.io/twitter/UmutAktu" },
  { name: "Tarık Bilen", handle: "@tarikbilenn", platform: "youtube", link: "https://www.youtube.com/@tarikbilenn", avatar: "https://unavatar.io/twitter/TarikBln" },
  { name: "Les Rois du Bitcoin", handle: "@lesroisdubitcoin", platform: "youtube", link: "https://www.youtube.com/@lesroisdubitcoin", avatar: "https://unavatar.io/youtube/lesroisdubitcoin" },
  { name: "Rover", handle: "@CryptoRover", platform: "youtube", link: "https://www.youtube.com/@CryptoRover/", avatar: "https://unavatar.io/youtube/cryptorover" },
  { name: "Edu Heras", handle: "@eduheras", platform: "youtube", link: "https://www.youtube.com/@eduheras", avatar: "https://unavatar.io/twitter/eduheras" },
  { name: "Sheldon Sniper", handle: "@Sheldon_Sniper", platform: "twitter", link: "https://twitter.com/Sheldon_Sniper", avatar: "https://unavatar.io/twitter/Sheldon_Sniper" },
  { name: "Crypto Genzo", handle: "@CryptoGenzo", platform: "twitter", link: "https://twitter.com/CryptoGenzo", avatar: "https://unavatar.io/twitter/CryptoGenzo" },
  { name: "Kripto Kraliyeni", handle: "@kriptokraliyeni", platform: "twitter", link: "https://x.com/kriptokraliyeni", avatar: "https://unavatar.io/twitter/kriptokraliyeni" },
  { name: "Crypto Wizard", handle: "@0xcryptowizard", platform: "twitter", link: "https://x.com/0xcryptowizard", avatar: "https://unavatar.io/twitter/0xcryptowizard" },
  { name: "SunNFT", handle: "@0xSunNFT", platform: "twitter", link: "https://x.com/0xSunNFT", avatar: "https://unavatar.io/twitter/0xSunNFT" },
  { name: "Tagado", handle: "@TagadoBTC", platform: "twitter", link: "https://x.com/TagadoBTC", avatar: "https://unavatar.io/twitter/TagadoBTC" },
  { name: "Veli Mutlu", handle: "@vemutlu", platform: "twitter", link: "https://x.com/vemutlu", avatar: "https://unavatar.io/twitter/vemutlu" },
  { name: "Kriptokrat", handle: "@kriptokrat5", platform: "twitter", link: "https://x.com/kriptokrat5", avatar: "https://unavatar.io/twitter/kriptokrat5" },
  { name: "Vforr Kripto", handle: "@Vforrkripto", platform: "twitter", link: "https://x.com/Vforrkripto", avatar: "https://unavatar.io/twitter/Vforrkripto" },
  { name: "Kripto Chef", handle: "@KriptoChef", platform: "twitter", link: "https://x.com/KriptoChef", avatar: "https://unavatar.io/twitter/KriptoChef" },
  { name: "Para Hub", handle: "@para_hub", platform: "youtube", link: "https://www.youtube.com/@para_hub", avatar: "https://unavatar.io/twitter/parahub_" },
  { name: "Nuh Batuhan", handle: "@nuhbatuhann", platform: "twitter", link: "https://x.com/nuhbatuhann", avatar: "https://unavatar.io/twitter/nuhbatuhann" },
  { name: "DaVinciJ15", handle: "@davincij15", platform: "youtube", link: "https://www.youtube.com/@davincij15", avatar: "https://unavatar.io/twitter/davincij15" },
  { name: "Hasheur", handle: "@Hasheur", platform: "youtube", link: "https://www.youtube.com/@Hasheur", avatar: "https://unavatar.io/twitter/Hasheur" },
  { name: "Tikooww", handle: "@tikooww", platform: "twitter", link: "https://x.com/tikooww", avatar: "https://unavatar.io/twitter/tikooww" },
];

// Static clients list with logos
const clients = [
  { name: "Antix", logo: antixLogo },
  { name: "Artrade", logo: artradeLogo },
  { name: "Binance", logo: binanceLogo },
  { name: "Bitget", logo: bitgetLogo },
  { name: "CMedia", logo: cmediaLogo },
  { name: "Castrum Capital", logo: castrumLogo },
  { name: "Coinscout", logo: coinscoutLogo },
  { name: "Disence", logo: disenceLogo },
  { name: "Fatty", logo: fattyLogo },
  { name: "KOLZ", logo: kolzLogo },
  { name: "Limewire", logo: limewireLogo },
  { name: "Lingo", logo: lingoLogo },
  { name: "Markchain", logo: markchainLogo },
  { name: "Metron Trading", logo: metronLogo },
  { name: "My Lovely Planet", logo: mylovelyplanetLogo },
  { name: "OKX", logo: okxLogo },
  { name: "Opulous", logo: opulousLogo },
  { name: "Space Catch", logo: spacecatchLogo },
  { name: "Triangle", logo: triangleLogo },
  { name: "UPX", logo: upxLogo },
  { name: "XBO", logo: xboLogo },
  { name: "Zetarium", logo: zetariumLogo },
  { name: "Zkverify", logo: zkverifyLogo },
];

export default function Home() {
  // Fetch KOLs from database
  const { data: kolsData } = useQuery({
    queryKey: ['/api/kols'],
    queryFn: async () => {
      const response = await fetch('/api/kols');
      if (!response.ok) throw new Error('Failed to fetch KOLs');
      return response.json();
    },
  });

  // Extract KOL network data with Twitter info
  const kolNetwork = kolsData?.kols?.map((kol: any) => {
    // Find Twitter social media account
    const twitterAccount = kol.socialMedia?.find(
      (sm: any) => sm.socialMedia?.name?.toLowerCase() === 'twitter' || 
                   sm.socialMedia?.name?.toLowerCase() === 'x'
    );
    
    // Extract username from Twitter link
    let handle = '';
    let username = '';
    if (twitterAccount?.link) {
      const match = twitterAccount.link.match(/(?:twitter\.com|x\.com)\/(@?[\w]+)/);
      if (match) {
        username = match[1].replace('@', '');
        handle = `@${username}`;
      }
    }

    // Generate avatar URL from Twitter username (with fallback)
    const avatar = username 
      ? `https://unavatar.io/twitter/${username}?fallback=https://ui-avatars.com/api/?name=${encodeURIComponent(kol.name)}&background=8b5cf6&color=fff&size=128`
      : `https://ui-avatars.com/api/?name=${encodeURIComponent(kol.name)}&background=8b5cf6&color=fff&size=128`;

    return {
      name: kol.name,
      handle: handle || '@unknown',
      twitterLink: twitterAccount?.link || '',
      avatar: avatar,
      verified: twitterAccount?.verified || false,
      followerCount: twitterAccount?.followerCount || 0,
    };
  }).filter((kol: any) => kol.twitterLink) || []; // Only show KOLs with Twitter accounts

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
              <Link
                href="/pitchdeck"
                className="text-sm text-gray-400 hover:text-white transition-colors"
              >
                Pitchdeck
              </Link>
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

      {/* Trusted By Section */}
      <section className="py-32 px-6 relative overflow-hidden" data-section="clients">
        <div className="max-w-6xl mx-auto relative">
          
          {/* CLIENTS AND PARTNERS Section */}
          <div className="mb-32">
            <div className="flex items-center gap-3 mb-8">
              <div className="w-2 h-2 rounded-full bg-purple-500"></div>
              <h3 className="text-sm font-semibold tracking-wider text-white uppercase">
                CLIENTS AND PARTNERS
              </h3>
            </div>
            
            {/* Scrolling row - moving right */}
            <div className="relative z-10 overflow-hidden">
              <div className="flex gap-6 animate-scroll-right" style={{ width: 'max-content' }}>
                {[...clients, ...clients].map((client, index) => (
                  <div
                    key={`client-${index}`}
                    className="group flex-shrink-0 bg-zinc-900/30 rounded-2xl border border-white/10 p-4 hover:border-white/30 transition-all duration-300 hover:scale-110 cursor-pointer w-24 h-24"
                  >
                    <div className="w-full h-full flex items-center justify-center">
                      <img
                        src={client.logo}
                        alt={client.name}
                        className="w-full h-full object-contain"
                      />
                    </div>
                    <div className="absolute -bottom-10 left-1/2 -translate-x-1/2 opacity-0 group-hover:opacity-100 transition-opacity duration-300 whitespace-nowrap z-10">
                      <span className="text-xs font-semibold text-white bg-black/90 px-3 py-1.5 rounded-lg">
                        {client.name}
                      </span>
                    </div>
                  </div>
                ))}
              </div>
            </div>
          </div>

          {/* 3D Rotating Stats Cube */}
          <div className="my-32 flex justify-center items-center">
            <div className="stat-cube">
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
                  <h2 className="text-6xl md:text-7xl font-bold mb-4">+600</h2>
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

          {/* KOL NETWORK Section */}
          <div className="mt-24">
            <div className="flex items-center gap-3 mb-8">
              <div className="w-2 h-2 rounded-full bg-purple-500"></div>
              <h3 className="text-sm font-semibold tracking-wider text-white uppercase">
                Our KOL Ecosystem
              </h3>
            </div>
            
            {/* Scrolling row - moving left */}
            <div className="relative z-10 overflow-hidden">
              <div className="flex gap-6 animate-scroll-left" style={{ width: 'max-content' }}>
                {[...kolEcosystem, ...kolEcosystem].map((kol, index) => (
                  <a
                    key={`kol-${index}`}
                    href={kol.link}
                    target="_blank"
                    rel="noopener noreferrer"
                    className="group flex-shrink-0 bg-zinc-900/30 rounded-2xl border border-white/10 p-4 hover:border-white/30 transition-all duration-300 hover:scale-110 cursor-pointer w-32"
                  >
                    <div className="flex flex-col items-center gap-3">
                      <div className="relative">
                        <div className="w-16 h-16 rounded-full overflow-hidden border-2 border-white/20">
                          <img
                            src={kol.avatar}
                            alt={kol.name}
                            className="w-full h-full object-cover"
                            onError={(e) => {
                              const target = e.target as HTMLImageElement;
                              target.src = `https://ui-avatars.com/api/?name=${encodeURIComponent(kol.name)}&background=8b5cf6&color=fff&size=128`;
                            }}
                          />
                        </div>
                        {kol.platform === "youtube" && (
                          <div className="absolute -bottom-1 -right-1 w-5 h-5 bg-red-600 rounded-full flex items-center justify-center border-2 border-zinc-900">
                            <svg className="w-3 h-3 text-white" fill="currentColor" viewBox="0 0 24 24">
                              <path d="M19.615 3.184c-3.604-.246-11.631-.245-15.23 0-3.897.266-4.356 2.62-4.385 8.816.029 6.185.484 8.549 4.385 8.816 3.6.245 11.626.246 15.23 0 3.897-.266 4.356-2.62 4.385-8.816-.029-6.185-.484-8.549-4.385-8.816zm-10.615 12.816v-8l8 3.993-8 4.007z"/>
                            </svg>
                          </div>
                        )}
                        {kol.platform === "twitter" && (
                          <div className="absolute -bottom-1 -right-1 w-5 h-5 bg-black rounded-full flex items-center justify-center border-2 border-zinc-900">
                            <svg className="w-3 h-3 text-white" fill="currentColor" viewBox="0 0 24 24">
                              <path d="M18.244 2.25h3.308l-7.227 8.26 8.502 11.24H16.17l-5.214-6.817L4.99 21.75H1.68l7.73-8.835L1.254 2.25H8.08l4.713 6.231zm-1.161 17.52h1.833L7.084 4.126H5.117z"/>
                            </svg>
                          </div>
                        )}
                      </div>
                      <div className="text-center">
                        <p className="text-xs font-semibold text-white truncate w-full">{kol.name}</p>
                        <p className="text-xs text-gray-400 truncate w-full">{kol.handle}</p>
                      </div>
                    </div>
                    <div className="absolute -bottom-10 left-1/2 -translate-x-1/2 opacity-0 group-hover:opacity-100 transition-opacity duration-300 whitespace-nowrap z-10">
                      <span className="text-xs font-semibold text-white bg-black/90 px-3 py-1.5 rounded-lg">
                        {kol.platform === "youtube" ? "View on YouTube" : "View on X (Twitter)"}
                      </span>
                    </div>
                  </a>
                ))}
              </div>
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
            <Card className="p-8 bg-zinc-900/50 border-white/10 hover:border-white/20 transition-all hover:bg-zinc-900/80 overflow-hidden">
              <div className="mb-6">
                <div className="w-full h-40 rounded-xl overflow-hidden mb-4">
                  <img 
                    src="https://images.unsplash.com/photo-1598550476439-6847785fcea6?w=600&h=300&fit=crop&q=80" 
                    alt="KOL Marketing" 
                    className="w-full h-full object-cover opacity-80 hover:opacity-100 transition-opacity grayscale hover:grayscale-0"
                  />
                </div>
              </div>
              <h3 className="text-2xl font-bold mb-4 text-white">
                KOL Marketing
              </h3>
              <p className="text-gray-400 leading-relaxed">
                Access to our network of 600+ verified influencers with proven track records across all major Web3 platforms.
              </p>
            </Card>

            <Card className="p-8 bg-zinc-900/50 border-white/10 hover:border-white/20 transition-all hover:bg-zinc-900/80 overflow-hidden">
              <div className="mb-6">
                <div className="w-full h-40 rounded-xl overflow-hidden mb-4">
                  <img 
                    src="https://images.unsplash.com/photo-1642790106117-e829e14a795f?w=600&h=300&fit=crop&q=80" 
                    alt="Token Value Creation" 
                    className="w-full h-full object-cover opacity-80 hover:opacity-100 transition-opacity grayscale hover:grayscale-0"
                  />
                </div>
              </div>
              <h3 className="text-2xl font-bold mb-4 text-white">
                Token Value Creation
              </h3>
              <p className="text-gray-400 leading-relaxed">
                Strategic buy pressure that delivers 3X buy volume.
              </p>
            </Card>

            <Card className="p-8 bg-zinc-900/50 border-white/10 hover:border-white/20 transition-all hover:bg-zinc-900/80 overflow-hidden">
              <div className="mb-6">
                <div className="w-full h-40 rounded-xl overflow-hidden mb-4">
                  <img 
                    src="https://images.unsplash.com/photo-1522071820081-009f0129c71c?w=600&h=300&fit=crop&q=80" 
                    alt="Community Growth" 
                    className="w-full h-full object-cover opacity-80 hover:opacity-100 transition-opacity grayscale hover:grayscale-0"
                  />
                </div>
              </div>
              <h3 className="text-2xl font-bold mb-4 text-white">
                Community Growth
              </h3>
              <p className="text-gray-400 leading-relaxed">
                We cultivate quality Web3 community members, driving meaningful growth and lasting brand loyalty.
              </p>
            </Card>

            <Card className="p-8 bg-zinc-900/50 border-white/10 hover:border-white/20 transition-all hover:bg-zinc-900/80 overflow-hidden">
              <div className="mb-6">
                <div className="w-full h-40 rounded-xl overflow-hidden mb-4">
                  <img 
                    src="https://images.unsplash.com/photo-1552664730-d307ca884978?w=600&h=300&fit=crop&q=80" 
                    alt="Community Management" 
                    className="w-full h-full object-cover opacity-80 hover:opacity-100 transition-opacity grayscale hover:grayscale-0"
                  />
                </div>
              </div>
              <h3 className="text-2xl font-bold mb-4 text-white">
                Community Management
              </h3>
              <p className="text-gray-400 leading-relaxed">
                We expertly manage Web3 communities with effective channel moderation, interactive discussions, and engaging events.
              </p>
            </Card>

            <Card className="p-8 bg-zinc-900/50 border-white/10 hover:border-white/20 transition-all hover:bg-zinc-900/80 overflow-hidden">
              <div className="mb-6">
                <div className="w-full h-40 rounded-xl overflow-hidden mb-4">
                  <img 
                    src="https://images.unsplash.com/photo-1521791136064-7986c2920216?w=600&h=300&fit=crop&q=80" 
                    alt="Partnership Management" 
                    className="w-full h-full object-cover opacity-80 hover:opacity-100 transition-opacity grayscale hover:grayscale-0"
                  />
                </div>
              </div>
              <h3 className="text-2xl font-bold mb-4 text-white">
                Partnership Management
              </h3>
              <p className="text-gray-400 leading-relaxed">
                We establish strategic blockchain partnerships aligned with your project's long-term growth objectives.
              </p>
            </Card>

            <Card className="p-8 bg-zinc-900/50 border-white/10 hover:border-white/20 transition-all hover:bg-zinc-900/80 overflow-hidden">
              <div className="mb-6">
                <div className="w-full h-40 rounded-xl overflow-hidden mb-4">
                  <img 
                    src="https://images.unsplash.com/photo-1504711434969-e33886168f5c?w=600&h=300&fit=crop&q=80" 
                    alt="PR & Media Marketing" 
                    className="w-full h-full object-cover opacity-80 hover:opacity-100 transition-opacity grayscale hover:grayscale-0"
                  />
                </div>
              </div>
              <h3 className="text-2xl font-bold mb-4 text-white">
                PR & Media Marketing
              </h3>
              <p className="text-gray-400 leading-relaxed">
                Top crypto media, guaranteed coverage. Direct relationships with major publications and journalists.
              </p>
            </Card>

            <Card className="p-8 bg-zinc-900/50 border-white/10 hover:border-white/20 transition-all hover:bg-zinc-900/80 overflow-hidden">
              <div className="mb-6">
                <div className="w-full h-40 rounded-xl overflow-hidden mb-4">
                  <img 
                    src="https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?w=600&h=300&fit=crop&q=80" 
                    alt="Tier-1 Exchange Listing" 
                    className="w-full h-full object-cover opacity-80 hover:opacity-100 transition-opacity grayscale hover:grayscale-0"
                  />
                </div>
              </div>
              <h3 className="text-2xl font-bold mb-4 text-white">
                Tier-1 Exchange Listing
              </h3>
              <p className="text-gray-400 leading-relaxed">
                Direct access to Binance, OKX, Upbit and more. Navigate the complex listing process with expert guidance.
              </p>
            </Card>

            <Card className="p-8 bg-zinc-900/50 border-white/10 hover:border-white/20 transition-all hover:bg-zinc-900/80 overflow-hidden">
              <div className="mb-6">
                <div className="w-full h-40 rounded-xl overflow-hidden mb-4">
                  <img 
                    src="https://images.unsplash.com/photo-1559136555-9303baea8ebd?w=600&h=300&fit=crop&q=80" 
                    alt="VC Network" 
                    className="w-full h-full object-cover opacity-80 hover:opacity-100 transition-opacity grayscale hover:grayscale-0"
                  />
                </div>
              </div>
              <h3 className="text-2xl font-bold mb-4 text-white">
                VC Network
              </h3>
              <p className="text-gray-400 leading-relaxed">
                Direct line to top VCs and investment groups. Access to our network of strategic investors.
              </p>
            </Card>

            <Card className="p-8 bg-zinc-900/50 border-white/10 hover:border-white/20 transition-all hover:bg-zinc-900/80 overflow-hidden">
              <div className="mb-6">
                <div className="w-full h-40 rounded-xl overflow-hidden mb-4">
                  <img 
                    src="https://images.unsplash.com/photo-1590283603385-17ffb3a7f29f?w=600&h=300&fit=crop&q=80" 
                    alt="Market Making" 
                    className="w-full h-full object-cover opacity-80 hover:opacity-100 transition-opacity grayscale hover:grayscale-0"
                  />
                </div>
              </div>
              <h3 className="text-2xl font-bold mb-4 text-white">
                Market Making
              </h3>
              <p className="text-gray-400 leading-relaxed">
                Professional market making through trusted partners. Ensure healthy liquidity and price discovery.
              </p>
            </Card>

            <Card className="p-8 bg-zinc-900/50 border-white/10 hover:border-white/20 transition-all hover:bg-zinc-900/80 overflow-hidden">
              <div className="mb-6">
                <div className="w-full h-40 rounded-xl overflow-hidden mb-4">
                  <img 
                    src="https://images.unsplash.com/photo-1480796927426-f609979314bd?w=600&h=300&fit=crop&q=80" 
                    alt="Asian Market" 
                    className="w-full h-full object-cover opacity-80 hover:opacity-100 transition-opacity grayscale hover:grayscale-0"
                  />
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


      {/* FAQ Section */}
      <section className="py-32 px-6" data-section="faq">
        <div className="max-w-4xl mx-auto">
          <div className="text-center mb-16">
            <Badge
              variant="outline"
              className="mb-8 border-white/20 text-white/80 bg-white/5"
            >
              FAQ
            </Badge>
            <h2 className="text-4xl md:text-5xl font-bold mb-4">
              Frequently Asked Questions
            </h2>
          </div>

          <div className="space-y-8">
            {/* Strategy & Approach */}
            <div>
              <h3 className="text-xl font-bold text-purple-400 mb-4 flex items-center gap-2">
                <div className="w-2 h-2 rounded-full bg-purple-500"></div>
                Strategy & Approach
              </h3>
              <div className="space-y-4">
                <details className="group bg-zinc-900/50 rounded-xl border border-white/10 overflow-hidden">
                  <summary className="flex items-center justify-between p-6 cursor-pointer hover:bg-white/5 transition-colors">
                    <span className="font-semibold text-white">What sets Magnor apart?</span>
                    <span className="text-purple-400 group-open:rotate-180 transition-transform">
                      <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
                      </svg>
                    </span>
                  </summary>
                  <div className="px-6 pb-6 text-gray-400">
                    We view you as a partner, not just a client, standing by your side at every stage of the marketing lifecycle. Beyond speaking fluent Web3, our long-standing relationships with top KOLs have built a unique level of trust and leverage, giving your project unmatched credibility that standard agencies simply can't offer.
                  </div>
                </details>

                <details className="group bg-zinc-900/50 rounded-xl border border-white/10 overflow-hidden">
                  <summary className="flex items-center justify-between p-6 cursor-pointer hover:bg-white/5 transition-colors">
                    <span className="font-semibold text-white">How do you handle token launches?</span>
                    <span className="text-purple-400 group-open:rotate-180 transition-transform">
                      <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
                      </svg>
                    </span>
                  </summary>
                  <div className="px-6 pb-6 text-gray-400">
                    We manage the entire lifecycle. If you are preparing for an ICO, IDO, or TGE, we engineer the necessary pre-launch momentum to attract high-value investors and genuine token holders before you go live.
                  </div>
                </details>

                <details className="group bg-zinc-900/50 rounded-xl border border-white/10 overflow-hidden">
                  <summary className="flex items-center justify-between p-6 cursor-pointer hover:bg-white/5 transition-colors">
                    <span className="font-semibold text-white">Do you prioritize hype or sustainability?</span>
                    <span className="text-purple-400 group-open:rotate-180 transition-transform">
                      <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
                      </svg>
                    </span>
                  </summary>
                  <div className="px-6 pb-6 text-gray-400">
                    We build for longevity. While we are experts at generating immediate buzz, our core focus is on sustainable growth strategies and authentic community building to ensure your project thrives long after the initial hype cycle.
                  </div>
                </details>
              </div>
            </div>

            {/* Execution & Results */}
            <div>
              <h3 className="text-xl font-bold text-purple-400 mb-4 flex items-center gap-2">
                <div className="w-2 h-2 rounded-full bg-purple-500"></div>
                Execution & Results
              </h3>
              <div className="space-y-4">
                <details className="group bg-zinc-900/50 rounded-xl border border-white/10 overflow-hidden">
                  <summary className="flex items-center justify-between p-6 cursor-pointer hover:bg-white/5 transition-colors">
                    <span className="font-semibold text-white">How do you determine the marketing mix?</span>
                    <span className="text-purple-400 group-open:rotate-180 transition-transform">
                      <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
                      </svg>
                    </span>
                  </summary>
                  <div className="px-6 pb-6 text-gray-400">
                    We reject "cookie-cutter" solutions. Based on your specific roadmap, we deploy a strategic mix of SEO, PPC, PR, and high-impact influencer marketing to maximize ROI for your niche.
                  </div>
                </details>

                <details className="group bg-zinc-900/50 rounded-xl border border-white/10 overflow-hidden">
                  <summary className="flex items-center justify-between p-6 cursor-pointer hover:bg-white/5 transition-colors">
                    <span className="font-semibold text-white">How is performance measured?</span>
                    <span className="text-purple-400 group-open:rotate-180 transition-transform">
                      <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
                      </svg>
                    </span>
                  </summary>
                  <div className="px-6 pb-6 text-gray-400">
                    We rely on data, not guesses. We track transparent KPIs—community growth, on-chain activity, and engagement rates—providing you with clear reports so you can verify the impact yourself.
                  </div>
                </details>

                <details className="group bg-zinc-900/50 rounded-xl border border-white/10 overflow-hidden">
                  <summary className="flex items-center justify-between p-6 cursor-pointer hover:bg-white/5 transition-colors">
                    <span className="font-semibold text-white">How fast can we deploy?</span>
                    <span className="text-purple-400 group-open:rotate-180 transition-transform">
                      <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
                      </svg>
                    </span>
                  </summary>
                  <div className="px-6 pb-6 text-gray-400">
                    Our process is streamlined for speed. We start with a focused discovery phase to align on strategy, then immediately execute a custom roadmap tailored to your launch or growth targets.
                  </div>
                </details>
              </div>
            </div>

            {/* Budget */}
            <div>
              <h3 className="text-xl font-bold text-purple-400 mb-4 flex items-center gap-2">
                <div className="w-2 h-2 rounded-full bg-purple-500"></div>
                Budget
              </h3>
              <div className="space-y-4">
                <details className="group bg-zinc-900/50 rounded-xl border border-white/10 overflow-hidden">
                  <summary className="flex items-center justify-between p-6 cursor-pointer hover:bg-white/5 transition-colors">
                    <span className="font-semibold text-white">How is your pricing structured?</span>
                    <span className="text-purple-400 group-open:rotate-180 transition-transform">
                      <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
                      </svg>
                    </span>
                  </summary>
                  <div className="px-6 pb-6 text-gray-400">
                    We don't use fixed packages because every project has different needs. Our pricing is custom-quoted based on the scope, ensuring you only pay for the services that drive your specific goals.
                  </div>
                </details>
              </div>
            </div>
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
