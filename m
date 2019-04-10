Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9819BC10F0E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 01:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70F032084B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 01:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbfDJBAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 21:00:31 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37485 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfDJBA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 21:00:29 -0400
Received: by mail-qk1-f194.google.com with SMTP id c1so225805qkk.4;
        Tue, 09 Apr 2019 18:00:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:organization:content-transfer-encoding;
        bh=jq7hHP6jp0qx7y15AyPUxCIeyvtpHQfds1gjSWmikM4=;
        b=L3omCm7V8zfwdzd6v9r9/4lNo7NbPvFIrioSrBEcOPH0fgCXOsbLKTAUAzfAaWxVoR
         bhu4gH4DwrkCHdz6v0taL02xEG4se+iX4wJapTDmPIIpkXkKJ5iBLHcZlSkWieHaeszA
         fTB45T4hP+4SubLw5TZOsU0HoyT+s4g+oW3asIAmuJz3HbwHl5VWTiSQfn+BoUlH+b9C
         mxXVOw3jLan0UBMa9A2G/UIDiH5bnELXpeyNLIFH28DzoNIyKq65RPr9ZOS2zVDeFAqP
         dEGOfWIXrl/fXdsJIIK5dW2hcselhWUjZ5g/MF5h6iSnsmqz8iLWVH5j1EHjodAmMNXo
         yCwQ==
X-Gm-Message-State: APjAAAWV1JtDmfewqkArggkp8+4mezVDfhfmQnLRnnj/rMB86+BGJGg/
        u/jNn31bEW0C2WVZ2MN9ruU=
X-Google-Smtp-Source: APXvYqzjZXw8saYM5fqGbOi+yI+8dNAO6Z2elMTB0SFMoeyA83p9gganz4zRhjQRotg0wP/kbEc6uw==
X-Received: by 2002:a37:a5d8:: with SMTP id o207mr31579738qke.0.1554858028423;
        Tue, 09 Apr 2019 18:00:28 -0700 (PDT)
Received: from localhost.localdomain ([177.194.197.186])
        by smtp.gmail.com with ESMTPSA id t34sm27741683qth.36.2019.04.09.18.00.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 18:00:27 -0700 (PDT)
Received: by localhost.localdomain (sSMTP sendmail emulation); Tue, 09 Apr 2019 22:00:21 -0300
From:   Otavio Salvador <otavio@ossystems.com.br>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Fabio Estevam <festevam@gmail.com>,
        Otavio Salvador <otavio@ossystems.com.br>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 2/2] ARM: dts: imx6ul-pico: Add support for the nymph baseboard
Date:   Tue,  9 Apr 2019 22:00:13 -0300
Message-Id: <20190410010013.17259-2-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190410010013.17259-1-otavio@ossystems.com.br>
References: <20190410010013.17259-1-otavio@ossystems.com.br>
MIME-Version: 1.0
Organization: O.S. Systems Software LTDA.
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabio Estevam <festevam@gmail.com>

Add support for the imx6ul pico board with nymph baseboard combination.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

 arch/arm/boot/dts/Makefile              |  1 +
 arch/arm/boot/dts/imx6ul-pico-nymph.dts | 77 +++++++++++++++++++++++++
 2 files changed, 78 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6ul-pico-nymph.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index e4a2349e130e..7b9b3d384902 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -568,6 +568,7 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
 	imx6ul-opos6uldev.dtb \
 	imx6ul-pico-dwarf.dtb \
 	imx6ul-pico-hobbit.dtb \
+	imx6ul-pico-nymph.dtb \
 	imx6ul-pico-pi.dtb \
 	imx6ul-phytec-phyboard-segin-full.dtb \
 	imx6ul-tx6ul-0010.dtb \
diff --git a/arch/arm/boot/dts/imx6ul-pico-nymph.dts b/arch/arm/boot/dts/imx6ul-pico-nymph.dts
new file mode 100644
index 000000000000..cb5ec45341bc
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ul-pico-nymph.dts
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+//
+// Copyright 2015 Technexion Ltd.
+//
+// Author: Wig Cheng  <wig.cheng@technexion.com>
+//	   Richard Hu <richard.hu@technexion.com>
+//	   Tapani Utriainen <tapani@technexion.com>
+/dts-v1/;
+
+#include "imx6ul-pico.dtsi"
+/ {
+	model = "TechNexion PICO-IMX6UL and NYMPH baseboard";
+	compatible = "technexion,imx6ul-pico-nymph", "fsl,imx6ul";
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_leds>;
+
+		led {
+			label = "gpio-led";
+			gpios = <&gpio1 29 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	sound {
+		compatible = "fsl,imx-audio-sgtl5000";
+		model = "imx6ul-sgtl5000";
+		audio-cpu = <&sai1>;
+		audio-codec = <&sgtl5000>;
+		audio-routing =
+			"LINE_IN", "Line In Jack",
+			"MIC_IN", "Mic Jack",
+			"Mic Jack", "Mic Bias",
+			"Headphone Jack", "HP_OUT";
+	};
+
+	sys_mclk: clock-sys-mclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24576000>;
+	};
+};
+
+&i2c2 {
+	clock_frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "okay";
+
+	sgtl5000: codec@a {
+		reg = <0x0a>;
+		compatible = "fsl,sgtl5000";
+		clocks = <&sys_mclk>;
+		VDDA-supply = <&reg_2p5v>;
+		VDDIO-supply = <&reg_3p3v>;
+	};
+
+	adc081c: adc@52 {
+		compatible = "ti,adc081c";
+		reg = <0x52>;
+		vref-supply = <&reg_2p5v>;
+	};
+
+	ds1337: rtc@68 {
+		compatible = "dallas,ds1337";
+		reg = <0x68>;
+	};
+};
+
+&iomuxc {
+	pinctrl_gpio_leds: gpioledsgrp {
+		fsl,pins = <
+			MX6UL_PAD_UART4_RX_DATA__GPIO1_IO29	0x10b0
+		>;
+	};
+};
-- 
2.21.0

