"""检查 Markdown 文档的仓库内部引用是否有效。

注意区分两类路径引用：
  1. 仓库内真实存在的文件（如 references/xxx.md）—— 必须校验
  2. skill 指导用户产出的交付物（如 design-brief.md、reports/qa-report.md）
     —— 这些属于「工作产物」，文档里只是给项目结构起名，不应存在于本仓库

用法: python tools/check-doc-links.py
"""
import re
import sys
from pathlib import Path

root = Path(__file__).resolve().parent.parent

# skill 产出的工作产物命名（相对「字体项目」而非本仓库），不参与存在性校验
WORK_PRODUCTS = {
    'design-brief.md', 'font-spec.md', 'qa-report.md', 'coverage.txt',
    'LICENSE.txt', 'README.md',
}
WORK_DIRS = ('reports/', 'packaging/', 'source/', 'build/', 'specimens/')

bad = []
checked = 0
skipped = 0


def is_work_product(path: str) -> bool:
    p = path.strip().lstrip('./')
    if p.startswith(WORK_DIRS):
        return True
    return Path(p).name in WORK_PRODUCTS


for f in sorted(root.rglob('*.md')):
    if '.git' in f.parts:
        continue
    s = f.read_text(encoding='utf-8')
    rel = f.relative_to(root)

    for m in re.finditer(r'\[[^\]]*\]\(([^)]+)\)', s):
        target = m.group(1).strip()
        if target.startswith(('http://', 'https://', '#', 'mailto:')):
            continue
        path = target.split('#')[0].strip()
        if not path:
            continue
        if is_work_product(path):
            skipped += 1
            continue
        checked += 1
        if not (f.parent / path).exists():
            bad.append(f'{rel}: 链接目标不存在 -> {target}')

    for m in re.finditer(r'`([^`]*\.(?:md|py|ps1|txt|json))`', s):
        path = m.group(1).strip()
        if path.startswith(('http', '/')):
            continue
        if is_work_product(path):
            skipped += 1
            continue
        checked += 1
        if not (root / path).exists() and not (f.parent / path).exists():
            bad.append(f'{rel}: 反引号引用不存在 -> {path}')

print(f'仓库内引用校验: {checked} 处')
print(f'跳过的工作产物引用: {skipped} 处（由 skill 指导用户创建，不属于本仓库）')
if bad:
    print('\n发现问题：')
    for b in bad:
        print('  - ' + b)
    sys.exit(1)
print('\n所有仓库内部引用均有效')
