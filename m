Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3786C31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EBDB20657
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfFQMYP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 08:24:15 -0400
Received: from mx1.emlix.com ([188.40.240.192]:37784 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbfFQMYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 08:24:14 -0400
Received: from mailer.emlix.com (unknown [81.20.119.6])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id EC211600A1;
        Mon, 17 Jun 2019 14:24:12 +0200 (CEST)
From:   Rolf Eike Beer <eb@emlix.com>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     uclinux-h8-devel@lists.sourceforge.jp, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] H8300: remove unused barrier defines
Date:   Mon, 17 Jun 2019 14:24:12 +0200
Message-ID: <5435162.LEDey6R3HY@devpool35>
Organization: emlix GmbH
In-Reply-To: <2401183.V4Yr0kgUre@devpool21>
References: <2401183.V4Yr0kgUre@devpool21>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From c907e749917f430e3dc62048985c8419778572f9 Mon Sep 17 00:00:00 2001
From: Rolf Eike Beer <eb@emlix.com>
Date: Fri, 14 Jul 2017 11:19:08 +0200
Subject: [PATCH] H8300: remove unused barrier defines

They were introduced in d2a5f4999f6c211adf30d9788349e13988d6f2a7 long after
2e39465abc4b7856a0ea6fcf4f6b4668bb5db877 removed the remnants of all previous
instances from the tree.

Signed-off-by: Rolf Eike Beer <eb@emlix.com>
---
 arch/h8300/include/asm/bitops.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/h8300/include/asm/bitops.h b/arch/h8300/include/asm/bitops.h
index 647a83bd40b7..7aa16c732aa9 100644
--- a/arch/h8300/include/asm/bitops.h
+++ b/arch/h8300/include/asm/bitops.h
@@ -51,12 +51,6 @@ static inline void FNAME(int nr, volatile unsigned long *addr)	\
 	}							\
 }
 
-/*
- * clear_bit() doesn't provide any barrier for the compiler.
- */
-#define smp_mb__before_clear_bit()	barrier()
-#define smp_mb__after_clear_bit()	barrier()
-
 H8300_GEN_BITOP(set_bit,    "bset")
 H8300_GEN_BITOP(clear_bit,  "bclr")
 H8300_GEN_BITOP(change_bit, "bnot")
-- 
2.21.0
-- 
Rolf Eike Beer, emlix GmbH, http://www.emlix.com
Fon +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 Göttingen, Germany
Sitz der Gesellschaft: Göttingen, Amtsgericht Göttingen HR B 3160
Geschäftsführung: Heike Jordan, Dr. Uwe Kracke – Ust-IdNr.: DE 205 198 055

emlix - smart embedded open source


