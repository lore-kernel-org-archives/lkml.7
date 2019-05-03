Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8118C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 05:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B77F22087F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 05:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="pggIm8Za"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfECFxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 01:53:05 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44175 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbfECFxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 01:53:05 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x435quZC2617988
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 2 May 2019 22:52:56 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x435quZC2617988
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556862777;
        bh=se5wEWxFOpKY1KRBwMNqNdrxQQRu6KbXG2pCulp3pSc=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=pggIm8ZaLP+LLIBEtrRUcBRcIZkx2QQIgJNgQNLji+5/b7tt/PjTHd/7AYVNW1gqe
         ZE9mwntI06Y0LDOWL+GFHnvUf8hp5W2p3JL4pHX4iPGHqSVapGtL37B221NomQo7CA
         v1vZgPEFAjuqy3Ys2uuRernUoO2SvCe7xcn2xUZ4DLEwZMd+WJ+GazMpvUDjNaTDRf
         I3LgzhZKJY3cZXSuHNF0gonUq5n4TTxHFwcPuptYdR0U8tPf3J3KRtGlp7tSrPMukp
         Xmet3thZpTlWtabLWMVBoeCbDZBI1F6mib1IfInSpaGM79zuSIIDpPUeqmUgaM6BUU
         bPHlW2M1Y7pmg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x435quba2617985;
        Thu, 2 May 2019 22:52:56 -0700
Date:   Thu, 2 May 2019 22:52:56 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-bjbo3zc0r8i8oa0udpvftya6@git.kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, acme@redhat.com,
        namhyung@kernel.org, jolsa@kernel.org, hpa@zytor.com,
        tglx@linutronix.de, pbonzini@redhat.com, adrian.hunter@intel.com
Reply-To: namhyung@kernel.org, linux-kernel@vger.kernel.org,
          mingo@kernel.org, acme@redhat.com, pbonzini@redhat.com,
          adrian.hunter@intel.com, tglx@linutronix.de, hpa@zytor.com,
          jolsa@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools uapi x86: Sync vmx.h with the kernel
Git-Commit-ID: 24e45b49eef07814e0507507161cd06f15b8ee1b
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

Commit-ID:  24e45b49eef07814e0507507161cd06f15b8ee1b
Gitweb:     https://git.kernel.org/tip/24e45b49eef07814e0507507161cd06f15b8ee1b
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 22 Apr 2019 11:54:50 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 2 May 2019 16:00:19 -0400

tools uapi x86: Sync vmx.h with the kernel

To pick up the changes from:

  2b27924bb1d4 ("KVM: nVMX: always use early vmcs check when EPT is disabled")

That causes this object in the tools/perf build process to be rebuilt:

  CC       /tmp/build/perf/arch/x86/util/kvm-stat.o

But it isn't using VMX_ABORT_ prefixed constants, so no change in
behaviour.

This silences this perf build warning:

  Warning: Kernel ABI header at 'tools/arch/x86/include/uapi/asm/vmx.h' differs from latest version at 'arch/x86/include/uapi/asm/vmx.h'
  diff -u tools/arch/x86/include/uapi/asm/vmx.h arch/x86/include/uapi/asm/vmx.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lkml.kernel.org/n/tip-bjbo3zc0r8i8oa0udpvftya6@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/uapi/asm/vmx.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/arch/x86/include/uapi/asm/vmx.h b/tools/arch/x86/include/uapi/asm/vmx.h
index f0b0c90dd398..d213ec5c3766 100644
--- a/tools/arch/x86/include/uapi/asm/vmx.h
+++ b/tools/arch/x86/include/uapi/asm/vmx.h
@@ -146,6 +146,7 @@
 
 #define VMX_ABORT_SAVE_GUEST_MSR_FAIL        1
 #define VMX_ABORT_LOAD_HOST_PDPTE_FAIL       2
+#define VMX_ABORT_VMCS_CORRUPTED             3
 #define VMX_ABORT_LOAD_HOST_MSR_FAIL         4
 
 #endif /* _UAPIVMX_H */
