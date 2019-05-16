Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EBBBC04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 07:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 649582087E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 07:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="pcVcFCvF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfEPHLS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 03:11:18 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57857 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfEPHLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 03:11:18 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4G7B39T711025
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 16 May 2019 00:11:03 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4G7B39T711025
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1557990664;
        bh=6h3XD1PWoI/XCV3jWmxqleb2yhE+4ElhSE3a+z0W/98=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=pcVcFCvFNnh7k2uL+iVBv4IXE4G7eE3C3OnI0MIx0rD+qY1LzVzpROlW5qDvHVRbo
         ZueneX2i+k8xROs0KGtMI6Mkh0WA9L1fADZk7+ravsfHsS8r3C6XLdWax37hi5Vr8R
         dIQuihC/6rul0uSRA8aCoo7RGs68ui4cPlqpqKZzu1RGEwEE2A19DzkwwZoHDRWS6m
         R+xD1oyvGFjx+ZrwzFTvVGaPYiT3rS8WIMTQ+5kvUOV1+kxjJM7Idp2MFvCwa23pxI
         SHYCLtbL+kH1kKl129VFkpoPenDJ/rnQoCQEWn4CK9UWIAHtfX2HGnNEhvd5aTFxUJ
         TTJnOuMUXvJ7Q==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4G7B3RS711022;
        Thu, 16 May 2019 00:11:03 -0700
Date:   Thu, 16 May 2019 00:11:03 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andy Lutomirski <tipbot@zytor.com>
Message-ID: <tip-9d8d0294e78a164d407133dea05caf4b84247d6a@git.kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        frederic@kernel.org, bp@suse.de, luto@kernel.org,
        gregkh@linuxfoundation.org, peterz@infradead.org, jcm@redhat.com
Reply-To: gregkh@linuxfoundation.org, peterz@infradead.org, jcm@redhat.com,
          luto@kernel.org, bp@suse.de, frederic@kernel.org,
          torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
          mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de
In-Reply-To: <999fa9e126ba6a48e9d214d2f18dbde5c62ac55c.1557865329.git.luto@kernel.org>
References: <999fa9e126ba6a48e9d214d2f18dbde5c62ac55c.1557865329.git.luto@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/speculation/mds: Improve CPU buffer clear
 documentation
Git-Commit-ID: 9d8d0294e78a164d407133dea05caf4b84247d6a
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

Commit-ID:  9d8d0294e78a164d407133dea05caf4b84247d6a
Gitweb:     https://git.kernel.org/tip/9d8d0294e78a164d407133dea05caf4b84247d6a
Author:     Andy Lutomirski <luto@kernel.org>
AuthorDate: Tue, 14 May 2019 13:24:40 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 16 May 2019 09:05:12 +0200

x86/speculation/mds: Improve CPU buffer clear documentation

On x86_64, all returns to usermode go through
prepare_exit_to_usermode(), with the sole exception of do_nmi().
This even includes machine checks -- this was added several years
ago to support MCE recovery.  Update the documentation.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@suse.de>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jon Masters <jcm@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Fixes: 04dcbdb80578 ("x86/speculation/mds: Clear CPU buffers on exit to user")
Link: http://lkml.kernel.org/r/999fa9e126ba6a48e9d214d2f18dbde5c62ac55c.1557865329.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 Documentation/x86/mds.rst | 39 +++++++--------------------------------
 1 file changed, 7 insertions(+), 32 deletions(-)

diff --git a/Documentation/x86/mds.rst b/Documentation/x86/mds.rst
index 0dc812bb9249..5d4330be200f 100644
--- a/Documentation/x86/mds.rst
+++ b/Documentation/x86/mds.rst
@@ -142,38 +142,13 @@ Mitigation points
    mds_user_clear.
 
    The mitigation is invoked in prepare_exit_to_usermode() which covers
-   most of the kernel to user space transitions. There are a few exceptions
-   which are not invoking prepare_exit_to_usermode() on return to user
-   space. These exceptions use the paranoid exit code.
-
-   - Non Maskable Interrupt (NMI):
-
-     Access to sensible data like keys, credentials in the NMI context is
-     mostly theoretical: The CPU can do prefetching or execute a
-     misspeculated code path and thereby fetching data which might end up
-     leaking through a buffer.
-
-     But for mounting other attacks the kernel stack address of the task is
-     already valuable information. So in full mitigation mode, the NMI is
-     mitigated on the return from do_nmi() to provide almost complete
-     coverage.
-
-   - Machine Check Exception (#MC):
-
-     Another corner case is a #MC which hits between the CPU buffer clear
-     invocation and the actual return to user. As this still is in kernel
-     space it takes the paranoid exit path which does not clear the CPU
-     buffers. So the #MC handler repopulates the buffers to some
-     extent. Machine checks are not reliably controllable and the window is
-     extremly small so mitigation would just tick a checkbox that this
-     theoretical corner case is covered. To keep the amount of special
-     cases small, ignore #MC.
-
-   - Debug Exception (#DB):
-
-     This takes the paranoid exit path only when the INT1 breakpoint is in
-     kernel space. #DB on a user space address takes the regular exit path,
-     so no extra mitigation required.
+   all but one of the kernel to user space transitions.  The exception
+   is when we return from a Non Maskable Interrupt (NMI), which is
+   handled directly in do_nmi().
+
+   (The reason that NMI is special is that prepare_exit_to_usermode() can
+    enable IRQs.  In NMI context, NMIs are blocked, and we don't want to
+    enable IRQs with NMIs blocked.)
 
 
 2. C-State transition
