# .cursor Configuration Folder

This folder contains all Cursor IDE specific configuration files for the Sikila Flutter project. These files ensure consistent development practices and enforce our design system across all team members.

## 📁 File Structure

```
.cursor/
├── README.md           # This file - explains the configuration
├── rules               # Main Cursor rules (moved from .cursorrules)
├── instructions.md     # Detailed development instructions
├── composer.md         # Cursor Composer specific rules
├── settings.json       # IDE settings for Flutter development
├── prompts.md          # Common prompts and quick references
└── snippets.json       # Code snippets for faster development
```

## 📋 File Descriptions

### `rules`
The main Cursor rules file that enforces:
- Strict adherence to `@DESIGN_SYSTEM.md`
- RTL and internationalization requirements
- Code quality standards
- Project structure guidelines
- Performance and accessibility requirements

### `instructions.md`
Comprehensive instructions for developers including:
- Project overview and principles
- Critical requirements and patterns
- File structure rules
- Common code patterns and examples
- Quality checklist

### `composer.md`
Specific rules for Cursor Composer:
- Context understanding guidelines
- Code generation strategies
- Quality checklist
- Anti-patterns to avoid
- Performance guidelines

### `settings.json`
IDE settings optimized for Flutter development:
- Dart/Flutter specific configurations
- File associations
- Formatting rules
- Debug settings
- Exclusion patterns

### `prompts.md`
Quick reference prompts for common tasks:
- Design system queries
- Code generation prompts
- Internationalization prompts
- Code review prompts
- Testing prompts
- Debugging prompts

### `snippets.json`
Custom code snippets for faster development:
- Sikila-compliant widget templates
- Theme-aware components
- RTL-ready layouts
- Localized text patterns
- Error handling patterns

## 🚀 Usage

### For New Team Members
1. Clone the repository
2. Open in Cursor IDE
3. The `.cursor` folder will automatically configure your environment
4. All rules and guidelines will be enforced automatically

### For Development
- Use snippets with prefixes like `sikilawidget`, `sikilapage`, etc.
- Reference `prompts.md` for common development tasks
- Follow the quality checklist in `composer.md`
- All code will be automatically checked against our rules

### For Customization
- Modify `settings.json` for IDE preferences
- Add new snippets to `snippets.json`
- Update prompts in `prompts.md` for new patterns
- Extend rules as needed while maintaining design system compliance

## 🔧 Integration

These configuration files work together to:
1. **Enforce Design System**: Every code suggestion follows `@DESIGN_SYSTEM.md`
2. **Ensure Quality**: Static analysis and testing requirements are enforced
3. **Support RTL**: All UI components must support Arabic/RTL layouts
4. **Enable i18n**: Internationalization is mandatory for all user-facing text
5. **Optimize Performance**: Best practices for Flutter performance are enforced

## 📝 Maintenance

- Review and update rules quarterly
- Add new snippets as patterns emerge
- Update prompts based on common development tasks
- Ensure settings remain compatible with latest Flutter/Dart versions

## 🎯 Benefits

- **Consistency**: All team members follow the same standards
- **Quality**: Automated enforcement of best practices
- **Speed**: Pre-built snippets and prompts accelerate development
- **Learning**: New developers learn proper patterns through examples
- **Maintainability**: Uniform codebase structure and quality

This configuration ensures that every line of code written in the Sikila project follows our established standards and contributes to a high-quality, maintainable codebase.