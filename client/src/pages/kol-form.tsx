import { useEffect, useState } from "react";
import { useLocation, useParams } from "wouter";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { useToast } from "@/hooks/use-toast";
import { Checkbox } from "@/components/ui/checkbox";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";

interface SocialMediaPlatform {
  id: string;
  name: string;
}

interface Language {
  id: string;
  name: string;
  code: string;
}

interface Category {
  id: string;
  name: string;
}

interface Agency {
  id: string;
  name: string;
}

interface SocialMediaAccount {
  socialMediaId: string;
  link: string;
  followerCount: string;
}

export default function KOLForm() {
  const params = useParams();
  const kolId = params.id;
  const isEdit = kolId && kolId !== "new";
  
  const [, setLocation] = useLocation();
  const { toast } = useToast();
  
  const [isLoading, setIsLoading] = useState(false);
  const [isSaving, setSaving] = useState(false);
  
  // Reference data
  const [platforms, setPlatforms] = useState<SocialMediaPlatform[]>([]);
  const [languages, setLanguages] = useState<Language[]>([]);
  const [categories, setCategories] = useState<Category[]>([]);
  const [agencies, setAgencies] = useState<Agency[]>([]);
  
  // Form data
  const [formData, setFormData] = useState({
    name: "",
    tierScore: "",
    telegramAddress: "",
    email: "",
    phone: "",
    notes: "",
  });
  
  const [socialMediaAccounts, setSocialMediaAccounts] = useState<SocialMediaAccount[]>([]);
  const [selectedLanguages, setSelectedLanguages] = useState<string[]>([]);
  const [selectedCategories, setSelectedCategories] = useState<string[]>([]);
  const [selectedAgencies, setSelectedAgencies] = useState<string[]>([]);

  useEffect(() => {
    checkAuth();
    loadReferenceData();
    if (isEdit) {
      loadKOL();
    }
  }, []);

  const checkAuth = async () => {
    const response = await fetch("/api/auth/me");
    if (!response.ok) {
      setLocation("/app");
    }
  };

  const loadReferenceData = async () => {
    try {
      const [platformsRes, languagesRes, categoriesRes, agenciesRes] = await Promise.all([
        fetch("/api/social-media"),
        fetch("/api/languages"),
        fetch("/api/categories"),
        fetch("/api/agencies"),
      ]);

      if (platformsRes.ok) {
        const data = await platformsRes.json();
        setPlatforms(data.platforms);
      }
      
      if (languagesRes.ok) {
        const data = await languagesRes.json();
        setLanguages(data.languages);
      }
      
      if (categoriesRes.ok) {
        const data = await categoriesRes.json();
        setCategories(data.categories);
      }
      
      if (agenciesRes.ok) {
        const data = await agenciesRes.json();
        setAgencies(data.agencies);
      }
    } catch (error) {
      console.error("Error loading reference data:", error);
    }
  };

  const loadKOL = async () => {
    setIsLoading(true);
    try {
      const response = await fetch(`/api/kols/${kolId}`);
      if (response.ok) {
        const data = await response.json();
        const kol = data.kol;
        
        setFormData({
          name: kol.name,
          tierScore: kol.tierScore?.toString() || "",
          telegramAddress: kol.telegramAddress || "",
          email: kol.email || "",
          phone: kol.phone || "",
          notes: kol.notes || "",
        });
        
        // TODO: Load related data
      }
    } catch (error) {
      toast({
        variant: "destructive",
        title: "Hata",
        description: "KOL yüklenirken bir hata oluştu",
      });
    } finally {
      setIsLoading(false);
    }
  };

  const handleAddSocialMedia = () => {
    setSocialMediaAccounts([
      ...socialMediaAccounts,
      { socialMediaId: "", link: "", followerCount: "" },
    ]);
  };

  const handleRemoveSocialMedia = (index: number) => {
    setSocialMediaAccounts(socialMediaAccounts.filter((_, i) => i !== index));
  };

  const handleSocialMediaChange = (index: number, field: keyof SocialMediaAccount, value: string) => {
    const updated = [...socialMediaAccounts];
    updated[index][field] = value;
    setSocialMediaAccounts(updated);
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setSaving(true);

    try {
      const payload = {
        name: formData.name,
        tierScore: formData.tierScore ? parseInt(formData.tierScore) : null,
        telegramAddress: formData.telegramAddress || null,
        email: formData.email || null,
        phone: formData.phone || null,
        notes: formData.notes || null,
        socialMediaAccounts: socialMediaAccounts
          .filter(sm => sm.socialMediaId && sm.link)
          .map(sm => ({
            socialMediaId: sm.socialMediaId,
            link: sm.link,
            followerCount: sm.followerCount ? parseInt(sm.followerCount) : null,
          })),
        languageIds: selectedLanguages,
        categoryIds: selectedCategories,
        agencyIds: selectedAgencies,
      };

      const url = isEdit ? `/api/kols/${kolId}` : "/api/kols";
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
        description: isEdit ? "KOL güncellendi" : "KOL eklendi",
      });

      setLocation("/app/kols");
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
          <div className="flex items-center gap-3">
            <Button
              variant="ghost"
              onClick={() => setLocation("/app/kols")}
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
              {isEdit ? "KOL Düzenle" : "Yeni KOL"}
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
              <CardTitle className="text-white">Temel Bilgiler</CardTitle>
              <CardDescription className="text-gray-400">KOL'un temel bilgilerini girin</CardDescription>
            </CardHeader>
            <CardContent className="space-y-4">
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div className="space-y-2">
                  <Label htmlFor="name">İsim *</Label>
                  <Input
                    id="name"
                    value={formData.name}
                    onChange={(e) => setFormData({ ...formData, name: e.target.value })}
                    required
                    placeholder="Örn: Crypto Expert"
                  />
                </div>

                <div className="space-y-2">
                  <Label htmlFor="tierScore">Tier Score (1-10)</Label>
                  <Input
                    id="tierScore"
                    type="number"
                    min="1"
                    max="10"
                    value={formData.tierScore}
                    onChange={(e) => setFormData({ ...formData, tierScore: e.target.value })}
                    placeholder="8"
                  />
                </div>

                <div className="space-y-2">
                  <Label htmlFor="email">E-posta</Label>
                  <Input
                    id="email"
                    type="email"
                    value={formData.email}
                    onChange={(e) => setFormData({ ...formData, email: e.target.value })}
                    placeholder="email@example.com"
                  />
                </div>

                <div className="space-y-2">
                  <Label htmlFor="phone">Telefon</Label>
                  <Input
                    id="phone"
                    value={formData.phone}
                    onChange={(e) => setFormData({ ...formData, phone: e.target.value })}
                    placeholder="+90 555 123 45 67"
                  />
                </div>

                <div className="space-y-2">
                  <Label htmlFor="telegram">Telegram</Label>
                  <Input
                    id="telegram"
                    value={formData.telegramAddress}
                    onChange={(e) => setFormData({ ...formData, telegramAddress: e.target.value })}
                    placeholder="@username"
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
                  rows={3}
                />
              </div>
            </CardContent>
          </Card>

          {/* Sosyal Medya Hesapları */}
          <Card className="bg-zinc-900/50 border-white/10">
            <CardHeader>
              <CardTitle className="text-white">Sosyal Medya Hesapları</CardTitle>
              <CardDescription className="text-gray-400">KOL'un sosyal medya hesaplarını ekleyin</CardDescription>
            </CardHeader>
            <CardContent className="space-y-4">
              {socialMediaAccounts.map((account, index) => (
                <div key={index} className="flex gap-3 items-end">
                  <div className="flex-1 space-y-2">
                    <Label>Platform</Label>
                    <Select
                      value={account.socialMediaId}
                      onValueChange={(value) => handleSocialMediaChange(index, "socialMediaId", value)}
                    >
                      <SelectTrigger>
                        <SelectValue placeholder="Platform seçin" />
                      </SelectTrigger>
                      <SelectContent>
                        {platforms.map((platform) => (
                          <SelectItem key={platform.id} value={platform.id}>
                            {platform.name}
                          </SelectItem>
                        ))}
                      </SelectContent>
                    </Select>
                  </div>

                  <div className="flex-1 space-y-2">
                    <Label>Link</Label>
                    <Input
                      value={account.link}
                      onChange={(e) => handleSocialMediaChange(index, "link", e.target.value)}
                      placeholder="https://twitter.com/username"
                    />
                  </div>

                  <div className="w-32 space-y-2">
                    <Label>Takipçi</Label>
                    <Input
                      type="number"
                      value={account.followerCount}
                      onChange={(e) => handleSocialMediaChange(index, "followerCount", e.target.value)}
                      placeholder="10000"
                    />
                  </div>

                  <Button
                    type="button"
                    variant="outline"
                    size="icon"
                    onClick={() => handleRemoveSocialMedia(index)}
                    className="text-red-600"
                  >
                    ×
                  </Button>
                </div>
              ))}

              <Button
                type="button"
                variant="outline"
                onClick={handleAddSocialMedia}
                className="w-full border-purple-200 text-purple-700 hover:bg-purple-50 hover:border-purple-300"
              >
                + Sosyal Medya Ekle
              </Button>
            </CardContent>
          </Card>

          {/* Diller */}
          <Card className="bg-zinc-900/50 border-white/10">
            <CardHeader>
              <CardTitle className="text-white">Diller</CardTitle>
              <CardDescription className="text-gray-400">KOL'un konuştuğu dilleri seçin</CardDescription>
            </CardHeader>
            <CardContent>
              <div className="grid grid-cols-2 md:grid-cols-3 gap-3">
                {languages.map((lang) => (
                  <div key={lang.id} className="flex items-center space-x-2">
                    <Checkbox
                      id={`lang-${lang.id}`}
                      checked={selectedLanguages.includes(lang.id)}
                      onCheckedChange={(checked) => {
                        if (checked) {
                          setSelectedLanguages([...selectedLanguages, lang.id]);
                        } else {
                          setSelectedLanguages(selectedLanguages.filter(id => id !== lang.id));
                        }
                      }}
                    />
                    <label htmlFor={`lang-${lang.id}`} className="text-sm cursor-pointer text-gray-300">
                      {lang.name}
                    </label>
                  </div>
                ))}
              </div>
            </CardContent>
          </Card>

          {/* Kategoriler */}
          <Card className="bg-zinc-900/50 border-white/10">
            <CardHeader>
              <CardTitle className="text-white">Kategoriler</CardTitle>
              <CardDescription className="text-gray-400">KOL'un uzmanlık alanlarını seçin</CardDescription>
            </CardHeader>
            <CardContent>
              <div className="grid grid-cols-2 md:grid-cols-3 gap-3">
                {categories.map((cat) => (
                  <div key={cat.id} className="flex items-center space-x-2">
                    <Checkbox
                      id={`cat-${cat.id}`}
                      checked={selectedCategories.includes(cat.id)}
                      onCheckedChange={(checked) => {
                        if (checked) {
                          setSelectedCategories([...selectedCategories, cat.id]);
                        } else {
                          setSelectedCategories(selectedCategories.filter(id => id !== cat.id));
                        }
                      }}
                    />
                    <label htmlFor={`cat-${cat.id}`} className="text-sm cursor-pointer text-gray-300">
                      {cat.name}
                    </label>
                  </div>
                ))}
              </div>
            </CardContent>
          </Card>

          {/* Ajanslar */}
          <Card className="bg-zinc-900/50 border-white/10">
            <CardHeader>
              <CardTitle className="text-white">Ajanslar</CardTitle>
              <CardDescription className="text-gray-400">KOL'un bağlı olduğu ajansları seçin</CardDescription>
            </CardHeader>
            <CardContent>
              <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
                {agencies.map((agency) => (
                  <div key={agency.id} className="flex items-center space-x-2">
                    <Checkbox
                      id={`agency-${agency.id}`}
                      checked={selectedAgencies.includes(agency.id)}
                      onCheckedChange={(checked) => {
                        if (checked) {
                          setSelectedAgencies([...selectedAgencies, agency.id]);
                        } else {
                          setSelectedAgencies(selectedAgencies.filter(id => id !== agency.id));
                        }
                      }}
                    />
                    <label htmlFor={`agency-${agency.id}`} className="text-sm cursor-pointer text-gray-300">
                      {agency.name}
                    </label>
                  </div>
                ))}
              </div>
            </CardContent>
          </Card>

          {/* Submit Buttons */}
          <div className="flex justify-end gap-3">
            <Button
              type="button"
              variant="outline"
              onClick={() => setLocation("/app/kols")}
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
