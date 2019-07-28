Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4AACC433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 15:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 958522077C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 15:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="1rM1J0SS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbfG1P2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 11:28:43 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:44239 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfG1P2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 11:28:42 -0400
Received: from grover.flets-west.jp (softbank126026094249.bbtec.net [126.26.94.249]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id x6SFRjoH032396;
        Mon, 29 Jul 2019 00:27:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com x6SFRjoH032396
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1564327665;
        bh=cv2R2Hg8yEnOOT6uX3lov2e8BV6CxCkH2pDRomEfHqU=;
        h=From:To:Cc:Subject:Date:From;
        b=1rM1J0SSiXt8N8GSFtzbA6gKDrl7bbMixYBMrIh9it841XsP1x/ye3Vn8AmgewHGv
         JLp2iUxMgOvQZVluF4Gvd9CwggXf8asUj/FfvbYBchyK4bPD4AHnCmFr77NWQHMAww
         3V0AFre1DcuG60vMrPtidwdt+/A/xScL5UJbWeTBADpfCqm3jKvAbMAFbWsYvvJAx+
         fEt1fYuVzB7mMPNNXuQ0uUXqCDCi5GjouTjyd7tBd8FOmO/KHhGPOqCPIGqRFILt2I
         9exP42YkRV6yuSu7UrYrzOfQJz2XMEbanrQ6thbKyIyK8qz3XUvcRhOJxrRQmptkol
         pdLQZXxRgSznQ==
X-Nifty-SrcIP: [126.26.94.249]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>,
        linux-parport@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ppdev: add header include guard
Date:   Mon, 29 Jul 2019 00:27:39 +0900
Message-Id: <20190728152739.9249-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a header include guard just in case.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 include/uapi/linux/ppdev.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/ppdev.h b/include/uapi/linux/ppdev.h
index 8fe3c64d149e..eb895b83f2bd 100644
--- a/include/uapi/linux/ppdev.h
+++ b/include/uapi/linux/ppdev.h
@@ -15,6 +15,9 @@
  * Added PPGETMODES/PPGETMODE/PPGETPHASE, Fred Barnes <frmb2@ukc.ac.uk>, 03/01/2001
  */
 
+#ifndef _UAPI_LINUX_PPDEV_H
+#define _UAPI_LINUX_PPDEV_H
+
 #define PP_IOCTL	'p'
 
 /* Set mode for read/write (e.g. IEEE1284_MODE_EPP) */
@@ -97,4 +100,4 @@ struct ppdev_frob_struct {
 /* only masks user-visible flags */
 #define PP_FLAGMASK	(PP_FASTWRITE | PP_FASTREAD | PP_W91284PIC)
 
-
+#endif /* _UAPI_LINUX_PPDEV_H */
-- 
2.17.1

