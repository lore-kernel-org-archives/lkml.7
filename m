Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B15AC04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 08:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EC0620872
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 08:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="uwfTNAeb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729362AbfERIul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 04:50:41 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42151 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbfERIuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 04:50:40 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4I8oTuK1732092
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 18 May 2019 01:50:29 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4I8oTuK1732092
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1558169430;
        bh=8INH8ZTJ9OB6Bca26u8x47g8QVc4eAyRuhcrZq48rb8=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=uwfTNAebwSCqqAhETG7Xp6+H0yAzBHpzvyjtK5MiEWeIIB8+slIJ6ksld/pypiWAF
         5XN1TWne4EysibJGqVB43qfxKJ4PyU8QBgXs5ys8FaGbidk3PndeCBojg8KtUFzeb8
         qDXvqFujITPVBwBKRoU0/DlcyhVP36IdjXViBwh2smtmX0zv2zhuRhqRO9W11mWIh6
         yjzSDbZTud8EU7BMKKy8d8uwCx2sYJ7rLBs6rnCCPd1riyOxi60QfwW3oZvHByhYKO
         ioAfNm0L6s5ZjS0wQxvcZuQc55S6270U50Da5GIXVu9aO1z/CPEfYmzU1N8Z+NDIXb
         +LwDb5PkwSL8Q==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4I8oSfg1732089;
        Sat, 18 May 2019 01:50:28 -0700
Date:   Sat, 18 May 2019 01:50:28 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-6uh8tpraons0h22dmxgfyony@git.kernel.org>
Cc:     acme@redhat.com, hpa@zytor.com, tglx@linutronix.de,
        namhyung@kernel.org, adrian.hunter@intel.com, mingo@kernel.org,
        jolsa@kernel.org, pbonzini@redhat.com, jmattson@google.com,
        linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org,
          adrian.hunter@intel.com, pbonzini@redhat.com,
          jmattson@google.com, jolsa@kernel.org, tglx@linutronix.de,
          namhyung@kernel.org, hpa@zytor.com, acme@redhat.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools arch uapi: Sync the x86 kvm.h copy
Git-Commit-ID: f98f10f35257d3c8c73104956f3b7aa6e6f75067
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

Commit-ID:  f98f10f35257d3c8c73104956f3b7aa6e6f75067
Gitweb:     https://git.kernel.org/tip/f98f10f35257d3c8c73104956f3b7aa6e6f75067
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 13 May 2019 13:27:12 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 15 May 2019 16:36:46 -0300

tools arch uapi: Sync the x86 kvm.h copy

To get the changes in:

  59073aaf6de0 ("kvm: x86: Add exception payload fields to kvm_vcpu_events")

This silences the following perf build warning:

  Warning: Kernel ABI header at 'tools/arch/x86/include/uapi/asm/kvm.h' differs from latest version at 'arch/x86/include/uapi/asm/kvm.h'
  diff -u tools/arch/x86/include/uapi/asm/kvm.h arch/x86/include/uapi/asm/kvm.h

The changes in this file are in something not used at this time in any
tools/perf/ tool.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jim Mattson <jmattson@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lkml.kernel.org/n/tip-6uh8tpraons0h22dmxgfyony@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/uapi/asm/kvm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/arch/x86/include/uapi/asm/kvm.h b/tools/arch/x86/include/uapi/asm/kvm.h
index dabfcf7c3941..7a0e64ccd6ff 100644
--- a/tools/arch/x86/include/uapi/asm/kvm.h
+++ b/tools/arch/x86/include/uapi/asm/kvm.h
@@ -381,6 +381,7 @@ struct kvm_sync_regs {
 #define KVM_X86_QUIRK_LINT0_REENABLED	(1 << 0)
 #define KVM_X86_QUIRK_CD_NW_CLEARED	(1 << 1)
 #define KVM_X86_QUIRK_LAPIC_MMIO_HOLE	(1 << 2)
+#define KVM_X86_QUIRK_OUT_7E_INC_RIP	(1 << 3)
 
 #define KVM_STATE_NESTED_GUEST_MODE	0x00000001
 #define KVM_STATE_NESTED_RUN_PENDING	0x00000002
