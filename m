Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BE0C31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 611282087F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbfFQM0B convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 08:26:01 -0400
Received: from mx1.emlix.com ([188.40.240.192]:37808 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726424AbfFQM0B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 08:26:01 -0400
Received: from mailer.emlix.com (unknown [81.20.119.6])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id B25D4600A1;
        Mon, 17 Jun 2019 14:25:59 +0200 (CEST)
From:   Rolf Eike Beer <eb@emlix.com>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: riscv: remove unused barrier defines
Date:   Mon, 17 Jun 2019 14:25:59 +0200
Message-ID: <1862877.fiP6YxjBP5@devpool35>
Organization: emlix GmbH
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From 947f9fe483dc6561e31f0d2294eb6fedc1d6d9bb Mon Sep 17 00:00:00 2001
From: Rolf Eike Beer <eb@emlix.com>
Date: Mon, 17 Jun 2019 14:22:37 +0200
Subject: [PATCH] riscv: remove unused barrier defines

They were introduced in fab957c11efe2f405e08b9f0d080524bc2631428 long after
2e39465abc4b7856a0ea6fcf4f6b4668bb5db877 removed the remnants of all previous
instances from the tree.

Signed-off-by: Rolf Eike Beer <eb@emlix.com>
---
 arch/riscv/include/asm/bitops.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/riscv/include/asm/bitops.h b/arch/riscv/include/asm/bitops.h
index 3943be480af0..396a3303c537 100644
--- a/arch/riscv/include/asm/bitops.h
+++ b/arch/riscv/include/asm/bitops.h
@@ -15,11 +15,6 @@
 #include <asm/barrier.h>
 #include <asm/bitsperlong.h>
 
-#ifndef smp_mb__before_clear_bit
-#define smp_mb__before_clear_bit()  smp_mb()
-#define smp_mb__after_clear_bit()   smp_mb()
-#endif /* smp_mb__before_clear_bit */
-
 #include <asm-generic/bitops/__ffs.h>
 #include <asm-generic/bitops/ffz.h>
 #include <asm-generic/bitops/fls.h>
-- 
2.21.0
-- 
Rolf Eike Beer, emlix GmbH, http://www.emlix.com
Fon +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 Göttingen, Germany
Sitz der Gesellschaft: Göttingen, Amtsgericht Göttingen HR B 3160
Geschäftsführung: Heike Jordan, Dr. Uwe Kracke – Ust-IdNr.: DE 205 198 055

emlix - smart embedded open source


