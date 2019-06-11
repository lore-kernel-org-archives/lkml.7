Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA41DC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99EB220665
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390242AbfFKOFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 10:05:05 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:55716 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389874AbfFKOFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 10:05:01 -0400
Received: from [167.98.27.226] (helo=happy.office.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1hahOR-0003vU-26; Tue, 11 Jun 2019 15:04:55 +0100
From:   Michael Drake <michael.drake@codethink.co.uk>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michael Drake <michael.drake@codethink.co.uk>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@lists.codethink.co.uk,
        Patrick Glaser <pglaser@tesla.com>, Nate Case <ncase@tesla.com>
Subject: [PATCH v1 01/11] dt-bindings: display/bridge: Add bindings for ti948
Date:   Tue, 11 Jun 2019 15:04:02 +0100
Message-Id: <20190611140412.32151-2-michael.drake@codethink.co.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611140412.32151-1-michael.drake@codethink.co.uk>
References: <20190611140412.32151-1-michael.drake@codethink.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds device tree bindings for:

  TI DS90UB948-Q1 2K FPD-Link III to OpenLDI Deserializer

The device has the compatible string "ti,ds90ub948", and
and allows an arrray of strings to be provided as regulator
names to enable for operation of the device.

Signed-off-by: Michael Drake <michael.drake@codethink.co.uk>
Cc: Patrick Glaser <pglaser@tesla.com>
Cc: Nate Case <ncase@tesla.com>
---
 .../bindings/display/bridge/ti,ds90ub948.txt  | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/ti,ds90ub948.txt

diff --git a/Documentation/devicetree/bindings/display/bridge/ti,ds90ub948.txt b/Documentation/devicetree/bindings/display/bridge/ti,ds90ub948.txt
new file mode 100644
index 000000000000..f9e86cb22900
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/ti,ds90ub948.txt
@@ -0,0 +1,24 @@
+TI DS90UB948-Q1 2K FPD-Link III to OpenLDI Deserializer
+=======================================================
+
+This is the binding for Texas Instruments DS90UB948-Q1 bridge deserializer.
+
+This device supports I2C only.
+
+Required properties:
+
+- compatible: "ti,ds90ub948"
+
+Optional properties:
+
+- regulators: List of regulator name strings to enable for operation of device.
+
+Example
+-------
+
+ti948: ds90ub948@0 {
+	compatible = "ti,ds90ub948";
+
+	regulators: "vcc",
+	            "vcc_disp";
+};
-- 
2.20.1

