Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E5A5C282DD
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 19:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74BF720896
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 19:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfDGThl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 15:37:41 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42455 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfDGThk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 15:37:40 -0400
Received: by mail-qt1-f193.google.com with SMTP id p20so13038268qtc.9;
        Sun, 07 Apr 2019 12:37:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:organization:content-transfer-encoding;
        bh=1pDGZipmO8DgkqgzegwfzZu1Dp4wUFl4SoA4H9PeyXc=;
        b=EMma0kQ21bogGcq4LcMvz331jnTr46y0reyjL1cyjoJ3NQgVWhA9OCE+zVGCu9g4LV
         6MxtPx7ep+oAw/mD0f1AK8L/VD+2F9wAxUNoeIuUTlqiZ5T0OF0Ftg0W89jldirsnJzs
         gUmjduuLtoKvD6+2+EDWTxw45CX+dUH96+86qOmfG6RTS7YuHhbjcE+w0XHA8MNKTv1G
         OEx3Lpk3Ox6w3uZKgG79p5FyvNAGrQeJctzUwHFn7e459+Ofd90bWQa9IJ1Etk7muxlI
         Ym+l8ntCa8wIJRhUmg1mrkI7M6xJe1t0n0XCtkf1r2cuXK0UpqzkyXK9Q2LHJ1AIp/0g
         d4Ow==
X-Gm-Message-State: APjAAAUEZaJKO2j5MxZv06VGDJvWIxazaibj0JfL7eUBvQy4ResHxAvm
        /BXr9P57Zpr4loucs0MWGO0=
X-Google-Smtp-Source: APXvYqyBTMJVpgjBUafqxVS11lBmfNZg1qgiTRg+W36mTLduJE8mIU9tAUERubwTnmaCJcqr24zHFg==
X-Received: by 2002:a0c:afce:: with SMTP id t14mr20059982qvc.147.1554665859599;
        Sun, 07 Apr 2019 12:37:39 -0700 (PDT)
Received: from localhost.localdomain ([177.194.204.148])
        by smtp.gmail.com with ESMTPSA id q50sm19076202qtq.34.2019.04.07.12.37.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Apr 2019 12:37:38 -0700 (PDT)
Received: by localhost.localdomain (sSMTP sendmail emulation); Sun, 07 Apr 2019 16:37:32 -0300
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
Subject: [PATCH 2/2] ARM: dts: imx6ul-pico: Add support for the dwarf baseboard
Date:   Sun,  7 Apr 2019 16:37:23 -0300
Message-Id: <20190407193723.3351-2-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190407193723.3351-1-otavio@ossystems.com.br>
References: <20190407193723.3351-1-otavio@ossystems.com.br>
MIME-Version: 1.0
Organization: O.S. Systems Software LTDA.
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabio Estevam <festevam@gmail.com>

Add support for the imx6ul pico board with dwarf baseboard combination.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

 arch/arm/boot/dts/Makefile              |  1 +
 arch/arm/boot/dts/imx6ul-pico-dwarf.dts | 52 +++++++++++++++++++++++++
 2 files changed, 53 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6ul-pico-dwarf.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index a969ca820d41..e4a2349e130e 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -566,6 +566,7 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
 	imx6ul-isiot-nand.dtb \
 	imx6ul-liteboard.dtb \
 	imx6ul-opos6uldev.dtb \
+	imx6ul-pico-dwarf.dtb \
 	imx6ul-pico-hobbit.dtb \
 	imx6ul-pico-pi.dtb \
 	imx6ul-phytec-phyboard-segin-full.dtb \
diff --git a/arch/arm/boot/dts/imx6ul-pico-dwarf.dts b/arch/arm/boot/dts/imx6ul-pico-dwarf.dts
new file mode 100644
index 000000000000..3edd60f46d37
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ul-pico-dwarf.dts
@@ -0,0 +1,52 @@
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
+	model = "TechNexion PICO-IMX6UL and DWARF baseboard";
+	compatible = "technexion,imx6ul-pico-dwarf", "fsl,imx6ul";
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
+	pressure-sensor@60 {
+		compatible = "fsl,mpl3115";
+		reg = <0x60>;
+	};
+};
-- 
2.21.0

