Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13B2C31E5E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 19:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 824C520B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 19:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560884762;
	bh=eYXtQ/oGmgo79qNHT8e57iHbj8Bqvh6OPJHen49rwPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vbPSs8+RCf1ByKb1egNAvlwrAOZahQXAQBxMprB2YIRfW7y6U7P4187+LPbG67EbX
	 8jd2D6zetV/YIzs1HkK4xLjlo6TVtjyOjcURJ6OX+c4fYpjEWnNJcV9Y/sv6Eb1Fyt
	 ELelBGSMgcOv6cgXmkXFKgbuNowT9Cxfsd63MUts=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730562AbfFRTGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 15:06:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:40852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730484AbfFRTGB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 15:06:01 -0400
Received: from localhost.localdomain (unknown [194.230.155.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0672B214AF;
        Tue, 18 Jun 2019 19:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560884760;
        bh=eYXtQ/oGmgo79qNHT8e57iHbj8Bqvh6OPJHen49rwPs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LoR2BgJI4mpckuhNnepofMTjo6LIUCbE1k79OExnkxys0upkPWlCCX9V6k+9BcS2p
         Uhr2k3D/CAaWoIjwNItMWX/FKKZkhkByPY4mBZZ3CsRkSI8L94xp2G063J1Mt4BFMZ
         5NK9xPGCT9ee8zzjupGBzNo00LT1iamXHP5kr1m4=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Olof Johansson <olof@lixom.net>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     Joseph Kogut <joseph.kogut@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [RFT 03/10] ARM: dts: exynos: Fix language typo and indentation
Date:   Tue, 18 Jun 2019 21:05:27 +0200
Message-Id: <20190618190534.4951-4-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190618190534.4951-1-krzk@kernel.org>
References: <20190618190534.4951-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct language typo and wrong indentation.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos4210.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index b491c345b2e8..ea0e043cd2b4 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -8,7 +8,7 @@
  *		www.linaro.org
  *
  * Samsung's Exynos4210 SoC device nodes are listed in this file. Exynos4210
- * based board files can include this file and provide values for board specfic
+ * based board files can include this file and provide values for board specific
  * bindings.
  *
  * Note: This file does not include device nodes for all the controllers in
@@ -381,13 +381,13 @@
 
 			trips {
 				cpu_alert0: cpu-alert-0 {
-				temperature = <85000>; /* millicelsius */
+					temperature = <85000>; /* millicelsius */
 				};
 				cpu_alert1: cpu-alert-1 {
-				temperature = <100000>; /* millicelsius */
+					temperature = <100000>; /* millicelsius */
 				};
 				cpu_alert2: cpu-alert-2 {
-				temperature = <110000>; /* millicelsius */
+					temperature = <110000>; /* millicelsius */
 				};
 			};
 		};
-- 
2.17.1

