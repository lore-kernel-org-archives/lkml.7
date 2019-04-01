Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7560C4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE23421019
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbfDAKfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 06:35:44 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:35120 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbfDAKfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 06:35:42 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id C8FFFFB04;
        Mon,  1 Apr 2019 12:35:39 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id noyXn7in9ZLo; Mon,  1 Apr 2019 12:35:38 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 4B92C44B61; Mon,  1 Apr 2019 12:35:35 +0200 (CEST)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Johan Hovold <johan@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v5 2/3] dt-bindings: Add Rocktech jh057n00900 panel bindings
Date:   Mon,  1 Apr 2019 12:35:34 +0200
Message-Id: <ec59b22907ac28764ffb3bec33445b6e019945a4.1554114302.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1554114302.git.agx@sigxcpu.org>
References: <cover.1554114302.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Rocktec jh057n00900 is a 5.5" MIPI DSI video mode panel with a
720x1440 resolution and a built in backlight.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 .../display/panel/rocktech,jh057n00900.txt     | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.txt

diff --git a/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.txt b/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.txt
new file mode 100644
index 000000000000..1b5763200cf6
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.txt
@@ -0,0 +1,18 @@
+Rocktech jh057n00900 5.5" 720x1440 TFT LCD panel
+
+Required properties:
+- compatible: should be "rocktech,jh057n00900"
+- reg: DSI virtual channel of the peripheral
+- reset-gpios: panel reset gpio
+- backlight: phandle of the backlight device attached to the panel
+
+Example:
+
+	&mipi_dsi {
+		panel@0 {
+			compatible = "rocktech,jh057n00900";
+			reg = <0>;
+			backlight = <&backlight>;
+			reset-gpios = <&gpio3 13 GPIO_ACTIVE_LOW>;
+		};
+	};
-- 
2.20.1

