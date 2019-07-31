Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95AF7C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 16:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7591F208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 16:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730345AbfGaQnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 12:43:39 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:55492 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728938AbfGaQnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 12:43:37 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 44AEDFB02;
        Wed, 31 Jul 2019 18:43:35 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nZ9ndQofYGCX; Wed, 31 Jul 2019 18:43:34 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 68E2046BB5; Wed, 31 Jul 2019 18:43:31 +0200 (CEST)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: reset: Fix typo in imx8mq resets
Date:   Wed, 31 Jul 2019 18:43:30 +0200
Message-Id: <f4c58a4a1c7a115cb9756630535031d6e9777247.1564591352.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1564591352.git.agx@sigxcpu.org>
References: <cover.1564591352.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the mipi dsi resets were called

  IMX8MQ_RESET_MIPI_DIS__

instead of

  IMX8MQ_RESET_MIPI_DSI__

Since they're DSI related this looks like a typo.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 include/dt-bindings/reset/imx8mq-reset.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/dt-bindings/reset/imx8mq-reset.h b/include/dt-bindings/reset/imx8mq-reset.h
index 57c592498aa0..bfa41b0e24f6 100644
--- a/include/dt-bindings/reset/imx8mq-reset.h
+++ b/include/dt-bindings/reset/imx8mq-reset.h
@@ -31,9 +31,9 @@
 #define IMX8MQ_RESET_OTG2_PHY_RESET		20
 #define IMX8MQ_RESET_MIPI_DSI_RESET_BYTE_N	21
 #define IMX8MQ_RESET_MIPI_DSI_RESET_N		22
-#define IMX8MQ_RESET_MIPI_DIS_DPI_RESET_N	23
-#define IMX8MQ_RESET_MIPI_DIS_ESC_RESET_N	24
-#define IMX8MQ_RESET_MIPI_DIS_PCLK_RESET_N	25
+#define IMX8MQ_RESET_MIPI_DSI_DPI_RESET_N	23
+#define IMX8MQ_RESET_MIPI_DSI_ESC_RESET_N	24
+#define IMX8MQ_RESET_MIPI_DSI_PCLK_RESET_N	25
 #define IMX8MQ_RESET_PCIEPHY			26
 #define IMX8MQ_RESET_PCIEPHY_PERST		27
 #define IMX8MQ_RESET_PCIE_CTRL_APPS_EN		28
-- 
2.20.1

