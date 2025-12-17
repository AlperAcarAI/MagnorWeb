import { useEffect, useState } from "react";
import { useLocation } from "wouter";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { useToast } from "@/hooks/use-toast";

interface User {
  id: string;
  username: string;
  email: string | null;
  role: string;
}

export default function Dashboard() {
  const [, setLocation] = useLocation();
  const { toast } = useToast();
  const [user, setUser] = useState<User | null>(null);
  const [isLoading, setIsLoading] = useState(true);
  const [kolCount, setKolCount] = useState(0);

  useEffect(() => {
    checkAuth();
    loadStats();
  }, []);

  const checkAuth = async () => {
    try {
      const response = await fetch("/api/auth/me");
      
      if (!response.ok) {
        setLocation("/app");
        return;
      }

      const data = await response.json();
      setUser(data.user);
    } catch (error) {
      console.error("Auth check failed:", error);
      setLocation("/app");
    } finally {
      setIsLoading(false);
    }
  };

  const loadStats = async () => {
    try {
      const response = await fetch("/api/kols");
      if (response.ok) {
        const data = await response.json();
        setKolCount(data.kols.length);
      }
    } catch (error) {
      console.error("Stats load failed:", error);
    }
  };

  const handleLogout = async () => {
    try {
      await fetch("/api/auth/logout", { method: "POST" });
      
      toast({
        title: "Çıkış Başarılı",
        description: "Güvenli bir şekilde çıkış yaptınız.",
      });

      setLocation("/app");
    } catch (error) {
      toast({
        variant: "destructive",
        title: "Hata",
        description: "Çıkış yapılırken bir hata oluştu.",
      });
    }
  };

  if (isLoading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="w-8 h-8 border-4 border-purple-600 border-t-transparent rounded-full animate-spin"></div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-black text-white">
      {/* Header */}
      <header className="bg-black/50 border-b border-white/10 backdrop-blur-md">
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
                className="bg-white/10 text-white hover:bg-white/20"
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
                onClick={() => setLocation("/app/pricing")}
                className="text-gray-400 hover:bg-white/10 hover:text-white"
              >
                Fiyatlar
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
                onClick={() => setLocation("/app/reports")}
                className="text-gray-400 hover:bg-white/10 hover:text-white"
              >
                Raporlar
              </Button>
            </nav>
          </div>
          
          <div className="flex items-center gap-4">
            <div className="text-right">
              <p className="text-sm font-medium text-white">{user?.username}</p>
              <p className="text-xs text-gray-400">{user?.role}</p>
            </div>
            <Button
              variant="outline"
              onClick={handleLogout}
              className="text-red-400 hover:text-red-300 hover:bg-red-500/10 border-red-500/20"
            >
              Çıkış Yap
            </Button>
          </div>
        </div>
      </header>

      {/* Main Content */}
      <main className="container mx-auto px-4 py-8">
        <div className="mb-8">
          <h1 className="text-3xl font-bold text-white mb-2">
            Hoş Geldiniz, {user?.username}!
          </h1>
          <p className="text-gray-400">
            KOL yönetim portalına hoş geldiniz. Buradan tüm influencer'larınızı yönetebilirsiniz.
          </p>
        </div>

        {/* Stats Cards */}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
          <Card className="bg-zinc-900/50 border-white/10">
            <CardHeader className="pb-3">
              <CardTitle className="text-sm font-medium text-gray-400">
                Toplam KOL
              </CardTitle>
            </CardHeader>
            <CardContent>
              <div className="text-3xl font-bold text-white">{kolCount}</div>
              <p className="text-xs text-gray-500 mt-1">
                {kolCount === 0 ? 'Henüz KOL eklenmemiş' : 'Kayıtlı KOL'}
              </p>
            </CardContent>
          </Card>

          <Card className="bg-zinc-900/50 border-white/10">
            <CardHeader className="pb-3">
              <CardTitle className="text-sm font-medium text-gray-400">
                Aktif Kampanyalar
              </CardTitle>
            </CardHeader>
            <CardContent>
              <div className="text-3xl font-bold text-white">0</div>
              <p className="text-xs text-gray-500 mt-1">Kampanya bulunmuyor</p>
            </CardContent>
          </Card>

          <Card className="bg-zinc-900/50 border-white/10">
            <CardHeader className="pb-3">
              <CardTitle className="text-sm font-medium text-gray-400">
                Toplam Erişim
              </CardTitle>
            </CardHeader>
            <CardContent>
              <div className="text-3xl font-bold text-white">0</div>
              <p className="text-xs text-gray-500 mt-1">Veri yok</p>
            </CardContent>
          </Card>
        </div>

        {/* Quick Actions */}
        <Card className="bg-zinc-900/50 border-white/10">
          <CardHeader>
            <CardTitle className="text-white">Hızlı İşlemler</CardTitle>
            <CardDescription className="text-gray-400">
              Sık kullanılan işlemlere buradan erişebilirsiniz
            </CardDescription>
          </CardHeader>
          <CardContent>
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
              <Button 
                className="h-24 flex-col gap-2 bg-purple-600 hover:bg-purple-700"
                onClick={() => setLocation("/app/kols/new")}
              >
                <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 4v16m8-8H4" />
                </svg>
                <span>Yeni KOL Ekle</span>
              </Button>

              <Button 
                variant="outline" 
                className="h-24 flex-col gap-2"
                onClick={() => setLocation("/app/kols")}
              >
                <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z" />
                </svg>
                <span>KOL Listesi</span>
              </Button>

              <Button 
                variant="outline" 
                className="h-24 flex-col gap-2"
                onClick={() => setLocation("/app/reports")}
              >
                <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z" />
                </svg>
                <span>Raporlar</span>
              </Button>

              <Button variant="outline" className="h-24 flex-col gap-2">
                <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z" />
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                </svg>
                <span>Ayarlar</span>
              </Button>
            </div>
          </CardContent>
        </Card>

        {/* Coming Soon Section */}
        <div className="mt-8 text-center py-12">
          <div className="inline-block p-6 bg-white/5 rounded-full mb-4">
            <svg className="w-12 h-12 text-purple-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M13 10V3L4 14h7v7l9-11h-7z" />
            </svg>
          </div>
          <h3 className="text-xl font-semibold text-white mb-2">
            Daha Fazla Özellik Yakında!
          </h3>
          <p className="text-gray-400 max-w-md mx-auto">
            KOL yönetimi, kampanya takibi, raporlama ve daha birçok özellik yakında eklenecek.
          </p>
        </div>
      </main>
    </div>
  );
}
