Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2868C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 07:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F4AB2173E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 07:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404456AbfFKHaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 03:30:07 -0400
Received: from shell.v3.sk ([90.176.6.54]:60999 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404353AbfFKH3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 03:29:45 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id C34D9104F73;
        Tue, 11 Jun 2019 09:29:42 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id UQ0Bb_68C3u1; Tue, 11 Jun 2019 09:29:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 32A5F104F88;
        Tue, 11 Jun 2019 09:29:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id C7D_2HtN1agj; Tue, 11 Jun 2019 09:29:24 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id E8414104F74;
        Tue, 11 Jun 2019 09:29:23 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Olof Johansson <olof@lixom.net>
Cc:     Wei Xu <xuwei5@hisilicon.com>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Patrice Chotard <patrice.chotard@st.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 1/6] ARM: dts: STi: Switch to SPDX header
Date:   Tue, 11 Jun 2019 09:29:16 +0200
Message-Id: <20190611072921.2979446-2-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190611072921.2979446-1-lkundrak@v3.sk>
References: <20190611072921.2979446-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original license text had a typo ("publishhed") which would be
likely to confuse automated licensing auditing tools. Let's just switch
to SPDX instead of fixing the wording.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/arm/boot/dts/stih407-family.dtsi  | 5 +----
 arch/arm/boot/dts/stih407-pinctrl.dtsi | 5 +----
 arch/arm/boot/dts/stih407.dtsi         | 5 +----
 arch/arm/boot/dts/stih410-pinctrl.dtsi | 5 +----
 arch/arm/boot/dts/stih410.dtsi         | 5 +----
 arch/arm/boot/dts/stih418.dtsi         | 5 +----
 6 files changed, 6 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/st=
ih407-family.dtsi
index 9e29a4499938..2ff2542bf335 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -1,10 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2014 STMicroelectronics Limited.
  * Author: Giuseppe Cavallaro <peppe.cavallaro@st.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * publishhed by the Free Software Foundation.
  */
 #include "stih407-pinctrl.dtsi"
 #include <dt-bindings/mfd/st-lpc.h>
diff --git a/arch/arm/boot/dts/stih407-pinctrl.dtsi b/arch/arm/boot/dts/s=
tih407-pinctrl.dtsi
index e393519fb84c..db174019626f 100644
--- a/arch/arm/boot/dts/stih407-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stih407-pinctrl.dtsi
@@ -1,10 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2014 STMicroelectronics Limited.
  * Author: Giuseppe Cavallaro <peppe.cavallaro@st.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * publishhed by the Free Software Foundation.
  */
 #include "st-pincfg.h"
 #include <dt-bindings/interrupt-controller/arm-gic.h>
diff --git a/arch/arm/boot/dts/stih407.dtsi b/arch/arm/boot/dts/stih407.d=
tsi
index 5b7951ffc350..242ac72e4d4a 100644
--- a/arch/arm/boot/dts/stih407.dtsi
+++ b/arch/arm/boot/dts/stih407.dtsi
@@ -1,10 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2015 STMicroelectronics Limited.
  * Author: Gabriel Fernandez <gabriel.fernandez@linaro.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * publishhed by the Free Software Foundation.
  */
 #include "stih407-clock.dtsi"
 #include "stih407-family.dtsi"
diff --git a/arch/arm/boot/dts/stih410-pinctrl.dtsi b/arch/arm/boot/dts/s=
tih410-pinctrl.dtsi
index 5ae1fd66c0b8..8532ae3f61e8 100644
--- a/arch/arm/boot/dts/stih410-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stih410-pinctrl.dtsi
@@ -1,10 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2014 STMicroelectronics Limited.
  * Author: Peter Griffin <peter.griffin@linaro.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * publishhed by the Free Software Foundation.
  */
 #include "st-pincfg.h"
 / {
diff --git a/arch/arm/boot/dts/stih410.dtsi b/arch/arm/boot/dts/stih410.d=
tsi
index 888548ea9b5c..23b494a13c47 100644
--- a/arch/arm/boot/dts/stih410.dtsi
+++ b/arch/arm/boot/dts/stih410.dtsi
@@ -1,10 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2014 STMicroelectronics Limited.
  * Author: Peter Griffin <peter.griffin@linaro.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * publishhed by the Free Software Foundation.
  */
 #include "stih410-clock.dtsi"
 #include "stih407-family.dtsi"
diff --git a/arch/arm/boot/dts/stih418.dtsi b/arch/arm/boot/dts/stih418.d=
tsi
index 0efb3cd6a86e..f3f0a0e0f23c 100644
--- a/arch/arm/boot/dts/stih418.dtsi
+++ b/arch/arm/boot/dts/stih418.dtsi
@@ -1,10 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2014 STMicroelectronics Limited.
  * Author: Peter Griffin <peter.griffin@linaro.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * publishhed by the Free Software Foundation.
  */
 #include "stih418-clock.dtsi"
 #include "stih407-family.dtsi"
--=20
2.21.0

