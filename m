Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81360C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 15:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DE9620874
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 15:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733163AbfHZPjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 11:39:14 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38961 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733087AbfHZPi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 11:38:56 -0400
Received: by mail-wm1-f66.google.com with SMTP id i63so16320514wmg.4;
        Mon, 26 Aug 2019 08:38:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I8BhmUjvRpuRsDLc+hCNgR+cjfG8z1wM6d0LK3Ong3c=;
        b=ujutz5n60DDR+Ja7QgzXOPqffrYJm1TMiCw10+Za6jldR78ngKUPwME01zFsen/MM+
         aFbOPBcTBYPNWsfwhys71YPvGnm4xRIzJXrKUZT9lWUD+bXZGRWd+Hurzai+e2egs5BZ
         zfb0yXjApiCB70FgwdwVsaqSyR//as78pBCBoMdniJswFYqBT4Ya/QOcYpb3aXn5V6Fj
         5ytvzAS3EO9pdv1vZsl6YXQ9DpzhwPeQvFeq+5Wy7eS8D+88OKGXpuSYetSskA8j/bGH
         x3nGiUfK46THcZ3FcVOGWFUZrXZOVMkbVoCT7+j3DMlUkPhbjvzzDf1J2TwvZND0tSGF
         QMcg==
X-Gm-Message-State: APjAAAX3DPPomImZLeuCo84253A8VcgE3RW970mVKW/5fk6DsNad9vKG
        V/4Nr5LsGXoszndZJ4C/w/qVC/1fk+A=
X-Google-Smtp-Source: APXvYqwMD/2qo0xGpO8j5/o0mKPTDWKJ+yk4XONGvPSsZuutCz0ekSIirvu1/zzmTBZWPbnKFZS1pw==
X-Received: by 2002:a1c:4005:: with SMTP id n5mr22328274wma.166.1566833933541;
        Mon, 26 Aug 2019 08:38:53 -0700 (PDT)
Received: from 1aq-andre.garage.tyco.com ([77.107.218.170])
        by smtp.gmail.com with ESMTPSA id z8sm11580798wru.13.2019.08.26.08.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 08:38:53 -0700 (PDT)
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
Subject: [PATCH 11/12] ARM: dts: imx7d: cl-som-imx7: add WiLink Bluetooth support
Date:   Mon, 26 Aug 2019 16:37:59 +0100
Message-Id: <20190826153800.35400-11-git@andred.net>
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

add / enable TI's WiLink8 Bluetooth module on UART3.

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
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
index 4cb36decef3d..08fb43f7ae1d 100644
--- a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
+++ b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
@@ -250,6 +250,21 @@
 	status = "okay";
 };
 
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3>;
+	assigned-clocks = <&clks IMX7D_UART3_ROOT_SRC>;
+	assigned-clock-parents = <&clks IMX7D_PLL_SYS_MAIN_240M_CLK>;
+	uart-has-rtscts;
+	status = "okay";
+
+	bluetooth {
+		compatible = "ti,wl1835-st";
+		enable-gpios = <&pca9555 1 GPIO_ACTIVE_HIGH>;
+		max-speed = <3000000>;
+	};
+};
+
 &usdhc2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc2>;
@@ -351,6 +366,15 @@
 		>;
 	};
 
+	pinctrl_uart3: uart3grp {
+		fsl,pins = <
+			MX7D_PAD_UART3_TX_DATA__UART3_DCE_TX	0x79
+			MX7D_PAD_UART3_RX_DATA__UART3_DCE_RX	0x79
+			MX7D_PAD_UART3_CTS_B__UART3_DCE_CTS	0x79
+			MX7D_PAD_UART3_RTS_B__UART3_DCE_RTS	0x79
+		>;
+	};
+
 	pinctrl_usdhc2: usdhc2grp {
 		fsl,pins = <
 			MX7D_PAD_SD2_CMD__SD2_CMD		0x59
-- 
2.23.0.rc1

