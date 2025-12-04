// Logo imports - Vite will handle these automatically
import AntixLogo from '/logos/Antix.png';
import ArtradeLogo from '/logos/Artrade.png';
import BinanceLogo from '/logos/Binance.png';
import BitgetLogo from '/logos/Bitget.png';
import CMediaLogo from '/logos/CMedia.jpeg';
import CastrumCapitalLogo from '/logos/Castrum Capital.jpg';
import CoinscoutLogo from '/logos/Coinscout.jpg';
import ConcordiumLogo from '/logos/Concordium.png';
import DisenceLogo from '/logos/Disence.jpg';
import FattyLogo from '/logos/Fatty.png';
import KOLZLogo from '/logos/KOLZ.png';
import LimewireLogo from '/logos/Limewire.png';
import LingoLogo from '/logos/Lingo.png';
import MarkchainLogo from '/logos/Markchain.jpg';
import MetronTradingLogo from '/logos/Metron Trading.jpg';
import MyLovelyPlanetLogo from '/logos/My Lovely Planet.png';
import OKXLogo from '/logos/OKX.jpg';
import OpulousLogo from '/logos/Opulous.png';
import SpaceCatchLogo from '/logos/Space Catch.png';
import TriangleLogo from '/logos/Triangle.png';
import UPXLogo from '/logos/UPX.jpeg';
import XBOLogo from '/logos/XBO.png';
import ZetariumLogo from '/logos/Zetarium.png';
import ZkverifyLogo from '/logos/Zkverify.png';

export const logoMap: Record<string, string> = {
  "Antix": AntixLogo,
  "Artrade": ArtradeLogo,
  "Binance": BinanceLogo,
  "Bitget": BitgetLogo,
  "CMedia": CMediaLogo,
  "Castrum Capital": CastrumCapitalLogo,
  "Coinscout": CoinscoutLogo,
  "Concordium": ConcordiumLogo,
  "Disence": DisenceLogo,
  "Fatty": FattyLogo,
  "KOLZ": KOLZLogo,
  "Limewire": LimewireLogo,
  "Lingo": LingoLogo,
  "Markchain": MarkchainLogo,
  "Metron Trading": MetronTradingLogo,
  "My Lovely Planet": MyLovelyPlanetLogo,
  "OKX": OKXLogo,
  "Opulous": OpulousLogo,
  "Space Catch": SpaceCatchLogo,
  "Triangle": TriangleLogo,
  "UPX": UPXLogo,
  "XBO": XBOLogo,
  "Zetarium": ZetariumLogo,
  "Zkverify": ZkverifyLogo,
};

export const getLogoForBrand = (brandName: string): string | null => {
  const logo = logoMap[brandName];
  if (logo) {
    console.log(`✅ Logo found for ${brandName}:`, logo);
    return logo;
  }
  console.warn(`❌ No logo found for brand: ${brandName}`);
  return null;
};
