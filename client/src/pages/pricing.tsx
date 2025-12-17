import { useEffect, useState } from "react";
import { useLocation } from "wouter";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";

interface Pricing {
  id: string;
  serviceName: string;
  price: string;
  priceWithoutCommission: string | null;
  currency: string;
  notes: string | null;
  contactInfo: string | null;
  kol: {
    id: string;
    name: string;
  };
}

export default function Pricing() {
  const [, setLocation] = useLocation();
  const [allPricing, setAllPricing] = useState<Pricing[]>([]);
  const [filteredPricing, setFilteredPricing] = useState<Pricing[]>([]);
  const [searchTerm, setSearchTerm] = useState("");
  const [isLoading, setIsLoading] = useState(true);

  useEffect(() => {
    checkAuthAndLoadPricing();
  }, []);

  useEffect(() => {
    applyFilters();
  }, [searchTerm, allPricing]);

  const checkAuthAndLoadPricing = async () => {
    try {
      const authResponse = await fetch("/api/auth/me");
      if (!authResponse.ok) {
        setLocation("/app");
        return;
      }

      const pricingResponse = await fetch("/api/pricing");
      if (pricingResponse.ok) {
        const data = await pricingResponse.json();
        setAllPricing(data.pricing);
      }
    } catch (error) {
      console.error("Error:", error);
    } finally {
      setIsLoading(false);
    }
  };

  const applyFilters = () => {
    let filtered = [...allPricing];

    if (searchTerm) {
      filtered = filtered.filter(p =>
        p.kol.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
        p.serviceName.toLowerCase().includes(searchTerm.toLowerCase())
      );
    }

    setFilteredPricing(filtered);
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

  return (
    <div className="min-h-screen bg-black text-white">
      <header className="bg-black/50 border-b border-white/10 backdrop-blur-md sticky top-0 z-10">
        <div className="container mx-auto px-4 py-4 flex items-center justify-between">
          <div className="flex items-center gap-6">
            <div className="flex items-center gap-3">
              <img src="/Logo.svg" alt="Magnor" className="h-8" style={{ filter: 'brightness(0) invert(1)' }} />
              <span className="text-xl font-bold text-white">KOL Portal</span>
            </div>
            
            <nav className="hidden md:flex items-center gap-4">
              <Button variant="ghost" onClick={() => setLocation("/app/dashboard")} className="text-gray-400 hover:bg-white/10 hover:text-white">
                Dashboard
              </Button>
              <Button variant="ghost" onClick={() => setLocation("/app/kols")} className="text-gray-400 hover:bg-white/10 hover:text-white">
                KOL'lar
              </Button>
              <Button variant="ghost" className="bg-white/10 text-white hover:bg-white/20">
                Fiyatlar
              </Button>
              <Button variant="ghost" onClick={() => setLocation("/app/agencies")} className="text-gray-400 hover:bg-white/10 hover:text-white">
                Ajanslar
              </Button>
            </nav>
          </div>
          
          <Button variant="outline" onClick={handleLogout} className="text-red-400 hover:text-red-300 hover:bg-red-500/10 border-red-500/20">
            Çıkış Yap
          </Button>
        </div>
      </header>

      <main className="container mx-auto px-4 py-8">
        <div className="flex items-center justify-between mb-6">
          <div>
            <h1 className="text-3xl font-bold text-white mb-2">KOL Fiyatları</h1>
            <p className="text-gray-400">{filteredPricing.length} / {allPricing.length} fiyat gösteriliyor</p>
          </div>
        </div>

        <Card className="bg-zinc-900/50 border-white/10 mb-6">
          <CardContent className="pt-6">
            <Input
              placeholder="🔍 Ara (KOL adı, servis)..."
              value={searchTerm}
              onChange={(e) => setSearchTerm(e.target.value)}
              className="bg-black/50 border-white/20 text-white placeholder:text-gray-500"
            />
          </CardContent>
        </Card>

        <Card className="bg-zinc-900/50 border-white/10">
          <CardHeader>
            <CardTitle className="text-white">Fiyat Listesi</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="overflow-x-auto">
              <Table>
                <TableHeader>
                  <TableRow>
                    <TableHead>KOL</TableHead>
                    <TableHead>Servis</TableHead>
                    <TableHead className="text-right">Fiyat</TableHead>
                    <TableHead className="text-right">Komisyonsuz</TableHead>
                    <TableHead>Notlar</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {filteredPricing.map((pricing) => (
                    <TableRow key={pricing.id}>
                      <TableCell className="font-medium text-white">{pricing.kol.name}</TableCell>
                      <TableCell>{pricing.serviceName}</TableCell>
                      <TableCell className="text-right text-green-400 font-semibold">
                        ${parseFloat(pricing.price).toLocaleString()}
                      </TableCell>
                      <TableCell className="text-right text-blue-400">
                        {pricing.priceWithoutCommission ? `$${parseFloat(pricing.priceWithoutCommission).toLocaleString()}` : '-'}
                      </TableCell>
                      <TableCell className="text-sm text-gray-400">
                        {pricing.notes || pricing.contactInfo || '-'}
                      </TableCell>
                    </TableRow>
                  ))}
                </TableBody>
              </Table>
            </div>
          </CardContent>
        </Card>
      </main>
    </div>
  );
}
