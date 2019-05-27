Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C226C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 14:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B8852070D
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 14:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfE0OjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 10:39:16 -0400
Received: from laurent.telenet-ops.be ([195.130.137.89]:43126 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbfE0OjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 10:39:16 -0400
Received: from ramsan ([84.194.111.163])
        by laurent.telenet-ops.be with bizsmtp
        id HSfD2000X3XaVaC01SfDU0; Mon, 27 May 2019 16:39:14 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hVGmP-0001tp-MO; Mon, 27 May 2019 16:39:13 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hVGmP-0004uv-KF; Mon, 27 May 2019 16:39:13 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH resend] fs: VALIDATE_FS_PARSER should default to n
Date:   Mon, 27 May 2019 16:39:03 +0200
Message-Id: <20190527143903.18849-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_VALIDATE_FS_PARSER is a debugging tool to check that the parser
tables are vaguely sane.  It was set to default to 'Y' for the moment to
catch errors in upcoming fs conversion development.

Make sure it is not enabled by default in the final release of v5.1.

Fixes: 31d921c7fb969172 ("vfs: Add configuration parser helpers")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Woops, we have already missed v5.1.
And the v5.2-rc1 merge window...

 fs/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/Kconfig b/fs/Kconfig
index f1046cf6ad85e01e..bfb1c6095c7a743c 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -11,7 +11,6 @@ config DCACHE_WORD_ACCESS
 
 config VALIDATE_FS_PARSER
 	bool "Validate filesystem parameter description"
-	default y
 	help
 	  Enable this to perform validation of the parameter description for a
 	  filesystem when it is registered.
-- 
2.17.1

