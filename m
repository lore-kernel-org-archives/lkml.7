Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1279C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76F41218D2
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730668AbfDXNrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 09:47:36 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:53809 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730651AbfDXNrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 09:47:35 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hJIFJ-0001AX-L5; Wed, 24 Apr 2019 15:47:33 +0200
Message-Id: <20190424134223.501598258@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 24 Apr 2019 15:41:16 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Juergen Gross <jgross@suse.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [patch 1/3] x86/paravirt: Remove bogus extern declarations
References: <20190424134115.091452807@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These functions are already declared in asm/paravirt.h

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/paravirt_patch_32.c |    3 ---
 arch/x86/kernel/paravirt_patch_64.c |    3 ---
 2 files changed, 6 deletions(-)

--- a/arch/x86/kernel/paravirt_patch_32.c
+++ b/arch/x86/kernel/paravirt_patch_32.c
@@ -23,9 +23,6 @@ DEF_NATIVE(lock, queued_spin_unlock, "mo
 DEF_NATIVE(lock, vcpu_is_preempted, "xor %eax, %eax");
 #endif
 
-extern bool pv_is_native_spin_unlock(void);
-extern bool pv_is_native_vcpu_is_preempted(void);
-
 unsigned native_patch(u8 type, void *ibuf, unsigned long addr, unsigned len)
 {
 #define PATCH_SITE(ops, x)					\
--- a/arch/x86/kernel/paravirt_patch_64.c
+++ b/arch/x86/kernel/paravirt_patch_64.c
@@ -29,9 +29,6 @@ DEF_NATIVE(lock, queued_spin_unlock, "mo
 DEF_NATIVE(lock, vcpu_is_preempted, "xor %eax, %eax");
 #endif
 
-extern bool pv_is_native_spin_unlock(void);
-extern bool pv_is_native_vcpu_is_preempted(void);
-
 unsigned native_patch(u8 type, void *ibuf, unsigned long addr, unsigned len)
 {
 #define PATCH_SITE(ops, x)					\


