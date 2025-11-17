# Magnor Web3 Marketing Agency Website

## Overview
A professional, visually stunning marketing website for Magnor, a Web3 marketing agency. The site showcases services, partner relationships, and value propositions with a modern purple/blue gradient aesthetic perfect for the Web3 space.

## Project Architecture

### Frontend
- **Framework**: React with TypeScript
- **Routing**: Wouter
- **Styling**: Tailwind CSS with shadcn/ui components
- **Typography**: 
  - Inter for body text and subsection headings
  - Space Grotesk for hero headlines, section headers, and statistics
- **Color Scheme**: Purple/blue gradients (primary: hsl(262 83% 58%))

### Key Features Implemented
1. **Hero Section**: Full-viewport with generated Web3 blockchain background, gradient overlay, and CTAs
2. **Key Strengths**: 3-column grid showcasing trust, network, and partnership approach with statistics
3. **Trusted Partners**: Grid of 12 partner logos with grayscale-to-color hover effects
4. **Services**: 6 service cards covering KOL Marketing, Token Value Creation, PR & Media, Exchange Listing, VC Network, and Market Making
5. **Token Value Creation**: Detailed breakdown showing 3X campaign budget visualization
6. **How We Work**: 5-step process timeline
7. **Contact Section**: Email, website, and Telegram contact methods
8. **Responsive Design**: Mobile-first approach with breakpoints for tablet and desktop

## Recent Changes (Latest Session)

### Design System Implementation
- Configured Inter and Space Grotesk fonts from Google Fonts
- Set up proper color variables in index.css following Web3 aesthetic
- Generated hero background image showing blockchain network visualization
- Added smooth scroll behavior for enhanced UX

### Component Architecture
- Single-page application with all sections in `client/src/pages/home.tsx`
- Proper use of shadcn components (Card, Button, Badge) with elevation system
- All interactive elements include data-testid attributes for testing
- Responsive grid layouts that adapt across breakpoints

### Technical Implementation Notes
- Partner logos use placeholder stock images (production would require branded assets for each partner)
- All buttons use shadcn's built-in hover/active states (no manual elevation classes)
- Typography hierarchy strictly enforced: Space Grotesk for headers only, Inter for body content
- Elevation system (hover-elevate, active-elevate-2) applied only to Card components
- Smooth scroll and transitions enhance premium feel

## User Preferences
- Modern, professional Web3 aesthetic with purple/blue gradients
- Clean, minimalist design with generous whitespace
- Emphasis on trust, transparency, and measurable results
- Focus on visual excellence and professional polish

## Development Guidelines
- Follow design_guidelines.md religiously for all UI implementations
- Use shadcn components instead of custom styled elements
- Never add manual hover colors to Button components
- Maintain proper typography hierarchy (Space Grotesk for headers, Inter for body)
- All interactive elements must have data-testid attributes
- Use elevation utilities only on appropriate components (Cards, not Buttons/Badges)
