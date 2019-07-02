Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B0DC06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 19:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCCB12184C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 19:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Sf3qzsDU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfGBTOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 15:14:49 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34899 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfGBTOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 15:14:49 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x62JDtPh2935803
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 2 Jul 2019 12:13:55 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x62JDtPh2935803
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562094836;
        bh=6PAtDxcbxse3qWHOJN5nO+ekfSO0ovyq4RB8UeAPDu4=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Sf3qzsDUIeeRheKIVfTE7/UNg0m1UHEmUHHxqpuG9kyj8UWB+afgnnCRhkXWWVsMy
         Z9NfhmMrV98K6O31+cJog2Wcyc93K7IH3c82cq6z1bShuuBnRbS5W6f+EVUIdq1N2E
         dJK47OcYjcvyxkxAjUdKaXTVmuRyDM7ImQyr2QQvX8HO3WnkuxjfJCs+tt3q4/YOUw
         ankPrT7Nckz+lLWro9VPe9MH4ywy7Oo85h94SBMnOdyGMwxH0R8Ny7P+46MZghFHHk
         XF8PPGjwJSTarX8emC2Y+1avDp63CHh3xFDXQV9lW60nPE+Ohd+X/sym5VUpoDFI6W
         hpraKK5c1JYYg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x62JDqTq2935800;
        Tue, 2 Jul 2019 12:13:52 -0700
Date:   Tue, 2 Jul 2019 12:13:52 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ross Zwisler <tipbot@zytor.com>
Message-ID: <tip-77a1619947ab31564aed54621d5b1e34af9b395d@git.kernel.org>
Cc:     klaus.kusche@computerix.info, groeck@google.com,
        zwisler@chromium.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, keescook@chromium.org, groeck@chromium.org,
        johannes.hirte@datenkhaos.de, hpa@zytor.com, bp@alien8.de,
        tglx@linutronix.de, zwisler@google.com
Reply-To: zwisler@chromium.org, johannes.hirte@datenkhaos.de,
          hpa@zytor.com, bp@alien8.de, tglx@linutronix.de,
          zwisler@google.com, linux-kernel@vger.kernel.org,
          klaus.kusche@computerix.info, mingo@kernel.org,
          keescook@chromium.org, groeck@chromium.org, groeck@google.com
In-Reply-To: <20190701155208.211815-1-zwisler@google.com>
References: <20190701155208.211815-1-zwisler@google.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] Revert "x86/build: Move _etext to actual end of
 .text"
Git-Commit-ID: 77a1619947ab31564aed54621d5b1e34af9b395d
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

Commit-ID:  77a1619947ab31564aed54621d5b1e34af9b395d
Gitweb:     https://git.kernel.org/tip/77a1619947ab31564aed54621d5b1e34af9b395d
Author:     Ross Zwisler <zwisler@chromium.org>
AuthorDate: Mon, 1 Jul 2019 09:52:08 -0600
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 2 Jul 2019 21:09:44 +0200

Revert "x86/build: Move _etext to actual end of .text"

This reverts commit 392bef709659abea614abfe53cf228e7a59876a4.

Per the discussion here:

  https://lkml.kernel.org/r/201906201042.3BF5CD6@keescook

the above referenced commit breaks kernel compilation with old GCC
toolchains as well as current versions of the Gold linker.

Revert it to fix the regression and to keep the ability to compile the
kernel with these tools.

Signed-off-by: Ross Zwisler <zwisler@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Guenter Roeck <groeck@chromium.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Kees Cook <keescook@chromium.org>
Cc: Johannes Hirte <johannes.hirte@datenkhaos.de>
Cc: Klaus Kusche <klaus.kusche@computerix.info>
Cc: samitolvanen@google.com
Cc: Guenter Roeck <groeck@google.com>
Link: https://lkml.kernel.org/r/20190701155208.211815-1-zwisler@google.com

---
 arch/x86/kernel/vmlinux.lds.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 0850b5149345..4d1517022a14 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -141,10 +141,10 @@ SECTIONS
 		*(.text.__x86.indirect_thunk)
 		__indirect_thunk_end = .;
 #endif
-	} :text = 0x9090
 
-	/* End of text section */
-	_etext = .;
+		/* End of text section */
+		_etext = .;
+	} :text = 0x9090
 
 	NOTES :text :note
 
