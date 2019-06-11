Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4C8C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 07:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C4972086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 07:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404355AbfFKH3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 03:29:44 -0400
Received: from shell.v3.sk ([90.176.6.54]:60977 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404240AbfFKH3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 03:29:41 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 8111A104F8B;
        Tue, 11 Jun 2019 09:29:38 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id VfebsCDJDAK9; Tue, 11 Jun 2019 09:29:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id AD63C104F73;
        Tue, 11 Jun 2019 09:29:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Xx40R8ZfYhLh; Tue, 11 Jun 2019 09:29:24 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 7017F104F80;
        Tue, 11 Jun 2019 09:29:24 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Olof Johansson <olof@lixom.net>
Cc:     Wei Xu <xuwei5@hisilicon.com>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Patrice Chotard <patrice.chotard@st.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 3/6] ARM: dts: mmp2: Switch to SPDX header
Date:   Tue, 11 Jun 2019 09:29:18 +0200
Message-Id: <20190611072921.2979446-4-lkundrak@v3.sk>
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
 arch/arm/boot/dts/mmp2-brownstone.dts | 5 +----
 arch/arm/boot/dts/mmp2.dtsi           | 5 +----
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/mmp2-brownstone.dts b/arch/arm/boot/dts/mm=
p2-brownstone.dts
index 3da038ba5733..2d5df1d1dad4 100644
--- a/arch/arm/boot/dts/mmp2-brownstone.dts
+++ b/arch/arm/boot/dts/mmp2-brownstone.dts
@@ -1,10 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *  Copyright (C) 2012 Marvell Technology Group Ltd.
  *  Author: Haojian Zhuang <haojian.zhuang@marvell.com>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  publishhed by the Free Software Foundation.
  */
=20
 /dts-v1/;
diff --git a/arch/arm/boot/dts/mmp2.dtsi b/arch/arm/boot/dts/mmp2.dtsi
index f02fb97f515c..b8c2d7eaa715 100644
--- a/arch/arm/boot/dts/mmp2.dtsi
+++ b/arch/arm/boot/dts/mmp2.dtsi
@@ -1,10 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *  Copyright (C) 2012 Marvell Technology Group Ltd.
  *  Author: Haojian Zhuang <haojian.zhuang@marvell.com>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  publishhed by the Free Software Foundation.
  */
=20
 #include <dt-bindings/clock/marvell,mmp2.h>
--=20
2.21.0

