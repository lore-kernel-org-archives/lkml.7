Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A91C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B1C62086A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568996707;
	bh=r0Q4VB/j5PL/rgZkRPpQzQ1S0oUxFSc3euGBv7t4Az4=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kjlUVW4oat3tEmFOanF1VsdvYfKK3f4xrReAksc2bZzi2UqYmca/aDRgPU9u7LjwT
	 ksR8rF50DS2fzVDarM7D7X+4Zul1rGtNFMxXGtKHnc+eUf0vYKMtl1kOozgKRkW7UQ
	 NLu9JwSzSl7WAOfzEeiQ1qHJtLKllVUCDInmph9g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393641AbfITQZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 12:25:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:43268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388479AbfITQZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 12:25:04 -0400
Received: from localhost.localdomain (unknown [194.230.155.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C057208C0;
        Fri, 20 Sep 2019 16:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568996704;
        bh=r0Q4VB/j5PL/rgZkRPpQzQ1S0oUxFSc3euGBv7t4Az4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=EeauKISn3XTY7h2mK8ciT18hLAcp6T//K9mDk0nLPYHS/5uhaCHsroOMs6niZEKk3
         YzSGC3EhzzlooZ1puJqs5dVD1GVS2B6wDU0Yh/4umNgotzRJvNP3Ghnwj2Jrn7PLaw
         Z7s0SC2ir3XDpxVlHzskMmDyeCdlgbLTDhOCcgQI=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: exynos: Rename Multi Core Timer node to just timer
Date:   Fri, 20 Sep 2019 18:24:56 +0200
Message-Id: <20190920162456.7294-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190920162456.7294-1-krzk@kernel.org>
References: <20190920162456.7294-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device node name should reflect generic class of a device so rename
the Multi Core Timer node from "mct" to "timer".  This will be also in
sync with upcoming DT schema.  No functional change.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index a76f620f7f35..8baf3c645eae 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -754,7 +754,7 @@
 			status = "disabled";
 		};
 
-		mct@101c0000 {
+		timer@101c0000 {
 			compatible = "samsung,exynos4210-mct";
 			reg = <0x101c0000 0x800>;
 			interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.17.1

