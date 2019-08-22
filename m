Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6757C3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 09:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85ACD233A0
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 09:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733299AbfHVJd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 05:33:56 -0400
Received: from shell.v3.sk ([90.176.6.54]:35833 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733263AbfHVJdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 05:33:52 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 85DC5D7568;
        Thu, 22 Aug 2019 11:33:47 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id sVi2EZBn7Y0o; Thu, 22 Aug 2019 11:33:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 5275ED755A;
        Thu, 22 Aug 2019 11:32:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ClbKA0x62TeE; Thu, 22 Aug 2019 11:27:29 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 92AC0D7564;
        Thu, 22 Aug 2019 11:26:49 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Olof Johansson <olof@lixom.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2 10/20] ARM: l2c: add definition for FWA in PL310 aux register
Date:   Thu, 22 Aug 2019 11:26:33 +0200
Message-Id: <20190822092643.593488-11-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190822092643.593488-1-lkundrak@v3.sk>
References: <20190822092643.593488-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PL310 also has a "Force write allocate" bits in the Auxiliary
Control Register.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/arm/include/asm/hardware/cache-l2x0.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/include/asm/hardware/cache-l2x0.h b/arch/arm/includ=
e/asm/hardware/cache-l2x0.h
index 32edfadb15935..a6d4ee86ba543 100644
--- a/arch/arm/include/asm/hardware/cache-l2x0.h
+++ b/arch/arm/include/asm/hardware/cache-l2x0.h
@@ -118,6 +118,8 @@
 #define L310_AUX_CTRL_STORE_LIMITATION		BIT(11)	/* R2P0+ */
 #define L310_AUX_CTRL_EXCLUSIVE_CACHE		BIT(12)
 #define L310_AUX_CTRL_ASSOCIATIVITY_16		BIT(16)
+#define L310_AUX_CTRL_FWA_SHIFT			23
+#define L310_AUX_CTRL_FWA_MASK			(3 << 23)
 #define L310_AUX_CTRL_CACHE_REPLACE_RR		BIT(25)	/* R2P0+ */
 #define L310_AUX_CTRL_NS_LOCKDOWN		BIT(26)
 #define L310_AUX_CTRL_NS_INT_CTRL		BIT(27)
--=20
2.21.0

