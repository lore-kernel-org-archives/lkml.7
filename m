Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05DC2C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 08:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5FCF22296
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 08:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="t1QcZOnJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbfGVI6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 04:58:21 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59571 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfGVI6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 04:58:20 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6M8w7563750529
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 22 Jul 2019 01:58:07 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6M8w7563750529
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1563785888;
        bh=ayJV2vNIGcNVbnd8QnIjhkvaE7cWRc8DCVz3ZkqOk78=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=t1QcZOnJbM9MvEXZsvWIwz1oFpD84L1QcygPaeryk0vry8Hqs83oOQAf5ICrcxgXW
         9jHGKouIGvkYfUZ61oEMxqRCgf2wazh/Y7stNUACYMw+JGmvPLmDXNg8q+PJlGSgfY
         QnVnAf95YynahP3pb8RHTtak0+rqcVBtwwZksHBaqwoKUPnkkLXW4/QfHcOOxtpMAN
         U7SEcb/IptED7W2jk3YqdgTtsit9Fdm9FeuaOJNzEqu7MHqnLohQk8r99Hd1TRj+/A
         uCffwF2svRnHZwlv26XKu0COauNY57Cj9KhcIvzm03SK/1DeHG9D2R8H+iGHMb8X4j
         HifqPZshcTvaA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6M8w6rQ3750526;
        Mon, 22 Jul 2019 01:58:06 -0700
Date:   Mon, 22 Jul 2019 01:58:06 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Cao jin <tipbot@zytor.com>
Message-ID: <tip-385065734cd417b9d7739b2ebb62c960aeb3ccb5@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com,
        tglx@linutronix.de, caoj.fnst@cn.fujitsu.com
Reply-To: tglx@linutronix.de, caoj.fnst@cn.fujitsu.com,
          linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org
In-Reply-To: <20190719081635.26528-1-caoj.fnst@cn.fujitsu.com>
References: <20190719081635.26528-1-caoj.fnst@cn.fujitsu.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/irq/64: Update stale comment
Git-Commit-ID: 385065734cd417b9d7739b2ebb62c960aeb3ccb5
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

Commit-ID:  385065734cd417b9d7739b2ebb62c960aeb3ccb5
Gitweb:     https://git.kernel.org/tip/385065734cd417b9d7739b2ebb62c960aeb3ccb5
Author:     Cao jin <caoj.fnst@cn.fujitsu.com>
AuthorDate: Fri, 19 Jul 2019 16:16:35 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 22 Jul 2019 10:54:27 +0200

x86/irq/64: Update stale comment

Commit e6401c130931 ("x86/irq/64: Split the IRQ stack into its own pages")
missed to update one piece of comment as it did to its peer in Xen, which
will confuse people who still need to read comment.

Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190719081635.26528-1-caoj.fnst@cn.fujitsu.com

---
 arch/x86/kernel/head_64.S | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index a6342c899be5..f3d3e9646a99 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -193,10 +193,10 @@ ENTRY(secondary_startup_64)
 
 	/* Set up %gs.
 	 *
-	 * The base of %gs always points to the bottom of the irqstack
-	 * union.  If the stack protector canary is enabled, it is
-	 * located at %gs:40.  Note that, on SMP, the boot cpu uses
-	 * init data section till per cpu areas are set up.
+	 * The base of %gs always points to fixed_percpu_data. If the
+	 * stack protector canary is enabled, it is located at %gs:40.
+	 * Note that, on SMP, the boot cpu uses init data section until
+	 * the per cpu areas are set up.
 	 */
 	movl	$MSR_GS_BASE,%ecx
 	movl	initial_gs(%rip),%eax
