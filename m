Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE4AC3A59B
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 10:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DBD42332A
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 10:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbfHUKQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 06:16:51 -0400
Received: from inva020.nxp.com ([92.121.34.13]:44760 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbfHUKQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 06:16:24 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 95FB81A00C1;
        Wed, 21 Aug 2019 12:16:23 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8A2DC1A007D;
        Wed, 21 Aug 2019 12:16:23 +0200 (CEST)
Received: from fsr-ub1664-120.ea.freescale.net (fsr-ub1664-120.ea.freescale.net [10.171.82.81])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id D170820612;
        Wed, 21 Aug 2019 12:16:22 +0200 (CEST)
From:   Robert Chiras <robert.chiras@nxp.com>
To:     =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/15] dt-bindings: display: Add max-memory-bandwidth property for mxsfb
Date:   Wed, 21 Aug 2019 13:15:50 +0300
Message-Id: <1566382555-12102-11-git-send-email-robert.chiras@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566382555-12102-1-git-send-email-robert.chiras@nxp.com>
References: <1566382555-12102-1-git-send-email-robert.chiras@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new optional property 'max-memory-bandwidth', to limit the maximum
bandwidth used by the MXSFB_DRM driver.

Signed-off-by: Robert Chiras <robert.chiras@nxp.com>
---
 Documentation/devicetree/bindings/display/mxsfb.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/mxsfb.txt b/Documentation/devicetree/bindings/display/mxsfb.txt
index 472e1ea..c8dca50 100644
--- a/Documentation/devicetree/bindings/display/mxsfb.txt
+++ b/Documentation/devicetree/bindings/display/mxsfb.txt
@@ -14,6 +14,11 @@ Required properties:
     - "pix" for the LCDIF block clock
     - (MX6SX-only) "axi", "disp_axi" for the bus interface clock
 
+Optional properties:
+- max-memory-bandwidth: maximum bandwidth in bytes per second that the
+	controller can handle; if not present, the memory
+	interface is fast enough to handle all possible video modes
+
 Required sub-nodes:
   - port: The connection to an encoder chip.
 
-- 
2.7.4

