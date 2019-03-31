Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFCDC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 22:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 830712084B
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 22:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731598AbfCaWK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 18:10:29 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:57585 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731447AbfCaWK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 18:10:26 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hAien-0004qP-8Z; Mon, 01 Apr 2019 00:10:25 +0200
Message-Id: <20190331215135.029727906@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 31 Mar 2019 23:40:23 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [patch 03/14] x86/exceptions: Remove unused stack defines on 32bit
References: <20190331214020.836098943@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nothing requires those for 32bit builds.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/page_32_types.h |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

--- a/arch/x86/include/asm/page_32_types.h
+++ b/arch/x86/include/asm/page_32_types.h
@@ -22,11 +22,7 @@
 #define THREAD_SIZE_ORDER	1
 #define THREAD_SIZE		(PAGE_SIZE << THREAD_SIZE_ORDER)
 
-#define DOUBLEFAULT_STACK 1
-#define NMI_STACK 0
-#define DEBUG_STACK 0
-#define MCE_STACK 0
-#define N_EXCEPTION_STACKS 1
+#define N_EXCEPTION_STACKS	1
 
 #ifdef CONFIG_X86_PAE
 /*


