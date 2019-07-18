Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 247F9C76192
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB0F321841
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563419457;
	bh=ElbY87/cBdf+A34uzf/e+nNtoHIbclwI6a8oA0mWftg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=siIwpJpU8/6nJ79/3FBOl/LSjlMGBcAM3rfaNmYNULTssj3H1DwGgXfAzqAAtnqr2
	 5A8m1IS6FruavME2Q0QPU15WCxGDWlNOb9SIaNMGWm9SYtIg/f2QbraEKpKFTv43XL
	 OwZcVU529Yz4b7nYAhIDI9dVQxpssasuO+Exz7Ig=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391229AbfGRDKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 23:10:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:44276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390438AbfGRDKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 23:10:50 -0400
Received: from localhost (115.42.148.210.bf.2iij.net [210.148.42.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5D73205F4;
        Thu, 18 Jul 2019 03:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563419450;
        bh=ElbY87/cBdf+A34uzf/e+nNtoHIbclwI6a8oA0mWftg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MHHXjk2otd/o5PaqRmS5blKc1ja4qIdQ91YgDozZzk1WtYSO7dslQjhL7sLEydZAW
         qrSJuorEAskK13engmVH26Iu0IgSunBpHX2GFUvtPD3obDz7ATxCBpmf6R8JoeGl3F
         FL4VuYoJOfgVFTtxm6Nid79edK4f/jAKBOeHu6gQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?S=C3=A9bastien=20Szymanski?= 
        <sebastien.szymanski@armadeus.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 69/80] ARM: dts: imx6ul: fix PWM[1-4] interrupts
Date:   Thu, 18 Jul 2019 12:02:00 +0900
Message-Id: <20190718030103.959302646@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190718030058.615992480@linuxfoundation.org>
References: <20190718030058.615992480@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 3cf10132ac8d536565f2c02f60a3aeb315863a52 ]

According to the i.MX6UL/L RM, table 3.1 "ARM Cortex A7 domain interrupt
summary", the interrupts for the PWM[1-4] go from 83 to 86.

Fixes: b9901fe84f02 ("ARM: dts: imx6ul: add pwm[1-4] nodes")
Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx6ul.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 036aeba4f02c..49f4bdc0d864 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -342,7 +342,7 @@
 			pwm1: pwm@02080000 {
 				compatible = "fsl,imx6ul-pwm", "fsl,imx27-pwm";
 				reg = <0x02080000 0x4000>;
-				interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6UL_CLK_PWM1>,
 					 <&clks IMX6UL_CLK_PWM1>;
 				clock-names = "ipg", "per";
@@ -353,7 +353,7 @@
 			pwm2: pwm@02084000 {
 				compatible = "fsl,imx6ul-pwm", "fsl,imx27-pwm";
 				reg = <0x02084000 0x4000>;
-				interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6UL_CLK_PWM2>,
 					 <&clks IMX6UL_CLK_PWM2>;
 				clock-names = "ipg", "per";
@@ -364,7 +364,7 @@
 			pwm3: pwm@02088000 {
 				compatible = "fsl,imx6ul-pwm", "fsl,imx27-pwm";
 				reg = <0x02088000 0x4000>;
-				interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6UL_CLK_PWM3>,
 					 <&clks IMX6UL_CLK_PWM3>;
 				clock-names = "ipg", "per";
@@ -375,7 +375,7 @@
 			pwm4: pwm@0208c000 {
 				compatible = "fsl,imx6ul-pwm", "fsl,imx27-pwm";
 				reg = <0x0208c000 0x4000>;
-				interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6UL_CLK_PWM4>,
 					 <&clks IMX6UL_CLK_PWM4>;
 				clock-names = "ipg", "per";
-- 
2.20.1



