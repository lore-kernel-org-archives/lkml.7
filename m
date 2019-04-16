Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E55C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 044B420652
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="MouFGr/c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729927AbfDPPBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 11:01:03 -0400
Received: from mout.gmx.net ([212.227.17.20]:45893 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbfDPPBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 11:01:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1555426749;
        bh=cmq3uTCvNem4hMhZFbGqISt7XCnjnlr87tqFEthDUxc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=MouFGr/c4CTHWqfu4yfrraeajvLikZEZwMBnpVz9p052qM7L7JAGkG/5Ffnai5wwh
         XdXvSM+Be2rbduNr546iIWvqYSI9Cgyj+Co8GjDCICWErjVkG0MzYMdf5czTrPou5a
         XLYXT5ieeMnqT6JMB2qUZNJgo5cEyYYbs6HP+iQA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([185.53.43.193]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0Mg0IT-1hSB8S09sT-00NRtT; Tue, 16 Apr 2019 16:59:09 +0200
From:   Frank Wunderlich <frank-w@public-files.de>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, chunhui dai <chunhui.dai@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>
Cc:     Frank Wunderlich <frank-w@public-files.de>
Subject: [PATCH v1 2/4] arm: dts: mt7623: add display subsystem related device nodes
Date:   Tue, 16 Apr 2019 16:58:46 +0200
Message-Id: <20190416145848.11932-3-frank-w@public-files.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190416145848.11932-1-frank-w@public-files.de>
References: <20190416145848.11932-1-frank-w@public-files.de>
X-Provags-ID: V03:K1:xeru4vEJ5OWBm6t9PohoLIQO9YX/PIsODiQ2AJirGabJJ+r5ntM
 mTQPLEmIrmT4fohcsGVQeIm03nx+mlF5JXmI7ZgLrXVnwQj81NwDtCjjFXguQicPmEWX3Q9
 DYU+EVkdOd7go/bdMbHlsBix6sd8FemfReFMo6PoCxgXSqjrYdLJyYLERplM4ELc2JuhfSV
 ifbpQvxltyYdUMzIJz1BQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/FyxCRLIKfs=:KRERBqrBKFgNPtbtHAdCIR
 djcqnLFI0KtjIfCgKs93O3zUggavtjNS/m2xYtCAi0Ta2yXWqzE3JqfWy38ftXw/ON8eYPnXp
 JnRay9gDmBqPp2QxFL3r8WfFGoEcnMoFsvoP18dllPSV1JW96Q1Y11x8jvhtMuW53zIWTppAo
 pbk283hHhzvw5nz9+G1BhQWBg5Qab5rpIE8ahanQqenEbK41JQWsL/mF5zvNdPP0abrb4ycoi
 HhViTARGBKoo9qUHNTbXQH9a7etfbN1SdLXpwZ9EuV4Z/sqQN2U6+dS16WK7jMirmHVwetnZf
 BKS8dmyfwhoaP6nFA5TJMRZUKnkobLxgyl7mEo39ZVxa9k5UZspqpisFONjH4cx3L6EOFJc+Z
 wFXl7OMR3PcQpzU6W8Sw92fEpACMA6L6wTTv9fnGDh0vfLNs+72Y3lXmEYbL61kbgdJwDN6+p
 +03WbwaMxmYjPv/5kh64B2kJpAHPtCbetmagX8e6Ga7HQEdw9UmHfqClfDlX39726C4AM3GBm
 KsSQObaCcswPA5xOTK2Q3rHgCiQ6kCT6a9kFcI6xK93Z9DQtqmOpJ9kc18TtPEJe8nh6dk0Iz
 KrkMaYTSB+HwwsLTdReTLFduuon2lc0xlvzWvWW5vjry9wiYlr+KuOd+IfpPy6Tp2yuKVa+im
 Rafly169Q4IznLdGICPEgH7PuEsL+l10ynqLNu4bg+Jq3kCpvG7yAqWkObIgEn8Lss2C7h/3S
 iE/enmUWtnf85RiVB0kcrWWFushCLsfUeQr6TDs1qYRaRqCD1vTYApVrUrIwma3DF3XcP1nyo
 v6HX2jmc7H35ae/WRyJhKdOKbFea+Z0MbwMZn75hnskBEHp1nsGhRt9D5ef7NSXZY6ExC4BW/
 sEv2zHU6C73I0+6K2YpQj/y4IjD7qpGHzUtJYglSLpPp7kASqvcLf3Xfn/FVoG
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ryder Lee <ryder.lee@mediatek.com>

Add display subsystem related device nodes for MT7623.

Cc: CK Hu <ck.hu@mediatek.com>
Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>
Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>

additional fixes:

[hdmi,dts] fixed dts-warnings
author: Bibby Hsieh <bibby.hsieh@mediatek.com>

[dtsi] fix dpi0-node
author: Ryder Lee <ryder.lee@mediatek.com>

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
Tested-by: Frank Wunderlich <frank-w@public-files.de>
=2D--
 arch/arm/boot/dts/mt7623.dtsi                 | 177 ++++++++++++++++++
 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts |  85 +++++++++
 arch/arm/boot/dts/mt7623n-rfb-emmc.dts        |  85 +++++++++
 3 files changed, 347 insertions(+)

diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
index 59e69f3dffa2..f1880ff04193 100644
=2D-- a/arch/arm/boot/dts/mt7623.dtsi
+++ b/arch/arm/boot/dts/mt7623.dtsi
@@ -23,6 +23,11 @@
 	#address-cells =3D <2>;
 	#size-cells =3D <2>;

+	aliases {
+		rdma0 =3D &rdma0;
+		rdma1 =3D &rdma1;
+	};
+
 	cpu_opp_table: opp-table {
 		compatible =3D "operating-points-v2";
 		opp-shared;
@@ -320,6 +325,25 @@
 		clock-names =3D "spi", "wrap";
 	};

+	mipi_tx0: mipi-dphy@10010000 {
+		compatible =3D "mediatek,mt7623-mipi-tx",
+			     "mediatek,mt2701-mipi-tx";
+		reg =3D <0 0x10010000 0 0x90>;
+		clocks =3D <&clk26m>;
+		clock-output-names =3D "mipi_tx0_pll";
+		#clock-cells =3D <0>;
+		#phy-cells =3D <0>;
+	};
+
+	cec: cec@10012000 {
+		compatible =3D "mediatek,mt7623-cec",
+			     "mediatek,mt8173-cec";
+		reg =3D <0 0x10012000 0 0xbc>;
+		interrupts =3D <GIC_SPI 182 IRQ_TYPE_LEVEL_LOW>;
+		clocks =3D <&infracfg CLK_INFRA_CEC>;
+		status =3D "disabled";
+	};
+
 	cir: cir@10013000 {
 		compatible =3D "mediatek,mt7623-cir";
 		reg =3D <0 0x10013000 0 0x1000>;
@@ -368,6 +392,18 @@
 		#clock-cells =3D <1>;
 	};

+	hdmi_phy: phy@10209100 {
+		compatible =3D "mediatek,mt7623-hdmi-phy",
+			     "mediatek,mt2701-hdmi-phy";
+		reg =3D <0 0x10209100 0 0x24>;
+		clocks =3D <&apmixedsys CLK_APMIXED_HDMI_REF>;
+		clock-names =3D "pll_ref";
+		clock-output-names =3D "hdmitx_dig_cts";
+		#clock-cells =3D <0>;
+		#phy-cells =3D <0>;
+		status =3D "disabled";
+	};
+
 	rng: rng@1020f000 {
 		compatible =3D "mediatek,mt7623-rng";
 		reg =3D <0 0x1020f000 0 0x1000>;
@@ -567,6 +603,16 @@
 		status =3D "disabled";
 	};

+	hdmiddc0: i2c@11013000 {
+		compatible =3D "mediatek,mt7623-hdmi-ddc",
+			     "mediatek,mt8173-hdmi-ddc";
+		interrupts =3D <GIC_SPI 81 IRQ_TYPE_LEVEL_LOW>;
+		reg =3D <0 0x11013000 0 0x1C>;
+		clocks =3D <&pericfg CLK_PERI_I2C3>;
+		clock-names =3D "ddc-i2c";
+		status =3D "disabled";
+	};
+
 	nor_flash: spi@11014000 {
 		compatible =3D "mediatek,mt7623-nor",
 			     "mediatek,mt8173-nor";
@@ -741,6 +787,84 @@
 		#clock-cells =3D <1>;
 	};

+	display_components: dispsys@14000000 {
+		compatible =3D "mediatek,mt7623-mmsys",
+			     "mediatek,mt2701-mmsys";
+		reg =3D <0 0x14000000 0 0x1000>;
+		power-domains =3D <&scpsys MT2701_POWER_DOMAIN_DISP>;
+	};
+
+	ovl@14007000 {
+		compatible =3D "mediatek,mt7623-disp-ovl",
+			     "mediatek,mt2701-disp-ovl";
+		reg =3D <0 0x14007000 0 0x1000>;
+		interrupts =3D <GIC_SPI 153 IRQ_TYPE_LEVEL_LOW>;
+		clocks =3D <&mmsys CLK_MM_DISP_OVL>;
+		iommus =3D <&iommu MT2701_M4U_PORT_DISP_OVL_0>;
+		mediatek,larb =3D <&larb0>;
+	};
+
+	rdma0: rdma@14008000 {
+		compatible =3D "mediatek,mt7623-disp-rdma",
+			     "mediatek,mt2701-disp-rdma";
+		reg =3D <0 0x14008000 0 0x1000>;
+		interrupts =3D <GIC_SPI 152 IRQ_TYPE_LEVEL_LOW>;
+		clocks =3D <&mmsys CLK_MM_DISP_RDMA>;
+		iommus =3D <&iommu MT2701_M4U_PORT_DISP_RDMA>;
+		mediatek,larb =3D <&larb0>;
+	};
+
+	wdma@14009000 {
+		compatible =3D "mediatek,mt7623-disp-wdma",
+			     "mediatek,mt2701-disp-wdma";
+		reg =3D <0 0x14009000 0 0x1000>;
+		interrupts =3D <GIC_SPI 154 IRQ_TYPE_LEVEL_LOW>;
+		clocks =3D <&mmsys CLK_MM_DISP_WDMA>;
+		iommus =3D <&iommu MT2701_M4U_PORT_DISP_WDMA>;
+		mediatek,larb =3D <&larb0>;
+	};
+
+	bls: pwm@1400a000 {
+		compatible =3D "mediatek,mt7623-disp-pwm",
+			     "mediatek,mt2701-disp-pwm";
+		reg =3D <0 0x1400a000 0 0x1000>;
+		#pwm-cells =3D <2>;
+		clocks =3D <&mmsys CLK_MM_MDP_BLS_26M>,
+			 <&mmsys CLK_MM_DISP_BLS>;
+		clock-names =3D "main", "mm";
+		status =3D "disabled";
+	};
+
+	color@1400b000 {
+		compatible =3D "mediatek,mt7623-disp-color",
+			     "mediatek,mt2701-disp-color";
+		reg =3D <0 0x1400b000 0 0x1000>;
+		interrupts =3D <GIC_SPI 156 IRQ_TYPE_LEVEL_LOW>;
+		clocks =3D <&mmsys CLK_MM_DISP_COLOR>;
+	};
+
+	dsi: dsi@1400c000 {
+		compatible =3D "mediatek,mt7623-dsi",
+			     "mediatek,mt2701-dsi";
+		reg =3D <0 0x1400c000 0 0x1000>;
+		interrupts =3D <GIC_SPI 157 IRQ_TYPE_LEVEL_LOW>;
+		clocks =3D <&mmsys CLK_MM_DSI_ENGINE>,
+			 <&mmsys CLK_MM_DSI_DIG>,
+			 <&mipi_tx0>;
+		clock-names =3D "engine", "digital", "hs";
+		phys =3D <&mipi_tx0>;
+		phy-names =3D "dphy";
+		status =3D "disabled";
+	};
+
+	mutex: mutex@1400e000 {
+		compatible =3D "mediatek,mt7623-disp-mutex",
+			     "mediatek,mt2701-disp-mutex";
+		reg =3D <0 0x1400e000 0 0x1000>;
+		interrupts =3D <GIC_SPI 161 IRQ_TYPE_LEVEL_LOW>;
+		clocks =3D <&mmsys CLK_MM_MUTEX_32K>;
+	};
+
 	larb0: larb@14010000 {
 		compatible =3D "mediatek,mt7623-smi-larb",
 			     "mediatek,mt2701-smi-larb";
@@ -753,6 +877,44 @@
 		power-domains =3D <&scpsys MT2701_POWER_DOMAIN_DISP>;
 	};

+	rdma1: rdma@14012000 {
+		compatible =3D "mediatek,mt7623-disp-rdma",
+			     "mediatek,mt2701-disp-rdma";
+		reg =3D <0 0x14012000 0 0x1000>;
+		interrupts =3D <GIC_SPI 164 IRQ_TYPE_LEVEL_LOW>;
+		clocks =3D <&mmsys CLK_MM_DISP_RDMA1>;
+		iommus =3D <&iommu MT2701_M4U_PORT_DISP_RDMA1>;
+		mediatek,larb =3D <&larb0>;
+	};
+
+	dpi0: dpi@14014000 {
+		compatible =3D "mediatek,mt7623-dpi",
+			     "mediatek,mt2701-dpi";
+		reg =3D <0 0x14014000 0 0x1000>;
+		interrupts =3D <GIC_SPI 194 IRQ_TYPE_LEVEL_LOW>;
+		clocks =3D <&mmsys CLK_MM_DPI1_DIGL>,
+			 <&mmsys CLK_MM_DPI1_ENGINE>,
+			 <&apmixedsys CLK_APMIXED_TVDPLL>;
+		clock-names =3D "pixel", "engine", "pll";
+		status =3D "disabled";
+	};
+
+	hdmi0: hdmi@14015000 {
+		compatible =3D "mediatek,mt7623-hdmi",
+			     "mediatek,mt8173-hdmi";
+		reg =3D <0 0x14015000 0 0x400>;
+		clocks =3D <&mmsys CLK_MM_HDMI_PIXEL>,
+			 <&mmsys CLK_MM_HDMI_PLL>,
+			 <&mmsys CLK_MM_HDMI_AUDIO>,
+			 <&mmsys CLK_MM_HDMI_SPDIF>;
+		clock-names =3D "pixel", "pll", "bclk", "spdif";
+		phys =3D <&hdmi_phy>;
+		phy-names =3D "hdmi";
+		mediatek,syscon-hdmi =3D <&mmsys 0x900>;
+		cec =3D <&cec>;
+		status =3D "disabled";
+	};
+
 	imgsys: syscon@15000000 {
 		compatible =3D "mediatek,mt7623-imgsys",
 			     "mediatek,mt2701-imgsys",
@@ -1077,6 +1239,21 @@
 		};
 	};

+	hdmi_pins_a: hdmi-default {
+		pins-hdmi {
+			pinmux =3D <MT7623_PIN_123_HTPLG_FUNC_HTPLG>;
+			input-enable;
+			bias-pull-down;
+		};
+	};
+
+	hdmi_ddc_pins_a: hdmi_ddc-default {
+		pins-hdmi-ddc {
+			pinmux =3D <MT7623_PIN_124_GPIO124_FUNC_HDMISCK>,
+				 <MT7623_PIN_125_GPIO125_FUNC_HDMISD>;
+		};
+	};
+
 	i2c0_pins_a: i2c0-default {
 		pins-i2c0 {
 			pinmux =3D <MT7623_PIN_75_SDA0_FUNC_SDA0>,
diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts b/arch/arm/boot=
/dts/mt7623n-bananapi-bpi-r2.dts
index 2b760f90f38c..7a1763472018 100644
=2D-- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
+++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
@@ -21,6 +21,19 @@
 		stdout-path =3D "serial2:115200n8";
 	};

+	connector {
+		compatible =3D "hdmi-connector";
+		label =3D "hdmi";
+		type =3D "d";
+		ddc-i2c-bus =3D <&hdmiddc0>;
+
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint =3D <&hdmi0_out>;
+			};
+		};
+	};
+
 	cpus {
 		cpu@0 {
 			proc-supply =3D <&mt6323_vproc_reg>;
@@ -114,10 +127,24 @@
 	};
 };

+&bls {
+	status =3D "okay";
+
+	port {
+		bls_out: endpoint {
+			remote-endpoint =3D <&dpi0_in>;
+		};
+	};
+};
+
 &btif {
 	status =3D "okay";
 };

+&cec {
+	status =3D "okay";
+};
+
 &cir {
 	pinctrl-names =3D "default";
 	pinctrl-0 =3D <&cir_pins_a>;
@@ -128,6 +155,28 @@
 	status =3D "okay";
 };

+&dpi0 {
+	status =3D "okay";
+
+	ports {
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+		port@0 {
+			reg =3D <0>;
+			dpi0_out: endpoint {
+				remote-endpoint =3D <&hdmi0_in>;
+			};
+		};
+
+		port@1 {
+			reg =3D <1>;
+			dpi0_in: endpoint {
+				remote-endpoint =3D <&bls_out>;
+			};
+		};
+	};
+};
+
 &eth {
 	status =3D "okay";

@@ -199,6 +248,42 @@
 	};
 };

+&hdmi0 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&hdmi_pins_a>;
+	status =3D "okay";
+
+	ports {
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+		port@0 {
+			reg =3D <0>;
+			hdmi0_in: endpoint {
+				remote-endpoint =3D <&dpi0_out>;
+			};
+		};
+
+		port@1 {
+			reg =3D <1>;
+			hdmi0_out: endpoint {
+				remote-endpoint =3D <&hdmi_connector_in>;
+			};
+		};
+	};
+};
+
+&hdmiddc0 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&hdmi_ddc_pins_a>;
+	status =3D "okay";
+};
+
+&hdmi_phy {
+	mediatek,ibias =3D <0xa>;
+	mediatek,ibias_up =3D <0x1c>;
+	status =3D "okay";
+};
+
 &i2c0 {
 	pinctrl-names =3D "default";
 	pinctrl-0 =3D <&i2c0_pins_a>;
diff --git a/arch/arm/boot/dts/mt7623n-rfb-emmc.dts b/arch/arm/boot/dts/mt=
7623n-rfb-emmc.dts
index b7606130ade9..3e5911d8d6bc 100644
=2D-- a/arch/arm/boot/dts/mt7623n-rfb-emmc.dts
+++ b/arch/arm/boot/dts/mt7623n-rfb-emmc.dts
@@ -24,6 +24,19 @@
 		stdout-path =3D "serial2:115200n8";
 	};

+	connector {
+		compatible =3D "hdmi-connector";
+		label =3D "hdmi";
+		type =3D "d";
+		ddc-i2c-bus =3D <&hdmiddc0>;
+
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint =3D <&hdmi0_out>;
+			};
+		};
+	};
+
 	cpus {
 		cpu@0 {
 			proc-supply =3D <&mt6323_vproc_reg>;
@@ -106,10 +119,24 @@
 	};
 };

+&bls {
+	status =3D "okay";
+
+	port {
+		bls_out: endpoint {
+			remote-endpoint =3D <&dpi0_in>;
+		};
+	};
+};
+
 &btif {
 	status =3D "okay";
 };

+&cec {
+	status =3D "okay";
+};
+
 &cir {
 	pinctrl-names =3D "default";
 	pinctrl-0 =3D <&cir_pins_a>;
@@ -120,6 +147,28 @@
 	status =3D "okay";
 };

+&dpi0 {
+	status =3D "okay";
+
+	ports {
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+		port@0 {
+			reg =3D <0>;
+			dpi0_out: endpoint {
+				remote-endpoint =3D <&hdmi0_in>;
+			};
+		};
+
+		port@1 {
+			reg =3D <1>;
+			dpi0_in: endpoint {
+				remote-endpoint =3D <&bls_out>;
+			};
+		};
+	};
+};
+
 &eth {
 	status =3D "okay";

@@ -202,6 +251,42 @@
 	};
 };

+&hdmi0 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&hdmi_pins_a>;
+	status =3D "okay";
+
+	ports {
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+		port@0 {
+			reg =3D <0>;
+			hdmi0_in: endpoint {
+				remote-endpoint =3D <&dpi0_out>;
+			};
+		};
+
+		port@1 {
+			reg =3D <1>;
+			hdmi0_out: endpoint {
+				remote-endpoint =3D <&hdmi_connector_in>;
+			};
+		};
+	};
+};
+
+&hdmiddc0 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&hdmi_ddc_pins_a>;
+	status =3D "okay";
+};
+
+&hdmi_phy {
+	mediatek,ibias =3D <0xa>;
+	mediatek,ibias_up =3D <0x1c>;
+	status =3D "okay";
+};
+
 &i2c0 {
 	pinctrl-names =3D "default";
 	pinctrl-0 =3D <&i2c0_pins_a>;
=2D-
2.17.1

