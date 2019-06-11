Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82F4C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 07:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CACBD212F5
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 07:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404372AbfFKHUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 03:20:46 -0400
Received: from shell.v3.sk ([90.176.6.54]:60873 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404186AbfFKHUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 03:20:44 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 3142B104F74;
        Tue, 11 Jun 2019 09:20:42 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id FvvXSs4m1zKn; Tue, 11 Jun 2019 09:20:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 45134104F78;
        Tue, 11 Jun 2019 09:20:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id rRDIVzG3U7MD; Tue, 11 Jun 2019 09:20:14 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 2749B104F6E;
        Tue, 11 Jun 2019 09:20:14 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Wei Xu <xuwei5@hisilicon.com>
Cc:     Pengcheng Li <lipengcheng8@huawei.com>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] arm64: dts: hisilicon: Switch to SPDX header
Date:   Tue, 11 Jun 2019 09:20:09 +0200
Message-Id: <20190611072009.2978447-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
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
 arch/arm64/boot/dts/hisilicon/hi6220-coresight.dtsi | 5 +----
 arch/arm64/boot/dts/hisilicon/hip05-d02.dts         | 5 +----
 arch/arm64/boot/dts/hisilicon/hip05.dtsi            | 5 +----
 arch/arm64/boot/dts/hisilicon/hip06-d03.dts         | 5 +----
 arch/arm64/boot/dts/hisilicon/hip06.dtsi            | 5 +----
 arch/arm64/boot/dts/hisilicon/hip07-d05.dts         | 5 +----
 arch/arm64/boot/dts/hisilicon/hip07.dtsi            | 5 +----
 7 files changed, 7 insertions(+), 28 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-coresight.dtsi b/arch/a=
rm64/boot/dts/hisilicon/hi6220-coresight.dtsi
index 68c52f1149be..f9662a9f17b8 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220-coresight.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220-coresight.dtsi
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * dtsi file for Hisilicon Hi6220 coresight
  *
@@ -6,10 +7,6 @@
  * Author: Pengcheng Li <lipengcheng8@huawei.com>
  *         Leo Yan <leo.yan@linaro.org>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * publishhed by the Free Software Foundation.
- *
  */
=20
 / {
diff --git a/arch/arm64/boot/dts/hisilicon/hip05-d02.dts b/arch/arm64/boo=
t/dts/hisilicon/hip05-d02.dts
index 3bbd017f088f..154c25d1d50d 100644
--- a/arch/arm64/boot/dts/hisilicon/hip05-d02.dts
+++ b/arch/arm64/boot/dts/hisilicon/hip05-d02.dts
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /**
  * dts file for Hisilicon D02 Development Board
  *
  * Copyright (C) 2014,2015 Hisilicon Ltd.
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * publishhed by the Free Software Foundation.
- *
  */
=20
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/hisilicon/hip05.dtsi b/arch/arm64/boot/d=
ts/hisilicon/hip05.dtsi
index d321edc09c3f..a2ffaee686b0 100644
--- a/arch/arm64/boot/dts/hisilicon/hip05.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hip05.dtsi
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /**
  * dts file for Hisilicon D02 Development Board
  *
  * Copyright (C) 2014,2015 Hisilicon Ltd.
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * publishhed by the Free Software Foundation.
- *
  */
=20
 #include <dt-bindings/interrupt-controller/arm-gic.h>
diff --git a/arch/arm64/boot/dts/hisilicon/hip06-d03.dts b/arch/arm64/boo=
t/dts/hisilicon/hip06-d03.dts
index a95c6f5619bf..46616215969d 100644
--- a/arch/arm64/boot/dts/hisilicon/hip06-d03.dts
+++ b/arch/arm64/boot/dts/hisilicon/hip06-d03.dts
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /**
  * dts file for Hisilicon D03 Development Board
  *
  * Copyright (C) 2016 Hisilicon Ltd.
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * publishhed by the Free Software Foundation.
- *
  */
=20
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/hisilicon/hip06.dtsi b/arch/arm64/boot/d=
ts/hisilicon/hip06.dtsi
index 56625587b6de..00baee6d399c 100644
--- a/arch/arm64/boot/dts/hisilicon/hip06.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hip06.dtsi
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /**
  * dts file for Hisilicon D03 Development Board
  *
  * Copyright (C) 2016 Hisilicon Ltd.
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * publishhed by the Free Software Foundation.
- *
  */
=20
 #include <dt-bindings/interrupt-controller/arm-gic.h>
diff --git a/arch/arm64/boot/dts/hisilicon/hip07-d05.dts b/arch/arm64/boo=
t/dts/hisilicon/hip07-d05.dts
index 21147e8e3f94..d0cd986ab3a0 100644
--- a/arch/arm64/boot/dts/hisilicon/hip07-d05.dts
+++ b/arch/arm64/boot/dts/hisilicon/hip07-d05.dts
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /**
  * dts file for Hisilicon D05 Development Board
  *
  * Copyright (C) 2016 Hisilicon Ltd.
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * publishhed by the Free Software Foundation.
- *
  */
=20
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/hisilicon/hip07.dtsi b/arch/arm64/boot/d=
ts/hisilicon/hip07.dtsi
index 28bd4389441f..abfa416613e5 100644
--- a/arch/arm64/boot/dts/hisilicon/hip07.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hip07.dtsi
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /**
  * dts file for Hisilicon D05 Development Board
  *
  * Copyright (C) 2016 Hisilicon Ltd.
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * publishhed by the Free Software Foundation.
- *
  */
=20
 #include <dt-bindings/interrupt-controller/arm-gic.h>
--=20
2.21.0

