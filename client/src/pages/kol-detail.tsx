import { useEffect, useState } from "react";
import { useLocation, useRoute } from "wouter";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { useToast } from "@/hooks/use-toast";
import { Separator } from "@/components/ui/separator";

interface KOL {
  id: string;
  name: string;
  tierScore: number | null;
  telegramAddress: string | null;
  email: string | null;
  phone: string | null;
  notes: string | null;
  socialMedia: Array<{
    id: string;
    link: string;
    followerCount: number | null;
    socialMedia: {
      id: string;
      name: string;
    };
  }>;
  categories: Array<{
    id: string;
    category: {
      id: string;
      name: string;
    };
  }>;
  languages: Array<{
    id: string;
    language: {
      id: string;
      name: string;
    };
  }>;
  agencies: Array<{
    id: string;
    agency: {
      id: string;
      name: string;
      email: string | null;
      phone: string | null;
    };
  }>;
  pricing: Array<{
    id: string;
    serviceName: string;
    price: string;
    priceWithoutCommission: string | null;
    currency: string;
    notes: string | null;
    contactInfo: string | null;
  }>;
}

export default function KOLDetail() {
  const [, setLocation] = useLocation();
  const [, params] = useRoute("/app/kols/view/:id");
  const { toast } = useToast();
  const [kol, setKol] = useState<KOL | null>(null);
  const [isLoading, setIsLoading] = useState(true);

  useEffect(() => {
    if (params?.id) {
      loadKOL(params.id);
    }
  }, [params?.id]);

  const loadKOL = async (id: string) => {
    try {
      const response = await fetch(`/api/kols/${id}`);
      if (response.ok) {
        const data = await response.json();
        setKol(data.kol);
      } else {
        throw new Error("KOL bulunamadı");
      }
    } catch (error) {
      toast({
        variant: "destructive",
        title: "Hata",
        description: "KOL yüklenirken bir hata oluştu",
      });
      setLocation("/app/kols");
    } finally {
      setIsLoading(false);
    }
  };

  const handleLogout = async () => {
    await fetch("/api/auth/logout", { method: "POST" });
    setLocation("/app");
  };

  if (isLoading) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-black">
        <div className="w-8 h-8 border-4 border-purple-600 border-t-transparent rounded-full animate-spin"></div>
      </div>
    );
  }

  if (!kol) {
    return null;
  }

  return (
    <div className="min-h-screen bg-black text-white">
      {/* Header */}
      <header className="bg-black/50 border-b border-white/10 backdrop-blur-md sticky top-0 z-10">
        <div className="container mx-auto px-4 py-4 flex items-center justify-between">
          <div className="flex items-center gap-6">
            <div className="flex items-center gap-3">
              <img 
                src="/Logo.svg" 
                alt="Magnor" 
                className="h-8"
                style={{ filter: 'brightness(0) invert(1)' }}
              />
              <span className="text-xl font-bold text-white">KOL Portal</span>
            </div>
            
            <nav className="hidden md:flex items-center gap-4">
              <Button
                variant="ghost"
                onClick={() => setLocation("/app/dashboard")}
                className="text-gray-400 hover:bg-white/10 hover:text-white"
              >
                Dashboard
              </Button>
              <Button
                variant="ghost"
                onClick={() => setLocation("/app/kols")}
                className="bg-white/10 text-white hover:bg-white/20"
              >
                KOL'lar
              </Button>
              <Button
                variant="ghost"
                onClick={() => setLocation("/app/agencies")}
                className="text-gray-400 hover:bg-white/10 hover:text-white"
              >
                Ajanslar
              </Button>
            </nav>
          </div>
          
          <Button
            variant="outline"
            onClick={handleLogout}
            className="text-red-400 hover:text-red-300 hover:bg-red-500/10 border-red-500/20"
          >
            Çıkış Yap
          </Button>
        </div>
      </header>

      {/* Main Content */}
      <main className="container mx-auto px-4 py-8">
        {/* Header with Actions */}
        <div className="flex items-center justify-between mb-6">
          <div className="flex items-center gap-4">
            <Button
              variant="outline"
              onClick={() => setLocation("/app/kols")}
              className="border-white/20 hover:bg-white/10"
            >
              ← Geri
            </Button>
            <div>
              <h1 className="text-3xl font-bold text-white mb-1">{kol.name}</h1>
              <p className="text-gray-400">KOL Detayları</p>
            </div>
          </div>
          
          <Button
            onClick={() => setLocation(`/app/kols/${kol.id}`)}
            className="bg-purple-600 hover:bg-purple-700"
          >
            <svg className="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z" />
            </svg>
            Düzenle
          </Button>
        </div>

        <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
          {/* Main Info */}
          <div className="lg:col-span-2 space-y-6">
            {/* Basic Information */}
            <Card className="bg-zinc-900/50 border-white/10">
              <CardHeader>
                <CardTitle className="text-white flex items-center justify-between">
                  <span>Temel Bilgiler</span>
                  {kol.tierScore && (
                    <Badge variant="secondary" className="text-lg px-4 py-1">
                      {"⭐".repeat(kol.tierScore)}
                    </Badge>
                  )}
                </CardTitle>
              </CardHeader>
              <CardContent className="space-y-4">
                <div>
                  <label className="text-sm text-gray-400">İsim</label>
                  <p className="text-lg font-medium text-white mt-1">{kol.name}</p>
                </div>

                {kol.tierScore && (
                  <div>
                    <label className="text-sm text-gray-400">Tier Score</label>
                    <p className="text-lg font-medium text-white mt-1">
                      {kol.tierScore} / 5
                    </p>
                  </div>
                )}

                {kol.email && (
                  <div>
                    <label className="text-sm text-gray-400">Email</label>
                    <p className="text-base text-white mt-1">{kol.email}</p>
                  </div>
                )}

                {kol.phone && (
                  <div>
                    <label className="text-sm text-gray-400">Telefon</label>
                    <p className="text-base text-white mt-1">{kol.phone}</p>
                  </div>
                )}

                {kol.telegramAddress && (
                  <div>
                    <label className="text-sm text-gray-400">Telegram / İletişim</label>
                    <p className="text-base text-white mt-1">{kol.telegramAddress}</p>
                  </div>
                )}

                {kol.notes && (
                  <div>
                    <label className="text-sm text-gray-400">Notlar</label>
                    <p className="text-base text-white mt-1 whitespace-pre-wrap">{kol.notes}</p>
                  </div>
                )}
              </CardContent>
            </Card>

            {/* Social Media */}
            <Card className="bg-zinc-900/50 border-white/10">
              <CardHeader>
                <CardTitle className="text-white">Sosyal Medya Hesapları</CardTitle>
                <CardDescription className="text-gray-400">
                  {kol.socialMedia?.length || 0} platform
                </CardDescription>
              </CardHeader>
              <CardContent>
                {!kol.socialMedia || kol.socialMedia.length === 0 ? (
                  <p className="text-gray-500 text-center py-8">
                    Henüz sosyal medya hesabı eklenmemiş
                  </p>
                ) : (
                  <div className="space-y-3">
                    {kol.socialMedia.map((sm) => (
                      <div
                        key={sm.id}
                        className="flex items-center justify-between p-4 bg-black/30 rounded-lg border border-white/5 hover:border-white/20 transition-colors"
                      >
                        <div className="flex items-center gap-3">
                          <Badge variant="secondary" className="px-3">
                            {sm.socialMedia.name}
                          </Badge>
                          <a
                            href={sm.link}
                            target="_blank"
                            rel="noopener noreferrer"
                            className="text-blue-400 hover:text-blue-300 hover:underline truncate max-w-md"
                          >
                            {sm.link}
                          </a>
                        </div>
                        {sm.followerCount && (
                          <Badge variant="outline" className="text-xs">
                            {sm.followerCount.toLocaleString()} takipçi
                          </Badge>
                        )}
                      </div>
                    ))}
                  </div>
                )}
              </CardContent>
            </Card>
          </div>

          {/* Sidebar */}
          <div className="space-y-6">
            {/* Languages */}
            <Card className="bg-zinc-900/50 border-white/10">
              <CardHeader>
                <CardTitle className="text-white">Diller</CardTitle>
                <CardDescription className="text-gray-400">
                  {kol.languages?.length || 0} dil
                </CardDescription>
              </CardHeader>
              <CardContent>
                {!kol.languages || kol.languages.length === 0 ? (
                  <p className="text-gray-500 text-sm">Dil bilgisi yok</p>
                ) : (
                  <div className="flex flex-wrap gap-2">
                    {kol.languages.map((lang) => (
                      <Badge key={lang.id} variant="outline" className="px-3 py-1">
                        {lang.language.name}
                      </Badge>
                    ))}
                  </div>
                )}
              </CardContent>
            </Card>

            {/* Categories */}
            <Card className="bg-zinc-900/50 border-white/10">
              <CardHeader>
                <CardTitle className="text-white">Kategoriler</CardTitle>
                <CardDescription className="text-gray-400">
                  {kol.categories?.length || 0} kategori
                </CardDescription>
              </CardHeader>
              <CardContent>
                {!kol.categories || kol.categories.length === 0 ? (
                  <p className="text-gray-500 text-sm">Kategori bilgisi yok</p>
                ) : (
                  <div className="flex flex-wrap gap-2">
                    {kol.categories.map((cat) => (
                      <Badge key={cat.id} variant="outline" className="px-3 py-1">
                        {cat.category.name}
                      </Badge>
                    ))}
                  </div>
                )}
              </CardContent>
            </Card>

            {/* Agencies */}
            <Card className="bg-zinc-900/50 border-white/10">
              <CardHeader>
                <CardTitle className="text-white">Ajanslar</CardTitle>
                <CardDescription className="text-gray-400">
                  {kol.agencies?.length || 0} ajans
                </CardDescription>
              </CardHeader>
              <CardContent>
                {!kol.agencies || kol.agencies.length === 0 ? (
                  <p className="text-gray-500 text-sm">Ajans bilgisi yok</p>
                ) : (
                  <div className="space-y-3">
                    {kol.agencies.map((agency) => (
                      <div
                        key={agency.id}
                        className="p-3 bg-black/30 rounded-lg border border-white/5"
                      >
                        <p className="font-medium text-white mb-1">
                          {agency.agency.name}
                        </p>
                        {agency.agency.email && (
                          <p className="text-sm text-gray-400">
                            📧 {agency.agency.email}
                          </p>
                        )}
                        {agency.agency.phone && (
                          <p className="text-sm text-gray-400">
                            📱 {agency.agency.phone}
                          </p>
                        )}
                      </div>
                    ))}
                  </div>
                )}
              </CardContent>
            </Card>

            {/* Pricing */}
            <Card className="bg-zinc-900/50 border-white/10">
              <CardHeader>
                <CardTitle className="text-white">Fiyatlar</CardTitle>
                <CardDescription className="text-gray-400">
                  {kol.pricing?.length || 0} fiyat
                </CardDescription>
              </CardHeader>
              <CardContent>
                {!kol.pricing || kol.pricing.length === 0 ? (
                  <p className="text-gray-500 text-sm">Fiyat bilgisi yok</p>
                ) : (
                  <div className="space-y-3">
                    {kol.pricing.map((price) => (
                      <div
                        key={price.id}
                        className="p-3 bg-black/30 rounded-lg border border-white/5"
                      >
                        <p className="font-medium text-white mb-2">
                          {price.serviceName}
                        </p>
                        <div className="space-y-1">
                          <p className="text-lg font-bold text-green-400">
                            ${parseFloat(price.price).toLocaleString()}
                          </p>
                          {price.priceWithoutCommission && (
                            <p className="text-sm text-blue-400">
                              Komisyonsuz: ${parseFloat(price.priceWithoutCommission).toLocaleString()}
                            </p>
                          )}
                          {price.notes && (
                            <p className="text-xs text-gray-500 mt-1">
                              {price.notes}
                            </p>
                          )}
                        </div>
                      </div>
                    ))}
                  </div>
                )}
              </CardContent>
            </Card>
          </div>
        </div>
      </main>
    </div>
  );
}
