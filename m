Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B834EC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 02:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85732218FC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 02:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555383506;
	bh=WG0cJAxgc70xkRMGU6FsXtxQXEhPAk7hSpduVkNDm7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I9AOgNHbcHex8nXmP1Y2/yqG7GxjxwGFirU+wjEtI19ZNbyJtvfsMtvifIGK90rdC
	 CsGNV5o2NCLiQ2Vg8PtNKzD1XiejNzyxYEr9FKJRT24NpMa43n0LQxaCqvJ94x+Bwa
	 KtXeOvey69lK6WbUSk5YsngFFnhFzW4ZokQpaBFU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbfDPC6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 22:58:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44464 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbfDPC4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 22:56:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tMJPA8XKlMb7HXqe8+rd4L7DaiBpG3Vaxyj02DvN2Fc=; b=S7wEK27WQjePN+YDaZrARtSsn+
        rV3qSxAsTKmFwaHzhRTvE4FET9FxitpL/d5flK9Q/gJMgJF0ZwVx31tnKBstF28oLg07C/MHPJnqz
        E5VOC/s5oBbzM7qyOEbsVAUvu7rtj8/ZcAgUdSlkQU6Qh2ltfAX54IR7XfEjgYokLrG0P3J8qNm6k
        nH0y2T+BRhqOKp0MyH/8G6GnYKQNIvJ6pEFKV5Vp7Rrifyz29lUKCpt7a+5tPgaTgZ8KSIpRI3AUG
        1rETqcpxhu8+wRGzBglVTKbD/eDUr6uEk9Yb6lTkaLx9JcI2c/wbErLD4PxRjAMOz4hvNYUype5RS
        ks5USWww==;
Received: from 177.205.118.176.dynamic.adsl.gvt.net.br ([177.205.118.176] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGEGv-0007aP-P2; Tue, 16 Apr 2019 02:56:33 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hGEGo-0001p8-1m; Mon, 15 Apr 2019 23:56:26 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 41/57] docs: EDID/HOWTO.txt: convert to ReST and move to kernel-API
Date:   Mon, 15 Apr 2019 23:56:06 -0300
Message-Id: <078dfe8f2ebe8c2a3e7cd8504580fbf67f214109.1555382110.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1555382110.git.mchehab+samsung@kernel.org>
References: <cover.1555382110.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sphinx need to know when a paragraph ends. So, do some adjustments
at the file for it to be properly parsed.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/EDID/HOWTO.txt | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/Documentation/EDID/HOWTO.txt b/Documentation/EDID/HOWTO.txt
index 539871c3b785..9a9b512e0ac9 100644
--- a/Documentation/EDID/HOWTO.txt
+++ b/Documentation/EDID/HOWTO.txt
@@ -1,3 +1,7 @@
+====
+EDID
+====
+
 In the good old days when graphics parameters were configured explicitly
 in a file called xorg.conf, even broken hardware could be managed.
 
@@ -34,16 +38,19 @@ Makefile. Please note that the EDID data structure expects the timing
 values in a different way as compared to the standard X11 format.
 
 X11:
-HTimings:  hdisp hsyncstart hsyncend htotal
-VTimings:  vdisp vsyncstart vsyncend vtotal
+  HTimings:
+    hdisp hsyncstart hsyncend htotal
+  VTimings:
+    vdisp vsyncstart vsyncend vtotal
 
-EDID:
-#define XPIX hdisp
-#define XBLANK htotal-hdisp
-#define XOFFSET hsyncstart-hdisp
-#define XPULSE hsyncend-hsyncstart
+EDID::
 
-#define YPIX vdisp
-#define YBLANK vtotal-vdisp
-#define YOFFSET vsyncstart-vdisp
-#define YPULSE vsyncend-vsyncstart
+  #define XPIX hdisp
+  #define XBLANK htotal-hdisp
+  #define XOFFSET hsyncstart-hdisp
+  #define XPULSE hsyncend-hsyncstart
+
+  #define YPIX vdisp
+  #define YBLANK vtotal-vdisp
+  #define YOFFSET vsyncstart-vdisp
+  #define YPULSE vsyncend-vsyncstart
-- 
2.20.1

