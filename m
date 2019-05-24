Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9598CC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 542BC2133D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="xCHhnsof"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389432AbfEXIHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 04:07:05 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35683 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389046AbfEXIHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 04:07:04 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4O86qXS118241
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 24 May 2019 01:06:52 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4O86qXS118241
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1558685213;
        bh=5QkrotJddjjWUgkG/UKFHdwYKxgHPZdllRWfDpBfu6M=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=xCHhnsofGo/uHqcS4Vc2ox3h7sV1w6RDxzdxPwTpwDehZGTQxkiUEaqsagH+UZlfc
         oAtd1jX12bKM4uImdlYNLFtl7IrZhM5HVZI6wxc8t0kBz0kddXIcwmXDwLAaBjeg/c
         JTeoyUbT3KMIaONxAJ9AsXzzF4bPt81S1WmYCRGp7R5E7wrl8/M4ftcU8uAbBhT0eU
         2jWSNz/eGl0tLb+lJbbbLAa+u+RC4j5HAuAxeZNzgkwwl0SwBZ0VIGQF52lxcObtyT
         twzyowXGLblLXWrkHERS6dGjFaB1gJdOP4JbUVEloGPxMDJTIZMCtrgGDYxIWYKsbi
         WTRR/CM2RfA+g==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4O86qKF118238;
        Fri, 24 May 2019 01:06:52 -0700
Date:   Fri, 24 May 2019 01:06:52 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ira Weiny <tipbot@zytor.com>
Message-ID: <tip-9db9b76767f133d0e1ce19f01117c83221641899@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@kernel.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, ira.weiny@intel.com, corbet@lwn.net,
        hpa@zytor.com
Reply-To: torvalds@linux-foundation.org, ira.weiny@intel.com,
          corbet@lwn.net, hpa@zytor.com, linux-kernel@vger.kernel.org,
          peterz@infradead.org, mingo@kernel.org, tglx@linutronix.de
In-Reply-To: <20190520205253.23762-1-ira.weiny@intel.com>
References: <20190520205253.23762-1-ira.weiny@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/asm] Documentation/x86: Fix path to entry_32.S
Git-Commit-ID: 9db9b76767f133d0e1ce19f01117c83221641899
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

Commit-ID:  9db9b76767f133d0e1ce19f01117c83221641899
Gitweb:     https://git.kernel.org/tip/9db9b76767f133d0e1ce19f01117c83221641899
Author:     Ira Weiny <ira.weiny@intel.com>
AuthorDate: Mon, 20 May 2019 13:52:53 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 24 May 2019 08:52:54 +0200

Documentation/x86: Fix path to entry_32.S

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-doc@vger.kernel.org
Link: http://lkml.kernel.org/r/20190520205253.23762-1-ira.weiny@intel.com
[ Adjusted the patch to the RST conversion. ]
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 Documentation/x86/exception-tables.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/x86/exception-tables.rst b/Documentation/x86/exception-tables.rst
index 24596c8210b5..ed6d4b0cf62c 100644
--- a/Documentation/x86/exception-tables.rst
+++ b/Documentation/x86/exception-tables.rst
@@ -35,7 +35,7 @@ page fault handler::
   void do_page_fault(struct pt_regs *regs, unsigned long error_code)
 
 in arch/x86/mm/fault.c. The parameters on the stack are set up by
-the low level assembly glue in arch/x86/kernel/entry_32.S. The parameter
+the low level assembly glue in arch/x86/entry/entry_32.S. The parameter
 regs is a pointer to the saved registers on the stack, error_code
 contains a reason code for the exception.
 
