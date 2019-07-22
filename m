Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E433AC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C938820693
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732014AbfGVS5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 14:57:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38054 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731891AbfGVS5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 14:57:03 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hpdUc-0002PJ-5s; Mon, 22 Jul 2019 20:57:02 +0200
Message-Id: <20190722105219.526508168@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 22 Jul 2019 20:47:13 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Nadav Amit <namit@vmware.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Feng Tang <feng.tang@intel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Subject: [patch V3 08/25] x86/apic: Move apic_flat_64 header into apic
 directory
References: <20190722104705.550071814@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only used locally.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/apic_flat_64.h  |    8 --------
 arch/x86/kernel/apic/apic_flat_64.c  |    2 +-
 arch/x86/kernel/apic/apic_flat_64.h  |    8 ++++++++
 arch/x86/kernel/apic/apic_numachip.c |    2 +-
 4 files changed, 10 insertions(+), 10 deletions(-)

--- a/arch/x86/include/asm/apic_flat_64.h
+++ /dev/null
@@ -1,8 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_X86_APIC_FLAT_64_H
-#define _ASM_X86_APIC_FLAT_64_H
-
-extern void flat_init_apic_ldr(void);
-
-#endif
-
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -13,9 +13,9 @@
 #include <linux/acpi.h>
 
 #include <asm/jailhouse_para.h>
-#include <asm/apic_flat_64.h>
 #include <asm/apic.h>
 
+#include "apic_flat_64.h"
 #include "ipi.h"
 
 static struct apic apic_physflat;
--- /dev/null
+++ b/arch/x86/kernel/apic/apic_flat_64.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_APIC_FLAT_64_H
+#define _ASM_X86_APIC_FLAT_64_H
+
+extern void flat_init_apic_ldr(void);
+
+#endif
+
--- a/arch/x86/kernel/apic/apic_numachip.c
+++ b/arch/x86/kernel/apic/apic_numachip.c
@@ -16,9 +16,9 @@
 #include <asm/numachip/numachip.h>
 #include <asm/numachip/numachip_csr.h>
 
-#include <asm/apic_flat_64.h>
 #include <asm/pgtable.h>
 
+#include "apic_flat_64.h"
 #include "ipi.h"
 
 u8 numachip_system __read_mostly;


