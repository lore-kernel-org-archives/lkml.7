Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDE6C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 07:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0196C2084F
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 07:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbfLDHyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 02:54:38 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56165 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727406AbfLDHyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 02:54:09 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1icPTt-0004RN-6x; Wed, 04 Dec 2019 08:53:53 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CE84D1C2217;
        Wed,  4 Dec 2019 08:53:52 +0100 (CET)
Date:   Wed, 04 Dec 2019 07:53:52 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] tools headers kvm: Sync kvm headers with the
 kernel sources
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Fabiano Rosas <farosas@linux.ibm.com>,
        Greg Kurz <groug@kaod.org>, Jiri Olsa <jolsa@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        Steven Price <steven.price@arm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <tip-qrjdudhq25mk5bfnhveofbm4@git.kernel.org>
References: <tip-qrjdudhq25mk5bfnhveofbm4@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157544603266.21853.2129594189262528844.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     1fc3d0ee242de68267769afcaf5520439de42f64
Gitweb:        https://git.kernel.org/tip/1fc3d0ee242de68267769afcaf5520439de42f64
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Mon, 02 Dec 2019 12:44:24 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 02 Dec 2019 12:54:13 -03:00

tools headers kvm: Sync kvm headers with the kernel sources

To pick up the changes from:

  14edff88315a Merge tag 'kvmarm-5.5' of git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into HEAD
  a4b28f5c6798 Merge remote-tracking branch 'kvmarm/kvm-arm64/stolen-time' into kvmarm-master/next
  58772e9a3db7 ("KVM: arm64: Provide VCPU attributes for stolen time")
  da345174ceca ("KVM: arm/arm64: Allow user injection of external data aborts")
  c726200dd106 ("KVM: arm/arm64: Allow reporting non-ISV data aborts to userspace")
  efe5ddcae496 ("KVM: PPC: Book3S HV: XIVE: Allow userspace to set the # of VPs")

No tools changes are caused by this, as the only defines so far used
from these files are for syscall arg pretty printing are:

  $ grep KVM tools/perf/trace/beauty/*.sh
  tools/perf/trace/beauty/kvm_ioctl.sh:regex='^#[[:space:]]*define[[:space:]]+KVM_(\w+)[[:space:]]+_IO[RW]*\([[:space:]]*KVMIO[[:space:]]*,[[:space:]]*(0x[[:xdigit:]]+).*'
  $

Some are also include by:

  tools/perf/arch/x86/util/kvm-stat.c
  tools/perf/arch/powerpc/util/kvm-stat.c

This addresses these tools/perf build warnings:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/kvm.h' differs from latest version at 'include/uapi/linux/kvm.h'
  diff -u tools/include/uapi/linux/kvm.h include/uapi/linux/kvm.h
  Warning: Kernel ABI header at 'tools/arch/powerpc/include/uapi/asm/kvm.h' differs from latest version at 'arch/powerpc/include/uapi/asm/kvm.h'
  diff -u tools/arch/powerpc/include/uapi/asm/kvm.h arch/powerpc/include/uapi/asm/kvm.h
  Warning: Kernel ABI header at 'tools/arch/arm/include/uapi/asm/kvm.h' differs from latest version at 'arch/arm/include/uapi/asm/kvm.h'
  diff -u tools/arch/arm/include/uapi/asm/kvm.h arch/arm/include/uapi/asm/kvm.h
  Warning: Kernel ABI header at 'tools/arch/arm64/include/uapi/asm/kvm.h' differs from latest version at 'arch/arm64/include/uapi/asm/kvm.h'
  diff -u tools/arch/arm64/include/uapi/asm/kvm.h arch/arm64/include/uapi/asm/kvm.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Christoffer Dall <christoffer.dall@arm.com>
Cc: Fabiano Rosas <farosas@linux.ibm.com>
Cc: Greg Kurz <groug@kaod.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paul Mackerras <paulus@ozlabs.org>
Cc: Steven Price <steven.price@arm.com>
Link: https://lkml.kernel.org/n/tip-qrjdudhq25mk5bfnhveofbm4@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/arm/include/uapi/asm/kvm.h     |  3 ++-
 tools/arch/arm64/include/uapi/asm/kvm.h   |  5 ++++-
 tools/arch/powerpc/include/uapi/asm/kvm.h |  3 +++
 tools/include/uapi/linux/kvm.h            | 11 +++++++++++
 4 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/tools/arch/arm/include/uapi/asm/kvm.h b/tools/arch/arm/include/uapi/asm/kvm.h
index 2769360..03cd7c1 100644
--- a/tools/arch/arm/include/uapi/asm/kvm.h
+++ b/tools/arch/arm/include/uapi/asm/kvm.h
@@ -131,8 +131,9 @@ struct kvm_vcpu_events {
 	struct {
 		__u8 serror_pending;
 		__u8 serror_has_esr;
+		__u8 ext_dabt_pending;
 		/* Align it to 8 bytes */
-		__u8 pad[6];
+		__u8 pad[5];
 		__u64 serror_esr;
 	} exception;
 	__u32 reserved[12];
diff --git a/tools/arch/arm64/include/uapi/asm/kvm.h b/tools/arch/arm64/include/uapi/asm/kvm.h
index 67c21f9..820e575 100644
--- a/tools/arch/arm64/include/uapi/asm/kvm.h
+++ b/tools/arch/arm64/include/uapi/asm/kvm.h
@@ -164,8 +164,9 @@ struct kvm_vcpu_events {
 	struct {
 		__u8 serror_pending;
 		__u8 serror_has_esr;
+		__u8 ext_dabt_pending;
 		/* Align it to 8 bytes */
-		__u8 pad[6];
+		__u8 pad[5];
 		__u64 serror_esr;
 	} exception;
 	__u32 reserved[12];
@@ -323,6 +324,8 @@ struct kvm_vcpu_events {
 #define KVM_ARM_VCPU_TIMER_CTRL		1
 #define   KVM_ARM_VCPU_TIMER_IRQ_VTIMER		0
 #define   KVM_ARM_VCPU_TIMER_IRQ_PTIMER		1
+#define KVM_ARM_VCPU_PVTIME_CTRL	2
+#define   KVM_ARM_VCPU_PVTIME_IPA	0
 
 /* KVM_IRQ_LINE irq field index values */
 #define KVM_ARM_IRQ_VCPU2_SHIFT		28
diff --git a/tools/arch/powerpc/include/uapi/asm/kvm.h b/tools/arch/powerpc/include/uapi/asm/kvm.h
index b0f72de..264e266 100644
--- a/tools/arch/powerpc/include/uapi/asm/kvm.h
+++ b/tools/arch/powerpc/include/uapi/asm/kvm.h
@@ -667,6 +667,8 @@ struct kvm_ppc_cpu_char {
 
 /* PPC64 eXternal Interrupt Controller Specification */
 #define KVM_DEV_XICS_GRP_SOURCES	1	/* 64-bit source attributes */
+#define KVM_DEV_XICS_GRP_CTRL		2
+#define   KVM_DEV_XICS_NR_SERVERS	1
 
 /* Layout of 64-bit source attribute values */
 #define  KVM_XICS_DESTINATION_SHIFT	0
@@ -683,6 +685,7 @@ struct kvm_ppc_cpu_char {
 #define KVM_DEV_XIVE_GRP_CTRL		1
 #define   KVM_DEV_XIVE_RESET		1
 #define   KVM_DEV_XIVE_EQ_SYNC		2
+#define   KVM_DEV_XIVE_NR_SERVERS	3
 #define KVM_DEV_XIVE_GRP_SOURCE		2	/* 64-bit source identifier */
 #define KVM_DEV_XIVE_GRP_SOURCE_CONFIG	3	/* 64-bit source identifier */
 #define KVM_DEV_XIVE_GRP_EQ_CONFIG	4	/* 64-bit EQ identifier */
diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index 52641d8..e6f17c8 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -235,6 +235,7 @@ struct kvm_hyperv_exit {
 #define KVM_EXIT_S390_STSI        25
 #define KVM_EXIT_IOAPIC_EOI       26
 #define KVM_EXIT_HYPERV           27
+#define KVM_EXIT_ARM_NISV         28
 
 /* For KVM_EXIT_INTERNAL_ERROR */
 /* Emulate instruction failed. */
@@ -394,6 +395,11 @@ struct kvm_run {
 		} eoi;
 		/* KVM_EXIT_HYPERV */
 		struct kvm_hyperv_exit hyperv;
+		/* KVM_EXIT_ARM_NISV */
+		struct {
+			__u64 esr_iss;
+			__u64 fault_ipa;
+		} arm_nisv;
 		/* Fix the size of the union. */
 		char padding[256];
 	};
@@ -1000,6 +1006,9 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_PMU_EVENT_FILTER 173
 #define KVM_CAP_ARM_IRQ_LINE_LAYOUT_2 174
 #define KVM_CAP_HYPERV_DIRECT_TLBFLUSH 175
+#define KVM_CAP_PPC_GUEST_DEBUG_SSTEP 176
+#define KVM_CAP_ARM_NISV_TO_USER 177
+#define KVM_CAP_ARM_INJECT_EXT_DABT 178
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1227,6 +1236,8 @@ enum kvm_device_type {
 #define KVM_DEV_TYPE_ARM_VGIC_ITS	KVM_DEV_TYPE_ARM_VGIC_ITS
 	KVM_DEV_TYPE_XIVE,
 #define KVM_DEV_TYPE_XIVE		KVM_DEV_TYPE_XIVE
+	KVM_DEV_TYPE_ARM_PV_TIME,
+#define KVM_DEV_TYPE_ARM_PV_TIME	KVM_DEV_TYPE_ARM_PV_TIME
 	KVM_DEV_TYPE_MAX,
 };
 
