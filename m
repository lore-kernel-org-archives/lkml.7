Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17235C31E5D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 13:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECB7F2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 13:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729215AbfFRNax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 09:30:53 -0400
Received: from inva020.nxp.com ([92.121.34.13]:55034 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbfFRNau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 09:30:50 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 560CF1A03B3;
        Tue, 18 Jun 2019 15:30:47 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 48EBD1A03AB;
        Tue, 18 Jun 2019 15:30:47 +0200 (CEST)
Received: from fsr-ub1664-046.ea.freescale.net (fsr-ub1664-046.ea.freescale.net [10.171.96.34])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 353A020633;
        Tue, 18 Jun 2019 15:30:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by fsr-ub1664-046.ea.freescale.net (Postfix) with ESMTP id 096CB55B2;
        Tue, 18 Jun 2019 16:30:47 +0300 (EEST)
Received: from fsr-ub1664-046.ea.freescale.net ([127.0.0.1])
        by localhost (fsr-ub1664-046.ea.freescale.net [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id eRSH-LX3U0vf; Tue, 18 Jun 2019 16:30:46 +0300 (EEST)
Received: from localhost (localhost [127.0.0.1])
        by fsr-ub1664-046.ea.freescale.net (Postfix) with ESMTP id 9994A4D1D;
        Tue, 18 Jun 2019 16:30:46 +0300 (EEST)
X-Virus-Scanned: amavisd-new at ea.freescale.net
Received: from fsr-ub1664-046.ea.freescale.net ([127.0.0.1])
        by localhost (fsr-ub1664-046.ea.freescale.net [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id yXSNJ-mYYNVK; Tue, 18 Jun 2019 16:30:46 +0300 (EEST)
Received: from fsr-ub1664-120.ea.freescale.net (fsr-ub1664-120.ea.freescale.net [10.171.82.81])
        by fsr-ub1664-046.ea.freescale.net (Postfix) with ESMTP id 5A86855B1;
        Tue, 18 Jun 2019 16:30:46 +0300 (EEST)
From:   Robert Chiras <robert.chiras@nxp.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        Robert Chiras <robert.chiras@nxp.com>
Subject: [PATCH v2 1/2] dt-bindings: display: panel: Add support for Raydium RM67191 panel
Date:   Tue, 18 Jun 2019 16:30:45 +0300
Message-Id: <1560864646-1468-2-git-send-email-robert.chiras@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560864646-1468-1-git-send-email-robert.chiras@nxp.com>
References: <1560864646-1468-1-git-send-email-robert.chiras@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-bindings documentation for Raydium RM67191 DSI panel.

Signed-off-by: Robert Chiras <robert.chiras@nxp.com>
---
 .../bindings/display/panel/raydium,rm67191.txt     | 43 ++++++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/raydium,rm67191.txt

diff --git a/Documentation/devicetree/bindings/display/panel/raydium,rm67191.txt b/Documentation/devicetree/bindings/display/panel/raydium,rm67191.txt
new file mode 100644
index 0000000..0952610
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/raydium,rm67191.txt
@@ -0,0 +1,43 @@
+Raydium RM67171 OLED LCD panel with MIPI-DSI protocol
+
+Required properties:
+- compatible: 		"raydium,rm67191"
+- reg:			virtual channel for MIPI-DSI protocol
+			must be <0>
+- dsi-lanes:		number of DSI lanes to be used
+			must be <3> or <4>
+- port: 		input port node with endpoint definition as
+			defined in Documentation/devicetree/bindings/graph.txt;
+			the input port should be connected to a MIPI-DSI device
+			driver
+
+Optional properties:
+- reset-gpios:		a GPIO spec for the RST_B GPIO pin
+- pinctrl-0		phandle to the pin settings for the reset pin
+- width-mm:		physical panel width [mm]
+- height-mm:		physical panel height [mm]
+- display-timings:	timings for the connected panel according to [1]
+- video-mode:		0 - burst-mode
+			1 - non-burst with sync event
+			2 - non-burst with sync pulse
+
+[1]: Documentation/devicetree/bindings/display/panel/display-timing.txt
+
+Example:
+
+	panel@0 {
+		compatible = "raydium,rm67191";
+		reg = <0>;
+		pinctrl-0 = <&pinctrl_mipi_dsi_0_1_en>;
+		pinctrl-names = "default";
+		reset-gpios = <&gpio1 7 GPIO_ACTIVE_LOW>;
+		dsi-lanes = <4>;
+		width-mm = <68>;
+		height-mm = <121>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&mipi_out>;
+			};
+		};
+	};
-- 
2.7.4

