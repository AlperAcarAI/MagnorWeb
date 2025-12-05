import { useState, useEffect } from "react";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Card } from "@/components/ui/card";
import {
    ChevronLeft,
    ChevronRight,
    Users,
    TrendingUp,
    Newspaper,
    Handshake,
    Scale,
    Megaphone,
    Network,
    Building2,
    ArrowUpRight,
} from "lucide-react";
import { Link } from "wouter";
import magnorLogo from "@shared/Logo1.svg";

// Static logo imports (same as home.tsx)
import antixLogo from "/logos/Antix.png";
import artradeLogo from "/logos/Artrade.png";
import binanceLogo from "/logos/Binance.png";
import bitgetLogo from "/logos/Bitget.png";
import cmediaLogo from "/logos/CMedia.jpeg";
import castrumLogo from "/logos/Castrum Capital.jpg";
import coinscoutLogo from "/logos/Coinscout.jpg";
import concordiumLogo from "/logos/Concordium.png";
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

// Static clients list with logos (same as home.tsx)
const clients = [
    { name: "Antix", logo: antixLogo },
    { name: "Artrade", logo: artradeLogo },
    { name: "Binance", logo: binanceLogo },
    { name: "Bitget", logo: bitgetLogo },
    { name: "CMedia", logo: cmediaLogo },
    { name: "Castrum Capital", logo: castrumLogo },
    { name: "Coinscout", logo: coinscoutLogo },
    { name: "Concordium", logo: concordiumLogo },
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

export default function PitchDeck() {
    const [currentSlide, setCurrentSlide] = useState(0);
    const totalSlides = 6;

    useEffect(() => {
        const handleKeyDown = (e: KeyboardEvent) => {
            if (e.key === "ArrowLeft") {
                prevSlide();
            } else if (e.key === "ArrowRight") {
                nextSlide();
            }
        };

        window.addEventListener("keydown", handleKeyDown);
        return () => window.removeEventListener("keydown", handleKeyDown);
    }, [currentSlide]);

    const nextSlide = () => {
        setCurrentSlide((prev) => (prev + 1) % totalSlides);
    };

    const prevSlide = () => {
        setCurrentSlide((prev) => (prev - 1 + totalSlides) % totalSlides);
    };

    const slides = [
        // Slide 1: About Magnor - Key Strengths
        <div key="slide1" className="flex flex-col items-center justify-center min-h-screen px-6">
            <div className="max-w-7xl w-full">
                <h1 className="text-5xl md:text-7xl font-bold mb-16">
                    About Magnor <span className="text-gray-500">— Key Strengths</span>
                </h1>

                <div className="grid md:grid-cols-3 gap-8 mb-20">
                    <Card className="p-8 bg-zinc-900/50 border-white/10">
                        <div className="text-4xl font-bold mb-4">01</div>
                        <h3 className="text-2xl font-bold mb-4">Trust & Transparency Focus</h3>
                        <p className="text-gray-400">
                            Every step is measurable—clear reporting, clear outcomes, no guesswork.
                        </p>
                    </Card>

                    <Card className="p-8 bg-zinc-900/50 border-white/10">
                        <div className="text-4xl font-bold mb-4">02</div>
                        <h3 className="text-2xl font-bold mb-4">Deep, trusted KOL/investor network</h3>
                        <p className="text-gray-400">
                            Strong relationships with influential KOLs and investment groups.
                        </p>
                    </Card>

                    <Card className="p-8 bg-zinc-900/50 border-white/10">
                        <div className="text-4xl font-bold mb-4">03</div>
                        <h3 className="text-2xl font-bold mb-4">Growth Partner, Not Just a Marketing Agency</h3>
                        <p className="text-gray-400">
                            We take ownership, think strategically, and act like part of your team.
                        </p>
                    </Card>
                </div>

                <div className="grid md:grid-cols-3 gap-12 text-center">
                    <div>
                        <div className="text-6xl md:text-7xl font-bold mb-2">600+</div>
                        <div className="text-xl text-gray-400">KOLS</div>
                    </div>
                    <div>
                        <div className="text-6xl md:text-7xl font-bold mb-2">100+</div>
                        <div className="text-xl text-gray-400">CLIENTS</div>
                    </div>
                    <div>
                        <div className="text-6xl md:text-7xl font-bold mb-2">5-30X</div>
                        <div className="text-xl text-gray-400">ROI AVERAGE</div>
                    </div>
                </div>

                <p className="text-center text-gray-400 mt-12 max-w-4xl mx-auto">
                    We connect blockchain projects with verified KOLs and communities, designing campaigns
                    that create real engagement and measurable results.
                </p>
            </div>
        </div>,

        // Slide 2: Trusted by Our Partners
        <div key="slide2" className="flex flex-col items-center justify-center min-h-screen px-6">
            <div className="max-w-7xl w-full">
                <h1 className="text-5xl md:text-7xl font-bold mb-16">Trusted by Our Partners</h1>

                <div className="grid grid-cols-3 md:grid-cols-6 gap-4 mb-12">
                    {clients.map((client, idx) => (
                        <div
                            key={idx}
                            className="group flex flex-col items-center justify-center p-4 rounded-lg border border-white/10 bg-zinc-900/50 hover:border-white/20 transition-all"
                        >
                            <div className="w-16 h-16 rounded-lg overflow-hidden flex items-center justify-center mb-3">
                                <img
                                    src={client.logo}
                                    alt={client.name}
                                    className="w-full h-full object-cover"
                                />
                            </div>
                            <span className="text-xs font-semibold text-center text-white/80">
                                {client.name}
                            </span>
                        </div>
                    ))}
                </div>

                <p className="text-center text-gray-400 text-xl mt-16">
                    Building the future of Web3 together with trusted partners
                </p>
            </div>
        </div>,

        // Slide 3: Our Services
        <div key="slide3" className="flex flex-col items-center justify-center min-h-screen px-6">
            <div className="max-w-7xl w-full">
                <h1 className="text-5xl md:text-7xl font-bold mb-16">Our Services</h1>

                <div className="grid md:grid-cols-2 lg:grid-cols-5 gap-4 mb-12">
                    <Card className="p-6 bg-zinc-900/50 border-white/10 hover:border-white/20 transition-all">
                        <Megaphone className="w-10 h-10 mb-4" />
                        <h3 className="text-lg font-bold mb-2">KOL Marketing</h3>
                        <p className="text-gray-400 text-sm">
                            Access to our network of 600+ verified influencers with proven track records.
                        </p>
                    </Card>

                    <Card className="p-6 bg-zinc-900/50 border-white/10 hover:border-white/20 transition-all">
                        <TrendingUp className="w-10 h-10 mb-4" />
                        <h3 className="text-lg font-bold mb-2">Token Value Creation</h3>
                        <p className="text-gray-400 text-sm">
                            Strategic buy pressure that delivers 3X buy volume.
                        </p>
                    </Card>

                    <Card className="p-6 bg-zinc-900/50 border-white/10 hover:border-white/20 transition-all">
                        <Users className="w-10 h-10 mb-4" />
                        <h3 className="text-lg font-bold mb-2">Community Growth</h3>
                        <p className="text-gray-400 text-sm">
                            We cultivate quality Web3 community members, driving meaningful growth.
                        </p>
                    </Card>

                    <Card className="p-6 bg-zinc-900/50 border-white/10 hover:border-white/20 transition-all">
                        <Network className="w-10 h-10 mb-4" />
                        <h3 className="text-lg font-bold mb-2">Community Management</h3>
                        <p className="text-gray-400 text-sm">
                            Expert channel moderation, interactive discussions, and engaging events.
                        </p>
                    </Card>

                    <Card className="p-6 bg-zinc-900/50 border-white/10 hover:border-white/20 transition-all">
                        <Handshake className="w-10 h-10 mb-4" />
                        <h3 className="text-lg font-bold mb-2">Partnership Management</h3>
                        <p className="text-gray-400 text-sm">
                            Strategic blockchain partnerships for long-term growth.
                        </p>
                    </Card>

                    <Card className="p-6 bg-zinc-900/50 border-white/10 hover:border-white/20 transition-all">
                        <Newspaper className="w-10 h-10 mb-4" />
                        <h3 className="text-lg font-bold mb-2">PR & Media Marketing</h3>
                        <p className="text-gray-400 text-sm">
                            Top crypto media, guaranteed coverage with major publications.
                        </p>
                    </Card>

                    <Card className="p-6 bg-zinc-900/50 border-white/10 hover:border-white/20 transition-all">
                        <Building2 className="w-10 h-10 mb-4" />
                        <h3 className="text-lg font-bold mb-2">Tier-1 Exchange Listing</h3>
                        <p className="text-gray-400 text-sm">
                            Direct access to Binance, OKX, Upbit and more.
                        </p>
                    </Card>

                    <Card className="p-6 bg-zinc-900/50 border-white/10 hover:border-white/20 transition-all">
                        <Users className="w-10 h-10 mb-4" />
                        <h3 className="text-lg font-bold mb-2">VC Network</h3>
                        <p className="text-gray-400 text-sm">
                            Direct line to top VCs and strategic investors.
                        </p>
                    </Card>

                    <Card className="p-6 bg-zinc-900/50 border-white/10 hover:border-white/20 transition-all">
                        <ArrowUpRight className="w-10 h-10 mb-4" />
                        <h3 className="text-lg font-bold mb-2">Market Making</h3>
                        <p className="text-gray-400 text-sm">
                            Professional market making for healthy liquidity.
                        </p>
                    </Card>

                    <Card className="p-6 bg-zinc-900/50 border-white/10 hover:border-white/20 transition-all">
                        <Network className="w-10 h-10 mb-4" />
                        <h3 className="text-lg font-bold mb-2">Asian Market</h3>
                        <p className="text-gray-400 text-sm">
                            Exclusive network of influential voices in China and Asia.
                        </p>
                    </Card>
                </div>

                <p className="text-center text-gray-400 mt-12">
                    Our comprehensive service suite is designed to provide end-to-end solutions for Web3 projects at every stage of development.
                </p>
            </div>
        </div>,

        // Slide 4: Campaign Showcase
        <div key="slide4" className="flex flex-col items-center justify-center min-h-screen px-6">
            <div className="max-w-7xl w-full">
                <h1 className="text-5xl md:text-7xl font-bold mb-8">Campaign Showcase</h1>
                <p className="text-xl text-gray-400 mb-12">See how we amplify your project across major platforms</p>

                <div className="grid md:grid-cols-3 gap-8">
                    <div className="group">
                        <div className="rounded-2xl overflow-hidden border border-white/10 hover:border-white/30 transition-all shadow-2xl">
                            <img
                                src="/campaign-telegram.png"
                                alt="Telegram Campaign"
                                className="w-full h-auto"
                            />
                        </div>
                        <p className="text-center text-gray-400 mt-4 text-lg font-semibold">Telegram</p>
                    </div>

                    <div className="group">
                        <div className="rounded-2xl overflow-hidden border border-white/10 hover:border-white/30 transition-all shadow-2xl">
                            <img
                                src="/campaign-youtube.png"
                                alt="YouTube Campaign"
                                className="w-full h-auto"
                            />
                        </div>
                        <p className="text-center text-gray-400 mt-4 text-lg font-semibold">YouTube</p>
                    </div>

                    <div className="group">
                        <div className="rounded-2xl overflow-hidden border border-white/10 hover:border-white/30 transition-all shadow-2xl">
                            <img
                                src="/campaign-twitter.png"
                                alt="Twitter/X Campaign"
                                className="w-full h-auto"
                            />
                        </div>
                        <p className="text-center text-gray-400 mt-4 text-lg font-semibold">Twitter / X</p>
                    </div>
                </div>

                <p className="text-center text-gray-400 text-xl mt-12">
                    Multi-platform campaigns designed for maximum reach and engagement
                </p>
            </div>
        </div>,

        // Slide 5: Token Value Creation - Key Benefits
        <div key="slide5" className="flex flex-col items-center justify-center min-h-screen px-6">
            <div className="max-w-7xl w-full">
                <h1 className="text-5xl md:text-7xl font-bold mb-16">
                    Token Value Creation <span className="text-gray-500">— Key Benefits</span>
                </h1>

                <div className="flex items-center justify-center gap-8 mb-16">
                    <Card className="p-12 bg-zinc-900/50 border-white/10">
                        <div className="text-sm text-gray-400 mb-2">CAMPAIGN BUDGET</div>
                        <div className="text-6xl font-bold">$50K</div>
                    </Card>

                    <div className="text-6xl font-bold">→</div>
                    <div className="text-4xl font-bold bg-white/5 px-6 py-3 rounded-lg">3X</div>
                    <div className="text-6xl font-bold">→</div>

                    <Card className="p-12 bg-zinc-900/50 border-white/10">
                        <div className="text-sm text-gray-400 mb-2">TOTAL BUY PRESSURE</div>
                        <div className="text-6xl font-bold">$150K</div>
                    </Card>
                </div>

                <div className="grid md:grid-cols-2 gap-6 mb-12">
                    <Card className="p-8 bg-zinc-900/50 border-white/10">
                        <h3 className="text-2xl font-bold mb-4">Guaranteed Buy Volume</h3>
                        <p className="text-gray-400">
                            Every campaign generates 3x the investment in guaranteed trading volume.
                        </p>
                    </Card>

                    <Card className="p-8 bg-zinc-900/50 border-white/10">
                        <h3 className="text-2xl font-bold mb-4">Risk Management</h3>
                        <p className="text-gray-400">
                            Advanced protection mechanisms prevent excessive market volatility.
                        </p>
                    </Card>

                    <Card className="p-8 bg-zinc-900/50 border-white/10">
                        <h3 className="text-2xl font-bold mb-4">Managed Exit Strategy</h3>
                        <p className="text-gray-400">
                            Coordinated profit-taking preserves market stability and long-term growth.
                        </p>
                    </Card>

                    <Card className="p-8 bg-zinc-900/50 border-white/10">
                        <h3 className="text-2xl font-bold mb-4">Investment Allocation</h3>
                        <p className="text-gray-400">
                            Partner investment groups commit capital based on project potential.
                        </p>
                    </Card>
                </div>

                <div className="mt-12">
                    <h3 className="text-3xl font-bold mb-4">Disclaimer</h3>
                    <p className="text-gray-400 text-lg">
                        Magnor is a marketing agency that provides services to projects in the crypto space. We are not
                        responsible for the success or failure of any project.
                    </p>
                </div>
            </div>
        </div>,

        // Slide 6: How We Work
        <div key="slide6" className="flex flex-col items-center justify-center min-h-screen px-6">
            <div className="max-w-7xl w-full">
                <h1 className="text-5xl md:text-7xl font-bold mb-8">How We Work</h1>
                <p className="text-xl text-gray-400 mb-16">
                    We work in sprints and divide the process into these key steps:
                </p>

                <div className="grid grid-cols-1 md:grid-cols-5 gap-6 mb-20">
                    <Card className="p-8 bg-white text-black border-0">
                        <div className="text-5xl font-bold mb-4">1</div>
                        <h3 className="text-2xl font-bold mb-3">Process project</h3>
                        <p className="text-gray-700">Understanding goals and ecosystem</p>
                    </Card>

                    <Card className="p-8 bg-zinc-900/50 border-white/10">
                        <div className="text-5xl font-bold mb-4">2</div>
                        <h3 className="text-2xl font-bold mb-3">Strategic plan</h3>
                        <p className="text-gray-400">Creating custom marketing strategy</p>
                    </Card>

                    <Card className="p-8 bg-zinc-900/50 border-white/10">
                        <div className="text-5xl font-bold mb-4">3</div>
                        <h3 className="text-2xl font-bold mb-3">KOL network</h3>
                        <p className="text-gray-400">Matching with verified influencers</p>
                    </Card>

                    <Card className="p-8 bg-zinc-900/50 border-white/10">
                        <div className="text-5xl font-bold mb-4">4</div>
                        <h3 className="text-2xl font-bold mb-3">Execute</h3>
                        <p className="text-gray-400">Implementation with monitoring</p>
                    </Card>

                    <Card className="p-8 bg-zinc-900/50 border-white/10">
                        <div className="text-5xl font-bold mb-4">5</div>
                        <h3 className="text-2xl font-bold mb-3">Results</h3>
                        <p className="text-gray-400">Detailed reporting and optimization</p>
                    </Card>
                </div>

                <div className="grid md:grid-cols-3 gap-12 text-center">
                    <div>
                        <div className="text-6xl md:text-7xl font-bold mb-2">200+</div>
                        <div className="text-xl text-gray-400">PROJECTS</div>
                    </div>
                    <div>
                        <div className="text-6xl md:text-7xl font-bold mb-2">600+</div>
                        <div className="text-xl text-gray-400">KOLS</div>
                    </div>
                    <div>
                        <div className="text-6xl md:text-7xl font-bold mb-2">5-20X</div>
                        <div className="text-xl text-gray-400">ROI AVERAGE</div>
                    </div>
                </div>

                <div className="text-right mt-16">
                    <p className="text-gray-500">www.magnor.agency</p>
                </div>
            </div>
        </div>,
    ];

    return (
        <div className="min-h-screen text-white relative">
            {/* Animated Background */}
            <div className="floating-orb orb-1"></div>
            <div className="floating-orb orb-2"></div>
            <div className="floating-orb orb-3"></div>
            <div className="gradient-mesh"></div>

            {/* Header */}
            <header className="fixed top-0 left-0 right-0 z-50 border-b border-white/5 backdrop-blur-md bg-black/50">
                <div className="max-w-7xl mx-auto px-6 py-5">
                    <div className="flex items-center justify-between">
                        <Link href="/">
                            <img
                                src={magnorLogo}
                                alt="Magnor Logo"
                                className="h-8 cursor-pointer"
                                style={{ filter: 'brightness(0) invert(1)' }}
                            />
                        </Link>

                        <div className="flex items-center gap-4">
                            <Badge variant="outline" className="border-white/20 text-white/80 bg-white/5">
                                {currentSlide + 1} / {totalSlides}
                            </Badge>
                            <Link href="/">
                                <Button size="sm" variant="outline" className="border-white/20 hover:bg-white/10 text-white">
                                    Back to Home
                                </Button>
                            </Link>
                        </div>
                    </div>
                </div>
            </header>

            {/* Slide Content */}
            <div className="pt-20">
                {slides[currentSlide]}
            </div>

            {/* Navigation Controls */}
            <div className="fixed bottom-8 left-1/2 -translate-x-1/2 z-50 flex items-center gap-4">
                <Button
                    onClick={prevSlide}
                    size="lg"
                    variant="outline"
                    className="border-white/20 hover:bg-white/10 text-white rounded-full w-14 h-14 p-0"
                    disabled={currentSlide === 0}
                >
                    <ChevronLeft className="w-6 h-6" />
                </Button>

                <div className="flex gap-2">
                    {Array.from({ length: totalSlides }).map((_, idx) => (
                        <button
                            key={idx}
                            onClick={() => setCurrentSlide(idx)}
                            className={`w-3 h-3 rounded-full transition-all ${idx === currentSlide
                                ? "bg-white w-8"
                                : "bg-white/30 hover:bg-white/50"
                                }`}
                        />
                    ))}
                </div>

                <Button
                    onClick={nextSlide}
                    size="lg"
                    variant="outline"
                    className="border-white/20 hover:bg-white/10 text-white rounded-full w-14 h-14 p-0"
                    disabled={currentSlide === totalSlides - 1}
                >
                    <ChevronRight className="w-6 h-6" />
                </Button>
            </div>

            {/* Keyboard Hint */}
            <div className="fixed bottom-8 right-8 z-40 text-sm text-gray-500">
                Use ← → arrow keys to navigate
            </div>
        </div>
    );
}
