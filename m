Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EB8C31E40
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 09:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7F5820656
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 09:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Y6ChTg8+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731457AbfHOJgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 05:36:42 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49081 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730212AbfHOJgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 05:36:42 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x7F9YWkM2274938
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 15 Aug 2019 02:34:32 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x7F9YWkM2274938
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565861673;
        bh=s+umhOEhsoHSyOY1TbZJ6f2SLi3+/KVSM76nm/zeXII=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=Y6ChTg8+XUi2R6SOe/U5o4UDQFwNwng+lfiykFdfNWLY/K0+zz3Q5DcQNeMqcSx8p
         SebRZRoVNkqHvrb6VTIMKX7ky6EUadC6CR1FuqICXocy597fKQExEulOLWwzeCeJTw
         fzo2HPbhqe1w421zSIirsYt/aZhC/n3gnZhQ9AR+uoDCehffY5REw2s0xOXPqPrpV7
         pQ/ABs9T/A5VmHSkfgA5dXa9mQY52an+K6i5Nw67vlhLy6AhhFkyRBVEBKPmCvxXAq
         fUR63HhXHN5sGADvJLCAEleRBRzKNycDC1xF/8jkHw2I7v8eCbuiU3aqcji3U2jbRZ
         IlEk8o0jdjBFw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x7F9YWRP2274935;
        Thu, 15 Aug 2019 02:34:32 -0700
Date:   Thu, 15 Aug 2019 02:34:32 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andy Shevchenko <tipbot@zytor.com>
Message-ID: <tip-0ke3p64ksa0hnbueh52n3v3q@git.kernel.org>
Cc:     tglx@linutronix.de, kafai@fb.com, ast@kernel.org, acme@redhat.com,
        hpa@zytor.com, andriy.shevchenko@linux.intel.com, mingo@kernel.org,
        songliubraving@fb.com, daniel@iogearbox.net, yhs@fb.com,
        linux-kernel@vger.kernel.org
Reply-To: acme@redhat.com, mingo@kernel.org, songliubraving@fb.com,
          tglx@linutronix.de, kafai@fb.com, ast@kernel.org,
          andriy.shevchenko@linux.intel.com, hpa@zytor.com,
          daniel@iogearbox.net, yhs@fb.com, linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools: Keep list of tools in alphabetical order
Git-Commit-ID: 38fe26b46f55538c2cb8b96500caed6ae9d59d46
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

Commit-ID:  38fe26b46f55538c2cb8b96500caed6ae9d59d46
Gitweb:     https://git.kernel.org/tip/38fe26b46f55538c2cb8b96500caed6ae9d59d46
Author:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate: Fri, 28 Jun 2019 20:22:09 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 14 Aug 2019 10:59:59 -0300

tools: Keep list of tools in alphabetical order

When `make help` is executed it lists the possible tools to build,
though couple of entries is kept unordered. Fix it here.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Song Liu <songliubraving@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Yonghong Song <yhs@fb.com>
Link: https://lkml.kernel.org/n/tip-0ke3p64ksa0hnbueh52n3v3q@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/Makefile b/tools/Makefile
index 68defd7ecf5d..7e42f7b8bfa7 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -10,6 +10,7 @@ help:
 	@echo 'Possible targets:'
 	@echo ''
 	@echo '  acpi                   - ACPI tools'
+	@echo '  bpf                    - misc BPF tools'
 	@echo '  cgroup                 - cgroup tools'
 	@echo '  cpupower               - a tool for all things x86 CPU power'
 	@echo '  debugging              - tools for debugging'
@@ -23,12 +24,11 @@ help:
 	@echo '  kvm_stat               - top-like utility for displaying kvm statistics'
 	@echo '  leds                   - LEDs  tools'
 	@echo '  liblockdep             - user-space wrapper for kernel locking-validator'
-	@echo '  bpf                    - misc BPF tools'
+	@echo '  objtool                - an ELF object analysis tool'
 	@echo '  pci                    - PCI tools'
 	@echo '  perf                   - Linux performance measurement and analysis tool'
 	@echo '  selftests              - various kernel selftests'
 	@echo '  spi                    - spi tools'
-	@echo '  objtool                - an ELF object analysis tool'
 	@echo '  tmon                   - thermal monitoring and tuning tool'
 	@echo '  turbostat              - Intel CPU idle stats and freq reporting tool'
 	@echo '  usb                    - USB testing tools'
