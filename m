Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85981C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 15:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68F5021873
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 15:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbfGXPwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 11:52:36 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:33564 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726371AbfGXPwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 11:52:33 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 64C62FB02;
        Wed, 24 Jul 2019 17:52:30 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1TeSWBVSsdkI; Wed, 24 Jul 2019 17:52:27 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 010B0416CA; Wed, 24 Jul 2019 17:52:26 +0200 (CEST)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Robert Chiras <robert.chiras@nxp.com>
Subject: [PATCH 1/3] arm64: imx8mq: add imx8mq iomux-gpr field defines
Date:   Wed, 24 Jul 2019 17:52:24 +0200
Message-Id: <3b85102dfe3e358bbdde359e0a3a5f8e121fd691.1563983037.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1563983037.git.agx@sigxcpu.org>
References: <cover.1563983037.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds all the gpr registers and the define needed for selecting
the input source in the imx-nwl drm bridge.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 include/linux/mfd/syscon/imx8mq-iomuxc-gpr.h | 62 ++++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 include/linux/mfd/syscon/imx8mq-iomuxc-gpr.h

diff --git a/include/linux/mfd/syscon/imx8mq-iomuxc-gpr.h b/include/linux/mfd/syscon/imx8mq-iomuxc-gpr.h
new file mode 100644
index 000000000000..62e85ffacfad
--- /dev/null
+++ b/include/linux/mfd/syscon/imx8mq-iomuxc-gpr.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017 NXP
+ *               2019 Purism SPC
+ */
+
+#ifndef __LINUX_IMX8MQ_IOMUXC_GPR_H
+#define __LINUX_IMX8MQ_IOMUXC_GPR_H
+
+#define IOMUXC_GPR0	0x00
+#define IOMUXC_GPR1	0x04
+#define IOMUXC_GPR2	0x08
+#define IOMUXC_GPR3	0x0c
+#define IOMUXC_GPR4	0x10
+#define IOMUXC_GPR5	0x14
+#define IOMUXC_GPR6	0x18
+#define IOMUXC_GPR7	0x1c
+#define IOMUXC_GPR8	0x20
+#define IOMUXC_GPR9	0x24
+#define IOMUXC_GPR10	0x28
+#define IOMUXC_GPR11	0x2c
+#define IOMUXC_GPR12	0x30
+#define IOMUXC_GPR13	0x34
+#define IOMUXC_GPR14	0x38
+#define IOMUXC_GPR15	0x3c
+#define IOMUXC_GPR16	0x40
+#define IOMUXC_GPR17	0x44
+#define IOMUXC_GPR18	0x48
+#define IOMUXC_GPR19	0x4c
+#define IOMUXC_GPR20	0x50
+#define IOMUXC_GPR21	0x54
+#define IOMUXC_GPR22	0x58
+#define IOMUXC_GPR23	0x5c
+#define IOMUXC_GPR24	0x60
+#define IOMUXC_GPR25	0x64
+#define IOMUXC_GPR26	0x68
+#define IOMUXC_GPR27	0x6c
+#define IOMUXC_GPR28	0x70
+#define IOMUXC_GPR29	0x74
+#define IOMUXC_GPR30	0x78
+#define IOMUXC_GPR31	0x7c
+#define IOMUXC_GPR32	0x80
+#define IOMUXC_GPR33	0x84
+#define IOMUXC_GPR34	0x88
+#define IOMUXC_GPR35	0x8c
+#define IOMUXC_GPR36	0x90
+#define IOMUXC_GPR37	0x94
+#define IOMUXC_GPR38	0x98
+#define IOMUXC_GPR39	0x9c
+#define IOMUXC_GPR40	0xa0
+#define IOMUXC_GPR41	0xa4
+#define IOMUXC_GPR42	0xa8
+#define IOMUXC_GPR43	0xac
+#define IOMUXC_GPR44	0xb0
+#define IOMUXC_GPR45	0xb4
+#define IOMUXC_GPR46	0xb8
+#define IOMUXC_GPR47	0xbc
+
+/* i.MX8Mq iomux gpr register field defines */
+#define IMX8MQ_GPR13_MIPI_MUX_SEL		BIT(2)
+
+#endif /* __LINUX_IMX8MQ_IOMUXC_GPR_H */
-- 
2.20.1

