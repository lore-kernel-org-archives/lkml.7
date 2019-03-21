Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0A5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 11:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6337218D8
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 11:29:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbfCUL3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 07:29:13 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54173 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727952AbfCUL3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 07:29:10 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2LBStJ6107108
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 21 Mar 2019 04:28:55 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2LBSt9V107100;
        Thu, 21 Mar 2019 04:28:55 -0700
Date:   Thu, 21 Mar 2019 04:28:55 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Colin Ian King <tipbot@zytor.com>
Message-ID: <tip-725e29db8cb9058976559bc3239c97ef7db40eea@git.kernel.org>
Cc:     tglx@linutronix.de, colin.king@canonical.com, bp@alien8.de,
        mingo@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org
Reply-To: bp@alien8.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
          hpa@zytor.com, colin.king@canonical.com, tglx@linutronix.de
In-Reply-To: <20190314230838.18256-1-colin.king@canonical.com>
References: <20190314230838.18256-1-colin.king@canonical.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/lib: Fix indentation issue, remove extra tab
Git-Commit-ID: 725e29db8cb9058976559bc3239c97ef7db40eea
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

Commit-ID:  725e29db8cb9058976559bc3239c97ef7db40eea
Gitweb:     https://git.kernel.org/tip/725e29db8cb9058976559bc3239c97ef7db40eea
Author:     Colin Ian King <colin.king@canonical.com>
AuthorDate: Thu, 14 Mar 2019 23:08:38 +0000
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 21 Mar 2019 12:24:38 +0100

x86/lib: Fix indentation issue, remove extra tab

The increment of buff is indented one level too deeply, clean
this up by removing a tab.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: kernel-janitors@vger.kernel.org
Link: https://lkml.kernel.org/r/20190314230838.18256-1-colin.king@canonical.com

---
 arch/x86/lib/csum-partial_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/lib/csum-partial_64.c b/arch/x86/lib/csum-partial_64.c
index 9baca3e054be..e7925d668b68 100644
--- a/arch/x86/lib/csum-partial_64.c
+++ b/arch/x86/lib/csum-partial_64.c
@@ -94,7 +94,7 @@ static unsigned do_csum(const unsigned char *buff, unsigned len)
 				    : "m" (*(unsigned long *)buff), 
 				    "r" (zero),  "0" (result));
 				--count; 
-					buff += 8;
+				buff += 8;
 			}
 			result = add32_with_carry(result>>32,
 						  result&0xffffffff); 
