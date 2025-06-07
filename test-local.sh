#!/bin/bash

# 빠른 로컬 테스트 스크립트
echo "🔥 빠른 Jekyll 빌드 테스트..."

# 빌드 테스트
if bundle exec jekyll build; then
    echo "✅ 빌드 성공! GitHub Pages에 배포할 준비가 되었습니다."
    echo ""
    echo "다음 명령어로 로컬 서버를 시작할 수 있습니다:"
    echo "bundle exec jekyll serve"
    echo ""
    echo "또는 라이브 리로드와 함께:"
    echo "bundle exec jekyll serve --livereload"
else
    echo "❌ 빌드 실패. 위의 오류를 확인해주세요."
    exit 1
fi 