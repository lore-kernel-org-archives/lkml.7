Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C70C282DE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 11:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3977420851
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 11:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="XctPffSc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730461AbfEWLkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 07:40:21 -0400
Received: from mail.skyhub.de ([5.9.137.197]:46340 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729966AbfEWLkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 07:40:21 -0400
Received: from cz.tnic (ip65-44-65-130.z65-44-65.customer.algx.net [65.44.65.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B10231EC0A6C;
        Thu, 23 May 2019 13:40:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1558611618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=2yMNQeGm6UFY2vb+yAxHwOHBfMVr3uLEA0lUDu9tB5o=;
        b=XctPffScadx9dKhQdf1dURrZPZjd8ZFoE7/vCnRH5qgV97874ZoQHuLF5gBbcrZetS6urF
        O6rh3HSOOGyonsX/Sv6nhFRx1dKSXIF1h1Eobupr1/6fz48SJuct4DlmCzsiIrfDjJ4CdO
        l6KJfJr1XfK86nRD14CbQF9epEEuqlQ=
Date:   Thu, 23 May 2019 13:40:51 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     TonyWWang-oc <TonyWWang-oc@zhaoxin.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        David Wang <DavidWang@zhaoxin.com>,
        "Cooper Yan(BJ-RD)" <CooperYan@zhaoxin.com>,
        "Qiyuan Wang(BJ-RD)" <QiyuanWang@zhaoxin.com>,
        "Herry Yang(BJ-RD)" <HerryYang@zhaoxin.com>
Subject: Re: [PATCH v1 1/3] x86/cpu: Create Zhaoxin processors architecture
 support file
Message-ID: <20190523114051.GA3268@cz.tnic>
References: <b3b31fab04814140b1feb13887c4aa2a@zhaoxin.com>
 <20190523102417.GC11016@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190523102417.GC11016@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 12:24:17PM +0200, gregkh@linuxfoundation.org wrote:
> This patch is totally corrupted, with leading spaces dropped and tabs
> turned into spaces.  Please read the email client documentation in the
> kernel directory for how to fix your email client, or just use 'git
> send-email' to send the patches out directly.

.. and before you do that, run them all through checkpatch.pl and apply
common sense when fixing the warnings from it:


ERROR: patch seems to be corrupt (line wrapped?)
#42: FILE: MAINTAINERS:17459:
S: Maintained

WARNING: MAINTAINERS entries use one tab after TYPE:
#45: FILE: MAINTAINERS:17461:
+M: TonyWWang <TonyWWang-oc@zhaoxin.com>

WARNING: MAINTAINERS entries use one tab after TYPE:
#46: FILE: MAINTAINERS:17462:
+L: linux-kernel@vger.kernel.org

WARNING: MAINTAINERS entries use one tab after TYPE:
#47: FILE: MAINTAINERS:17463:
+S: Maintained

WARNING: MAINTAINERS entries use one tab after TYPE:
#48: FILE: MAINTAINERS:17464:
+F: arch/x86/kernel/cpu/zhaoxin.c

WARNING: prefer 'help' over '---help---' for new help texts
#61: FILE: arch/x86/Kconfig.cpu:483:
+config CPU_SUP_ZHAOXIN

WARNING: please, no spaces at the start of a line
#140: FILE: arch/x86/kernel/cpu/zhaoxin.c:39:
+   u32  lo, hi;$

WARNING: please, no spaces at the start of a line
#143: FILE: arch/x86/kernel/cpu/zhaoxin.c:42:
+   if (cpuid_eax(0xC0000000) >= 0xC0000001) {$

WARNING: suspect code indent for conditional statements (3, 6)
#143: FILE: arch/x86/kernel/cpu/zhaoxin.c:42:
+   if (cpuid_eax(0xC0000000) >= 0xC0000001) {
+      u32 tmp = cpuid_edx(0xC0000001);

WARNING: please, no spaces at the start of a line
#144: FILE: arch/x86/kernel/cpu/zhaoxin.c:43:
+      u32 tmp = cpuid_edx(0xC0000001);$

WARNING: please, no spaces at the start of a line
#147: FILE: arch/x86/kernel/cpu/zhaoxin.c:46:
+      if ((tmp & (ACE_PRESENT | ACE_ENABLED)) == ACE_PRESENT) {$

WARNING: suspect code indent for conditional statements (6, 10)
#147: FILE: arch/x86/kernel/cpu/zhaoxin.c:46:
+      if ((tmp & (ACE_PRESENT | ACE_ENABLED)) == ACE_PRESENT) {
+          rdmsr(MSR_ZHAOXIN_FCR57, lo, hi);

ERROR: code indent should use tabs where possible
#148: FILE: arch/x86/kernel/cpu/zhaoxin.c:47:
+          rdmsr(MSR_ZHAOXIN_FCR57, lo, hi);$

WARNING: please, no spaces at the start of a line
#148: FILE: arch/x86/kernel/cpu/zhaoxin.c:47:
+          rdmsr(MSR_ZHAOXIN_FCR57, lo, hi);$

ERROR: code indent should use tabs where possible
#149: FILE: arch/x86/kernel/cpu/zhaoxin.c:48:
+          lo |= ACE_FCR;       /* enable ACE unit */$

WARNING: please, no spaces at the start of a line
#149: FILE: arch/x86/kernel/cpu/zhaoxin.c:48:
+          lo |= ACE_FCR;       /* enable ACE unit */$

ERROR: code indent should use tabs where possible
#150: FILE: arch/x86/kernel/cpu/zhaoxin.c:49:
+          wrmsr(MSR_ZHAOXIN_FCR57, lo, hi);$

WARNING: please, no spaces at the start of a line
#150: FILE: arch/x86/kernel/cpu/zhaoxin.c:49:
+          wrmsr(MSR_ZHAOXIN_FCR57, lo, hi);$

ERROR: code indent should use tabs where possible
#151: FILE: arch/x86/kernel/cpu/zhaoxin.c:50:
+          pr_info("CPU: Enabled ACE h/w crypto\n");$

WARNING: please, no spaces at the start of a line
#151: FILE: arch/x86/kernel/cpu/zhaoxin.c:50:
+          pr_info("CPU: Enabled ACE h/w crypto\n");$

WARNING: please, no spaces at the start of a line
#152: FILE: arch/x86/kernel/cpu/zhaoxin.c:51:
+      }$

WARNING: please, no spaces at the start of a line
#155: FILE: arch/x86/kernel/cpu/zhaoxin.c:54:
+      if ((tmp & (RNG_PRESENT | RNG_ENABLED)) == RNG_PRESENT) {$

WARNING: suspect code indent for conditional statements (6, 10)
#155: FILE: arch/x86/kernel/cpu/zhaoxin.c:54:
+      if ((tmp & (RNG_PRESENT | RNG_ENABLED)) == RNG_PRESENT) {
+          rdmsr(MSR_ZHAOXIN_FCR57, lo, hi);

ERROR: code indent should use tabs where possible
#156: FILE: arch/x86/kernel/cpu/zhaoxin.c:55:
+          rdmsr(MSR_ZHAOXIN_FCR57, lo, hi);$

WARNING: please, no spaces at the start of a line
#156: FILE: arch/x86/kernel/cpu/zhaoxin.c:55:
+          rdmsr(MSR_ZHAOXIN_FCR57, lo, hi);$

ERROR: code indent should use tabs where possible
#157: FILE: arch/x86/kernel/cpu/zhaoxin.c:56:
+          lo |= RNG_ENABLE; /* enable RNG unit */$

WARNING: please, no spaces at the start of a line
#157: FILE: arch/x86/kernel/cpu/zhaoxin.c:56:
+          lo |= RNG_ENABLE; /* enable RNG unit */$

ERROR: code indent should use tabs where possible
#158: FILE: arch/x86/kernel/cpu/zhaoxin.c:57:
+          wrmsr(MSR_ZHAOXIN_FCR57, lo, hi);$

WARNING: please, no spaces at the start of a line
#158: FILE: arch/x86/kernel/cpu/zhaoxin.c:57:
+          wrmsr(MSR_ZHAOXIN_FCR57, lo, hi);$

ERROR: code indent should use tabs where possible
#159: FILE: arch/x86/kernel/cpu/zhaoxin.c:58:
+          pr_info("CPU: Enabled h/w RNG\n");$

WARNING: please, no spaces at the start of a line
#159: FILE: arch/x86/kernel/cpu/zhaoxin.c:58:
+          pr_info("CPU: Enabled h/w RNG\n");$

WARNING: please, no spaces at the start of a line
#160: FILE: arch/x86/kernel/cpu/zhaoxin.c:59:
+      }$

WARNING: Block comments should align the * on each line
#163: FILE: arch/x86/kernel/cpu/zhaoxin.c:62:
+      /* store Extended Feature Flags as
+      * word 5 of the CPU capability bit array

WARNING: please, no spaces at the start of a line
#165: FILE: arch/x86/kernel/cpu/zhaoxin.c:64:
+      c->x86_capability[CPUID_C000_0001_EDX] = cpuid_edx(0xC0000001);$

WARNING: please, no spaces at the start of a line
#166: FILE: arch/x86/kernel/cpu/zhaoxin.c:65:
+   }$

WARNING: please, no spaces at the start of a line
#168: FILE: arch/x86/kernel/cpu/zhaoxin.c:67:
+   if (c->x86 >= 0x6) {$

WARNING: suspect code indent for conditional statements (3, 6)
#168: FILE: arch/x86/kernel/cpu/zhaoxin.c:67:
+   if (c->x86 >= 0x6) {
+      set_cpu_cap(c, X86_FEATURE_REP_GOOD);

WARNING: braces {} are not necessary for single statement blocks
#168: FILE: arch/x86/kernel/cpu/zhaoxin.c:67:
+   if (c->x86 >= 0x6) {
+      set_cpu_cap(c, X86_FEATURE_REP_GOOD);
+   }

WARNING: please, no spaces at the start of a line
#169: FILE: arch/x86/kernel/cpu/zhaoxin.c:68:
+      set_cpu_cap(c, X86_FEATURE_REP_GOOD);$

WARNING: please, no spaces at the start of a line
#170: FILE: arch/x86/kernel/cpu/zhaoxin.c:69:
+   }$

WARNING: please, no spaces at the start of a line
#172: FILE: arch/x86/kernel/cpu/zhaoxin.c:71:
+   cpu_detect_cache_sizes(c);$

WARNING: please, no spaces at the start of a line
#177: FILE: arch/x86/kernel/cpu/zhaoxin.c:76:
+   if (c->x86 >= 0x6) {$

WARNING: suspect code indent for conditional statements (3, 6)
#177: FILE: arch/x86/kernel/cpu/zhaoxin.c:76:
+   if (c->x86 >= 0x6) {
+      set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);

WARNING: braces {} are not necessary for single statement blocks
#177: FILE: arch/x86/kernel/cpu/zhaoxin.c:76:
+   if (c->x86 >= 0x6) {
+      set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
+   }

WARNING: please, no spaces at the start of a line
#178: FILE: arch/x86/kernel/cpu/zhaoxin.c:77:
+      set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);$

WARNING: please, no spaces at the start of a line
#179: FILE: arch/x86/kernel/cpu/zhaoxin.c:78:
+   }$

WARNING: please, no spaces at the start of a line
#181: FILE: arch/x86/kernel/cpu/zhaoxin.c:80:
+   set_cpu_cap(c, X86_FEATURE_SYSENTER32);$

WARNING: please, no spaces at the start of a line
#183: FILE: arch/x86/kernel/cpu/zhaoxin.c:82:
+   if (c->x86_power & (1 << 8)) {$

WARNING: suspect code indent for conditional statements (3, 6)
#183: FILE: arch/x86/kernel/cpu/zhaoxin.c:82:
+   if (c->x86_power & (1 << 8)) {
+      set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);

WARNING: please, no spaces at the start of a line
#184: FILE: arch/x86/kernel/cpu/zhaoxin.c:83:
+      set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);$

WARNING: please, no spaces at the start of a line
#185: FILE: arch/x86/kernel/cpu/zhaoxin.c:84:
+      set_cpu_cap(c, X86_FEATURE_NONSTOP_TSC);$

WARNING: please, no spaces at the start of a line
#186: FILE: arch/x86/kernel/cpu/zhaoxin.c:85:
+   }$

WARNING: please, no spaces at the start of a line
#188: FILE: arch/x86/kernel/cpu/zhaoxin.c:87:
+   if (c->cpuid_level >= 0x00000001) {$

WARNING: suspect code indent for conditional statements (3, 6)
#188: FILE: arch/x86/kernel/cpu/zhaoxin.c:87:
+   if (c->cpuid_level >= 0x00000001) {
+      u32 eax, ebx, ecx, edx;

WARNING: please, no spaces at the start of a line
#189: FILE: arch/x86/kernel/cpu/zhaoxin.c:88:
+      u32 eax, ebx, ecx, edx;$

WARNING: please, no spaces at the start of a line
#191: FILE: arch/x86/kernel/cpu/zhaoxin.c:90:
+      cpuid(0x00000001, &eax, &ebx, &ecx, &edx);$

WARNING: Block comments should align the * on each line
#193: FILE: arch/x86/kernel/cpu/zhaoxin.c:92:
+      /*
+      * If HTT (EDX[28]) is set EBX[16:23] contain the number of

WARNING: please, no spaces at the start of a line
#197: FILE: arch/x86/kernel/cpu/zhaoxin.c:96:
+      if (edx & (1U << 28))$

WARNING: suspect code indent for conditional statements (6, 10)
#197: FILE: arch/x86/kernel/cpu/zhaoxin.c:96:
+      if (edx & (1U << 28))
+          c->x86_coreid_bits = get_count_order((ebx >> 16) & 0xff);

ERROR: code indent should use tabs where possible
#198: FILE: arch/x86/kernel/cpu/zhaoxin.c:97:
+          c->x86_coreid_bits = get_count_order((ebx >> 16) & 0xff);$

WARNING: please, no spaces at the start of a line
#198: FILE: arch/x86/kernel/cpu/zhaoxin.c:97:
+          c->x86_coreid_bits = get_count_order((ebx >> 16) & 0xff);$

WARNING: please, no spaces at the start of a line
#199: FILE: arch/x86/kernel/cpu/zhaoxin.c:98:
+   }$

WARNING: please, no spaces at the start of a line
#205: FILE: arch/x86/kernel/cpu/zhaoxin.c:104:
+   u32 vmx_msr_low, vmx_msr_high, msr_ctl, msr_ctl2;$

WARNING: please, no spaces at the start of a line
#207: FILE: arch/x86/kernel/cpu/zhaoxin.c:106:
+   rdmsr(MSR_IA32_VMX_PROCBASED_CTLS, vmx_msr_low, vmx_msr_high);$

WARNING: please, no spaces at the start of a line
#208: FILE: arch/x86/kernel/cpu/zhaoxin.c:107:
+   msr_ctl = vmx_msr_high | vmx_msr_low;$

WARNING: please, no spaces at the start of a line
#210: FILE: arch/x86/kernel/cpu/zhaoxin.c:109:
+   if (msr_ctl & X86_VMX_FEATURE_PROC_CTLS_TPR_SHADOW)$

WARNING: suspect code indent for conditional statements (3, 6)
#210: FILE: arch/x86/kernel/cpu/zhaoxin.c:109:
+   if (msr_ctl & X86_VMX_FEATURE_PROC_CTLS_TPR_SHADOW)
+      set_cpu_cap(c, X86_FEATURE_TPR_SHADOW);

WARNING: please, no spaces at the start of a line
#211: FILE: arch/x86/kernel/cpu/zhaoxin.c:110:
+      set_cpu_cap(c, X86_FEATURE_TPR_SHADOW);$

WARNING: please, no spaces at the start of a line
#212: FILE: arch/x86/kernel/cpu/zhaoxin.c:111:
+   if (msr_ctl & X86_VMX_FEATURE_PROC_CTLS_VNMI)$

WARNING: suspect code indent for conditional statements (3, 6)
#212: FILE: arch/x86/kernel/cpu/zhaoxin.c:111:
+   if (msr_ctl & X86_VMX_FEATURE_PROC_CTLS_VNMI)
+      set_cpu_cap(c, X86_FEATURE_VNMI);

WARNING: please, no spaces at the start of a line
#213: FILE: arch/x86/kernel/cpu/zhaoxin.c:112:
+      set_cpu_cap(c, X86_FEATURE_VNMI);$

WARNING: please, no spaces at the start of a line
#214: FILE: arch/x86/kernel/cpu/zhaoxin.c:113:
+   if (msr_ctl & X86_VMX_FEATURE_PROC_CTLS_2ND_CTLS) {$

WARNING: suspect code indent for conditional statements (3, 6)
#214: FILE: arch/x86/kernel/cpu/zhaoxin.c:113:
+   if (msr_ctl & X86_VMX_FEATURE_PROC_CTLS_2ND_CTLS) {
+      rdmsr(MSR_IA32_VMX_PROCBASED_CTLS2,

WARNING: please, no spaces at the start of a line
#215: FILE: arch/x86/kernel/cpu/zhaoxin.c:114:
+      rdmsr(MSR_IA32_VMX_PROCBASED_CTLS2,$

ERROR: code indent should use tabs where possible
#216: FILE: arch/x86/kernel/cpu/zhaoxin.c:115:
+            vmx_msr_low, vmx_msr_high);$

WARNING: please, no spaces at the start of a line
#216: FILE: arch/x86/kernel/cpu/zhaoxin.c:115:
+            vmx_msr_low, vmx_msr_high);$

WARNING: please, no spaces at the start of a line
#217: FILE: arch/x86/kernel/cpu/zhaoxin.c:116:
+      msr_ctl2 = vmx_msr_high | vmx_msr_low;$

WARNING: please, no spaces at the start of a line
#218: FILE: arch/x86/kernel/cpu/zhaoxin.c:117:
+      if ((msr_ctl2 & X86_VMX_FEATURE_PROC_CTLS2_VIRT_APIC) &&$

WARNING: suspect code indent for conditional statements (6, 10)
#218: FILE: arch/x86/kernel/cpu/zhaoxin.c:117:
+      if ((msr_ctl2 & X86_VMX_FEATURE_PROC_CTLS2_VIRT_APIC) &&
[...]
+          set_cpu_cap(c, X86_FEATURE_FLEXPRIORITY);

ERROR: code indent should use tabs where possible
#219: FILE: arch/x86/kernel/cpu/zhaoxin.c:118:
+          (msr_ctl & X86_VMX_FEATURE_PROC_CTLS_TPR_SHADOW))$

WARNING: please, no spaces at the start of a line
#219: FILE: arch/x86/kernel/cpu/zhaoxin.c:118:
+          (msr_ctl & X86_VMX_FEATURE_PROC_CTLS_TPR_SHADOW))$

ERROR: code indent should use tabs where possible
#220: FILE: arch/x86/kernel/cpu/zhaoxin.c:119:
+          set_cpu_cap(c, X86_FEATURE_FLEXPRIORITY);$

WARNING: please, no spaces at the start of a line
#220: FILE: arch/x86/kernel/cpu/zhaoxin.c:119:
+          set_cpu_cap(c, X86_FEATURE_FLEXPRIORITY);$

WARNING: please, no spaces at the start of a line
#221: FILE: arch/x86/kernel/cpu/zhaoxin.c:120:
+      if (msr_ctl2 & X86_VMX_FEATURE_PROC_CTLS2_EPT)$

WARNING: suspect code indent for conditional statements (6, 10)
#221: FILE: arch/x86/kernel/cpu/zhaoxin.c:120:
+      if (msr_ctl2 & X86_VMX_FEATURE_PROC_CTLS2_EPT)
+          set_cpu_cap(c, X86_FEATURE_EPT);

ERROR: code indent should use tabs where possible
#222: FILE: arch/x86/kernel/cpu/zhaoxin.c:121:
+          set_cpu_cap(c, X86_FEATURE_EPT);$

WARNING: please, no spaces at the start of a line
#222: FILE: arch/x86/kernel/cpu/zhaoxin.c:121:
+          set_cpu_cap(c, X86_FEATURE_EPT);$

WARNING: please, no spaces at the start of a line
#223: FILE: arch/x86/kernel/cpu/zhaoxin.c:122:
+      if (msr_ctl2 & X86_VMX_FEATURE_PROC_CTLS2_VPID)$

WARNING: suspect code indent for conditional statements (6, 10)
#223: FILE: arch/x86/kernel/cpu/zhaoxin.c:122:
+      if (msr_ctl2 & X86_VMX_FEATURE_PROC_CTLS2_VPID)
+          set_cpu_cap(c, X86_FEATURE_VPID);

ERROR: code indent should use tabs where possible
#224: FILE: arch/x86/kernel/cpu/zhaoxin.c:123:
+          set_cpu_cap(c, X86_FEATURE_VPID);$

WARNING: please, no spaces at the start of a line
#224: FILE: arch/x86/kernel/cpu/zhaoxin.c:123:
+          set_cpu_cap(c, X86_FEATURE_VPID);$

WARNING: please, no spaces at the start of a line
#225: FILE: arch/x86/kernel/cpu/zhaoxin.c:124:
+   }$

WARNING: please, no spaces at the start of a line
#230: FILE: arch/x86/kernel/cpu/zhaoxin.c:129:
+   early_init_zhaoxin(c);$

WARNING: please, no spaces at the start of a line
#231: FILE: arch/x86/kernel/cpu/zhaoxin.c:130:
+   init_intel_cacheinfo(c);$

WARNING: please, no spaces at the start of a line
#232: FILE: arch/x86/kernel/cpu/zhaoxin.c:131:
+   detect_num_cpu_cores(c);$

WARNING: please, no spaces at the start of a line
#234: FILE: arch/x86/kernel/cpu/zhaoxin.c:133:
+   detect_ht(c);$

WARNING: please, no spaces at the start of a line
#237: FILE: arch/x86/kernel/cpu/zhaoxin.c:136:
+   if (c->cpuid_level > 9) {$

WARNING: suspect code indent for conditional statements (3, 6)
#237: FILE: arch/x86/kernel/cpu/zhaoxin.c:136:
+   if (c->cpuid_level > 9) {
+      unsigned int eax = cpuid_eax(10);

WARNING: please, no spaces at the start of a line
#238: FILE: arch/x86/kernel/cpu/zhaoxin.c:137:
+      unsigned int eax = cpuid_eax(10);$

WARNING: Block comments should align the * on each line
#241: FILE: arch/x86/kernel/cpu/zhaoxin.c:140:
+      /*
+      * Check for version and the number of counters

WARNING: please, no spaces at the start of a line
#245: FILE: arch/x86/kernel/cpu/zhaoxin.c:144:
+      if ((eax & 0xff) && (((eax >> 8) & 0xff) > 1))$

WARNING: suspect code indent for conditional statements (6, 10)
#245: FILE: arch/x86/kernel/cpu/zhaoxin.c:144:
+      if ((eax & 0xff) && (((eax >> 8) & 0xff) > 1))
+          set_cpu_cap(c, X86_FEATURE_ARCH_PERFMON);

ERROR: code indent should use tabs where possible
#246: FILE: arch/x86/kernel/cpu/zhaoxin.c:145:
+          set_cpu_cap(c, X86_FEATURE_ARCH_PERFMON);$

WARNING: please, no spaces at the start of a line
#246: FILE: arch/x86/kernel/cpu/zhaoxin.c:145:
+          set_cpu_cap(c, X86_FEATURE_ARCH_PERFMON);$

WARNING: please, no spaces at the start of a line
#247: FILE: arch/x86/kernel/cpu/zhaoxin.c:146:
+   }$

WARNING: please, no spaces at the start of a line
#249: FILE: arch/x86/kernel/cpu/zhaoxin.c:148:
+   if (c->x86 >= 0x6) {$

WARNING: suspect code indent for conditional statements (3, 6)
#249: FILE: arch/x86/kernel/cpu/zhaoxin.c:148:
+   if (c->x86 >= 0x6) {
+      init_zhaoxin_cap(c);

WARNING: braces {} are not necessary for single statement blocks
#249: FILE: arch/x86/kernel/cpu/zhaoxin.c:148:
+   if (c->x86 >= 0x6) {
+      init_zhaoxin_cap(c);
+   }

WARNING: please, no spaces at the start of a line
#250: FILE: arch/x86/kernel/cpu/zhaoxin.c:149:
+      init_zhaoxin_cap(c);$

WARNING: please, no spaces at the start of a line
#251: FILE: arch/x86/kernel/cpu/zhaoxin.c:150:
+   }$

WARNING: please, no spaces at the start of a line
#253: FILE: arch/x86/kernel/cpu/zhaoxin.c:152:
+   set_cpu_cap(c, X86_FEATURE_LFENCE_RDTSC);$

WARNING: please, no spaces at the start of a line
#256: FILE: arch/x86/kernel/cpu/zhaoxin.c:155:
+   if (cpu_has(c, X86_FEATURE_VMX))$

WARNING: suspect code indent for conditional statements (3, 6)
#256: FILE: arch/x86/kernel/cpu/zhaoxin.c:155:
+   if (cpu_has(c, X86_FEATURE_VMX))
+      zhaoxin_detect_vmx_virtcap(c);

WARNING: please, no spaces at the start of a line
#257: FILE: arch/x86/kernel/cpu/zhaoxin.c:156:
+      zhaoxin_detect_vmx_virtcap(c);$

WARNING: please, no spaces at the start of a line
#264: FILE: arch/x86/kernel/cpu/zhaoxin.c:163:
+   return size;$

WARNING: please, no spaces at the start of a line
#269: FILE: arch/x86/kernel/cpu/zhaoxin.c:168:
+   .c_vendor  = "zhaoxin",$

WARNING: please, no spaces at the start of a line
#270: FILE: arch/x86/kernel/cpu/zhaoxin.c:169:
+   .c_ident   = { "  Shanghai  " },$

WARNING: please, no spaces at the start of a line
#271: FILE: arch/x86/kernel/cpu/zhaoxin.c:170:
+   .c_early_init = early_init_zhaoxin,$

WARNING: please, no spaces at the start of a line
#272: FILE: arch/x86/kernel/cpu/zhaoxin.c:171:
+   .c_init       = init_zhaoxin,$

WARNING: please, no spaces at the start of a line
#274: FILE: arch/x86/kernel/cpu/zhaoxin.c:173:
+   .legacy_cache_size = zhaoxin_size_cache,$

WARNING: please, no spaces at the start of a line
#276: FILE: arch/x86/kernel/cpu/zhaoxin.c:175:
+   .c_x86_vendor = X86_VENDOR_ZHAOXIN,$

WARNING: Missing Signed-off-by: line by nominal patch author 'TonyWWang-oc <TonyWWang-oc@zhaoxin.com>'

total: 16 errors, 106 warnings, 226 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

NOTE: Whitespace errors detected.
      You may wish to use scripts/cleanpatch or scripts/cleanfile

/tmp/tonywwang-oc has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply. Srsly.
