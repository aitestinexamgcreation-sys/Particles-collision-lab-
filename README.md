# Quantum Collision Lab v6.2

A high-performance GPU-accelerated particle simulation with 65,536 particles featuring WebGL2 transform feedback, spatial hashing collision detection, and advanced rendering effects.

![Quantum Collision Lab](https://github.com/user-attachments/assets/63123fca-f1e6-4ef0-8ec2-27f23f573b2b)

## 🌟 Features

### Core Simulation
- **65,536 particles** updated entirely on GPU via WebGL2 transform feedback
- **Spatial hash grid** collision system with configurable cell size
- **GPU-based physics**: gravity, damping, mouse forces, boundary collisions, procedural jitter
- **SDF point sprite rendering** with smooth circular particles and glow effects

### Lifecycle Modes
1. **Respawn**: Particles regenerate in circular patterns when life reaches zero
2. **Heat-map**: Particle life increases on mouse/touch interaction
3. **Energy-preserving**: Constant particle life without decay

### Color Systems
1. **Hue Rotation**: HSV-based color shifting
2. **Temporal Drift**: Time-based colors with per-particle variation
3. **Speed-based**: Energy coloring (blue for slow, red for fast)

### Performance
- DPI-aware particle size clamping
- Dynamic LOD (reduces particle size when FPS < 30)
- Distance-based alpha falloff
- Optimized interleaved buffer layout (8 floats/particle)

### Cross-Platform
- **Web**: Works in any modern browser with WebGL2
- **Android**: APK available via WebView wrapper (maintains WebGL2)
- Unified pointer events for mouse and touch input

## 🚀 Quick Start

### Web Version
Simply open `index.html` in a modern browser that supports WebGL2:
```bash
# Using Python
python3 -m http.server 8000

# Using Node.js
npx serve

# Or just open index.html directly in browser
```

Visit `http://localhost:8000` in Chrome, Firefox, or Edge.

### Android APK
See the [Android README](android/README.md) for detailed build instructions.

**Quick build:**
```bash
cd android
./gradlew assembleDebug
# APK output: android/app/build/outputs/apk/debug/app-debug.apk
```

## 🎮 Controls

### Lifecycle Modes
- **Respawn**: Circular particle regeneration
- **Heat-map**: Interactive life boost
- **Energy**: Constant particle life

### Color Modes
- **Hue Rotate**: HSV color shifting
- **Temporal**: Time-based drift
- **Speed**: Energy-based coloring

### Physics Parameters
- **Repulsion Power** (0-15): Collision force strength
- **Visual Radius** (1-20): Particle size
- **Grid Cell Size** (16-128): Spatial hash resolution
- **Gravity** (-3 to 3): Vertical acceleration
- **Decay Rate** (0-2): Life decrease speed
- **Simulation Speed** (0.1-5x): Time scaling

### Rendering
- **Color Shift** (0-1): Hue rotation amount
- **Dynamic LOD**: Auto-adjust quality based on FPS

### Interaction
- Click/tap and hold to spawn particles
- Particles are attracted or repelled by mouse/touch position
- UI panel is minimizable (click arrow)
- "PURGE SYSTEM" resets all particles

## 🏗️ Architecture

### GPU Pipeline
```
Update Pass (Transform Feedback)
├── Read from Buffer A
├── Compute physics on GPU
├── Write to Buffer B
└── Swap buffers (ping-pong)

Render Pass
├── Read from current buffer
├── SDF point sprite shader
└── Additive blending
```

### Buffer Layout
```
Interleaved format (8 floats per particle):
[pos.x, pos.y, vel.x, vel.y, life, speed, radius, seed]
```

### Spatial Hashing
- Canvas divided into grid cells
- Hash function approximates local density
- Procedural collision response based on density
- Note: Uses hash-based approximation (not actual density texture)

## 📱 Android Implementation

The Android version uses a **WebView wrapper** approach:

### Why WebView (not native Vulkan)?
✅ Maintains existing WebGL2 code
✅ Faster deployment (no rewrite)
✅ Both web and Android share same codebase
✅ Hardware-accelerated WebGL on Android
✅ 30-60 FPS on modern devices

❌ Native Vulkan would require:
- Complete C++ rewrite
- GLSL → SPIR-V shader conversion
- Vulkan rendering pipeline implementation
- NDK integration
- 2-4 weeks development time
- But could achieve 90-120 FPS

For most use cases, the WebView approach provides excellent performance with minimal development effort.

See [android/README.md](android/README.md) for build instructions.

## 🛠️ Technical Details

### WebGL2 Transform Feedback
Particle physics runs entirely on GPU without CPU readback:
```glsl
// Update shader processes all particles in parallel
out vec4 o_position;
out vec4 o_velocity;
out float o_life;

void main() {
    // Compute forces, update position/velocity
    // Write to transform feedback buffer
}
```

### Performance Optimizations
- Interleaved buffer layout for cache coherency
- Ping-pong buffers avoid read/write hazards
- Dynamic LOD scales quality based on FPS
- DPI-aware rendering for consistent visuals
- Distance-based alpha for depth perception

### Browser Requirements
- WebGL2 support (Chrome 56+, Firefox 51+, Edge 79+)
- Hardware acceleration enabled
- Modern GPU with OpenGL ES 3.0+

### Android Requirements
- Android 7.0 (API 24) or later
- OpenGL ES 3.0 support
- Hardware acceleration
- Recent Chrome WebView

## 📊 Performance

**Web (Desktop)**
- 60 FPS on modern GPUs
- 30-45 FPS on integrated graphics
- Dynamic LOD maintains playability

**Android (WebView)**
- 40-60 FPS on flagship devices (2020+)
- 25-40 FPS on mid-range devices
- LOD adjusts automatically

**Particle Count**
- 65,536 particles (256×256)
- Configurable via `PARTICLE_COUNT` constant
- Higher counts possible on powerful GPUs

## 🔮 Future Enhancements

### Short-term
- [ ] GPU-computed density texture (replace hash approximation)
- [ ] GPU readback for accurate particle counting
- [ ] Additional lifecycle modes (orbit, flock)
- [ ] More color schemes
- [ ] Preset parameter configurations

### Long-term
- [ ] Native Vulkan Android port for maximum performance
- [ ] Particle-particle collision (N-body simulation)
- [ ] Compute shader implementation (WebGPU)
- [ ] VR/AR support
- [ ] Multiplayer synchronization

## 📄 License

MIT License - See LICENSE file for details

## 🤝 Contributing

Contributions welcome! Areas of interest:
- Performance optimizations
- Additional rendering modes
- Mobile UX improvements
- Native platform ports (iOS, Vulkan)

## 🙏 Acknowledgments

Built by Tory Thompson
Simulation techniques inspired by GPU Gems and ShaderToy community
