#!/bin/bash

# Jekyll 로컬 개발 환경 설정 스크립트
# 사용법: ./setup-local.sh

set -e  # 오류 발생 시 스크립트 중단

echo "🚀 Jekyll 로컬 개발 환경 설정을 시작합니다..."

# 색깔 정의
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 함수: 성공 메시지
success() {
    echo -e "${GREEN}✅ $1${NC}"
}

# 함수: 경고 메시지
warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

# 함수: 에러 메시지
error() {
    echo -e "${RED}❌ $1${NC}"
    exit 1
}

# 함수: 정보 메시지
info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

# Ruby 버전 확인
echo ""
info "Ruby 버전을 확인합니다..."
if command -v ruby &> /dev/null; then
    RUBY_VERSION=$(ruby --version)
    echo "   $RUBY_VERSION"
    success "Ruby가 설치되어 있습니다."
else
    error "Ruby가 설치되어 있지 않습니다. Ruby를 먼저 설치해주세요."
fi

# Bundler 확인 및 설치
echo ""
info "Bundler를 확인합니다..."
if command -v bundler &> /dev/null; then
    BUNDLER_VERSION=$(bundler --version)
    echo "   $BUNDLER_VERSION"
    success "Bundler가 이미 설치되어 있습니다."
else
    info "Bundler를 설치합니다..."
    gem install bundler
    success "Bundler 설치가 완료되었습니다."
fi

# Bundle install 실행
echo ""
info "프로젝트 의존성을 설치합니다..."
if bundle install; then
    success "의존성 설치가 완료되었습니다."
else
    error "의존성 설치에 실패했습니다. 위의 오류 메시지를 확인해주세요."
fi

# Jekyll 빌드 테스트
echo ""
info "Jekyll 빌드를 테스트합니다..."
if bundle exec jekyll build; then
    success "Jekyll 빌드가 성공했습니다."
else
    error "Jekyll 빌드에 실패했습니다. 위의 오류 메시지를 확인해주세요."
fi

# 완료 메시지
echo ""
echo "🎉 로컬 개발 환경 설정이 완료되었습니다!"
echo ""
echo "다음 명령어로 로컬 서버를 시작할 수 있습니다:"
echo ""
echo -e "${GREEN}bundle exec jekyll serve${NC}"
echo ""
echo "또는 라이브 리로드와 함께:"
echo ""
echo -e "${GREEN}bundle exec jekyll serve --livereload${NC}"
echo ""
echo "서버가 시작되면 다음 주소에서 사이트를 확인할 수 있습니다:"
echo -e "${BLUE}http://localhost:4000${NC}"
echo ""
warning "참고: 파일을 수정한 후에는 Ctrl+C로 서버를 중단하고 다시 시작해야 할 수 있습니다." 