Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1DFCC31E40
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 20:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E5C3204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 20:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="BHU5ZVR9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436491AbfFKUoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 16:44:24 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34519 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405843AbfFKUoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 16:44:24 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5BKhGgT365626
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 11 Jun 2019 13:43:16 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5BKhGgT365626
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560285797;
        bh=1n7aUfZ97JSp4xFQ3PjE3Ez/FC8yS/PdBSFp6zkA8Uo=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=BHU5ZVR9IoFlEm6221JQjSInO79uOTbs1lgw1oqSXtZR+gRhLAXeALGSKJfDEHl49
         1Ugd2mtW7vicYxlbFeJoi2m5n8OoiVIXk7r9DOfnBpeURtME8FdaJSvv9cGG6iTKq1
         h5i5jAKKwnmF3wO0wFplqOsZ7y/b+erzM5Y58iZLsalnhbesoerFXZmVc1kYU851RC
         4j/ZAaGCL+C1kqocRu6KqTV1slloC8CwTUM+rdtlqPsvZYQGbh+1TBVDd/L690uNee
         0DyQREk7PsXuJUPXuH/Nv98bWSTXNz4zJQJHRZjLdpCPa3ESJwcSDlt3mLcfYNazgD
         92yK3CRNZwfdA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5BKhFGi365623;
        Tue, 11 Jun 2019 13:43:15 -0700
Date:   Tue, 11 Jun 2019 13:43:15 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Zhao Yakui <tipbot@zytor.com>
Message-ID: <tip-ecca25029473bee6e98ce062e76b7310904bbdd1@git.kernel.org>
Cc:     hpa@zytor.com, nstange@suse.de, sstabellini@kernel.org,
        frederic@kernel.org, mingo@redhat.com, x86@kernel.org, bp@suse.de,
        haiyangz@microsoft.com, sthemmin@microsoft.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de,
        pbonzini@redhat.com, kys@microsoft.com, yakui.zhao@intel.com,
        jgross@suse.com, sashal@kernel.org, boris.ostrovsky@oracle.com,
        peterz@infradead.org
Reply-To: boris.ostrovsky@oracle.com, peterz@infradead.org,
          kys@microsoft.com, yakui.zhao@intel.com, sashal@kernel.org,
          jgross@suse.com, sthemmin@microsoft.com, haiyangz@microsoft.com,
          pbonzini@redhat.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, mingo@kernel.org, mingo@redhat.com,
          frederic@kernel.org, sstabellini@kernel.org, hpa@zytor.com,
          nstange@suse.de, bp@suse.de, x86@kernel.org
In-Reply-To: <1559108037-18813-2-git-send-email-yakui.zhao@intel.com>
References: <1559108037-18813-2-git-send-email-yakui.zhao@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/platform] x86/Kconfig: Add new X86_HV_CALLBACK_VECTOR
 config symbol
Git-Commit-ID: ecca25029473bee6e98ce062e76b7310904bbdd1
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

Commit-ID:  ecca25029473bee6e98ce062e76b7310904bbdd1
Gitweb:     https://git.kernel.org/tip/ecca25029473bee6e98ce062e76b7310904bbdd1
Author:     Zhao Yakui <yakui.zhao@intel.com>
AuthorDate: Tue, 30 Apr 2019 11:45:23 +0800
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Tue, 11 Jun 2019 21:21:11 +0200

x86/Kconfig: Add new X86_HV_CALLBACK_VECTOR config symbol

Add a special Kconfig symbol X86_HV_CALLBACK_VECTOR so that the guests
using the hypervisor interrupt callback counter can select and thus
enable that counter. Select it when xen or hyperv support is enabled. No
functional changes.

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
Cc: Nicolai Stange <nstange@suse.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sasha Levin <sashal@kernel.org>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Cc: xen-devel@lists.xenproject.org
Link: https://lkml.kernel.org/r/1559108037-18813-2-git-send-email-yakui.zhao@intel.com
---
 arch/x86/Kconfig               | 3 +++
 arch/x86/include/asm/hardirq.h | 2 +-
 arch/x86/kernel/irq.c          | 2 +-
 arch/x86/xen/Kconfig           | 1 +
 drivers/hv/Kconfig             | 1 +
 5 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2bbbd4d1ba31..c9ab09004b16 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -781,6 +781,9 @@ config PARAVIRT_SPINLOCKS
 
 	  If you are unsure how to answer this question, answer Y.
 
+config X86_HV_CALLBACK_VECTOR
+	def_bool n
+
 source "arch/x86/xen/Kconfig"
 
 config KVM_GUEST
diff --git a/arch/x86/include/asm/hardirq.h b/arch/x86/include/asm/hardirq.h
index d9069bb26c7f..07533795b8d2 100644
--- a/arch/x86/include/asm/hardirq.h
+++ b/arch/x86/include/asm/hardirq.h
@@ -37,7 +37,7 @@ typedef struct {
 #ifdef CONFIG_X86_MCE_AMD
 	unsigned int irq_deferred_error_count;
 #endif
-#if IS_ENABLED(CONFIG_HYPERV) || defined(CONFIG_XEN)
+#ifdef CONFIG_X86_HV_CALLBACK_VECTOR
 	unsigned int irq_hv_callback_count;
 #endif
 #if IS_ENABLED(CONFIG_HYPERV)
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 9b68b5b00ac9..4e8f193ad81f 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -135,7 +135,7 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 		seq_printf(p, "%10u ", per_cpu(mce_poll_count, j));
 	seq_puts(p, "  Machine check polls\n");
 #endif
-#if IS_ENABLED(CONFIG_HYPERV) || defined(CONFIG_XEN)
+#ifdef CONFIG_X86_HV_CALLBACK_VECTOR
 	if (test_bit(HYPERVISOR_CALLBACK_VECTOR, system_vectors)) {
 		seq_printf(p, "%*s: ", prec, "HYP");
 		for_each_online_cpu(j)
diff --git a/arch/x86/xen/Kconfig b/arch/x86/xen/Kconfig
index e07abefd3d26..ba5a41828e9d 100644
--- a/arch/x86/xen/Kconfig
+++ b/arch/x86/xen/Kconfig
@@ -7,6 +7,7 @@ config XEN
 	bool "Xen guest support"
 	depends on PARAVIRT
 	select PARAVIRT_CLOCK
+	select X86_HV_CALLBACK_VECTOR
 	depends on X86_64 || (X86_32 && X86_PAE)
 	depends on X86_LOCAL_APIC && X86_TSC
 	help
diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 1c1a2514d6f3..cafcb974dcfe 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -6,6 +6,7 @@ config HYPERV
 	tristate "Microsoft Hyper-V client drivers"
 	depends on X86 && ACPI && X86_LOCAL_APIC && HYPERVISOR_GUEST
 	select PARAVIRT
+	select X86_HV_CALLBACK_VECTOR
 	help
 	  Select this option to run Linux as a Hyper-V client operating
 	  system.
