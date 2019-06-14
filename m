Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7F5C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 11:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C9A521473
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 11:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbfFNLvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 07:51:09 -0400
Received: from inva021.nxp.com ([92.121.34.21]:49690 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727434AbfFNLvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 07:51:07 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D6FDA200EA3;
        Fri, 14 Jun 2019 13:51:04 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C98EE200EA2;
        Fri, 14 Jun 2019 13:51:04 +0200 (CEST)
Received: from fsr-ub1664-046.ea.freescale.net (fsr-ub1664-046.ea.freescale.net [10.171.96.34])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id B634C20606;
        Fri, 14 Jun 2019 13:51:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by fsr-ub1664-046.ea.freescale.net (Postfix) with ESMTP id 8EB9255AE;
        Fri, 14 Jun 2019 14:51:04 +0300 (EEST)
Received: from fsr-ub1664-046.ea.freescale.net ([127.0.0.1])
        by localhost (fsr-ub1664-046.ea.freescale.net [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 0h5MoUcoTq8V; Fri, 14 Jun 2019 14:51:04 +0300 (EEST)
Received: from localhost (localhost [127.0.0.1])
        by fsr-ub1664-046.ea.freescale.net (Postfix) with ESMTP id 1C6C155B0;
        Fri, 14 Jun 2019 14:51:04 +0300 (EEST)
X-Virus-Scanned: amavisd-new at ea.freescale.net
Received: from fsr-ub1664-046.ea.freescale.net ([127.0.0.1])
        by localhost (fsr-ub1664-046.ea.freescale.net [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id q-SgHouCg23M; Fri, 14 Jun 2019 14:51:03 +0300 (EEST)
Received: from fsr-ub1664-120.ea.freescale.net (fsr-ub1664-120.ea.freescale.net [10.171.82.81])
        by fsr-ub1664-046.ea.freescale.net (Postfix) with ESMTP id DF85E55AD;
        Fri, 14 Jun 2019 14:51:03 +0300 (EEST)
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
Subject: [PATCH 1/2] dt-bindings: display: panel: Add support for Raydium RM67191 panel
Date:   Fri, 14 Jun 2019 14:51:02 +0300
Message-Id: <1560513063-24995-2-git-send-email-robert.chiras@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560513063-24995-1-git-send-email-robert.chiras@nxp.com>
References: <1560513063-24995-1-git-send-email-robert.chiras@nxp.com>
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
 .../bindings/display/panel/raydium,rm67191.txt     | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/raydium,rm67191.txt

diff --git a/Documentation/devicetree/bindings/display/panel/raydium,rm67191.txt b/Documentation/devicetree/bindings/display/panel/raydium,rm67191.txt
new file mode 100644
index 0000000..5a6268d
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/raydium,rm67191.txt
@@ -0,0 +1,42 @@
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
+- reset-gpio:		a GPIO spec for the RST_B GPIO pin
+- pinctrl-0		phandle to the pin settings for the reset pin
+- width-mm:		physical panel width [mm]
+- height-mm:		physical panel height [mm]
+- display-timings:	timings for the connected panel according to [1]
+- video-mode:		0 - burst-mode
+			1 - non-burst with sync event
+			2 - non-burst with sync pulse
+
+[1]: Documentation/devicetree/bindings/display/display-timing.txt
+
+Example:
+
+	panel@0 {
+		compatible = "raydium,rm67191";
+		reg = <0>;
+		pinctrl-0 = <&pinctrl_mipi_dsi_0_1_en>;
+		reset-gpio = <&gpio1 7 GPIO_ACTIVE_HIGH>;
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

