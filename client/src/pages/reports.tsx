import { useEffect, useState } from "react";
import { useLocation } from "wouter";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Card, CardContent } from "@/components/ui/card";
import { useToast } from "@/hooks/use-toast";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";

interface KOL {
  id: string;
  name: string;
  tierScore: number | null;
  telegramAddress: string | null;
  email: string | null;
  socialMedia: any[];
  categories: any[];
  languages: any[];
  agencies: any[];
}

interface Pricing {
  id: string;
  kolId: string;
  serviceName: string;
  socialMediaDetails: any;
  price: string;
  priceWithoutCommission: string | null;
  currency: string;
  notes: string | null;
  kol?: any;
}

export default function Reports() {
  const [, setLocation] = useLocation();
  const { toast } = useToast();
  const [kols, setKols] = useState<KOL[]>([]);
  const [pricing, setPricing] = useState<Pricing[]>([]);
  const [isLoading, setIsLoading] = useState(true);
  
  // Filters
  const [searchTerm, setSearchTerm] = useState("");
  const [tierFilter, setTierFilter] = useState("all");
  const [agencyFilter, setAgencyFilter] = useState("all");
  
  // Pagination
  const [currentPage, setCurrentPage] = useState(1);
  const ITEMS_PER_PAGE = 20;

  useEffect(() => {
    checkAuthAndLoadData();
  }, []);

  const checkAuthAndLoadData = async () => {
    try {
      const authResponse = await fetch("/api/auth/me");
      if (!authResponse.ok) {
        setLocation("/app");
        return;
      }

      // Load KOLs
      const kolsResponse = await fetch("/api/kols");
      if (kolsResponse.ok) {
        const data = await kolsResponse.json();
        setKols(data.kols);
      }

      // Load Pricing
      const pricingResponse = await fetch("/api/pricing");
      if (pricingResponse.ok) {
        const data = await pricingResponse.json();
        setPricing(data.pricing);
      }
    } catch (error) {
      console.error("Error:", error);
      toast({
        variant: "destructive",
        title: "Hata",
        description: "Veriler yüklenirken bir hata oluştu",
      });
    } finally {
      setIsLoading(false);
    }
  };

  const handleLogout = async () => {
    await fetch("/api/auth/logout", { method: "POST" });
    setLocation("/app");
  };

  const allFilteredKols = kols.filter(kol => {
    // Search filter
    if (searchTerm && !kol.name.toLowerCase().includes(searchTerm.toLowerCase())) {
      return false;
    }
    
    // Tier filter
    if (tierFilter !== "all" && kol.tierScore !== parseInt(tierFilter)) {
      return false;
    }
    
    // Agency filter
    if (agencyFilter !== "all" && !kol.agencies?.some((a: any) => a.agency.name === agencyFilter)) {
      return false;
    }
    
    return true;
  });

  // Pagination
  const totalPages = Math.ceil(allFilteredKols.length / ITEMS_PER_PAGE);
  const startIndex = (currentPage - 1) * ITEMS_PER_PAGE;
  const endIndex = startIndex + ITEMS_PER_PAGE;
  const filteredKols = allFilteredKols.slice(startIndex, endIndex);

  // Reset to page 1 when filters change
  useEffect(() => {
    setCurrentPage(1);
  }, [searchTerm, tierFilter, agencyFilter]);

  const getPricingForKol = (kolId: string) => {
    return pricing.filter(p => p.kolId === kolId);
  };

  const uniqueAgencies = Array.from(
    new Set(
      kols.flatMap(kol => 
        kol.agencies?.map((a: any) => a.agency.name) || []
      )
    )
  ).sort();

  const exportToCSV = () => {
    const rows: string[][] = [];
    
    // Header
    rows.push([
      "KOL Adı",
      "Tier",
      "Email",
      "Telegram",
      "Ajans",
      "Diller",
      "Kategoriler",
      "Sosyal Medya",
      "Takipçi Sayısı",
      "Hizmet Adı",
      "Fiyat",
      "Komisyonsuz Fiyat",
      "Para Birimi",
      "Notlar"
    ]);

    // Data rows (export all filtered data, not just current page)
    allFilteredKols.forEach(kol => {
      const kolPricing = getPricingForKol(kol.id);
      const socialMediaList = kol.socialMedia?.map((sm: any) => 
        `${sm.socialMedia.name}: ${sm.link} (${sm.followerCount || '0'} takipçi)`
      ).join("; ") || "-";
      
      const agencies = kol.agencies?.map((a: any) => a.agency.name).join(", ") || "-";
      const languages = kol.languages?.map((l: any) => l.language.name).join(", ") || "-";
      const categories = kol.categories?.map((c: any) => c.category.name).join(", ") || "-";

      if (kolPricing.length > 0) {
        kolPricing.forEach(price => {
          const socialMediaDetails = price.socialMediaDetails 
            ? Object.entries(price.socialMediaDetails).map(([key, val]: [string, any]) => 
                `${key}: ${JSON.stringify(val)}`
              ).join("; ")
            : "-";

          rows.push([
            kol.name,
            kol.tierScore?.toString() || "-",
            kol.email || "-",
            kol.telegramAddress || "-",
            agencies,
            languages,
            categories,
            socialMediaList,
            kol.socialMedia?.reduce((sum: number, sm: any) => sum + (sm.followerCount || 0), 0).toString() || "0",
            price.serviceName,
            price.price,
            price.priceWithoutCommission || "-",
            price.currency,
            price.notes || "-"
          ]);
        });
      } else {
        rows.push([
          kol.name,
          kol.tierScore?.toString() || "-",
          kol.email || "-",
          kol.telegramAddress || "-",
          agencies,
          languages,
          categories,
          socialMediaList,
          kol.socialMedia?.reduce((sum: number, sm: any) => sum + (sm.followerCount || 0), 0).toString() || "0",
          "-",
          "-",
          "-",
          "-",
          "-"
        ]);
      }
    });

    const csvContent = rows.map(row => 
      row.map(cell => `"${cell.replace(/"/g, '""')}"`).join(",")
    ).join("\n");

    const blob = new Blob(["\ufeff" + csvContent], { type: "text/csv;charset=utf-8;" });
    const link = document.createElement("a");
    const url = URL.createObjectURL(blob);
    link.setAttribute("href", url);
    link.setAttribute("download", `kol_raporu_${new Date().toISOString().split('T')[0]}.csv`);
    link.style.visibility = "hidden";
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
  };

  if (isLoading) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-black">
        <div className="w-8 h-8 border-4 border-purple-600 border-t-transparent rounded-full animate-spin"></div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-black text-white">
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
                className="text-gray-400 hover:bg-white/10 hover:text-white"
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
              <Button
                variant="ghost"
                className="bg-white/10 text-white hover:bg-white/20"
              >
                Raporlar
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

      <main className="container mx-auto px-4 py-8">
        <div className="flex items-center justify-between mb-6">
          <div>
            <h1 className="text-3xl font-bold text-white mb-2">KOL Raporları - Sheet Görünümü</h1>
            <p className="text-gray-400">
              {allFilteredKols.length} KOL - Sayfa {currentPage} / {totalPages || 1}
            </p>
          </div>
          
          <Button
            onClick={exportToCSV}
            className="bg-green-600 hover:bg-green-700"
          >
            <svg className="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 10v6m0 0l-3-3m3 3l3-3m2 8H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
            </svg>
            CSV İndir
          </Button>
        </div>

        <Card className="bg-zinc-900/50 border-white/10 mb-6">
          <CardContent className="pt-6">
            <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
              <div className="md:col-span-2">
                <Input
                  placeholder="🔍 KOL Ara..."
                  value={searchTerm}
                  onChange={(e) => setSearchTerm(e.target.value)}
                  className="bg-black/50 border-white/20 text-white placeholder:text-gray-500"
                />
              </div>
              
              <Select value={tierFilter} onValueChange={setTierFilter}>
                <SelectTrigger className="bg-black/50 border-white/20">
                  <SelectValue placeholder="Tier Score" />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="all">Tüm Tier'lar</SelectItem>
                  <SelectItem value="5">⭐⭐⭐⭐⭐ (5)</SelectItem>
                  <SelectItem value="4">⭐⭐⭐⭐ (4)</SelectItem>
                  <SelectItem value="3">⭐⭐⭐ (3)</SelectItem>
                  <SelectItem value="2">⭐⭐ (2)</SelectItem>
                  <SelectItem value="1">⭐ (1)</SelectItem>
                </SelectContent>
              </Select>

              <Select value={agencyFilter} onValueChange={setAgencyFilter}>
                <SelectTrigger className="bg-black/50 border-white/20">
                  <SelectValue placeholder="Ajans" />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="all">Tüm Ajanslar</SelectItem>
                  {uniqueAgencies.map((agency) => (
                    <SelectItem key={agency} value={agency}>
                      {agency}
                    </SelectItem>
                  ))}
                </SelectContent>
              </Select>
            </div>
          </CardContent>
        </Card>

        <div className="bg-zinc-900/50 border border-white/10 rounded-lg overflow-hidden">
          <div className="overflow-x-auto">
            <table className="w-full text-sm">
              <thead className="bg-zinc-800/50 sticky top-0">
                <tr>
                  <th className="px-4 py-3 text-left font-semibold text-white border-b border-white/10 min-w-[150px]">KOL Adı</th>
                  <th className="px-4 py-3 text-left font-semibold text-white border-b border-white/10">Tier</th>
                  <th className="px-4 py-3 text-left font-semibold text-white border-b border-white/10 min-w-[200px]">İletişim</th>
                  <th className="px-4 py-3 text-left font-semibold text-white border-b border-white/10 min-w-[150px]">Ajans</th>
                  <th className="px-4 py-3 text-left font-semibold text-white border-b border-white/10 min-w-[250px]">Sosyal Medya</th>
                  <th className="px-4 py-3 text-left font-semibold text-white border-b border-white/10 min-w-[200px]">Hizmet</th>
                  <th className="px-4 py-3 text-left font-semibold text-white border-b border-white/10">Fiyat</th>
                  <th className="px-4 py-3 text-left font-semibold text-white border-b border-white/10">Komisyonsuz</th>
                </tr>
              </thead>
              <tbody>
                {filteredKols.map((kol) => {
                  const kolPricing = getPricingForKol(kol.id);
                  const rowCount = Math.max(kolPricing.length, 1);
                  
                  return Array.from({ length: rowCount }).map((_, idx) => {
                    const price = kolPricing[idx];
                    const isFirstRow = idx === 0;
                    
                    return (
                      <tr key={`${kol.id}-${idx}`} className="border-b border-white/5 hover:bg-white/5">
                        {isFirstRow && (
                          <>
                            <td className="px-4 py-3 font-medium text-white border-r border-white/5" rowSpan={rowCount}>
                              <div className="font-semibold">{kol.name}</div>
                              <div className="text-xs text-gray-400 mt-1">
                                {kol.languages?.map((l: any) => l.language.name).join(", ") || "-"}
                              </div>
                            </td>
                            <td className="px-4 py-3 border-r border-white/5" rowSpan={rowCount}>
                              {kol.tierScore ? (
                                <span className="text-yellow-500">{"⭐".repeat(kol.tierScore)}</span>
                              ) : (
                                <span className="text-gray-500">-</span>
                              )}
                            </td>
                            <td className="px-4 py-3 border-r border-white/5" rowSpan={rowCount}>
                              <div className="space-y-1 text-xs">
                                {kol.email && (
                                  <div className="text-blue-400">✉️ {kol.email}</div>
                                )}
                                {kol.telegramAddress && (
                                  <div className="text-cyan-400">📱 {kol.telegramAddress}</div>
                                )}
                                {!kol.email && !kol.telegramAddress && (
                                  <span className="text-gray-500">-</span>
                                )}
                              </div>
                            </td>
                            <td className="px-4 py-3 border-r border-white/5" rowSpan={rowCount}>
                              <div className="text-xs">
                                {kol.agencies?.map((a: any) => (
                                  <div key={a.id} className="bg-blue-600/20 text-blue-300 px-2 py-1 rounded mb-1 inline-block mr-1">
                                    {a.agency.name}
                                  </div>
                                )) || <span className="text-gray-500">-</span>}
                              </div>
                            </td>
                            <td className="px-4 py-3 border-r border-white/5" rowSpan={rowCount}>
                              <div className="space-y-1 text-xs">
                                {kol.socialMedia?.map((sm: any) => (
                                  <div key={sm.id} className="flex items-center gap-2">
                                    <span className="font-semibold text-purple-400">{sm.socialMedia.name}:</span>
                                    <span className="text-gray-300 truncate max-w-[150px]">{sm.followerCount?.toLocaleString() || '0'} takipçi</span>
                                  </div>
                                )) || <span className="text-gray-500">-</span>}
                              </div>
                            </td>
                          </>
                        )}
                        {price ? (
                          <>
                            <td className="px-4 py-3 border-r border-white/5">
                              <div className="font-medium">{price.serviceName}</div>
                              {price.socialMediaDetails && (
                                <div className="text-xs text-gray-400 mt-1">
                                  {Object.entries(price.socialMediaDetails).map(([key, val]: [string, any]) => (
                                    <div key={key}>{key}: {JSON.stringify(val)}</div>
                                  ))}
                                </div>
                              )}
                            </td>
                            <td className="px-4 py-3 border-r border-white/5">
                              <div className="font-semibold text-green-400">
                                {parseFloat(price.price).toLocaleString()} {price.currency}
                              </div>
                            </td>
                            <td className="px-4 py-3">
                              {price.priceWithoutCommission ? (
                                <div className="text-gray-300">
                                  {parseFloat(price.priceWithoutCommission).toLocaleString()} {price.currency}
                                </div>
                              ) : (
                                <span className="text-gray-500">-</span>
                              )}
                            </td>
                          </>
                        ) : (
                          <>
                            <td className="px-4 py-3 border-r border-white/5 text-gray-500 text-center">-</td>
                            <td className="px-4 py-3 border-r border-white/5 text-gray-500 text-center">-</td>
                            <td className="px-4 py-3 text-gray-500 text-center">-</td>
                          </>
                        )}
                      </tr>
                    );
                  });
                })}
              </tbody>
            </table>
          </div>
        </div>

        {totalPages > 1 && (
          <div className="mt-6 flex items-center justify-between bg-zinc-900/50 border border-white/10 rounded-lg p-4">
            <div className="text-sm text-gray-400">
              {startIndex + 1}-{Math.min(endIndex, allFilteredKols.length)} arası gösteriliyor (Toplam: {allFilteredKols.length})
            </div>
            
            <div className="flex gap-2">
              <Button
                variant="outline"
                size="sm"
                onClick={() => setCurrentPage(p => Math.max(1, p - 1))}
                disabled={currentPage === 1}
                className="border-white/20 hover:bg-white/10"
              >
                ← Önceki
              </Button>
              
              <div className="flex items-center gap-1">
                {Array.from({ length: Math.min(5, totalPages) }, (_, i) => {
                  let pageNum;
                  if (totalPages <= 5) {
                    pageNum = i + 1;
                  } else if (currentPage <= 3) {
                    pageNum = i + 1;
                  } else if (currentPage >= totalPages - 2) {
                    pageNum = totalPages - 4 + i;
                  } else {
                    pageNum = currentPage - 2 + i;
                  }
                  
                  return (
                    <Button
                      key={pageNum}
                      variant={currentPage === pageNum ? "default" : "outline"}
                      size="sm"
                      onClick={() => setCurrentPage(pageNum)}
                      className={currentPage === pageNum 
                        ? "bg-purple-600 hover:bg-purple-700" 
                        : "border-white/20 hover:bg-white/10"
                      }
                    >
                      {pageNum}
                    </Button>
                  );
                })}
              </div>
              
              <Button
                variant="outline"
                size="sm"
                onClick={() => setCurrentPage(p => Math.min(totalPages, p + 1))}
                disabled={currentPage === totalPages}
                className="border-white/20 hover:bg-white/10"
              >
                Sonraki →
              </Button>
            </div>
          </div>
        )}

        {allFilteredKols.length === 0 && (
          <div className="text-center py-12">
            <div className="inline-block p-6 bg-white/5 rounded-full mb-4">
              <svg className="w-12 h-12 text-gray-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
              </svg>
            </div>
            <h3 className="text-lg font-semibold text-white mb-2">Sonuç Bulunamadı</h3>
            <p className="text-gray-400">Filtrelerinizi değiştirmeyi deneyin</p>
          </div>
        )}
      </main>
    </div>
  );
}
