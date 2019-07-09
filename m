Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FUZZY_XPILL,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493D0C004EF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 11:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DCBF20844
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 11:29:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="qAk/ShDQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfGIL33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 07:29:29 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49461 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfGIL33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 07:29:29 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x69BSRF11892565
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 9 Jul 2019 04:28:27 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x69BSRF11892565
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562671708;
        bh=t+l4r+DUyH3rXcvMmz6e/QMLX2Zrzx/xFEgFBdfPxkQ=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=qAk/ShDQjzQuc2gazmRfYxD0RYSbRM1hqufV2vmaaHQRFkoEXV+kqzwl8Jqu/DzSx
         qZW7t4gof85pHnL3a8lBWEYkE3s+y9ST9Yh6S/W1vuo5F+xmdQ+FJCKnIBVfT8lftI
         4jXvJrKPR5WQWRpl9SObF9qVothtU5IPu1zQKlXkR9l2TbGjWrlQJeTmNqUzYPWQ7K
         +FRoaYYRvmYP/6y1h6gzJ2+WYP1rUgQIct3oRkMJ/Pnlgmia9UFo7piy4XjQ3H/hcn
         LgNyva+XqFW5HPtQ2CR0taf2v1O4Uw54gRqZ8kQW/N6yks8V3T6OfvFlhxdROOVEhD
         vZjfTzHRNA3uA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x69BSQxM1892559;
        Tue, 9 Jul 2019 04:28:26 -0700
Date:   Tue, 9 Jul 2019 04:28:26 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-1cdbq5ulr4d6cx3iv2ye5wdv@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Dave.Martin@arm.com, namhyung@kernel.org, acme@redhat.com,
        adrian.hunter@intel.com, will.deacon@arm.com, mingo@kernel.org,
        hpa@zytor.com, pbonzini@redhat.com, jolsa@kernel.org,
        liran.alon@oracle.com
Reply-To: linux-kernel@vger.kernel.org, Dave.Martin@arm.com,
          tglx@linutronix.de, namhyung@kernel.org, acme@redhat.com,
          adrian.hunter@intel.com, will.deacon@arm.com, mingo@kernel.org,
          hpa@zytor.com, jolsa@kernel.org, pbonzini@redhat.com,
          liran.alon@oracle.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools arch kvm: Sync kvm headers with the kernel
 sources
Git-Commit-ID: c499d1f483a99e86a5f712277de7c8fa33a9ec0a
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

Commit-ID:  c499d1f483a99e86a5f712277de7c8fa33a9ec0a
Gitweb:     https://git.kernel.org/tip/c499d1f483a99e86a5f712277de7c8fa33a9ec0a
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Sat, 6 Jul 2019 14:26:40 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Sat, 6 Jul 2019 14:26:40 -0300

tools arch kvm: Sync kvm headers with the kernel sources

To pick up the changes from:

  41040cf7c5f0 ("arm64/sve: Fix missing SVE/FPSIMD endianness conversions")
  6ca00dfafda7 ("KVM: x86: Modify struct kvm_nested_state to have explicit fields for data")

None entail changes in tooling.

This silences these tools/perf build warnings:

  Warning: Kernel ABI header at 'tools/arch/x86/include/uapi/asm/kvm.h' differs from latest version at 'arch/x86/include/uapi/asm/kvm.h'
  diff -u tools/arch/x86/include/uapi/asm/kvm.h arch/x86/include/uapi/asm/kvm.h
  Warning: Kernel ABI header at 'tools/arch/arm64/include/uapi/asm/kvm.h' differs from latest version at 'arch/arm64/include/uapi/asm/kvm.h'
  diff -u tools/arch/arm64/include/uapi/asm/kvm.h arch/arm64/include/uapi/asm/kvm.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Dave Martin <Dave.Martin@arm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Liran Alon <liran.alon@oracle.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>
Link: https://lkml.kernel.org/n/tip-1cdbq5ulr4d6cx3iv2ye5wdv@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/arm64/include/uapi/asm/kvm.h |  7 +++++++
 tools/arch/x86/include/uapi/asm/kvm.h   | 31 +++++++++++++++++++++----------
 2 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/tools/arch/arm64/include/uapi/asm/kvm.h b/tools/arch/arm64/include/uapi/asm/kvm.h
index 7b7ac0f6cec9..d819a3e8b552 100644
--- a/tools/arch/arm64/include/uapi/asm/kvm.h
+++ b/tools/arch/arm64/include/uapi/asm/kvm.h
@@ -260,6 +260,13 @@ struct kvm_vcpu_events {
 	 KVM_REG_SIZE_U256 |						\
 	 ((i) & (KVM_ARM64_SVE_MAX_SLICES - 1)))
 
+/*
+ * Register values for KVM_REG_ARM64_SVE_ZREG(), KVM_REG_ARM64_SVE_PREG() and
+ * KVM_REG_ARM64_SVE_FFR() are represented in memory in an endianness-
+ * invariant layout which differs from the layout used for the FPSIMD
+ * V-registers on big-endian systems: see sigcontext.h for more explanation.
+ */
+
 #define KVM_ARM64_SVE_VQ_MIN __SVE_VQ_MIN
 #define KVM_ARM64_SVE_VQ_MAX __SVE_VQ_MAX
 
diff --git a/tools/arch/x86/include/uapi/asm/kvm.h b/tools/arch/x86/include/uapi/asm/kvm.h
index 24a8cd229df6..d6ab5b4d15e5 100644
--- a/tools/arch/x86/include/uapi/asm/kvm.h
+++ b/tools/arch/x86/include/uapi/asm/kvm.h
@@ -383,6 +383,9 @@ struct kvm_sync_regs {
 #define KVM_X86_QUIRK_LAPIC_MMIO_HOLE	(1 << 2)
 #define KVM_X86_QUIRK_OUT_7E_INC_RIP	(1 << 3)
 
+#define KVM_STATE_NESTED_FORMAT_VMX	0
+#define KVM_STATE_NESTED_FORMAT_SVM	1	/* unused */
+
 #define KVM_STATE_NESTED_GUEST_MODE	0x00000001
 #define KVM_STATE_NESTED_RUN_PENDING	0x00000002
 #define KVM_STATE_NESTED_EVMCS		0x00000004
@@ -390,7 +393,14 @@ struct kvm_sync_regs {
 #define KVM_STATE_NESTED_SMM_GUEST_MODE	0x00000001
 #define KVM_STATE_NESTED_SMM_VMXON	0x00000002
 
-struct kvm_vmx_nested_state {
+#define KVM_STATE_NESTED_VMX_VMCS_SIZE	0x1000
+
+struct kvm_vmx_nested_state_data {
+	__u8 vmcs12[KVM_STATE_NESTED_VMX_VMCS_SIZE];
+	__u8 shadow_vmcs12[KVM_STATE_NESTED_VMX_VMCS_SIZE];
+};
+
+struct kvm_vmx_nested_state_hdr {
 	__u64 vmxon_pa;
 	__u64 vmcs12_pa;
 
@@ -401,24 +411,25 @@ struct kvm_vmx_nested_state {
 
 /* for KVM_CAP_NESTED_STATE */
 struct kvm_nested_state {
-	/* KVM_STATE_* flags */
 	__u16 flags;
-
-	/* 0 for VMX, 1 for SVM.  */
 	__u16 format;
-
-	/* 128 for SVM, 128 + VMCS size for VMX.  */
 	__u32 size;
 
 	union {
-		/* VMXON, VMCS */
-		struct kvm_vmx_nested_state vmx;
+		struct kvm_vmx_nested_state_hdr vmx;
 
 		/* Pad the header to 128 bytes.  */
 		__u8 pad[120];
-	};
+	} hdr;
 
-	__u8 data[0];
+	/*
+	 * Define data region as 0 bytes to preserve backwards-compatability
+	 * to old definition of kvm_nested_state in order to avoid changing
+	 * KVM_{GET,PUT}_NESTED_STATE ioctl values.
+	 */
+	union {
+		struct kvm_vmx_nested_state_data vmx[0];
+	} data;
 };
 
 #endif /* _ASM_X86_KVM_H */
