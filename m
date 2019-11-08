Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3499BFA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B8C020656
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573215251;
	bh=vFmPq7PNhXDOpLhB/RDsLsk5lYZk6ybGv47b1LMINsk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d5b4slafXzmChXOeTTL1UmR2ANZjj6RbNdOQ98lEtOpps721MM5BeycEVfvKjPPF/
	 ycs9+hnoM4Cn2z6m/YY7JpWcsbvi8d5hlyXguJQiUlqAjaZYtPgqpCx8ekoCzNC8mt
	 Was1UQhUBSyFzLaNMSmQWWBbJaxToSeDHVCeXpzM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732336AbfKHLiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:38:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:51052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732217AbfKHLiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:38:11 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 959F220869;
        Fri,  8 Nov 2019 11:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213090;
        bh=vFmPq7PNhXDOpLhB/RDsLsk5lYZk6ybGv47b1LMINsk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tgINtxYdzVMrAmHQxRLki+8aaTHqlPAO5qLAYjl3jiIq0NePqRYciVW2pOhWG1Ot0
         Q90J+Safv3Zc724GEl/T4AXYil0TlV8AQfrymxoeQpDpt65ifKsqPit+mN7ziZF8PZ
         VNfRQJWO4B3Snu5YNqqeQ43pL+PKfnFMvytPUIHk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Sasha Levin <sashal@kernel.org>, linux-sh@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 015/205] ARM: dts: rcar: Correct SATA device sizes to 2 MiB
Date:   Fri,  8 Nov 2019 06:34:42 -0500
Message-Id: <20191108113752.12502-15-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108113752.12502-1-sashal@kernel.org>
References: <20191108113752.12502-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 441f61e3aa9e7386731ce1405044d484bd81f911 ]

Update the SATA device nodes on R-Car H1, H2, and M2-W to use a 2 MiB
I/O space, as specified in Rev.1.0 of the R-Car H1 and R-Car Gen2
hardware user manuals.

See also commit e9f0089b2d8a3d45 ("arm64: dts: r8a7795: Correct SATA
device size to 2MiB").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/r8a7779.dtsi | 2 +-
 arch/arm/boot/dts/r8a7790.dtsi | 4 ++--
 arch/arm/boot/dts/r8a7791.dtsi | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index 6b997bc016ee8..03919714645ae 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -344,7 +344,7 @@
 
 	sata: sata@fc600000 {
 		compatible = "renesas,sata-r8a7779", "renesas,rcar-sata";
-		reg = <0xfc600000 0x2000>;
+		reg = <0xfc600000 0x200000>;
 		interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7779_CLK_SATA>;
 		power-domains = <&sysc R8A7779_PD_ALWAYS_ON>;
diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 0925bdca438fe..52a757f47bf08 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -1559,7 +1559,7 @@
 		sata0: sata@ee300000 {
 			compatible = "renesas,sata-r8a7790",
 				     "renesas,rcar-gen2-sata";
-			reg = <0 0xee300000 0 0x2000>;
+			reg = <0 0xee300000 0 0x200000>;
 			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 815>;
 			power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
@@ -1570,7 +1570,7 @@
 		sata1: sata@ee500000 {
 			compatible = "renesas,sata-r8a7790",
 				     "renesas,rcar-gen2-sata";
-			reg = <0 0xee500000 0 0x2000>;
+			reg = <0 0xee500000 0 0x200000>;
 			interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 814>;
 			power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 991ac6feedd5b..25b6a99dd87a2 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -1543,7 +1543,7 @@
 		sata0: sata@ee300000 {
 			compatible = "renesas,sata-r8a7791",
 				     "renesas,rcar-gen2-sata";
-			reg = <0 0xee300000 0 0x2000>;
+			reg = <0 0xee300000 0 0x200000>;
 			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 815>;
 			power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
@@ -1554,7 +1554,7 @@
 		sata1: sata@ee500000 {
 			compatible = "renesas,sata-r8a7791",
 				     "renesas,rcar-gen2-sata";
-			reg = <0 0xee500000 0 0x2000>;
+			reg = <0 0xee500000 0 0x200000>;
 			interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 814>;
 			power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
-- 
2.20.1

