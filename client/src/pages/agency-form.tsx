import { useEffect, useState } from "react";
import { useLocation, useParams } from "wouter";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { useToast } from "@/hooks/use-toast";

export default function AgencyForm() {
  const params = useParams();
  const agencyId = params.id;
  const isEdit = agencyId && agencyId !== "new";
  
  const [, setLocation] = useLocation();
  const { toast } = useToast();
  
  const [isLoading, setIsLoading] = useState(false);
  const [isSaving, setSaving] = useState(false);
  
  const [formData, setFormData] = useState({
    name: "",
    contactName: "",
    contactEmail: "",
    contactPhone: "",
    commissionRate: "",
    notes: "",
  });

  useEffect(() => {
    checkAuth();
    if (isEdit) {
      loadAgency();
    }
  }, []);

  const checkAuth = async () => {
    const response = await fetch("/api/auth/me");
    if (!response.ok) {
      setLocation("/app");
    }
  };

  const loadAgency = async () => {
    setIsLoading(true);
    try {
      const response = await fetch(`/api/agencies-list/${agencyId}`);
      if (response.ok) {
        const data = await response.json();
        const agency = data.agency;
        
        setFormData({
          name: agency.name,
          contactName: agency.contactName || "",
          contactEmail: agency.contactEmail || "",
          contactPhone: agency.contactPhone || "",
          commissionRate: agency.commissionRate || "",
          notes: agency.notes || "",
        });
      }
    } catch (error) {
      toast({
        variant: "destructive",
        title: "Hata",
        description: "Ajans yüklenirken bir hata oluştu",
      });
    } finally {
      setIsLoading(false);
    }
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setSaving(true);

    try {
      const payload = {
        name: formData.name,
        contactName: formData.contactName || null,
        contactEmail: formData.contactEmail || null,
        contactPhone: formData.contactPhone || null,
        commissionRate: formData.commissionRate || null,
        notes: formData.notes || null,
      };

      const url = isEdit ? `/api/agencies-list/${agencyId}` : "/api/agencies-list";
      const method = isEdit ? "PUT" : "POST";

      const response = await fetch(url, {
        method,
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(payload),
      });

      if (!response.ok) {
        throw new Error("Kaydetme başarısız");
      }

      toast({
        title: "Başarılı",
        description: isEdit ? "Ajans güncellendi" : "Ajans eklendi",
      });

      setLocation("/app/agencies");
    } catch (error: any) {
      toast({
        variant: "destructive",
        title: "Hata",
        description: error.message || "Bir hata oluştu",
      });
    } finally {
      setSaving(false);
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
      <header className="bg-black/50 border-b border-white/10 backdrop-blur-md">
        <div className="container mx-auto px-4 py-4 flex items-center justify-between">
          <div className="flex items-center gap-3">
            <Button
              variant="ghost"
              onClick={() => setLocation("/app/agencies")}
              className="mr-2 text-gray-400 hover:text-white hover:bg-white/10"
            >
              ← Geri
            </Button>
            <img 
              src="/Logo.svg" 
              alt="Magnor" 
              className="h-8"
              style={{ filter: 'brightness(0) invert(1)' }}
            />
            <span className="text-xl font-bold text-white">
              {isEdit ? "Ajans Düzenle" : "Yeni Ajans"}
            </span>
          </div>
        </div>
      </header>

      {/* Main Content */}
      <main className="container mx-auto px-4 py-8 max-w-4xl">
        <form onSubmit={handleSubmit} className="space-y-6">
          {/* Temel Bilgiler */}
          <Card className="bg-zinc-900/50 border-white/10">
            <CardHeader>
              <CardTitle className="text-white">Ajans Bilgileri</CardTitle>
              <CardDescription className="text-gray-400">Ajansın temel bilgilerini girin</CardDescription>
            </CardHeader>
            <CardContent className="space-y-4">
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div className="space-y-2">
                  <Label htmlFor="name">Ajans Adı *</Label>
                  <Input
                    id="name"
                    value={formData.name}
                    onChange={(e) => setFormData({ ...formData, name: e.target.value })}
                    required
                    placeholder="Örn: Magnor Agency"
                  />
                </div>

                <div className="space-y-2">
                  <Label htmlFor="commissionRate">Komisyon Oranı (%)</Label>
                  <Input
                    id="commissionRate"
                    type="number"
                    step="0.01"
                    min="0"
                    max="100"
                    value={formData.commissionRate}
                    onChange={(e) => setFormData({ ...formData, commissionRate: e.target.value })}
                    placeholder="15.00"
                  />
                </div>
              </div>
            </CardContent>
          </Card>

          {/* İletişim Bilgileri */}
          <Card className="bg-zinc-900/50 border-white/10">
            <CardHeader>
              <CardTitle className="text-white">İletişim Bilgileri</CardTitle>
              <CardDescription className="text-gray-400">Ajansın iletişim bilgilerini girin</CardDescription>
            </CardHeader>
            <CardContent className="space-y-4">
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div className="space-y-2">
                  <Label htmlFor="contactName">İletişim Kişisi</Label>
                  <Input
                    id="contactName"
                    value={formData.contactName}
                    onChange={(e) => setFormData({ ...formData, contactName: e.target.value })}
                    placeholder="John Doe"
                  />
                </div>

                <div className="space-y-2">
                  <Label htmlFor="contactEmail">E-posta</Label>
                  <Input
                    id="contactEmail"
                    type="email"
                    value={formData.contactEmail}
                    onChange={(e) => setFormData({ ...formData, contactEmail: e.target.value })}
                    placeholder="contact@agency.com"
                  />
                </div>

                <div className="space-y-2">
                  <Label htmlFor="contactPhone">Telefon</Label>
                  <Input
                    id="contactPhone"
                    value={formData.contactPhone}
                    onChange={(e) => setFormData({ ...formData, contactPhone: e.target.value })}
                    placeholder="+90 555 123 45 67"
                  />
                </div>
              </div>

              <div className="space-y-2">
                <Label htmlFor="notes">Notlar</Label>
                <Textarea
                  id="notes"
                  value={formData.notes}
                  onChange={(e) => setFormData({ ...formData, notes: e.target.value })}
                  placeholder="İlave notlar..."
                  rows={4}
                />
              </div>
            </CardContent>
          </Card>

          {/* Submit Buttons */}
          <div className="flex justify-end gap-3">
            <Button
              type="button"
              variant="outline"
              onClick={() => setLocation("/app/agencies")}
              disabled={isSaving}
              className="border-white/20 hover:bg-white/10"
            >
              İptal
            </Button>
            <Button
              type="submit"
              className="bg-purple-600 hover:bg-purple-700"
              disabled={isSaving}
            >
              {isSaving ? "Kaydediliyor..." : isEdit ? "Güncelle" : "Kaydet"}
            </Button>
          </div>
        </form>
      </main>
    </div>
  );
}
