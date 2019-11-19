Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 277E7C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8BE6208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574142049;
	bh=wOI/QU4y8qLszeihRbu28akQEhXLJhHGcVOEfMMH57o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ssOQAP2M+sPxNHmxv566DFo6iXtaWFiRyBSxY+oyHpm66pPrrnkimdnwMXLi05V7O
	 Rj589ioTBwAXp1L9EQqDWPuLVkZ+2l9PBiV6CDlsn3DJYxYtiC9ShnnTftmgZzBuFe
	 wlYhO9fg0jhMiXbBS9HTcJJAUDfHzxuvJYOIajUg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729242AbfKSFkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:40:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:34932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730433AbfKSFkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:40:42 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 216A7208C3;
        Tue, 19 Nov 2019 05:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574142041;
        bh=wOI/QU4y8qLszeihRbu28akQEhXLJhHGcVOEfMMH57o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pjZb1LKKQtq6PiaeU7ayZptuewuwJwwtorcryuJB+UXToDLWYRPVj3a256XzfCUEB
         19O5w7EaFgvbv4ApSYduKr6N3mFObJ3tbse/KYEDW3ym3OoDyKCXkdqpz+T/MRG+Oz
         vxTLFCr93uBDX+ikUFM06dPTh94cOHlhVd5/A1TI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Stefan Agner <stefan@agner.ch>,
        Thierry Reding <treding@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 369/422] ARM: dts: tegra20: restore address order
Date:   Tue, 19 Nov 2019 06:19:26 +0100
Message-Id: <20191119051422.923914109@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051400.261610025@linuxfoundation.org>
References: <20191119051400.261610025@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

[ Upstream commit 8188391c127ea34d66f37eda6755d0acb51dc600 ]

Commit 6c468f109884 ("ARM: dts: tegra: add Tegra20 NAND flash
controller node") introduced the nand-controller node. However, it got
added at the wrong spot not honoring the address order. Fix this.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Reviewed-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/tegra20.dtsi | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 15b73bd377f04..80854f7de765c 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -419,19 +419,6 @@
 		status = "disabled";
 	};
 
-	gmi@70009000 {
-		compatible = "nvidia,tegra20-gmi";
-		reg = <0x70009000 0x1000>;
-		#address-cells = <2>;
-		#size-cells = <1>;
-		ranges = <0 0 0xd0000000 0xfffffff>;
-		clocks = <&tegra_car TEGRA20_CLK_NOR>;
-		clock-names = "gmi";
-		resets = <&tegra_car 42>;
-		reset-names = "gmi";
-		status = "disabled";
-	};
-
 	nand-controller@70008000 {
 		compatible = "nvidia,tegra20-nand";
 		reg = <0x70008000 0x100>;
@@ -447,6 +434,19 @@
 		status = "disabled";
 	};
 
+	gmi@70009000 {
+		compatible = "nvidia,tegra20-gmi";
+		reg = <0x70009000 0x1000>;
+		#address-cells = <2>;
+		#size-cells = <1>;
+		ranges = <0 0 0xd0000000 0xfffffff>;
+		clocks = <&tegra_car TEGRA20_CLK_NOR>;
+		clock-names = "gmi";
+		resets = <&tegra_car 42>;
+		reset-names = "gmi";
+		status = "disabled";
+	};
+
 	pwm: pwm@7000a000 {
 		compatible = "nvidia,tegra20-pwm";
 		reg = <0x7000a000 0x100>;
-- 
2.20.1



