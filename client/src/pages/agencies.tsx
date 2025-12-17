import { useEffect, useState } from "react";
import { useLocation } from "wouter";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { useToast } from "@/hooks/use-toast";
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";

interface Agency {
  id: string;
  name: string;
  contactName: string | null;
  contactEmail: string | null;
  contactPhone: string | null;
  commissionRate: string | null;
  notes: string | null;
}

export default function Agencies() {
  const [, setLocation] = useLocation();
  const { toast } = useToast();
  const [agencies, setAgencies] = useState<Agency[]>([]);
  const [isLoading, setIsLoading] = useState(true);

  useEffect(() => {
    checkAuthAndLoadAgencies();
  }, []);

  const checkAuthAndLoadAgencies = async () => {
    try {
      const authResponse = await fetch("/api/auth/me");
      if (!authResponse.ok) {
        setLocation("/app");
        return;
      }

      const agenciesResponse = await fetch("/api/agencies-list");
      if (agenciesResponse.ok) {
        const data = await agenciesResponse.json();
        setAgencies(data.agencies);
      }
    } catch (error) {
      console.error("Error:", error);
      toast({
        variant: "destructive",
        title: "Hata",
        description: "Ajanslar yüklenirken bir hata oluştu",
      });
    } finally {
      setIsLoading(false);
    }
  };

  const handleLogout = async () => {
    await fetch("/api/auth/logout", { method: "POST" });
    setLocation("/app");
  };

  const handleDelete = async (id: string, name: string) => {
    if (!confirm(`"${name}" adlı ajansı silmek istediğinizden emin misiniz?`)) {
      return;
    }

    try {
      const response = await fetch(`/api/agencies-list/${id}`, { method: "DELETE" });
      
      if (response.ok) {
        toast({
          title: "Başarılı",
          description: "Ajans başarıyla silindi",
        });
        setAgencies(agencies.filter(a => a.id !== id));
      } else {
        throw new Error("Silme başarısız");
      }
    } catch (error) {
      toast({
        variant: "destructive",
        title: "Hata",
        description: "Ajans silinirken bir hata oluştu",
      });
    }
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
              <span className="text-xl font-bold text-white">Ajans Portal</span>
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
                className="bg-white/10 text-white hover:bg-white/20"
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
        <div className="flex items-center justify-between mb-6">
          <div>
            <h1 className="text-3xl font-bold text-white mb-2">Ajans Yönetimi</h1>
            <p className="text-gray-400">
              Tüm ajansları buradan yönetebilirsiniz
            </p>
          </div>
          
          <Button
            onClick={() => setLocation("/app/agencies/new")}
            className="bg-purple-600 hover:bg-purple-700"
          >
            <svg className="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 4v16m8-8H4" />
            </svg>
            Yeni Ajans Ekle
          </Button>
        </div>

        <Card className="bg-zinc-900/50 border-white/10">
          <CardHeader>
            <CardTitle className="text-white">Ajans Listesi</CardTitle>
            <CardDescription className="text-gray-400">
              Toplam {agencies.length} ajans bulunuyor
            </CardDescription>
          </CardHeader>
          <CardContent>
            {agencies.length === 0 ? (
              <div className="text-center py-12">
                <div className="inline-block p-6 bg-white/5 rounded-full mb-4">
                  <svg className="w-12 h-12 text-gray-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4" />
                  </svg>
                </div>
                <h3 className="text-lg font-semibold text-white mb-2">
                  Henüz Ajans Eklenmemiş
                </h3>
                <p className="text-gray-400 mb-4">
                  İlk ajansı ekleyerek başlayın
                </p>
                <Button
                  onClick={() => setLocation("/app/agencies/new")}
                  className="bg-purple-600 hover:bg-purple-700"
                >
                  Yeni Ajans Ekle
                </Button>
              </div>
            ) : (
              <div className="overflow-x-auto">
                <Table>
                  <TableHeader>
                    <TableRow>
                      <TableHead>Ajans Adı</TableHead>
                      <TableHead>İletişim Kişisi</TableHead>
                      <TableHead>E-posta</TableHead>
                      <TableHead>Telefon</TableHead>
                      <TableHead>Komisyon</TableHead>
                      <TableHead className="text-right">İşlemler</TableHead>
                    </TableRow>
                  </TableHeader>
                  <TableBody>
                    {agencies.map((agency) => (
                      <TableRow key={agency.id}>
                        <TableCell className="font-medium text-white">{agency.name}</TableCell>
                        <TableCell className="text-gray-300">
                          {agency.contactName || <span className="text-gray-500">-</span>}
                        </TableCell>
                        <TableCell className="text-gray-300">
                          {agency.contactEmail || <span className="text-gray-500">-</span>}
                        </TableCell>
                        <TableCell className="text-gray-300">
                          {agency.contactPhone || <span className="text-gray-500">-</span>}
                        </TableCell>
                        <TableCell>
                          {agency.commissionRate ? (
                            <Badge variant="secondary">%{agency.commissionRate}</Badge>
                          ) : (
                            <span className="text-gray-500">-</span>
                          )}
                        </TableCell>
                        <TableCell className="text-right">
                          <div className="flex justify-end gap-2">
                            <Button
                              variant="outline"
                              size="sm"
                              onClick={() => setLocation(`/app/agencies/${agency.id}`)}
                              className="border-white/20 hover:bg-white/10"
                            >
                              Düzenle
                            </Button>
                            <Button
                              variant="outline"
                              size="sm"
                              className="text-red-400 hover:text-red-300 hover:bg-red-500/10 border-red-500/20"
                              onClick={() => handleDelete(agency.id, agency.name)}
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
            )}
          </CardContent>
        </Card>
      </main>
    </div>
  );
}
