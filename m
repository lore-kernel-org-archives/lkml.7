Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D82CA9EB7
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 18:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35F9C214B2
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 18:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571681122;
	bh=yyOjELTdxm8vdGtIFPCxeWArh8Xp5R+LNwJC8tsWNvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FZm+F4lC3smol1FYjkOCcS/qeyHTVtPDfUZRVT5TLyt2UhLqeEPJjfTjhJWtENSyH
	 gxBpNsMgs+pee4MT9djTI1oyzTC1mDjOHMbdwZwjg0rgZ0ut0+/HWkBDQB8oGrGxF8
	 MnUmbU0LuEOgl6omTzcTTbhpkLCExBanY+ZcV6uc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730025AbfJUSFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 14:05:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:38118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729968AbfJUSFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 14:05:19 -0400
Received: from localhost.localdomain (unknown [194.230.155.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A40C320B7C;
        Mon, 21 Oct 2019 18:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571681118;
        bh=yyOjELTdxm8vdGtIFPCxeWArh8Xp5R+LNwJC8tsWNvU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w7f4CyiASL+Bl/+jvR3zVUL6MZbNCB+OEZHkmr2+mWTx8G47qgwDmnBA+fF88xrci
         c6PKJ7G8N/bnaG+l0yHQQ0ddfbQj/AZTNu9nk95FZNfc0jL47B0o5KLg0lnyguoH5i
         5qjvwklsFAF4bwg83H3dMPBBjaZNlpPK6izHBA3k=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL 4/5] ARM: dts: exynos: Stuff for v5.5
Date:   Mon, 21 Oct 2019 20:04:51 +0200
Message-Id: <20191021180453.29455-4-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191021180453.29455-1-krzk@kernel.org>
References: <20191021180453.29455-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-5.5

for you to fetch changes up to d60d0cff4ab01255b25375425745c3cff69558ad:

  ARM: dts: s3c64xx: Fix init order of clock providers (2019-10-08 22:45:20 +0200)

----------------------------------------------------------------
Samsung DTS ARM changes for v5.5

1. Add ARM architected timers on Exynos5 for KVM-based virtualization,
2. Extend chip identification needed for future Adaptive Supply Voltage,
3. Add audio support to Arndale board,
4. Fix init order of clock providers on s3c64xx,
5. A lot of cleanups and adjustments of DTS with DT schema.

----------------------------------------------------------------
Krzysztof Kozlowski (8):
      ARM: dts: exynos: Rename Multi Core Timer node to "timer"
      ARM: dts: exynos: Remove MCT subnode for interrupt map on Exynos4210
      ARM: dts: exynos: Remove MCT subnode for interrupt map on Exynos4412
      ARM: dts: exynos: Remove MCT subnode for interrupt map on Exynos5250
      ARM: dts: exynos: Remove MCT subnode for interrupt map on Exynos54xx
      ARM: dts: exynos: Use defines for MCT interrupt GIC SPI/PPI specifier
      ARM: dts: exynos: Rename power domain nodes to "power-domain" in Exynos4
      ARM: dts: exynos: Rename SysRAM node to "sram"

Lihua Yao (1):
      ARM: dts: s3c64xx: Fix init order of clock providers

Maciej Falkowski (2):
      ARM: dts: exynos: Remove obsolete IRQ lines on Exynos3250
      ARM: dts: exynos: Split phandle in dmas property

Marek Szyprowski (1):
      ARM: dts: exynos: Add support ARM architected timers on Exynos5

Sylwester Nawrocki (3):
      ARM: dts: exynos: Add "syscon" compatible string to chipid node on Exynos5
      ARM: dts: exynos: Add samsung,asv-bin property to Odroid XU3 Lite
      ARM: dts: exynos: Add audio support (WM1811 CODEC boards) to Arndale board

 arch/arm/boot/dts/exynos3250.dtsi               | 13 +++----
 arch/arm/boot/dts/exynos4.dtsi                  | 14 ++++----
 arch/arm/boot/dts/exynos4210.dtsi               | 27 +++++----------
 arch/arm/boot/dts/exynos4412.dtsi               | 25 +++++---------
 arch/arm/boot/dts/exynos5.dtsi                  |  4 +--
 arch/arm/boot/dts/exynos5250-arndale.dts        | 27 ++++++++++++++-
 arch/arm/boot/dts/exynos5250.dtsi               | 41 ++++++++--------------
 arch/arm/boot/dts/exynos5260.dtsi               |  2 +-
 arch/arm/boot/dts/exynos5410.dtsi               |  6 ++--
 arch/arm/boot/dts/exynos5420-peach-pit.dts      |  4 +++
 arch/arm/boot/dts/exynos5420.dtsi               | 14 ++++----
 arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts |  4 +++
 arch/arm/boot/dts/exynos54xx.dtsi               | 46 ++++++++++++-------------
 arch/arm/boot/dts/exynos5800-peach-pi.dts       |  4 +++
 arch/arm/boot/dts/s3c6410-mini6410.dts          |  4 +++
 arch/arm/boot/dts/s3c6410-smdk6410.dts          |  4 +++
 16 files changed, 126 insertions(+), 113 deletions(-)
