Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AAAC10F14
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 02:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEEC820833
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 02:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfDVC6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 22:58:15 -0400
Received: from mail2.tencent.com ([163.177.67.195]:57363 "EHLO
        mail2.tencent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbfDVC6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 22:58:15 -0400
X-Greylist: delayed 477 seconds by postgrey-1.27 at vger.kernel.org; Sun, 21 Apr 2019 22:58:14 EDT
Received: from EXHUB-SZMail01.tencent.com (unknown [10.14.6.21])
        by mail2.tencent.com (Postfix) with ESMTP id 3A3928E86E;
        Mon, 22 Apr 2019 10:50:14 +0800 (CST)
Received: from localhost.localdomain (10.35.10.44) by
 EXHUB-SZMail01.tencent.com (10.14.6.21) with Microsoft SMTP Server id
 14.3.408.0; Mon, 22 Apr 2019 10:50:13 +0800
From:   Jiang Biao <benbjiang@tencent.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        <benbjiang@tencent.com>
Subject: [PATCH] asm/irq_vector.h: fix outdated comments
Date:   Mon, 22 Apr 2019 10:49:43 +0800
Message-ID: <20190422024943.71918-1-benbjiang@tencent.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.35.10.44]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

INVALIDATE_TLB_VECTOR_START has been removed by commit,
52aec3308db8("x86/tlb: replace INVALIDATE_TLB_VECTOR by
CALL_FUNCTION_VECTOR")
And VSYSCALL_EMU_VECTO(204) has also been remove by commit,
3ae36655b97a("x86-64: Rework vsyscall emulation and add vsyscall=
parameter")
but the comments here are outdated, update them.

Signed-off-by: Jiang Biao <benbjiang@tencent.com>
---
 arch/x86/include/asm/irq_vectors.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/irq_vectors.h b/arch/x86/include/asm/irq_vectors.h
index 548d90bbf919..889f8b1b5b7f 100644
--- a/arch/x86/include/asm/irq_vectors.h
+++ b/arch/x86/include/asm/irq_vectors.h
@@ -18,8 +18,8 @@
  *  Vectors   0 ...  31 : system traps and exceptions - hardcoded events
  *  Vectors  32 ... 127 : device interrupts
  *  Vector  128         : legacy int80 syscall interface
- *  Vectors 129 ... INVALIDATE_TLB_VECTOR_START-1 except 204 : device interrupts
- *  Vectors INVALIDATE_TLB_VECTOR_START ... 255 : special interrupts
+ *  Vectors 129 ... LOCAL_TIMER_VECTOR-1
+ *  Vectors LOCAL_TIMER_VECTOR ... 255 : special interrupts
  *
  * 64-bit x86 has per CPU IDT tables, 32-bit has one shared IDT table.
  *
-- 
2.17.2 (Apple Git-113)

