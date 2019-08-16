Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45335C3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 20:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2185421726
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 20:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbfHPUyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 16:54:32 -0400
Received: from mailoutvs24.siol.net ([185.57.226.215]:38646 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727797AbfHPUya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 16:54:30 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 7C4FA522331;
        Fri, 16 Aug 2019 22:54:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id SfvfW7dd9v8E; Fri, 16 Aug 2019 22:54:28 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 27D0D52227B;
        Fri, 16 Aug 2019 22:54:28 +0200 (CEST)
Received: from localhost.localdomain (89-212-178-211.dynamic.t-2.net [89.212.178.211])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id DEF20522352;
        Fri, 16 Aug 2019 22:54:25 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     robh+dt@kernel.org, mark.rutland@arm.com, mripard@kernel.org,
        wens@csie.org
Cc:     jernej.skrabec@siol.net, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: allwinner: h6: Introduce Tanix TX6 board
Date:   Fri, 16 Aug 2019 22:53:42 +0200
Message-Id: <20190816205342.29552-3-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20190816205342.29552-1-jernej.skrabec@siol.net>
References: <20190816205342.29552-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tanix TX6 is an Allwinner H6 based TV box, which supports:
- Allwinner H6 Quad-core 64-bit ARM Cortex-A53
- GPU Mali-T720
- 4GiB DDR3 RAM (3GiB useable)
- 100Mbps EMAC via AC200 EPHY
- Cdtech 47822BS Wifi/BT
- 2x USB 2.0 Host and 1x USB 3.0 Host
- HDMI port
- IR receiver
- 64GiB eMMC
- 5V/2A DC power supply

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 arch/arm64/boot/dts/allwinner/Makefile        |   1 +
 .../dts/allwinner/sun50i-h6-tanix-tx6.dts     | 100 ++++++++++++++++++
 2 files changed, 101 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts

diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts=
/allwinner/Makefile
index f6db0611cb85..395fe76f6819 100644
--- a/arch/arm64/boot/dts/allwinner/Makefile
+++ b/arch/arm64/boot/dts/allwinner/Makefile
@@ -25,3 +25,4 @@ dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-orangepi-3.dtb
 dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-orangepi-lite2.dtb
 dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-orangepi-one-plus.dtb
 dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-pine-h64.dtb
+dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-tanix-tx6.dtb
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts b/arch=
/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
new file mode 100644
index 000000000000..7e7cb10e3d96
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+/*
+ * Copyright (c) 2019 Jernej Skrabec <jernej.skrabec@siol.net>
+ */
+
+/dts-v1/;
+
+#include "sun50i-h6.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	model =3D "Tanix TX6";
+	compatible =3D "oranth,tanix-tx6", "allwinner,sun50i-h6";
+
+	aliases {
+		serial0 =3D &uart0;
+	};
+
+	chosen {
+		stdout-path =3D "serial0:115200n8";
+	};
+
+	connector {
+		compatible =3D "hdmi-connector";
+		ddc-en-gpios =3D <&pio 7 2 GPIO_ACTIVE_HIGH>; /* PH2 */
+		type =3D "a";
+
+		port {
+			hdmi_con_in: endpoint {
+				remote-endpoint =3D <&hdmi_out_con>;
+			};
+		};
+	};
+
+	reg_vcc3v3: vcc3v3 {
+		compatible =3D "regulator-fixed";
+		regulator-name =3D "vcc3v3";
+		regulator-min-microvolt =3D <3300000>;
+		regulator-max-microvolt =3D <3300000>;
+	};
+};
+
+&de {
+	status =3D "okay";
+};
+
+&ehci0 {
+	status =3D "okay";
+};
+
+&ehci3 {
+	status =3D "okay";
+};
+
+&hdmi {
+	status =3D "okay";
+};
+
+&hdmi_out {
+	hdmi_out_con: endpoint {
+		remote-endpoint =3D <&hdmi_con_in>;
+	};
+};
+
+&mmc0 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&mmc0_pins>;
+	vmmc-supply =3D <&reg_vcc3v3>;
+	cd-gpios =3D <&pio 5 6 GPIO_ACTIVE_LOW>;
+	bus-width =3D <4>;
+	status =3D "okay";
+};
+
+&ohci0 {
+	status =3D "okay";
+};
+
+&ohci3 {
+	status =3D "okay";
+};
+
+&r_ir {
+	status =3D "okay";
+};
+
+&uart0 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&uart0_ph_pins>;
+	status =3D "okay";
+};
+
+&usb2otg {
+	dr_mode =3D "host";
+	status =3D "okay";
+};
+
+&usb2phy {
+	status =3D "okay";
+};
--=20
2.22.1

