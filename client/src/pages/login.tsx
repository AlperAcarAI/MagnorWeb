import { useState } from "react";
import { useLocation } from "wouter";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Checkbox } from "@/components/ui/checkbox";
import { useToast } from "@/hooks/use-toast";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";

export default function Login() {
  const [, setLocation] = useLocation();
  const { toast } = useToast();
  const [isLoading, setIsLoading] = useState(false);
  const [formData, setFormData] = useState({
    username: "",
    password: "",
    rememberMe: false,
  });

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setIsLoading(true);

    try {
      const response = await fetch("/api/auth/login", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          username: formData.username,
          password: formData.password,
        }),
      });

      const data = await response.json();

      if (!response.ok) {
        throw new Error(data.message || "Giriş başarısız");
      }

      toast({
        title: "Giriş Başarılı",
        description: `Hoş geldiniz, ${data.user.username}!`,
      });

      // Dashboard'a yönlendir
      setLocation("/app/dashboard");
    } catch (error: any) {
      toast({
        variant: "destructive",
        title: "Giriş Hatası",
        description: error.message || "Kullanıcı adı veya şifre hatalı",
      });
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <div className="min-h-screen flex">
      {/* Sol Taraf - Branding */}
      <div className="hidden lg:flex lg:w-1/2 bg-gradient-to-br from-purple-600 via-purple-700 to-indigo-800 p-12 flex-col justify-between relative overflow-hidden">
        {/* Background Pattern */}
        <div className="absolute inset-0 opacity-10">
          <div className="absolute top-0 left-0 w-96 h-96 bg-white rounded-full blur-3xl"></div>
          <div className="absolute bottom-0 right-0 w-96 h-96 bg-white rounded-full blur-3xl"></div>
        </div>

        {/* Logo */}
        <div className="relative z-10">
          <img src="/Logo.svg" alt="Magnor" className="h-12 brightness-0 invert" />
        </div>

        {/* Content */}
        <div className="relative z-10 text-white">
          <h1 className="text-5xl font-bold mb-6 leading-tight">
            KOL Yönetim
            <br />
            Portal'ına
            <br />
            Hoş Geldiniz
          </h1>
          <p className="text-xl text-purple-100 max-w-md">
            Influencer'larınızı yönetin, kampanyalarınızı planlayın,
            başarınızı ölçün.
          </p>
        </div>

        {/* Footer */}
        <div className="relative z-10 text-purple-200 text-sm">
          <p>© 2024 Magnor Agency. Tüm hakları saklıdır.</p>
        </div>
      </div>

      {/* Sağ Taraf - Login Form */}
      <div className="flex-1 flex items-center justify-center p-8 bg-gray-50">
        <div className="w-full max-w-md">
          {/* Mobile Logo */}
          <div className="lg:hidden mb-8 text-center">
            <img src="/Logo.svg" alt="Magnor" className="h-10 mx-auto" />
          </div>

          <Card className="border-0 shadow-xl">
            <CardHeader className="space-y-1 pb-6">
              <CardTitle className="text-2xl font-bold">Giriş Yap</CardTitle>
              <CardDescription>
                Hesabınıza giriş yapmak için bilgilerinizi girin
              </CardDescription>
            </CardHeader>
            <CardContent>
              <form onSubmit={handleSubmit} className="space-y-4">
                <div className="space-y-2">
                  <Label htmlFor="username">Kullanıcı Adı veya E-posta</Label>
                  <Input
                    id="username"
                    type="text"
                    placeholder="admin"
                    value={formData.username}
                    onChange={(e) =>
                      setFormData({ ...formData, username: e.target.value })
                    }
                    required
                    disabled={isLoading}
                    className="h-11"
                  />
                </div>

                <div className="space-y-2">
                  <div className="flex items-center justify-between">
                    <Label htmlFor="password">Şifre</Label>
                    <a
                      href="#"
                      className="text-sm text-purple-600 hover:text-purple-700 transition-colors"
                      onClick={(e) => {
                        e.preventDefault();
                        toast({
                          title: "Şifre Sıfırlama",
                          description: "Bu özellik yakında eklenecek.",
                        });
                      }}
                    >
                      Şifremi Unuttum?
                    </a>
                  </div>
                  <Input
                    id="password"
                    type="password"
                    placeholder="••••••••"
                    value={formData.password}
                    onChange={(e) =>
                      setFormData({ ...formData, password: e.target.value })
                    }
                    required
                    disabled={isLoading}
                    className="h-11"
                  />
                </div>

                <div className="flex items-center space-x-2">
                  <Checkbox
                    id="remember"
                    checked={formData.rememberMe}
                    onCheckedChange={(checked) =>
                      setFormData({ ...formData, rememberMe: checked as boolean })
                    }
                    disabled={isLoading}
                  />
                  <label
                    htmlFor="remember"
                    className="text-sm text-gray-600 cursor-pointer select-none"
                  >
                    Beni hatırla
                  </label>
                </div>

                <Button
                  type="submit"
                  className="w-full h-11 bg-purple-600 hover:bg-purple-700 text-white font-medium"
                  disabled={isLoading}
                >
                  {isLoading ? (
                    <div className="flex items-center gap-2">
                      <div className="w-4 h-4 border-2 border-white border-t-transparent rounded-full animate-spin"></div>
                      Giriş yapılıyor...
                    </div>
                  ) : (
                    "Giriş Yap"
                  )}
                </Button>
              </form>

              <div className="mt-6 text-center text-sm text-gray-600">
                <p>Demo Hesap: <span className="font-mono text-purple-600">admin / admin</span></p>
              </div>
            </CardContent>
          </Card>

          {/* Additional Info */}
          <div className="mt-6 text-center text-sm text-gray-500">
            <p>
              Sorun mu yaşıyorsunuz?{" "}
              <a href="mailto:support@magnor.agency" className="text-purple-600 hover:text-purple-700">
                Destek ekibimizle iletişime geçin
              </a>
            </p>
          </div>
        </div>
      </div>
    </div>
  );
}
