Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE445C282DC
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 16:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9375627982
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 16:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="UemrOozu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfFBQtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 12:49:00 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:44000 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfFBQtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 12:49:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1559494136; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=vb7xsY48X0IRX6WU/JJNVZf+YbRONceHxAfWa0qnxCM=;
        b=UemrOozu4Rr/GzEu+cKFK/mOKU91ndgTzD9ExD9YClsejMyJmTvR7OPou7D0BOrtuzoztp
        M1CTSia3mAC3rXHuLtg3r9OUszmbj9NrOuV+stE/jTYl7SgoNLPZ6X+XCjC3VrVzBXfEr6
        wBpFhMHNjXsMc5E7UO+I+8dhfOjVSLU=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, sam@ravnborg.org, od@zcrc.me,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 1/2] dt-bindings: display: Add King Display KD035G6-54NT panel documentation
Date:   Sun,  2 Jun 2019 18:48:43 +0200
Message-Id: <20190602164844.15659-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The KD035G6-54NT is a 3.5" 320x240 24-bit TFT LCD panel.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 .../panel/kingdisplay,kd035g6-54nt.txt        | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/kingdisplay,kd035g6-54nt.txt

diff --git a/Documentation/devicetree/bindings/display/panel/kingdisplay,kd035g6-54nt.txt b/Documentation/devicetree/bindings/display/panel/kingdisplay,kd035g6-54nt.txt
new file mode 100644
index 000000000000..a6e4a9af4925
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/kingdisplay,kd035g6-54nt.txt
@@ -0,0 +1,27 @@
+King Display KD035G6-54NT 3.5" (320x240 pixels) 24-bit TFT LCD panel
+
+Required properties:
+- compatible: should be "kingdisplay,kd035g6-54nt"
+- power-supply: See panel-common.txt
+- reset-gpios: See panel-common.txt
+
+Optional properties:
+- backlight: see panel-common.txt
+
+Example:
+
+&spi {
+	display-panel {
+		compatible = "kingdisplay,kd035g6-54nt";
+		reg = <0>;
+
+		spi-max-frequency = <3125000>;
+		spi-3wire;
+		spi-cs-high;
+
+		reset-gpios = <&gpe 2 GPIO_ACTIVE_LOW>;
+
+		backlight = <&backlight>;
+		power-supply = <&ldo6>;
+	};
+};
-- 
2.21.0.593.g511ec345e18

