Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EEF8CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 22:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E9EF205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 22:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436866AbfJWWoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 18:44:19 -0400
Received: from gloria.sntech.de ([185.11.138.130]:57476 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436833AbfJWWoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 18:44:18 -0400
Received: from ip5f5a6266.dynamic.kabel-deutschland.de ([95.90.98.102] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iNPMX-0004JL-5g; Thu, 24 Oct 2019 00:44:17 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        christoph.muellner@theobroma-systems.com,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH] arm64: dts: rockchip: remove px30 default optee node
Date:   Thu, 24 Oct 2019 00:44:09 +0200
Message-Id: <20191023224409.3550-1-heiko@sntech.de>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having a default optee node in a soc devicetree is not really good.
For one there is no guarantee that any tee got loaded and there's even
the possibility that a completely different TEE got loaded.

OP-Tee however will insert relevant nodes to the devicetree (firmware
+reserved memory sections) during its own startup, so there really is
no need to provide a default node.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/boot/dts/rockchip/px30.dtsi | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/px30.dtsi b/arch/arm64/boot/dts/rockchip/px30.dtsi
index 767f3ce6e9f7..5ab281bb40a4 100644
--- a/arch/arm64/boot/dts/rockchip/px30.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30.dtsi
@@ -161,13 +161,6 @@
 		status = "disabled";
 	};
 
-	firmware {
-		optee {
-			compatible = "linaro,optee-tz";
-			method = "smc";
-		};
-	};
-
 	gmac_clkin: external-gmac-clock {
 		compatible = "fixed-clock";
 		clock-frequency = <50000000>;
-- 
2.23.0

