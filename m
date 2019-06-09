Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DE8C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05C1120843
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560099203;
	bh=MpYDlxEzM89J10j2FWR/9KD66j1za1YxxQWzRSi1PHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SMIS1D9Uf9uUR+Riw8nZhVUb04KdeoE69Oar1f3IV4wQR0vCWnf/tcxPq252ry++r
	 v8X3qkODgI0skkjHOGVT+QwKRsYbPyYUbeiKCMQ+vhEbGjAPMZ9fpsIkIcHMSDZz3A
	 2sjOcrMUn/2O1dMkTTu0jnUwusFNCt2KJkd1FtZ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732382AbfFIQxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 12:53:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:54476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732369AbfFIQxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 12:53:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95E212081C;
        Sun,  9 Jun 2019 16:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560099197;
        bh=MpYDlxEzM89J10j2FWR/9KD66j1za1YxxQWzRSi1PHU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w98sDvUm8sPPYHBt+O8XVEXsOZ8u0ovh/VgyaIEkdRcqVW5EcPhI4LvuRiNIiGjEp
         R/qG6lz/zfqrKkKhh0BVtcKvhyaXyXU61PGePCz/Ah16KLDGcFMmirgH44PhPlyxD+
         H7po4SQfvCQRAYQO6guL6v6sX/TLuT78TnxUUWfA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 4.9 44/83] docs: Fix conf.py for Sphinx 2.0
Date:   Sun,  9 Jun 2019 18:42:14 +0200
Message-Id: <20190609164131.661407633@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164127.843327870@linuxfoundation.org>
References: <20190609164127.843327870@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Corbet <corbet@lwn.net>

commit 3bc8088464712fdcb078eefb68837ccfcc413c88 upstream.

Our version check in Documentation/conf.py never envisioned a world where
Sphinx moved beyond 1.x.  Now that the unthinkable has happened, fix our
version check to handle higher version numbers correctly.

Cc: stable@vger.kernel.org
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Documentation/conf.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -37,7 +37,7 @@ from load_config import loadConfig
 extensions = ['kernel-doc', 'rstFlatTable', 'kernel_include', 'cdomain']
 
 # The name of the math extension changed on Sphinx 1.4
-if major == 1 and minor > 3:
+if (major == 1 and minor > 3) or (major > 1):
     extensions.append("sphinx.ext.imgmath")
 else:
     extensions.append("sphinx.ext.pngmath")


