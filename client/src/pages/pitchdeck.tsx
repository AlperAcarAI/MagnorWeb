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
} from "lucide-react";
import { Link } from "wouter";
import magnorLogo from "@shared/Logo1.svg";

export default function PitchDeck() {
    const [currentSlide, setCurrentSlide] = useState(0);
    const totalSlides = 5;

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
                        <div className="text-xl text-gray-400">PROJECTS</div>
                    </div>
                    <div>
                        <div className="text-6xl md:text-7xl font-bold mb-2">5-20X</div>
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

                <div className="grid grid-cols-2 md:grid-cols-4 gap-6 mb-12">
                    {["Markchain", "Disence", "Artrade", "Gmedia", "Concordium", "Fatty", "LimeWire", "Lingo", "My Lovely Planet", "Opulous", "SpaceCatch"].map((partner, idx) => (
                        <Card key={idx} className="p-8 bg-zinc-900/50 border-white/10 flex items-center justify-center hover:border-white/20 transition-all">
                            <span className="text-xl font-bold text-center">{partner}</span>
                        </Card>
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

                <div className="grid md:grid-cols-3 gap-6 mb-12">
                    <Card className="p-8 bg-zinc-900/50 border-white/10 hover:border-white/20 transition-all">
                        <Users className="w-12 h-12 mb-6" />
                        <h3 className="text-2xl font-bold mb-4">KOL Marketing</h3>
                        <p className="text-gray-400">
                            Only verified influencers with proven results
                        </p>
                    </Card>

                    <Card className="p-8 bg-zinc-900/50 border-white/10 hover:border-white/20 transition-all">
                        <TrendingUp className="w-12 h-12 mb-6" />
                        <h3 className="text-2xl font-bold mb-4">Token Value Creation</h3>
                        <p className="text-gray-400">
                            Strategic buy pressure that delivers 3X buy volume, zero risk
                        </p>
                    </Card>

                    <Card className="p-8 bg-zinc-900/50 border-white/10 hover:border-white/20 transition-all">
                        <Newspaper className="w-12 h-12 mb-6" />
                        <h3 className="text-2xl font-bold mb-4">PR & Media Marketing</h3>
                        <p className="text-gray-400">
                            Top crypto media, guaranteed coverage
                        </p>
                    </Card>

                    <Card className="p-8 bg-zinc-900/50 border-white/10 hover:border-white/20 transition-all">
                        <div className="w-12 h-12 mb-6 flex items-center justify-center">
                            <div className="text-3xl">🔄</div>
                        </div>
                        <h3 className="text-2xl font-bold mb-4">Tier-1 Exchange Listing</h3>
                        <p className="text-gray-400">
                            Direct access to Binance, OKX, and more
                        </p>
                    </Card>

                    <Card className="p-8 bg-zinc-900/50 border-white/10 hover:border-white/20 transition-all">
                        <Handshake className="w-12 h-12 mb-6" />
                        <h3 className="text-2xl font-bold mb-4">VC Network</h3>
                        <p className="text-gray-400">
                            Direct line to top VCs and investment groups
                        </p>
                    </Card>

                    <Card className="p-8 bg-zinc-900/50 border-white/10 hover:border-white/20 transition-all">
                        <Scale className="w-12 h-12 mb-6" />
                        <h3 className="text-2xl font-bold mb-4">Market Making</h3>
                        <p className="text-gray-400">
                            Professional market making through trusted partners
                        </p>
                    </Card>
                </div>

                <p className="text-center text-gray-400 mt-12">
                    Our comprehensive service suite is designed to provide end-to-end solutions for Web3 projects at every stage of development.
                </p>
            </div>
        </div>,

        // Slide 4: Token Value Creation - Key Benefits
        <div key="slide4" className="flex flex-col items-center justify-center min-h-screen px-6">
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
                        <div className="text-sm text-gray-400 mb-2">TOTAL MARKET ACTIVITY</div>
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
                    <h3 className="text-3xl font-bold mb-4">Sustainable Growth</h3>
                    <p className="text-gray-400 text-lg">
                        Strategic investment patterns create healthy long-term price appreciation. Projects undergo
                        strict filtering criteria to ensure quality and potential.
                    </p>
                </div>
            </div>
        </div>,

        // Slide 5: How We Work
        <div key="slide5" className="flex flex-col items-center justify-center min-h-screen px-6">
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
                        <div className="text-6xl md:text-7xl font-bold mb-2">150+</div>
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
