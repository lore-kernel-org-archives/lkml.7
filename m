Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F00C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 05:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 195F720833
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 05:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554700814;
	bh=j6KenvNaaKfLy4DmoL4CCShplQcOAxZcX8KqAsmeeOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZZS2Ddvd2Tc3LPy1tGJ8C5d0z+6KzHwVXyDWRDSXk2PUgSFffgDjtktA60KlFbI0T
	 O91XNZ7A09ZjlcwTjhQTYeW2ccJBQNEQ0JKTkPYy6ikpUId1thnkkAYDg/KG/tsoX6
	 FzmdwLH9JCl+hCixwhWRrYs3xnY+5lzA9TrgS9k8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfDHFTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 01:19:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:39672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbfDHFTp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 01:19:45 -0400
Received: from kozik-book.CAR-A-WANv3.local (unknown [83.137.6.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A354208E4;
        Mon,  8 Apr 2019 05:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554700784;
        bh=j6KenvNaaKfLy4DmoL4CCShplQcOAxZcX8KqAsmeeOo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y1NehTUr1VOjE4n1L/xotv6e7JP5TD2vXDLDK63B3wptcldTkVaMp/Ry4H7UqxAiN
         sX4yvtdBUxHb8EEsF6ILnoSQIEsbIRXhVJqJBc5sF0LEAjsGJCZD2BIl6VqtL9617G
         ifF/BehV1pw2o0d76UuIe0AcTuhLcDGnghcjQzFM=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     notify@kernel.org, Sylwester Nawrocki <snawrocki@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 2/2] ARM: dts: exynos: Remove console argument from bootargs
Date:   Mon,  8 Apr 2019 07:19:26 +0200
Message-Id: <20190408051926.462-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190408051926.462-1-krzk@kernel.org>
References: <20190408051926.462-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the "console=ttySAC..." argument from DTSes having a proper
stdout-path property.  To make the code functionally equivalent, add the
serial port baud rate and parity.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos4210-origen.dts         | 4 ++--
 arch/arm/boot/dts/exynos4210-smdkv310.dts       | 4 ++--
 arch/arm/boot/dts/exynos4210-trats.dts          | 4 ++--
 arch/arm/boot/dts/exynos4210-universal_c210.dts | 4 ++--
 arch/arm/boot/dts/exynos4412-origen.dts         | 3 +--
 arch/arm/boot/dts/exynos4412-smdk4412.dts       | 4 ++--
 6 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4210-origen.dts b/arch/arm/boot/dts/exynos4210-origen.dts
index dd9ec05eb0f7..36b1edea254a 100644
--- a/arch/arm/boot/dts/exynos4210-origen.dts
+++ b/arch/arm/boot/dts/exynos4210-origen.dts
@@ -30,8 +30,8 @@
 	};
 
 	chosen {
-		bootargs ="root=/dev/ram0 rw ramdisk=8192 initrd=0x41000000,8M console=ttySAC2,115200 init=/linuxrc";
-		stdout-path = &serial_2;
+		bootargs = "root=/dev/ram0 rw ramdisk=8192 initrd=0x41000000,8M init=/linuxrc";
+		stdout-path = "serial2:115200n8";
 	};
 
 	mmc_reg: voltage-regulator {
diff --git a/arch/arm/boot/dts/exynos4210-smdkv310.dts b/arch/arm/boot/dts/exynos4210-smdkv310.dts
index 7a3e621edede..77fc11e593ad 100644
--- a/arch/arm/boot/dts/exynos4210-smdkv310.dts
+++ b/arch/arm/boot/dts/exynos4210-smdkv310.dts
@@ -26,8 +26,8 @@
 	};
 
 	chosen {
-		bootargs = "root=/dev/ram0 rw ramdisk=8192 initrd=0x41000000,8M console=ttySAC1,115200 init=/linuxrc";
-		stdout-path = &serial_1;
+		bootargs = "root=/dev/ram0 rw ramdisk=8192 initrd=0x41000000,8M init=/linuxrc";
+		stdout-path = "serial1:115200n8";
 	};
 
 	fixed-rate-clocks {
diff --git a/arch/arm/boot/dts/exynos4210-trats.dts b/arch/arm/boot/dts/exynos4210-trats.dts
index 8dbc47d627a5..6882480dbaf7 100644
--- a/arch/arm/boot/dts/exynos4210-trats.dts
+++ b/arch/arm/boot/dts/exynos4210-trats.dts
@@ -26,8 +26,8 @@
 	};
 
 	chosen {
-		bootargs = "console=ttySAC2,115200N8 root=/dev/mmcblk0p5 rootwait earlyprintk panic=5";
-		stdout-path = &serial_2;
+		bootargs = "root=/dev/mmcblk0p5 rootwait earlyprintk panic=5";
+		stdout-path = "serial2:115200n8";
 	};
 
 	regulators {
diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts b/arch/arm/boot/dts/exynos4210-universal_c210.dts
index 5c3d98654f13..07d64a8f82e3 100644
--- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
+++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
@@ -24,8 +24,8 @@
 	};
 
 	chosen {
-		bootargs = "console=ttySAC2,115200N8 root=/dev/mmcblk0p5 rw rootwait earlyprintk panic=5 maxcpus=1";
-		stdout-path = &serial_2;
+		bootargs = "root=/dev/mmcblk0p5 rw rootwait earlyprintk panic=5 maxcpus=1";
+		stdout-path = "serial2:115200n8";
 	};
 
 
diff --git a/arch/arm/boot/dts/exynos4412-origen.dts b/arch/arm/boot/dts/exynos4412-origen.dts
index 346f71932457..698de4345d16 100644
--- a/arch/arm/boot/dts/exynos4412-origen.dts
+++ b/arch/arm/boot/dts/exynos4412-origen.dts
@@ -25,8 +25,7 @@
 	};
 
 	chosen {
-		bootargs ="console=ttySAC2,115200";
-		stdout-path = &serial_2;
+		stdout-path = "serial2:115200n8";
 	};
 
 	firmware@203f000 {
diff --git a/arch/arm/boot/dts/exynos4412-smdk4412.dts b/arch/arm/boot/dts/exynos4412-smdk4412.dts
index 5c5c2887c14f..e70fb6e601f0 100644
--- a/arch/arm/boot/dts/exynos4412-smdk4412.dts
+++ b/arch/arm/boot/dts/exynos4412-smdk4412.dts
@@ -23,8 +23,8 @@
 	};
 
 	chosen {
-		bootargs ="root=/dev/ram0 rw ramdisk=8192 initrd=0x41000000,8M console=ttySAC1,115200 init=/linuxrc";
-		stdout-path = &serial_1;
+		bootargs = "root=/dev/ram0 rw ramdisk=8192 initrd=0x41000000,8M init=/linuxrc";
+		stdout-path = "serial1:115200n8";
 	};
 
 	fixed-rate-clocks {
-- 
2.17.1

