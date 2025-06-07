# 로컬 개발 환경 설정 가이드

GitHub Pages에 배포하기 전에 로컬에서 Jekyll 사이트를 실행하고 테스트하는 방법을 안내합니다.

## 📋 목차

1. [시스템 요구사항](#시스템-요구사항)
2. [Ruby 설치](#ruby-설치)
3. [프로젝트 설정](#프로젝트-설정)
4. [로컬 서버 실행](#로컬-서버-실행)
5. [문제 해결](#문제-해결)
6. [유용한 명령어](#유용한-명령어)

## 🔧 시스템 요구사항

- **Ruby**: 2.7.0 이상 (권장: 3.1.x)
- **Bundler**: 2.0 이상
- **Git**: 최신 버전

### 현재 버전 확인
```bash
# Ruby 버전 확인
ruby --version

# Bundler 버전 확인
bundler --version

# Git 버전 확인
git --version
```

## 💎 Ruby 설치

### macOS (Homebrew 사용)
```bash
# Homebrew 설치 (없는 경우)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Ruby 설치
brew install ruby

# PATH 설정 (~/.zshrc 또는 ~/.bash_profile에 추가)
echo 'export PATH="/opt/homebrew/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

### Ubuntu/Debian
```bash
# 의존성 설치
sudo apt update
sudo apt install ruby-full build-essential zlib1g-dev

# Gem 설치 경로 설정
echo '# Install Ruby Gems to ~/gems' >> ~/.bashrc
echo 'export GEM_HOME="$HOME/gems"' >> ~/.bashrc
echo 'export PATH="$HOME/gems/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

### Windows
1. [RubyInstaller](https://rubyinstaller.org/) 다운로드 및 설치
2. "Ruby+Devkit" 버전 선택 (권장)
3. 설치 후 명령 프롬프트에서 `ridk install` 실행

## 🚀 프로젝트 설정

### 1. 저장소 클론
```bash
git clone https://github.com/ThakiCloud/agency-jekyll-theme.git
cd agency-jekyll-theme
```

### 2. Bundler 설치
```bash
gem install bundler
```

### 3. 의존성 설치
```bash
# GitHub Pages gem 및 의존성 설치
bundle install
```

## 🌐 로컬 서버 실행

### 기본 실행
```bash
# Jekyll 서버 시작
bundle exec jekyll serve

# 또는 더 자세한 출력
bundle exec jekyll serve --verbose
```

### 개발 모드 옵션
```bash
# 라이브 리로드 (파일 변경 시 자동 새로고침)
bundle exec jekyll serve --livereload

# 초안(draft) 포스트도 포함
bundle exec jekyll serve --drafts

# 포트 변경
bundle exec jekyll serve --port 4001

# 모든 옵션 조합
bundle exec jekyll serve --livereload --drafts --port 4001
```

### 성공 시 출력 예시
```
Configuration file: /path/to/your/site/_config.yml
            Source: /path/to/your/site
       Destination: /path/to/your/site/_site
 Incremental build: disabled. Enable with --incremental
      Generating...
       Jekyll Feed: Generating feed for posts
                    done in 2.345 seconds.
 Auto-regeneration: enabled for '/path/to/your/site'
    Server address: http://127.0.0.1:4000/
  Server running... press ctrl-c to stop.
```

### 사이트 접속
브라우저에서 `http://127.0.0.1:4000` 또는 `http://localhost:4000` 접속

## 🔍 문제 해결

### 일반적인 오류와 해결방법

#### 1. `bundle install` 실패
```bash
# Bundler 업데이트
gem update bundler

# 캐시 클리어 후 재설치
bundle clean --force
bundle install
```

#### 2. Jekyll 빌드 오류
```bash
# 의존성 업데이트
bundle update

# 깨끗한 빌드
bundle exec jekyll clean
bundle exec jekyll build
```

#### 3. Remote theme 로딩 실패
```bash
# 인터넷 연결 확인 후
bundle exec jekyll clean
bundle install
bundle exec jekyll serve
```

#### 4. 포트 이미 사용 중 오류
```bash
# 다른 포트 사용
bundle exec jekyll serve --port 4001

# 또는 기존 프로세스 종료 (macOS/Linux)
lsof -ti:4000 | xargs kill -9
```

#### 5. 권한 오류 (macOS/Linux)
```bash
# gem 설치 경로 확인
gem environment

# 사용자 gem 디렉토리 사용
echo 'export GEM_HOME="$HOME/.gem"' >> ~/.zshrc
echo 'export PATH="$GEM_HOME/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

## 📚 유용한 명령어

### Jekyll 명령어
```bash
# 새 포스트 생성
bundle exec jekyll post "Post Title"

# 새 페이지 생성
bundle exec jekyll page "Page Title"

# 사이트 빌드만 실행
bundle exec jekyll build

# 사이트 정리 (생성된 파일 삭제)
bundle exec jekyll clean

# Jekyll 도움말
bundle exec jekyll help
```

### Bundle 관리
```bash
# 의존성 업데이트
bundle update

# 보안 취약점 검사
bundle audit

# 사용하지 않는 gem 정리
bundle clean

# Bundler 버전 확인
bundle version
```

### Git 워크플로
```bash
# 변경사항 확인
git status

# 모든 변경사항 스테이징
git add .

# 커밋
git commit -m "Update content"

# GitHub에 푸시
git push origin master
```

## 🔄 개발 워크플로 권장사항

1. **로컬에서 먼저 테스트**
   ```bash
   bundle exec jekyll serve --livereload
   ```

2. **변경사항 확인 후 커밋**
   ```bash
   git add .
   git commit -m "Descriptive commit message"
   ```

3. **GitHub에 푸시하여 자동 배포**
   ```bash
   git push origin master
   ```

4. **GitHub Actions에서 빌드 상태 확인**
   - 저장소의 Actions 탭에서 빌드 로그 확인

## ⚠️ 주의사항

- **절대 `_site/` 폴더를 커밋하지 마세요** (이미 `.gitignore`에 포함됨)
- **로컬 테스트 없이 바로 푸시하지 마세요**
- **`Gemfile.lock`은 커밋해주세요** (의존성 버전 고정)
- **sensitive 정보는 `_config.yml`에 직접 입력하지 마세요**

## 📞 도움이 필요할 때

1. **Jekyll 공식 문서**: https://jekyllrb.com/docs/
2. **GitHub Pages 문서**: https://docs.github.com/en/pages
3. **Agency 테마 문서**: https://github.com/raviriley/agency-jekyll-theme

---

## 🎉 성공적인 설정 확인

다음이 모두 정상 작동하면 설정이 완료된 것입니다:

- [ ] `bundle install` 성공
- [ ] `bundle exec jekyll serve` 성공
- [ ] `http://localhost:4000`에서 사이트 로딩
- [ ] 파일 수정 시 자동 리빌드 (--livereload 사용 시)
- [ ] Git push 후 GitHub Actions 빌드 성공

성공을 축하합니다! 🎊 