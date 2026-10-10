# Commercial Font Builder · 商用字体构建器

> [English](README.md) | **简体中文**

一套可复用的 agent skill：从**设计简报**出发，开发一款**可安装、可商业交付**的桌面字体 —— 起点是字形设计，而不是现成的字体素材。

默认工作流面向**现代圆体拉丁字体**（含字母、数字与标点），编译为 TTF/OTF 并在 Windows 上验证。覆盖设计规格、代表字形、可编辑源文件管理、编译、字体表 QA、Windows 安装可见性，以及商业交付的完备性检查。

## 覆盖范围

- 字体设计简报与字形系统规则
- 现代圆体无衬线的度量与代表字形
- 拉丁字母、数字、标点、`.notdef` 与空格覆盖
- 可编辑源文件格式，如 UFO 或 FontForge 工程
- TTF/OTF 元数据与命名表要求
- 自动 QA 与目视 QA
- Windows 字体查看器、字库与 Word/WPS 可见性检查
- 命名、缓存、安装范围与缺字形问题的诊断
- 商业交付包结构、许可状态、版本与交接文档

## 仓库结构

```text
commercial-font-builder/
├── SKILL.md
├── README.md
├── README.zh-CN.md
├── LICENSE
├── references/
│   ├── design-brief-template.md
│   └── windows-validation.md
└── .gitignore
```

## 使用方式

把本目录放进你所用的 agent 环境支持的 skills 目录即可，或在配置 agent skill 时直接引用 `SKILL.md`。

本 skill **不包含任何字体二进制文件**，也**不授予任何生成字体的商业权利**。

按本 skill 创建的项目，应把源文件与生成产物分开存放：

```text
font-project/
├── source/
├── build/
├── specimens/
├── reports/
└── packaging/
```

## 环境要求

工作流可使用字体编辑器或编译器，例如 FontForge、UFO/FontTools 流程，或其它专业字体工具。自动检查可使用 FontTools、FontBakery、OTS Sanitizer 或同类工具。

最终的 Windows 安装与应用可见性验收测试**需要 Windows 环境**。

本 skill **不会静默安装或卸载字体**。安装范围必须显式声明，且在改变系统状态前需要用户确认。

## 商业与法律边界

**字体能编译或能安装，不等于它自动获得了商业许可。**

在销售或再分发字体之前，必须确认：字形归属、贡献者协议、第三方素材许可、字体家族名冲突、商标因素、嵌入权限，以及最终 EULA。

在上述检查完成之前，许可状态应标注为**待定**或**未核实**，不要声称已通过商业授权。

## 随附参考文档

- `references/design-brief-template.md`：项目简报、度量、风格系统、覆盖范围与发布门禁。
- `references/windows-validation.md`：Windows 安装范围、只读方式检查、应用刷新与故障排查。

## 许可

本 skill 仓库采用 **MIT License** 发布，详见 `LICENSE`。

**通过本工作流创建的字体，其许可属于该字体项目自身的决定**，必须在那个字体的交付包中单独记录。
