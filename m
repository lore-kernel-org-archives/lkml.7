Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D5FAC48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01D9A21670
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="P0cWMohr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbfFZOIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 10:08:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41987 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfFZOIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 10:08:22 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5QE79ek4135902
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 26 Jun 2019 07:07:09 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5QE79ek4135902
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561558030;
        bh=nrf4YhrjU86Fm8glLH2+q0CeNX8zUFQc6avfpF5+lC0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=P0cWMohrhKOZQOuEz3it1JZkqVsMSRoHdmZF6SS6CAaEaYTEgTV12MK/+Wl9r+xmZ
         jmjv96oZHYGxFkNYNnDttIRmKNd4guIkmzrInedU9zpUiGhPqMIsg4lkatJER1MzJ/
         uQoyj5W9fH83Bh3rRyRs+twG/9RjtUlf08UrIJ5XZMQ1H9CSlPB8rSoVoDL5U5DeXz
         3xf0J8/jVvp1QIP6HoHPGNxR/PPtt9mWZIiNXuytU8trPt5KsHGfDcOiImLG1z3NVO
         4EZmilcOYDbp5Zm3pHASmS3TCAj9QGzvrWq2nl95B8oYdZYjuKa9CSPNC5Ku916NOc
         cdp5BAxk54OUQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5QE78sN4135892;
        Wed, 26 Jun 2019 07:07:08 -0700
Date:   Wed, 26 Jun 2019 07:07:08 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tiezhu Yang <tipbot@zytor.com>
Message-ID: <tip-53b7607382b0b99d6ae1ef5b1b0fa042b00ac7f4@git.kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, dyoung@redhat.com,
        kernelpatch@126.com, vgoyal@redhat.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com
Reply-To: hpa@zytor.com, linux-kernel@vger.kernel.org, vgoyal@redhat.com,
          tglx@linutronix.de, kernelpatch@126.com, dyoung@redhat.com,
          mingo@kernel.org
In-Reply-To: <117ef0c6.3d30.16b87c9cfbf.Coremail.kernelpatch@126.com>
References: <117ef0c6.3d30.16b87c9cfbf.Coremail.kernelpatch@126.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cleanups] x86/kexec: Make variable static and config
 dependent
Git-Commit-ID: 53b7607382b0b99d6ae1ef5b1b0fa042b00ac7f4
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

Commit-ID:  53b7607382b0b99d6ae1ef5b1b0fa042b00ac7f4
Gitweb:     https://git.kernel.org/tip/53b7607382b0b99d6ae1ef5b1b0fa042b00ac7f4
Author:     Tiezhu Yang <kernelpatch@126.com>
AuthorDate: Mon, 24 Jun 2019 12:41:18 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 26 Jun 2019 16:02:45 +0200

x86/kexec: Make variable static and config dependent

The following sparse warning is emitted:

  arch/x86/kernel/crash.c:59:15:
  warning: symbol 'crash_zero_bytes' was not declared. Should it be static?

The variable is only used in this compilation unit, but it is also only
used when CONFIG_KEXEC_FILE is enabled. Just making it static would result
in a 'defined but not used' warning for CONFIG_KEXEC_FILE=n.

Make it static and move it into the existing CONFIG_KEXEC_FILE section.

[ tglx: Massaged changelog and moved it into the existing ifdef ]

Fixes: dd5f726076cc ("kexec: support for kexec on panic using new system call")
Signed-off-by: Tiezhu Yang <kernelpatch@126.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Dave Young <dyoung@redhat.com>
Cc: bp@alien8.de
Cc: hpa@zytor.com
Cc: kexec@lists.infradead.org
Cc: vgoyal@redhat.com
Cc: Vivek Goyal <vgoyal@redhat.com>
Link: https://lkml.kernel.org/r/117ef0c6.3d30.16b87c9cfbf.Coremail.kernelpatch@126.com
---
 arch/x86/kernel/crash.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 576b2e1bfc12..27157d66f807 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -56,7 +56,6 @@ struct crash_memmap_data {
  */
 crash_vmclear_fn __rcu *crash_vmclear_loaded_vmcss = NULL;
 EXPORT_SYMBOL_GPL(crash_vmclear_loaded_vmcss);
-unsigned long crash_zero_bytes;
 
 static inline void cpu_crash_vmclear_loaded_vmcss(void)
 {
@@ -181,6 +180,9 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
 }
 
 #ifdef CONFIG_KEXEC_FILE
+
+static unsigned long crash_zero_bytes;
+
 static int get_nr_ram_ranges_callback(struct resource *res, void *arg)
 {
 	unsigned int *nr_ranges = arg;
