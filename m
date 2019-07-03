Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2928BC06510
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 02:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0397921873
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 02:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562120253;
	bh=hvo/xJWIFxCzX48Eui0bjmsddf11dWAUfzIV7B+b+hA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vwnuPsIVuOw1V30MAw8+QutdhuJVOX3M4hzrNMeFidIY52MczN+FKRdoGiYDrMLhZ
	 NectZ9s+m+ooVhXcAUAeM8wyX7GxMbr0ujt/wIGQ7vwfTRCehN3/jyxaagiu8wSUdc
	 Mr+5IQPXuwYJ9cI0G63TDDmt0jYZftoHeTkT+XJs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbfGCCQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 22:16:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:55140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728028AbfGCCQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 22:16:44 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 571EC21882;
        Wed,  3 Jul 2019 02:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562120204;
        bh=hvo/xJWIFxCzX48Eui0bjmsddf11dWAUfzIV7B+b+hA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C2OCtXW+E1QtiHRD1kgPOYqbKgGCLx6pXbX5BMbmF1ZmUl7ikH7D6j32dz0hfqNKG
         iwI1t3gjJDOIG0g5SADXmKrOrqwjJdCg7dgiGA0XMT4edEqxe2olngFzzqsex0oKk4
         mGtOuEtj3TxfRQllKXzZooB5a5Tj5UDXtsfqM1Nw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?S=C3=A9bastien=20Szymanski?= 
        <sebastien.szymanski@armadeus.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 14/26] ARM: dts: imx6ul: fix PWM[1-4] interrupts
Date:   Tue,  2 Jul 2019 22:16:13 -0400
Message-Id: <20190703021625.18116-14-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190703021625.18116-1-sashal@kernel.org>
References: <20190703021625.18116-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sébastien Szymanski <sebastien.szymanski@armadeus.com>

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
index 2366f093cc76..336cdead3da5 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -359,7 +359,7 @@
 			pwm1: pwm@2080000 {
 				compatible = "fsl,imx6ul-pwm", "fsl,imx27-pwm";
 				reg = <0x02080000 0x4000>;
-				interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6UL_CLK_PWM1>,
 					 <&clks IMX6UL_CLK_PWM1>;
 				clock-names = "ipg", "per";
@@ -370,7 +370,7 @@
 			pwm2: pwm@2084000 {
 				compatible = "fsl,imx6ul-pwm", "fsl,imx27-pwm";
 				reg = <0x02084000 0x4000>;
-				interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6UL_CLK_PWM2>,
 					 <&clks IMX6UL_CLK_PWM2>;
 				clock-names = "ipg", "per";
@@ -381,7 +381,7 @@
 			pwm3: pwm@2088000 {
 				compatible = "fsl,imx6ul-pwm", "fsl,imx27-pwm";
 				reg = <0x02088000 0x4000>;
-				interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6UL_CLK_PWM3>,
 					 <&clks IMX6UL_CLK_PWM3>;
 				clock-names = "ipg", "per";
@@ -392,7 +392,7 @@
 			pwm4: pwm@208c000 {
 				compatible = "fsl,imx6ul-pwm", "fsl,imx27-pwm";
 				reg = <0x0208c000 0x4000>;
-				interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6UL_CLK_PWM4>,
 					 <&clks IMX6UL_CLK_PWM4>;
 				clock-names = "ipg", "per";
-- 
2.20.1

