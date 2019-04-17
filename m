Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB2BC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A4E62177B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="CoeHUw8i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732393AbfDQOFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:05:47 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39569 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731960AbfDQOFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:05:47 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3HE5Ksf3932925
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 17 Apr 2019 07:05:21 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3HE5Ksf3932925
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041743; t=1555509921;
        bh=pobE8QEhbjkm5vdI7GHWFpL+JdevApp18b41bVq08e4=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=CoeHUw8ioeUontAEIj1m5crjcUNVknDJNA8+iAoaxPwDHO9pflf5LtBMRKuxrkr3Y
         ZLRhl76uUPVMHKaNhOwVI+m/NJIOzfwyMkjgyDcoxpWKtomEJzZ5+wi8dBM/qo46j7
         EqXg1B5sQLsUbiOWoK76Qj26fhno7GeWFQDut5LrD6RoI2DXuXpcUzg8f5GauCgY0D
         h6Qrm3mpGTR0p1RKzpARs/ERn5Eao8XJz9a4v2BIL2GM1WWDygux2V6+fYBFWJL/Jj
         +ea3uT8fsSG/+lWRbOUdctqfqRhc8e34KS85mCudhrqhXEndtUo0BWW1+lYmVW2ekb
         2xgLEK0keoHmQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3HE5KUm3932922;
        Wed, 17 Apr 2019 07:05:20 -0700
Date:   Wed, 17 Apr 2019 07:05:20 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-99d334511b337884cadbdfae28da912a4edb1001@git.kernel.org>
Cc:     hpa@zytor.com, x86@kernel.org, mingo@kernel.org,
        douly.fnst@cn.fujitsu.com, tglx@linutronix.de,
        sean.j.christopherson@intel.com, nstange@suse.de,
        linux-kernel@vger.kernel.org, mingo@redhat.com, bp@suse.de,
        jpoimboe@redhat.com, luto@kernel.org
Reply-To: hpa@zytor.com, mingo@kernel.org, douly.fnst@cn.fujitsu.com,
          x86@kernel.org, tglx@linutronix.de,
          sean.j.christopherson@intel.com, nstange@suse.de,
          linux-kernel@vger.kernel.org, mingo@redhat.com, bp@suse.de,
          jpoimboe@redhat.com, luto@kernel.org
In-Reply-To: <20190414160144.050689789@linutronix.de>
References: <20190414160144.050689789@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/irq] x86/idt: Remove unused macro SISTG
Git-Commit-ID: 99d334511b337884cadbdfae28da912a4edb1001
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  99d334511b337884cadbdfae28da912a4edb1001
Gitweb:     https://git.kernel.org/tip/99d334511b337884cadbdfae28da912a4edb1001
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 14 Apr 2019 17:59:42 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 17 Apr 2019 12:36:19 +0200

x86/idt: Remove unused macro SISTG

Commit

  d8ba61ba58c8 ("x86/entry/64: Don't use IST entry for #BP stack")

removed the last user but left the macro around.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Nicolai Stange <nstange@suse.de>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190414160144.050689789@linutronix.de
---
 arch/x86/kernel/idt.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index 01adea278a71..2877606e97de 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -45,10 +45,6 @@ struct idt_data {
 #define ISTG(_vector, _addr, _ist)			\
 	G(_vector, _addr, _ist, GATE_INTERRUPT, DPL0, __KERNEL_CS)
 
-/* System interrupt gate with interrupt stack */
-#define SISTG(_vector, _addr, _ist)			\
-	G(_vector, _addr, _ist, GATE_INTERRUPT, DPL3, __KERNEL_CS)
-
 /* Task gate */
 #define TSKG(_vector, _gdt)				\
 	G(_vector, NULL, DEFAULT_STACK, GATE_TASK, DPL0, _gdt << 3)
