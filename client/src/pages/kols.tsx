import { useEffect, useState } from "react";
import { useLocation } from "wouter";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { useToast } from "@/hooks/use-toast";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";

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

type SortField = 'name' | 'tierScore' | 'language' | 'agency';
type SortDirection = 'asc' | 'desc';

const ITEMS_PER_PAGE = 20;

export default function KOLs() {
  const [, setLocation] = useLocation();
  const { toast } = useToast();
  const [allKols, setAllKols] = useState<KOL[]>([]);
  const [filteredKols, setFilteredKols] = useState<KOL[]>([]);
  const [isLoading, setIsLoading] = useState(true);
  
  // Filters
  const [searchTerm, setSearchTerm] = useState("");
  const [tierFilter, setTierFilter] = useState("all");
  const [languageFilter, setLanguageFilter] = useState("all");
  const [agencyFilter, setAgencyFilter] = useState("all");
  
  // Sorting
  const [sortField, setSortField] = useState<SortField>('name');
  const [sortDirection, setSortDirection] = useState<SortDirection>('asc');
  
  // Pagination
  const [currentPage, setCurrentPage] = useState(1);
  
  const totalPages = Math.ceil(filteredKols.length / ITEMS_PER_PAGE);
  const startIndex = (currentPage - 1) * ITEMS_PER_PAGE;
  const endIndex = startIndex + ITEMS_PER_PAGE;
  const currentKols = filteredKols.slice(startIndex, endIndex);

  useEffect(() => {
    checkAuthAndLoadKOLs();
  }, []);

  useEffect(() => {
    applyFilters();
  }, [searchTerm, tierFilter, languageFilter, agencyFilter, allKols, sortField, sortDirection]);

  const checkAuthAndLoadKOLs = async () => {
    try {
      const authResponse = await fetch("/api/auth/me");
      if (!authResponse.ok) {
        setLocation("/app");
        return;
      }

      const kolsResponse = await fetch("/api/kols");
      if (kolsResponse.ok) {
        const data = await kolsResponse.json();
        setAllKols(data.kols);
      }
    } catch (error) {
      console.error("Error:", error);
      toast({
        variant: "destructive",
        title: "Hata",
        description: "KOL'lar yüklenirken bir hata oluştu",
      });
    } finally {
      setIsLoading(false);
    }
  };

  const applyFilters = () => {
    let filtered = [...allKols];

    // Search filter
    if (searchTerm) {
      filtered = filtered.filter(kol =>
        kol.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
        kol.email?.toLowerCase().includes(searchTerm.toLowerCase()) ||
        kol.telegramAddress?.toLowerCase().includes(searchTerm.toLowerCase())
      );
    }

    // Tier filter
    if (tierFilter !== "all") {
      const tier = parseInt(tierFilter);
      filtered = filtered.filter(kol => kol.tierScore === tier);
    }

    // Language filter
    if (languageFilter !== "all") {
      filtered = filtered.filter(kol =>
        kol.languages?.some((l: any) => l.language.name === languageFilter)
      );
    }

    // Agency filter
    if (agencyFilter !== "all") {
      filtered = filtered.filter(kol =>
        kol.agencies?.some((a: any) => a.agency.name === agencyFilter)
      );
    }

    // Sorting
    filtered.sort((a, b) => {
      let aValue: any;
      let bValue: any;

      switch (sortField) {
        case 'name':
          aValue = a.name.toLowerCase();
          bValue = b.name.toLowerCase();
          break;
        case 'tierScore':
          aValue = a.tierScore ?? -1;
          bValue = b.tierScore ?? -1;
          break;
        case 'language':
          aValue = a.languages?.[0]?.language.name || '';
          bValue = b.languages?.[0]?.language.name || '';
          break;
        case 'agency':
          aValue = a.agencies?.[0]?.agency.name || '';
          bValue = b.agencies?.[0]?.agency.name || '';
          break;
      }

      if (aValue < bValue) return sortDirection === 'asc' ? -1 : 1;
      if (aValue > bValue) return sortDirection === 'asc' ? 1 : -1;
      return 0;
    });

    setFilteredKols(filtered);
    setCurrentPage(1);
  };

  const handleSort = (field: SortField) => {
    if (sortField === field) {
      setSortDirection(sortDirection === 'asc' ? 'desc' : 'asc');
    } else {
      setSortField(field);
      setSortDirection('asc');
    }
  };

  const SortIcon = ({ field }: { field: SortField }) => {
    if (sortField !== field) {
      return <span className="text-gray-500 ml-1">⇅</span>;
    }
    return <span className="ml-1">{sortDirection === 'asc' ? '↑' : '↓'}</span>;
  };

  const handleLogout = async () => {
    await fetch("/api/auth/logout", { method: "POST" });
    setLocation("/app");
  };

  const handleDelete = async (id: string, name: string) => {
    if (!confirm(`"${name}" adlı KOL'u silmek istediğinizden emin misiniz?`)) {
      return;
    }

    try {
      const response = await fetch(`/api/kols/${id}`, { method: "DELETE" });
      
      if (response.ok) {
        toast({
          title: "Başarılı",
          description: "KOL başarıyla silindi",
        });
        setAllKols(allKols.filter(k => k.id !== id));
      } else {
        throw new Error("Silme başarısız");
      }
    } catch (error) {
      toast({
        variant: "destructive",
        title: "Hata",
        description: "KOL silinirken bir hata oluştu",
      });
    }
  };

  const clearFilters = () => {
    setSearchTerm("");
    setTierFilter("all");
    setLanguageFilter("all");
    setAgencyFilter("all");
  };

  const uniqueLanguages = Array.from(
    new Set(
      allKols.flatMap(kol => 
        kol.languages?.map((l: any) => l.language.name) || []
      )
    )
  ).sort();

  const uniqueAgencies = Array.from(
    new Set(
      allKols.flatMap(kol => 
        kol.agencies?.map((a: any) => a.agency.name) || []
      )
    )
  ).sort();

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

      <main className="container mx-auto px-4 py-8">
        <div className="flex items-center justify-between mb-6">
          <div>
            <h1 className="text-3xl font-bold text-white mb-2">KOL Yönetimi</h1>
            <p className="text-gray-400">
              {filteredKols.length} / {allKols.length} KOL gösteriliyor
            </p>
          </div>
          
          <Button
            onClick={() => setLocation("/app/kols/new")}
            className="bg-purple-600 hover:bg-purple-700"
          >
            <svg className="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 4v16m8-8H4" />
            </svg>
            Yeni KOL Ekle
          </Button>
        </div>

        <Card className="bg-zinc-900/50 border-white/10 mb-6">
          <CardContent className="pt-6">
            <div className="grid grid-cols-1 md:grid-cols-5 gap-4">
              <div className="md:col-span-2">
                <Input
                  placeholder="🔍 Ara (isim, email, telegram)..."
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

              <Select value={languageFilter} onValueChange={setLanguageFilter}>
                <SelectTrigger className="bg-black/50 border-white/20">
                  <SelectValue placeholder="Dil" />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="all">Tüm Diller</SelectItem>
                  {uniqueLanguages.map((lang) => (
                    <SelectItem key={lang} value={lang}>
                      {lang}
                    </SelectItem>
                  ))}
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
            
            {(searchTerm || tierFilter !== "all" || languageFilter !== "all" || agencyFilter !== "all") && (
              <div className="mt-4 flex items-center gap-2">
                <Button
                  variant="outline"
                  size="sm"
                  onClick={clearFilters}
                  className="border-white/20 hover:bg-white/10"
                >
                  Filtreleri Temizle
                </Button>
                <span className="text-sm text-gray-400">
                  {filteredKols.length} sonuç bulundu
                </span>
              </div>
            )}
          </CardContent>
        </Card>

        <Card className="bg-zinc-900/50 border-white/10">
          <CardHeader>
            <CardTitle className="text-white">KOL Listesi</CardTitle>
            <CardDescription className="text-gray-400">
              Sayfa {currentPage} / {totalPages || 1}
            </CardDescription>
          </CardHeader>
          <CardContent>
            {filteredKols.length === 0 ? (
              <div className="text-center py-12">
                <div className="inline-block p-6 bg-white/5 rounded-full mb-4">
                  <svg className="w-12 h-12 text-gray-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
                  </svg>
                </div>
                <h3 className="text-lg font-semibold text-white mb-2">
                  {allKols.length === 0 ? "Henüz KOL Eklenmemiş" : "Sonuç Bulunamadı"}
                </h3>
                <p className="text-gray-400 mb-4">
                  {allKols.length === 0 
                    ? "İlk KOL'unuzu ekleyerek başlayın"
                    : "Filtrelerinizi değiştirmeyi deneyin"
                  }
                </p>
                {allKols.length === 0 && (
                  <Button
                    onClick={() => setLocation("/app/kols/new")}
                    className="bg-purple-600 hover:bg-purple-700"
                  >
                    Yeni KOL Ekle
                  </Button>
                )}
              </div>
            ) : (
              <>
                <div className="overflow-x-auto">
                  <Table>
                    <TableHeader>
                      <TableRow>
                        <TableHead 
                          className="cursor-pointer hover:bg-white/5 select-none"
                          onClick={() => handleSort('name')}
                        >
                          İsim <SortIcon field="name" />
                        </TableHead>
                        <TableHead 
                          className="cursor-pointer hover:bg-white/5 select-none"
                          onClick={() => handleSort('tierScore')}
                        >
                          Tier <SortIcon field="tierScore" />
                        </TableHead>
                        <TableHead 
                          className="cursor-pointer hover:bg-white/5 select-none"
                          onClick={() => handleSort('language')}
                        >
                          Dil <SortIcon field="language" />
                        </TableHead>
                        <TableHead 
                          className="cursor-pointer hover:bg-white/5 select-none"
                          onClick={() => handleSort('agency')}
                        >
                          Ajans <SortIcon field="agency" />
                        </TableHead>
                        <TableHead>Kategoriler</TableHead>
                        <TableHead>Sosyal Medya</TableHead>
                        <TableHead className="text-right">İşlemler</TableHead>
                      </TableRow>
                    </TableHeader>
                    <TableBody>
                      {currentKols.map((kol) => (
                        <TableRow key={kol.id}>
                          <TableCell className="font-medium text-white">{kol.name}</TableCell>
                          <TableCell>
                            {kol.tierScore ? (
                              <Badge variant="secondary">
                                {"⭐".repeat(kol.tierScore)}
                              </Badge>
                            ) : (
                              <span className="text-gray-500">-</span>
                            )}
                          </TableCell>
                          <TableCell>
                            <div className="flex flex-wrap gap-1">
                              {kol.languages?.slice(0, 2).map((lang: any) => (
                                <Badge key={lang.id} variant="outline" className="text-xs">
                                  {lang.language.name}
                                </Badge>
                              ))}
                              {kol.languages?.length > 2 && (
                                <Badge variant="outline" className="text-xs">
                                  +{kol.languages.length - 2}
                                </Badge>
                              )}
                            </div>
                          </TableCell>
                          <TableCell>
                            <div className="flex flex-wrap gap-1">
                              {kol.agencies?.map((agency: any) => (
                                <Badge key={agency.id} className="bg-blue-600 text-xs">
                                  {agency.agency.name}
                                </Badge>
                              ))}
                              {!kol.agencies?.length && (
                                <span className="text-gray-500 text-sm">-</span>
                              )}
                            </div>
                          </TableCell>
                          <TableCell>
                            <div className="flex flex-wrap gap-1">
                              {kol.categories?.slice(0, 2).map((cat: any) => (
                                <Badge key={cat.id} variant="outline" className="text-xs">
                                  {cat.category.name}
                                </Badge>
                              ))}
                              {kol.categories?.length > 2 && (
                                <Badge variant="outline" className="text-xs">
                                  +{kol.categories.length - 2}
                                </Badge>
                              )}
                            </div>
                          </TableCell>
                          <TableCell>
                            <div className="flex gap-1">
                              {kol.socialMedia?.slice(0, 3).map((sm: any) => (
                                <Badge key={sm.id} variant="secondary" className="text-xs">
                                  {sm.socialMedia.name}
                                </Badge>
                              ))}
                              {kol.socialMedia?.length > 3 && (
                                <Badge variant="secondary" className="text-xs">
                                  +{kol.socialMedia.length - 3}
                                </Badge>
                              )}
                            </div>
                          </TableCell>
                          <TableCell className="text-right">
                            <div className="flex justify-end gap-2">
                              <Button
                                variant="outline"
                                size="sm"
                                onClick={() => setLocation(`/app/kols/view/${kol.id}`)}
                                className="border-blue-500/20 text-blue-400 hover:text-blue-300 hover:bg-blue-500/10"
                              >
                                İncele
                              </Button>
                              <Button
                                variant="outline"
                                size="sm"
                                onClick={() => setLocation(`/app/kols/${kol.id}`)}
                                className="border-white/20 hover:bg-white/10"
                              >
                                Düzenle
                              </Button>
                              <Button
                                variant="outline"
                                size="sm"
                                className="text-red-400 hover:text-red-300 hover:bg-red-500/10 border-red-500/20"
                                onClick={() => handleDelete(kol.id, kol.name)}
                              >
                                Sil
                              </Button>
                            </div>
                          </TableCell>
                        </TableRow>
                      ))}
                    </TableBody>
                  </Table>
                </div>

                {totalPages > 1 && (
                  <div className="mt-6 flex items-center justify-between">
                    <div className="text-sm text-gray-400">
                      {startIndex + 1}-{Math.min(endIndex, filteredKols.length)} arası gösteriliyor (Toplam: {filteredKols.length})
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
              </>
            )}
          </CardContent>
        </Card>
      </main>
    </div>
  );
}
