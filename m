Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DFCC43215
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDE1922528
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574257401;
	bh=5OeD+Fpcv3jbL7DY20Wdxgsi232mvvhsRtlVt+/FobY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=tQ4lXDCk2yVxiUEYXb80iBvGNVSxiZyIx75RmriMp5WIqlufVBrowCVOcNl4OaA2I
	 TK+TyNvb9VXEEOXYINhX7cblxi+IWhMgJIPYFD+sE+C2gsG/+JLAhlWPIX4GTQjGgK
	 oz1aZIhqp2lL6sDsZcRJF2321xmSrvXKzzmgjyYE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731285AbfKTNnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:43:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:51200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730110AbfKTNnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:43:18 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FA2222528;
        Wed, 20 Nov 2019 13:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257398;
        bh=5OeD+Fpcv3jbL7DY20Wdxgsi232mvvhsRtlVt+/FobY=;
        h=From:To:Cc:Subject:Date:From;
        b=XAkPp5iGbCv+yJbra+fpKyQQVrsNijmXlFUmG0napgcSHhuT78joo0C+580Xpskfh
         +DTHdr5GT6GdTPNyOJtxNGAQVRDkeVKkloDiaefYTvroiemCNqaJrwC8J01Jp+0aIX
         c+GHFYfyiiAdR3XVK1X6Ss1p7ew6+Ub3FIMQYkJs=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Evgeniy Dushistov <dushistov@mail.ru>
Subject: [PATCH] ufs: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:43:14 +0800
Message-Id: <20191120134314.16412-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 fs/ufs/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ufs/Kconfig b/fs/ufs/Kconfig
index 6d30adb6b890..f1f725c5a28c 100644
--- a/fs/ufs/Kconfig
+++ b/fs/ufs/Kconfig
@@ -11,8 +11,8 @@ config UFS_FS
 	  experimental "UFS file system write support", below. Please read the
 	  file <file:Documentation/admin-guide/ufs.rst> for more information.
 
-          The recently released UFS2 variant (used in FreeBSD 5.x) is
-          READ-ONLY supported.
+	  The recently released UFS2 variant (used in FreeBSD 5.x) is
+	  READ-ONLY supported.
 
 	  Note that this option is generally not needed for floppies, since a
 	  good portable way to transport files and directories between unixes
-- 
2.17.1

