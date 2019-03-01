Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2C9C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 13:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E50662084F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 13:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733102AbfCANCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 08:02:14 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:55740 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728202AbfCANCK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 08:02:10 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 21C5CFB07;
        Fri,  1 Mar 2019 14:02:09 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9PJGrJdhgDsG; Fri,  1 Mar 2019 14:02:06 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 321B641507; Fri,  1 Mar 2019 14:02:04 +0100 (CET)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v2 2/3] dt-bindings: Add Rocktech jh057n00900 panel bindings
Date:   Fri,  1 Mar 2019 14:02:03 +0100
Message-Id: <bc44793f9ec456f3147537e0ad4083e94df0294b.1551445106.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1551445106.git.agx@sigxcpu.org>
References: <cover.1551445106.git.agx@sigxcpu.org>
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
index 000000000000..32f4001d2d6f
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
+		panel {
+			compatible = "rocktech,jh057n00900";
+			reg = <0>;
+			backlight = <&backlight>;
+			reset-gpios = <&gpio3 13 GPIO_ACTIVE_LOW>;
+		};
+	};
-- 
2.20.1

