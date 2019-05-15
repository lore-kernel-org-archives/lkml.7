Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762E8C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 16:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F49D20873
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 16:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfEOQEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 12:04:49 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:37493 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfEOQEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 12:04:49 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 453zsB4SbJz1rFrb;
        Wed, 15 May 2019 18:04:46 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 453zsB3QvGz1qqkL;
        Wed, 15 May 2019 18:04:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 5kj7UBK9TA2A; Wed, 15 May 2019 18:04:44 +0200 (CEST)
X-Auth-Info: yb3aXatXonqrkdakbIW4956qityxBqYXZDTyuzRUq58=
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed, 15 May 2019 18:04:44 +0200 (CEST)
From:   Lukasz Majewski <lukma@denx.de>
To:     Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thierry Reding <treding@nvidia.com>,
        Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v4 1/2] dt-bindings: display/panel: Add KOE tx14d24vm1bpa display description
Date:   Wed, 15 May 2019 18:04:28 +0200
Message-Id: <20190515160428.6114-1-lukma@denx.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180412143715.6828-1-lukma@denx.de>
References: <20180412143715.6828-1-lukma@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds documentation entry description for KOE's 5.7" display.

Signed-off-by: Lukasz Majewski <lukma@denx.de>

---
Previous discussion (and Rob's Reviewed-by) about this patch
https://patchwork.kernel.org/patch/10339595/

Changes for v4:
- Rebase on top of newest mainline
SHA1: 5ac94332248ee017964ba368cdda4ce647e3aba7

Changes for v3 :
- New patch
---
 .../bindings/display/panel/koe,tx14d24vm1bpa.txt   | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/koe,tx14d24vm1bpa.txt

diff --git a/Documentation/devicetree/bindings/display/panel/koe,tx14d24vm1bpa.txt b/Documentation/devicetree/bindings/display/panel/koe,tx14d24vm1bpa.txt
new file mode 100644
index 000000000000..be7ac666807b
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/koe,tx14d24vm1bpa.txt
@@ -0,0 +1,42 @@
+Kaohsiung Opto-Electronics Inc. 5.7" QVGA (320 x 240) TFT LCD panel
+
+Required properties:
+- compatible: should be "koe,tx14d24vm1bpa"
+- backlight: phandle of the backlight device attached to the panel
+- power-supply: single regulator to provide the supply voltage
+
+Required nodes:
+- port: Parallel port mapping to connect this display
+
+This panel needs single power supply voltage. Its backlight is conntrolled
+via PWM signal.
+
+Example:
+--------
+
+Example device-tree definition when connected to iMX53 based board
+
+	lcd_panel: lcd-panel {
+		compatible = "koe,tx14d24vm1bpa";
+		backlight = <&backlight_lcd>;
+		power-supply = <&reg_3v3>;
+
+		port {
+			lcd_panel_in: endpoint {
+				remote-endpoint = <&lcd_display_out>;
+			};
+		};
+	};
+
+Then one needs to extend the dispX node:
+
+	lcd_display: disp1 {
+
+		port@1 {
+			reg = <1>;
+
+			lcd_display_out: endpoint {
+				remote-endpoint = <&lcd_panel_in>;
+			};
+		};
+	};
-- 
2.11.0

