Return-Path: <SRS0=64FT=XQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13363C4360D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 17:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE18A20820
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 17:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569085334;
	bh=r0Q4VB/j5PL/rgZkRPpQzQ1S0oUxFSc3euGBv7t4Az4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lqHB63esLucgjDD9Ejwcqig44Am4FqNn8+4pfYtH9zVEh9CynGZNXh+VwMoL8+Ux0
	 pziRM8wPk/5j9aXP2FZlytXGoukbxKzInErP50jMBlQSwsHVI3MPRztTjqwqRwT131
	 9VrTYHvjzHVrelECU4mH3oBZP8IH+xeGG546Lu0s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438365AbfIURCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Sep 2019 13:02:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:39654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438031AbfIURCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 13:02:11 -0400
Received: from localhost.localdomain (unknown [194.230.155.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CCB321907;
        Sat, 21 Sep 2019 17:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569085330;
        bh=r0Q4VB/j5PL/rgZkRPpQzQ1S0oUxFSc3euGBv7t4Az4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iyOhYRg0R5F0iOR+PFexeovw1dm3Y/lUP4Q6QAZvnyIAqXwpcBmHP0xwaLEuvkjie
         UAVvBK183DtsynyHXphvY3hl3WhaJnqB5jJI8U99dHNVaE2TcfDe68pRR9W6f9Qt1u
         dQjam3/1D0HS0sUCYVuVLWYkaKR/w19AxQgYecv8=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: [PATCH v3 3/8] arm64: dts: exynos: Rename Multi Core Timer node to "timer"
Date:   Sat, 21 Sep 2019 19:01:47 +0200
Message-Id: <20190921170152.5033-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190921170152.5033-1-krzk@kernel.org>
References: <20190921170152.5033-1-krzk@kernel.org>
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

