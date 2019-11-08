Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C41FFA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 121692085B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573214635;
	bh=3R1O+2sefDUBuO2KrxNRutCSxBn0BF/KyQKfUA/8QQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2OTJKTzuB7Ng9y9422EBiUVt0QCGOHcWKx4QVrFhMVfJgUzSTWBfb6i0vN1NiYI4V
	 FDxsifD+nvAUtIiNnvHUFXxCfYomU3reL0UU4M2f6B9Lq9lHHmC1bTjFHyjrowwfmO
	 6STD1hQwQNhGoERUSAy2VGQ9rOZc5WfV99pe1zJY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391590AbfKHMDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 07:03:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:56538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390040AbfKHLme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:42:34 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3E93222C5;
        Fri,  8 Nov 2019 11:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213353;
        bh=3R1O+2sefDUBuO2KrxNRutCSxBn0BF/KyQKfUA/8QQE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h+t6PNKaSH0k4ywBttqLBwyLX9XJPN8ubG3z+zPROr1GK3oHOZEarrRIA4jfWxu3/
         FQViyZiw6tHGkRMsEWBxZnxCD3M2sp/T9LCEj2X8CturUvT4E+RHPrJRL+w0iUyx+K
         wdy1p6SNqy7jGSjbb2tXHhjRXFDJCvaO7M+/yGt0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Sasha Levin <sashal@kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 184/205] ARM: dts: sunxi: Fix I2C bus warnings
Date:   Fri,  8 Nov 2019 06:37:31 -0500
Message-Id: <20191108113752.12502-184-sashal@kernel.org>
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

From: Rob Herring <robh@kernel.org>

[ Upstream commit 0729b4af5753b65aa031f58c435da53dbbf56d19 ]

dtc has new checks for I2C buses. Fix the warnings in unit-addresses.

arch/arm/boot/dts/sun8i-a23-gt90h-v4.dtb: Warning (i2c_bus_reg): /soc@1c00000/i2c@1c2ac00/touchscreen@0: I2C bus unit address format error, expected "40"
arch/arm/boot/dts/sun8i-a23-inet86dz.dtb: Warning (i2c_bus_reg): /soc@1c00000/i2c@1c2ac00/touchscreen@0: I2C bus unit address format error, expected "40"
arch/arm/boot/dts/sun8i-a23-polaroid-mid2407pxe03.dtb: Warning (i2c_bus_reg): /soc@1c00000/i2c@1c2ac00/touchscreen@0: I2C bus unit address format error, expected "40"
arch/arm/boot/dts/sun8i-a23-polaroid-mid2809pxe04.dtb: Warning (i2c_bus_reg): /soc@1c00000/i2c@1c2ac00/touchscreen@0: I2C bus unit address format error, expected "40"
arch/arm/boot/dts/sun8i-a33-ga10h-v1.1.dtb: Warning (i2c_bus_reg): /soc@1c00000/i2c@1c2ac00/touchscreen@0: I2C bus unit address format error, expected "40"
arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dtb: Warning (i2c_bus_reg): /soc@1c00000/i2c@1c2ac00/touchscreen@0: missing or empty reg property
arch/arm/boot/dts/sun8i-a33-ippo-q8h-v1.2.dtb: Warning (i2c_bus_reg): /soc@1c00000/i2c@1c2ac00/touchscreen@0: missing or empty reg property
arch/arm/boot/dts/sun8i-a33-q8-tablet.dtb: Warning (i2c_bus_reg): /soc@1c00000/i2c@1c2ac00/touchscreen@0: missing or empty reg property
arch/arm/boot/dts/sun5i-a13-utoo-p66.dtb: Warning (i2c_bus_reg): /soc@1c00000/i2c@1c2b000/touchscreen: I2C bus unit address format error, expected "40"
arch/arm/boot/dts/sun5i-a13-difrnce-dit4350.dtb: Warning (i2c_bus_reg): /soc@1c00000/i2c@1c2b000/touchscreen: missing or empty reg property
arch/arm/boot/dts/sun5i-a13-empire-electronix-m712.dtb: Warning (i2c_bus_reg): /soc@1c00000/i2c@1c2b000/touchscreen: missing or empty reg property
arch/arm/boot/dts/sun5i-a13-inet-98v-rev2.dtb: Warning (i2c_bus_reg): /soc@1c00000/i2c@1c2b000/touchscreen: missing or empty reg property
arch/arm/boot/dts/sun5i-a13-q8-tablet.dtb: Warning (i2c_bus_reg): /soc@1c00000/i2c@1c2b000/touchscreen: missing or empty reg property

Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi | 3 ++-
 arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi | 3 ++-
 arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts    | 2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi b/arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi
index 8acbaab14fe51..d2a2eb8b3f262 100644
--- a/arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi
+++ b/arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi
@@ -92,7 +92,8 @@
 	 */
 	clock-frequency = <400000>;
 
-	touchscreen: touchscreen {
+	touchscreen: touchscreen@40 {
+		reg = <0x40>;
 		interrupt-parent = <&pio>;
 		interrupts = <6 11 IRQ_TYPE_EDGE_FALLING>; /* EINT11 (PG11) */
 		pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi b/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
index 880096c7e2523..5e8a95af89b8c 100644
--- a/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
+++ b/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
@@ -69,7 +69,8 @@
 	 */
 	clock-frequency = <400000>;
 
-	touchscreen: touchscreen@0 {
+	touchscreen: touchscreen@40 {
+		reg = <0x40>;
 		interrupt-parent = <&pio>;
 		interrupts = <1 5 IRQ_TYPE_EDGE_FALLING>; /* PB5 */
 		pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts b/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
index 35859d8f3267f..bf97f6244c233 100644
--- a/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
+++ b/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
@@ -95,7 +95,7 @@
 &i2c0 {
 	status = "okay";
 
-	axp22x: pmic@68 {
+	axp22x: pmic@34 {
 		compatible = "x-powers,axp221";
 		reg = <0x34>;
 		interrupt-parent = <&nmi_intc>;
-- 
2.20.1

