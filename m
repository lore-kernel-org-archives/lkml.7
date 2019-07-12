Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B86C742BA
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4F3520645
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562935087;
	bh=xxRtUTDCKhzXdeTgs0S5YKCWNASaZOqK2PANmHf8px8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sj1I6xHcTjRvjUmJj39s7/k1GEGXT2dTtteFePDqzvpV7qgtAT63wCH9uMtXjtYhq
	 IeHXimOWXRxq9hgGzeH4VQc52NirCBWMGTNBE9JiEvMb7IRaJKlvkP9ATc6F7NIo4I
	 JlElekYePopkSNJ1FTT0gh7+THB5BPVHjHv7neB8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbfGLMiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 08:38:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:45118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727610AbfGLM3y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:29:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93C57208E4;
        Fri, 12 Jul 2019 12:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562934593;
        bh=xxRtUTDCKhzXdeTgs0S5YKCWNASaZOqK2PANmHf8px8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GSODTSO+wG8kk636QnZzDojug75nlV/NTVjRMMyRJbFNp6Vty4AVuAS/6dpIIpj9T
         D0g1fhwYLrxBHw+2BKF0frlNgDOr5oc69THZGwLn1udyZsLeHIhgwb0d3H/E3FncHN
         QW6KooajjVYmPTbkwE2UZYliqNM86pJOogpB++LM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Florian Weimer <fweimer@redhat.com>,
        Jann Horn <jannh@google.com>, Borislav Petkov <bp@alien8.de>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 5.1 105/138] Documentation/admin: Remove the vsyscall=native documentation
Date:   Fri, 12 Jul 2019 14:19:29 +0200
Message-Id: <20190712121632.793176749@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190712121628.731888964@linuxfoundation.org>
References: <20190712121628.731888964@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Lutomirski <luto@kernel.org>

commit d974ffcfb7447db5f29a4b662a3eaf99a4e1109e upstream.

The vsyscall=native feature is gone -- remove the docs.

Fixes: 076ca272a14c ("x86/vsyscall/64: Drop "native" vsyscalls")
Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Kees Cook <keescook@chromium.org>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: Jann Horn <jannh@google.com>
Cc: stable@vger.kernel.org
Cc: Borislav Petkov <bp@alien8.de>
Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/r/d77c7105eb4c57c1a95a95b6a5b8ba194a18e764.1561610354.git.luto@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Documentation/admin-guide/kernel-parameters.txt |    6 ------
 1 file changed, 6 deletions(-)

--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5074,12 +5074,6 @@
 			emulate     [default] Vsyscalls turn into traps and are
 			            emulated reasonably safely.
 
-			native      Vsyscalls are native syscall instructions.
-			            This is a little bit faster than trapping
-			            and makes a few dynamic recompilers work
-			            better than they would in emulation mode.
-			            It also makes exploits much easier to write.
-
 			none        Vsyscalls don't work at all.  This makes
 			            them quite hard to use for exploits but
 			            might break your system.


