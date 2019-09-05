Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 482FDC43140
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 19:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1A2420825
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 19:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403917AbfIEToj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 15:44:39 -0400
Received: from fieldses.org ([173.255.197.46]:56710 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727171AbfIETof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 15:44:35 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id CB5921E3B; Thu,  5 Sep 2019 15:44:34 -0400 (EDT)
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 4/9] Remove unused string_escape_*_any_np
Date:   Thu,  5 Sep 2019 15:44:28 -0400
Message-Id: <1567712673-1629-4-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1567712673-1629-1-git-send-email-bfields@redhat.com>
References: <20190905193604.GC31247@fieldses.org>
 <1567712673-1629-1-git-send-email-bfields@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

These aren't called anywhere.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 include/linux/string_helpers.h | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/include/linux/string_helpers.h b/include/linux/string_helpers.h
index c28955132234..8a299a29b767 100644
--- a/include/linux/string_helpers.h
+++ b/include/linux/string_helpers.h
@@ -56,25 +56,12 @@ int string_escape_mem(const char *src, size_t isz, char *dst, size_t osz,
 
 int string_escape_mem_ascii(const char *src, size_t isz, char *dst,
 					size_t osz);
-
-static inline int string_escape_mem_any_np(const char *src, size_t isz,
-		char *dst, size_t osz, const char *only)
-{
-	return string_escape_mem(src, isz, dst, osz, ESCAPE_ANY_NP, only);
-}
-
 static inline int string_escape_str(const char *src, char *dst, size_t sz,
 		unsigned int flags, const char *only)
 {
 	return string_escape_mem(src, strlen(src), dst, sz, flags, only);
 }
 
-static inline int string_escape_str_any_np(const char *src, char *dst,
-		size_t sz, const char *only)
-{
-	return string_escape_str(src, dst, sz, ESCAPE_ANY_NP, only);
-}
-
 char *kstrdup_quotable(const char *src, gfp_t gfp);
 char *kstrdup_quotable_cmdline(struct task_struct *task, gfp_t gfp);
 char *kstrdup_quotable_file(struct file *file, gfp_t gfp);
-- 
2.21.0

