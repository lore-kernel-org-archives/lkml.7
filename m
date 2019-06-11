Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE780C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 07:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C00AB208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 07:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404427AbfFKH3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 03:29:53 -0400
Received: from shell.v3.sk ([90.176.6.54]:32796 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404402AbfFKH3v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 03:29:51 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id F133F104F85;
        Tue, 11 Jun 2019 09:29:48 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id HVHb10XKGsyh; Tue, 11 Jun 2019 09:29:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 471B1104F87;
        Tue, 11 Jun 2019 09:29:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Yxt4QUuLaodL; Tue, 11 Jun 2019 09:29:26 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 2CDFB104F82;
        Tue, 11 Jun 2019 09:29:25 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Olof Johansson <olof@lixom.net>
Cc:     Wei Xu <xuwei5@hisilicon.com>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Patrice Chotard <patrice.chotard@st.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 6/6] ARM: hisilicon: DT: Switch to SPDX header
Date:   Tue, 11 Jun 2019 09:29:21 +0200
Message-Id: <20190611072921.2979446-7-lkundrak@v3.sk>
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
 arch/arm/boot/dts/hi3620-hi4511.dts  | 5 +----
 arch/arm/boot/dts/hi3620.dtsi        | 5 +----
 arch/arm/boot/dts/hip04-d01.dts      | 5 +----
 arch/arm/boot/dts/hisi-x5hd2-dkb.dts | 5 +----
 arch/arm/boot/dts/hisi-x5hd2.dtsi    | 5 +----
 5 files changed, 5 insertions(+), 20 deletions(-)

diff --git a/arch/arm/boot/dts/hi3620-hi4511.dts b/arch/arm/boot/dts/hi36=
20-hi4511.dts
index a579fbf13b5f..86282e6a2eff 100644
--- a/arch/arm/boot/dts/hi3620-hi4511.dts
+++ b/arch/arm/boot/dts/hi3620-hi4511.dts
@@ -1,10 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *  Copyright (C) 2012-2013 Linaro Ltd.
  *  Author: Haojian Zhuang <haojian.zhuang@linaro.org>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  publishhed by the Free Software Foundation.
  */
=20
 /dts-v1/;
diff --git a/arch/arm/boot/dts/hi3620.dtsi b/arch/arm/boot/dts/hi3620.dts=
i
index 541d70094544..d6aed21eaac5 100644
--- a/arch/arm/boot/dts/hi3620.dtsi
+++ b/arch/arm/boot/dts/hi3620.dtsi
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Hisilicon Ltd. Hi3620 SoC
  *
@@ -5,10 +6,6 @@
  * Copyright (C) 2012-2013 Linaro Ltd.
  *
  * Author: Haojian Zhuang <haojian.zhuang@linaro.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * publishhed by the Free Software Foundation.
  */
=20
 #include <dt-bindings/clock/hi3620-clock.h>
diff --git a/arch/arm/boot/dts/hip04-d01.dts b/arch/arm/boot/dts/hip04-d0=
1.dts
index ca48641d0f48..157244dbd074 100644
--- a/arch/arm/boot/dts/hip04-d01.dts
+++ b/arch/arm/boot/dts/hip04-d01.dts
@@ -1,10 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *  Copyright (C) 2013-2014 Linaro Ltd.
  *  Author: Haojian Zhuang <haojian.zhuang@linaro.org>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  publishhed by the Free Software Foundation.
  */
=20
 /dts-v1/;
diff --git a/arch/arm/boot/dts/hisi-x5hd2-dkb.dts b/arch/arm/boot/dts/his=
i-x5hd2-dkb.dts
index d13af8437d10..cb507e237068 100644
--- a/arch/arm/boot/dts/hisi-x5hd2-dkb.dts
+++ b/arch/arm/boot/dts/hisi-x5hd2-dkb.dts
@@ -1,10 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2013-2014 Linaro Ltd.
  * Copyright (c) 2013-2014 Hisilicon Limited.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  publishhed by the Free Software Foundation.
  */
=20
 /dts-v1/;
diff --git a/arch/arm/boot/dts/hisi-x5hd2.dtsi b/arch/arm/boot/dts/hisi-x=
5hd2.dtsi
index 50d3f8426da1..2dd1d4fb0c27 100644
--- a/arch/arm/boot/dts/hisi-x5hd2.dtsi
+++ b/arch/arm/boot/dts/hisi-x5hd2.dtsi
@@ -1,10 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2013-2014 Linaro Ltd.
  * Copyright (c) 2013-2014 Hisilicon Limited.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * publishhed by the Free Software Foundation.
  */
=20
 #include <dt-bindings/clock/hix5hd2-clock.h>
--=20
2.21.0

