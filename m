Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4697DC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 03:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D8F421850
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 03:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573355362;
	bh=wOI/QU4y8qLszeihRbu28akQEhXLJhHGcVOEfMMH57o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AsJdFxjHGD38j0Sbj+oOBaW4JtuA5pLi64iW4IZ+7M95IWkV2CRGHUWpcP/pgw0bJ
	 Lnq+yOclwhwpXiDlN2E7Sjv9nDV53UrwuetVgjmvfCPjwQKeM7T9c1vIs8QGwTHJQi
	 5UK4O8lk5v6ttA4WoLCfIPnaaMuGfe2nx2KKq44s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbfKJCoj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 21:44:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:43328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728495AbfKJCoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 21:44:13 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2326F21655;
        Sun, 10 Nov 2019 02:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573353853;
        bh=wOI/QU4y8qLszeihRbu28akQEhXLJhHGcVOEfMMH57o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fLXqx1SqkC+mZKRDTpOyWXggLTmJ2GFEOy9ksbe/mJPqx0F6M0DAxRm/QzwGkLkEb
         WguJFMWAyztco2x/w/wU32+EuCe0Y5OvdSj81on/e40CQ3cfcLsULfE9v/364PYiuy
         jl8HElC4qdInaenxG7QCK98/NZO8Gu0JUCDflBkw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Stefan Agner <stefan@agner.ch>,
        Thierry Reding <treding@nvidia.com>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 138/191] ARM: dts: tegra20: restore address order
Date:   Sat,  9 Nov 2019 21:39:20 -0500
Message-Id: <20191110024013.29782-138-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191110024013.29782-1-sashal@kernel.org>
References: <20191110024013.29782-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

