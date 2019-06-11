Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978E4C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 767712173C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391009AbfFKOTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 10:19:51 -0400
Received: from hermes.aosc.io ([199.195.250.187]:33451 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389585AbfFKOTn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 10:19:43 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id EAC598229B;
        Tue, 11 Jun 2019 14:12:22 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH v2 08/11] ARM: sunxi: dts: s3/s3l/v3: add DTSI files for S3/S3L/V3 SoCs
Date:   Tue, 11 Jun 2019 22:09:37 +0800
Message-Id: <20190611140940.14357-9-icenowy@aosc.io>
In-Reply-To: <20190611140940.14357-1-icenowy@aosc.io>
References: <20190611140940.14357-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Allwinner S3/S3L/V3 SoCs all share the same die with the V3s SoC,
but with more GPIO wired out of the package.

Add DTSI files for these SoCs. The DTSI file for V3 just replaces the
pinctrl compatible string, and the S3/S3L DTSI files just include the V3
DTSI file.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
No changes in v2.

 arch/arm/boot/dts/sun8i-s3.dtsi  |  6 ++++++
 arch/arm/boot/dts/sun8i-s3l.dtsi |  6 ++++++
 arch/arm/boot/dts/sun8i-v3.dtsi  | 14 ++++++++++++++
 3 files changed, 26 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun8i-s3.dtsi
 create mode 100644 arch/arm/boot/dts/sun8i-s3l.dtsi
 create mode 100644 arch/arm/boot/dts/sun8i-v3.dtsi

diff --git a/arch/arm/boot/dts/sun8i-s3.dtsi b/arch/arm/boot/dts/sun8i-s3.dtsi
new file mode 100644
index 000000000000..0f41a25ecb30
--- /dev/null
+++ b/arch/arm/boot/dts/sun8i-s3.dtsi
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2019 Icenowy Zheng <icenowy@aosc.io>
+ */
+
+#include "sun8i-v3.dtsi"
diff --git a/arch/arm/boot/dts/sun8i-s3l.dtsi b/arch/arm/boot/dts/sun8i-s3l.dtsi
new file mode 100644
index 000000000000..0f41a25ecb30
--- /dev/null
+++ b/arch/arm/boot/dts/sun8i-s3l.dtsi
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2019 Icenowy Zheng <icenowy@aosc.io>
+ */
+
+#include "sun8i-v3.dtsi"
diff --git a/arch/arm/boot/dts/sun8i-v3.dtsi b/arch/arm/boot/dts/sun8i-v3.dtsi
new file mode 100644
index 000000000000..6ae8645ade50
--- /dev/null
+++ b/arch/arm/boot/dts/sun8i-v3.dtsi
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2019 Icenowy Zheng <icenowy@aosc.io>
+ */
+
+#include "sun8i-v3s.dtsi"
+
+&ccu {
+	compatible = "allwinner,sun8i-v3-ccu";
+};
+
+&pio {
+	compatible = "allwinner,sun8i-v3-pinctrl";
+};
-- 
2.21.0

