Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D89C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D24120869
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573214347;
	bh=IX5U8K8SuthgdC74NUur07uuuI6bV3BcP4bDwzbqvHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pFJigfC78kw+2Zq9dap6rvkErKa8+TRgZf0HCoaiVtQaBje1XOEfntZLiFXrHdovA
	 YJ+kAXE44AbLJDT3/l/2j9GLJhwvNQNz+C86zQ6zeFFj+53+FoMOmdvTwbuWqU9qv+
	 VcyHvUFaKbysWQpOG27k3RY5m4N1fd36kv7cV+R8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391109AbfKHL7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:59:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:59366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390769AbfKHLo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:44:27 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C99E222C2;
        Fri,  8 Nov 2019 11:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213466;
        bh=IX5U8K8SuthgdC74NUur07uuuI6bV3BcP4bDwzbqvHk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rZYMjEDAyvaRvPHqkpqhdpUDRA1TbTV9FEbcySLyIFAJ8p1FisHQ7dImLbuquaQjP
         rX5Az18ToGYbNYbhAmd6B46jD15aeGQv26+bHpzotOVe2SBqaAoWsGmoQ8BuqIO4UQ
         0YcfYPqrnNnJq/Z4SwQxSZqjYcEWJ5+Tp9bOUuTc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 052/103] ARM: dts: omap3-gta04: fix touchscreen tsc2007
Date:   Fri,  8 Nov 2019 06:42:17 -0500
Message-Id: <20191108114310.14363-52-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108114310.14363-1-sashal@kernel.org>
References: <20191108114310.14363-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H. Nikolaus Schaller" <hns@goldelico.com>

[ Upstream commit 7384a24248eda140a234d356b6c840701ee9f055 ]

we fix penirq polarity, add penirq pinmux and touchscreen
properties.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 7e9d6c4cdbfb6..11daca2f19c32 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -275,6 +275,13 @@
 			OMAP3_CORE1_IOPAD(0x2134, PIN_INPUT_PULLUP | MUX_MODE4) /* gpio112 */
 		>;
 	};
+
+	penirq_pins: pinmux_penirq_pins {
+		pinctrl-single,pins = <
+			/* here we could enable to wakeup the cpu from suspend by a pen touch */
+			OMAP3_CORE1_IOPAD(0x2194, PIN_INPUT_PULLUP | MUX_MODE4) /* gpio160 */
+		>;
+	};
 };
 
 &omap3_pmx_core2 {
@@ -412,10 +419,19 @@
 	tsc2007@48 {
 		compatible = "ti,tsc2007";
 		reg = <0x48>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&penirq_pins>;
 		interrupt-parent = <&gpio6>;
 		interrupts = <0 IRQ_TYPE_EDGE_FALLING>; /* GPIO_160 */
-		gpios = <&gpio6 0 GPIO_ACTIVE_LOW>;
+		gpios = <&gpio6 0 GPIO_ACTIVE_LOW>;	/* GPIO_160 */
 		ti,x-plate-ohms = <600>;
+		touchscreen-size-x = <480>;
+		touchscreen-size-y = <640>;
+		touchscreen-max-pressure = <1000>;
+		touchscreen-fuzz-x = <3>;
+		touchscreen-fuzz-y = <8>;
+		touchscreen-fuzz-pressure = <10>;
+		touchscreen-inverted-y;
 	};
 
 	/* RFID EEPROM */
-- 
2.20.1

