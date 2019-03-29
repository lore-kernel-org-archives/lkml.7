Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85388C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 20:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ABB42184C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 20:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730200AbfC2Uky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 16:40:54 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33817 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730150AbfC2Uky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 16:40:54 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2TKecqJ3938464
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 29 Mar 2019 13:40:38 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2TKeb3F3938461;
        Fri, 29 Mar 2019 13:40:37 -0700
Date:   Fri, 29 Mar 2019 13:40:37 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-4pb7ywp9536hub2pnj4hu6i4@git.kernel.org>
Cc:     hpa@zytor.com, sjitindarsingh@gmail.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        adrian.hunter@intel.com, paulus@ozlabs.org, tglx@linutronix.de,
        jolsa@kernel.org, namhyung@kernel.org, acme@redhat.com
Reply-To: tglx@linutronix.de, paulus@ozlabs.org, adrian.hunter@intel.com,
          jolsa@kernel.org, namhyung@kernel.org, acme@redhat.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com,
          sjitindarsingh@gmail.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools headers uapi: Sync powerpc's asm/kvm.h copy
 with the kernel sources
Git-Commit-ID: 707c373c846cf6e27a47a2c093d243a35c691b62
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

Commit-ID:  707c373c846cf6e27a47a2c093d243a35c691b62
Gitweb:     https://git.kernel.org/tip/707c373c846cf6e27a47a2c093d243a35c691b62
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 26 Mar 2019 13:45:58 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 28 Mar 2019 14:41:21 -0300

tools headers uapi: Sync powerpc's asm/kvm.h copy with the kernel sources

To pick up the changes in:

  2b57ecd0208f ("KVM: PPC: Book3S: Add count cache flush parameters to kvmppc_get_cpu_char()")

That don't cause any changes in the tools.

This silences this perf build warning:

  Warning: Kernel ABI header at 'tools/arch/powerpc/include/uapi/asm/kvm.h' differs from latest version at 'arch/powerpc/include/uapi/asm/kvm.h'
  diff -u tools/arch/powerpc/include/uapi/asm/kvm.h arch/powerpc/include/uapi/asm/kvm.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paul Mackerras <paulus@ozlabs.org>
Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Link: https://lkml.kernel.org/n/tip-4pb7ywp9536hub2pnj4hu6i4@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/powerpc/include/uapi/asm/kvm.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/arch/powerpc/include/uapi/asm/kvm.h b/tools/arch/powerpc/include/uapi/asm/kvm.h
index 8c876c166ef2..26ca425f4c2c 100644
--- a/tools/arch/powerpc/include/uapi/asm/kvm.h
+++ b/tools/arch/powerpc/include/uapi/asm/kvm.h
@@ -463,10 +463,12 @@ struct kvm_ppc_cpu_char {
 #define KVM_PPC_CPU_CHAR_BR_HINT_HONOURED	(1ULL << 58)
 #define KVM_PPC_CPU_CHAR_MTTRIG_THR_RECONF	(1ULL << 57)
 #define KVM_PPC_CPU_CHAR_COUNT_CACHE_DIS	(1ULL << 56)
+#define KVM_PPC_CPU_CHAR_BCCTR_FLUSH_ASSIST	(1ull << 54)
 
 #define KVM_PPC_CPU_BEHAV_FAVOUR_SECURITY	(1ULL << 63)
 #define KVM_PPC_CPU_BEHAV_L1D_FLUSH_PR		(1ULL << 62)
 #define KVM_PPC_CPU_BEHAV_BNDS_CHK_SPEC_BAR	(1ULL << 61)
+#define KVM_PPC_CPU_BEHAV_FLUSH_COUNT_CACHE	(1ull << 58)
 
 /* Per-vcpu XICS interrupt controller state */
 #define KVM_REG_PPC_ICP_STATE	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0x8c)
