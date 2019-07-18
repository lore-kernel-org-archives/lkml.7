Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E52C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38BA1208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="C7liqoEy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391588AbfGRTrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 15:47:13 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47469 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391394AbfGRTrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 15:47:12 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6IJl3HW2136613
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 18 Jul 2019 12:47:04 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6IJl3HW2136613
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563479224;
        bh=QLmgHG6GxLsgdcsFj3WGG565YW99KcAv1vtOrOkRfQs=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=C7liqoEyX4KtMirVte9kGgETePa5PKYlmGEwKyCbGR3ZNKxo/JDflDjZ5inMvVcXw
         7P+Fkb7IE4DuWOM+GaUohTkKAeoxsEE0QX6NuVQjFIPSr9cTHC4SRtYWOXShhpYw9y
         xK5AtUQk69oTYYinT+AiPmZbSVVer/RL32qTNLhnEzI25iRrCd+K83wY6Y+5F7Nn+4
         urqpJxZtLExVTYAebNC6Iw1MymXJ/oZd1/ei8MZUO0VQ3Gda+GXvMAdPNuZcZAKCVC
         16bzULzAhHb6OAObX4V/mvqqRJHrlbwZmkNOolddv+Dg5/2ey9T+XuH2/G1/Oy9ENr
         C1N8Tni+VFkWg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6IJl3hU2136610;
        Thu, 18 Jul 2019 12:47:03 -0700
Date:   Thu, 18 Jul 2019 12:47:03 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Zhenzhong Duan <tipbot@zytor.com>
Message-ID: <tip-449f328637e3ca62461da04d60ccb35aa5aa21dc@git.kernel.org>
Cc:     zhenzhong.duan@oracle.com, tglx@linutronix.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        hpa@zytor.com
Reply-To: kirill.shutemov@linux.intel.com, hpa@zytor.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          zhenzhong.duan@oracle.com, tglx@linutronix.de
In-Reply-To: <1563283040-31101-1-git-send-email-zhenzhong.duan@oracle.com>
References: <1563283040-31101-1-git-send-email-zhenzhong.duan@oracle.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/boot/compressed/64: Remove unused variable
Git-Commit-ID: 449f328637e3ca62461da04d60ccb35aa5aa21dc
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

Commit-ID:  449f328637e3ca62461da04d60ccb35aa5aa21dc
Gitweb:     https://git.kernel.org/tip/449f328637e3ca62461da04d60ccb35aa5aa21dc
Author:     Zhenzhong Duan <zhenzhong.duan@oracle.com>
AuthorDate: Tue, 16 Jul 2019 21:17:20 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 18 Jul 2019 21:41:57 +0200

x86/boot/compressed/64: Remove unused variable

Fix gcc warning:

arch/x86/boot/compressed/pgtable_64.c: In function 'find_trampoline_placement':
arch/x86/boot/compressed/pgtable_64.c:43:16: warning: unused variable 'trampoline_start' [-Wunused-variable]
  unsigned long trampoline_start;
               ^

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Link: https://lkml.kernel.org/r/1563283040-31101-1-git-send-email-zhenzhong.duan@oracle.com

---
 arch/x86/boot/compressed/pgtable_64.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index f8debf7aeb4c..5f2d03067ae5 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -40,7 +40,6 @@ int cmdline_find_option_bool(const char *option);
 static unsigned long find_trampoline_placement(void)
 {
 	unsigned long bios_start = 0, ebda_start = 0;
-	unsigned long trampoline_start;
 	struct boot_e820_entry *entry;
 	char *signature;
 	int i;
