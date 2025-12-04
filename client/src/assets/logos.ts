// Simple logo path mapping - logos are served from public/logos directory
const logoExtensions: Record<string, string> = {
  "Antix": "png",
  "Artrade": "png",
  "Binance": "png",
  "Bitget": "png",
  "CMedia": "jpeg",
  "Castrum Capital": "jpg",
  "Coinscout": "jpg",
  "Concordium": "png",
  "Disence": "jpg",
  "Fatty": "png",
  "KOLZ": "png",
  "Limewire": "png",
  "Lingo": "png",
  "Markchain": "jpg",
  "Metron Trading": "jpg",
  "My Lovely Planet": "png",
  "OKX": "jpg",
  "Opulous": "png",
  "Space Catch": "png",
  "Triangle": "png",
  "UPX": "jpeg",
  "XBO": "png",
  "Zetarium": "png",
  "Zkverify": "png",
};

export const getLogoForBrand = (brandName: string): string | null => {
  const ext = logoExtensions[brandName];
  if (ext) {
    // Encode the brand name to handle spaces and special characters in URLs
    const encodedBrandName = encodeURIComponent(brandName);
    const logoPath = `/logos/${encodedBrandName}.${ext}`;
    console.log(`✅ Logo path for ${brandName}:`, logoPath);
    return logoPath;
  }
  console.warn(`❌ No logo extension found for brand: ${brandName}`);
  return null;
};
