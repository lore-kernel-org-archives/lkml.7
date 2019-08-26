Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5A9C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 15:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE86A20874
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 15:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733142AbfHZPjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 11:39:03 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35956 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733067AbfHZPiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 11:38:51 -0400
Received: by mail-wr1-f65.google.com with SMTP id r3so15790010wrt.3;
        Mon, 26 Aug 2019 08:38:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sdNLZLbUZjioU3Z4lRpuQbaNIysXdv9lDzhe4Q5gJwU=;
        b=CfCocCWMwTszwFAeiQHIpRu1PjqDEExNjixAjIeiZZ1uRRMQEl0xka9egM+Kqw+5zf
         UdDuDXIDMT8ky3fgkh23UbAwnHxUvL2CiGjZaqBuTvFXcx9AG/Eq01MR4b1STngL33NE
         M79+zZdSkChVCgv9FM8JjPJCbJkW9vOMxfmInaOjw2aG94F/yYQcjyWloNJYVbWR/lGZ
         8/DA5oy3irqO+ETOp4/PtvSdAcKeAS49y7TfHA4qvMwLAFjj7pPTL1kj8djgI6jnw9k1
         qMMPrDTlmz1KCtsAtgMdZH7cjOCpP1RCoXq9w7wk9COxTc/5cbujVE4Pxsq0bfbLNsRP
         CsKA==
X-Gm-Message-State: APjAAAVkt7DmxK2TIg2QMIHRqkDrLHiMLRMZ/QPhZ+lvnz7h4qy2MP7C
        5yaRnOvo5F7/w1OfAuVLErPhwvRLtwc=
X-Google-Smtp-Source: APXvYqyupufwIm7Jbil3XGdUZ6YsobfUaIlznuBm6oZ9/FZv+zEyI9GMPHplQrpOf0n27DVXhf+4PA==
X-Received: by 2002:adf:fd8b:: with SMTP id d11mr22079526wrr.300.1566833929706;
        Mon, 26 Aug 2019 08:38:49 -0700 (PDT)
Received: from 1aq-andre.garage.tyco.com ([77.107.218.170])
        by smtp.gmail.com with ESMTPSA id z8sm11580798wru.13.2019.08.26.08.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 08:38:49 -0700 (PDT)
From:   =?UTF-8?q?Andr=C3=A9=20Draszik?= <git@andred.net>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Andr=C3=A9=20Draszik?= <git@andred.net>,
        Ilya Ledvich <ilya@compulab.co.il>,
        Igor Grinberg <grinberg@compulab.co.il>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 07/12] ARM: dts: imx7d: cl-som-imx7: add/enable SPI flash on spi1
Date:   Mon, 26 Aug 2019 16:37:55 +0100
Message-Id: <20190826153800.35400-7-git@andred.net>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190826153800.35400-1-git@andred.net>
References: <20190826153800.35400-1-git@andred.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add/enable SPI flash on spi1 using the default vendor's
partition layout as per downstream kernel

Signed-off-by: André Draszik <git@andred.net>
Cc: Ilya Ledvich <ilya@compulab.co.il>
Cc: Igor Grinberg <grinberg@compulab.co.il>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts | 45 +++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
index ca3c5d95d6c3..d4637a8ca223 100644
--- a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
+++ b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
@@ -28,6 +28,36 @@
 	cpu-supply = <&sw1a_reg>;
 };
 
+&ecspi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi1 &pinctrl_ecspi1_cs>;
+	cs-gpios = <&gpio4 19 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+
+	flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		spi-max-frequency = <20000000>;
+		reg = <0>;
+
+		partition@0 {
+			label = "uboot";
+			reg = <0x0 0xc0000>;
+		};
+
+		partition@c0000 {
+			label = "uboot environment";
+			reg = <0xc0000 0x40000>;
+		};
+
+		partition@100000 {
+			label = "splash";
+			reg = <0x100000 0x100000>;
+		};
+	};
+};
+
 &fec1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet1 &pinctrl_enet1phy>;
@@ -214,6 +244,21 @@
 };
 
 &iomuxc {
+	pinctrl_ecspi1: ecspi1grp {
+		fsl,pins = <
+			MX7D_PAD_ECSPI1_MOSI__ECSPI1_MOSI		0xf
+			MX7D_PAD_ECSPI1_MISO__ECSPI1_MISO		0xf
+			MX7D_PAD_ECSPI1_SCLK__ECSPI1_SCLK		0xf
+		>;
+	};
+
+	pinctrl_ecspi1_cs: ecspi1_cs_grp {
+		fsl,pins = <
+			/* SPI flash chipselect */
+			MX7D_PAD_ECSPI1_SS0__GPIO4_IO19			0x34
+		>;
+	};
+
 	pinctrl_enet1: enet1grp {
 		fsl,pins = <
 			MX7D_PAD_SD2_CD_B__ENET1_MDIO			0x30
-- 
2.23.0.rc1

