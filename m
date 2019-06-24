Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548A9C4646B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 21:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2927520665
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 21:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="mqK6FDiF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732283AbfFXV2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 17:28:10 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:38584 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbfFXV2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 17:28:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1561411688; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=Hlbcb6l9yiX+hOM4Bc0EQHzETkdFwe9zp7QRPnRT/04=;
        b=mqK6FDiFCVc7CKkIbkgIdt5KBOsnx/uYHSkCQNZQDDDw6yZoqEQcE9+1MfcMvOrvGwTpl/
        /p7Zm0jNVLX+tJrzQO4XeNWbae1263OFwD7Y9yp0Hjo+vLyFihIrIFQtIl0EMPPyZ7P56I
        IIZzo6XnEAMpUM641oU/NyMkjDmGoUI=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 1/2] MAINTAINERS: Correct path to moved files
Date:   Mon, 24 Jun 2019 23:27:51 +0200
Message-Id: <20190624212752.6816-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver was moved in commit 1838a7b31fcb ("mtd: rawnand: Move
drivers for Ingenic SoCs to subfolder").

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d0ed735994a5..dfedde2f5720 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7800,7 +7800,7 @@ INGENIC JZ4780 NAND DRIVER
 M:	Harvey Hunt <harveyhuntnexus@gmail.com>
 L:	linux-mtd@lists.infradead.org
 S:	Maintained
-F:	drivers/mtd/nand/raw/jz4780_*
+F:	drivers/mtd/nand/raw/ingenic/
 
 INOTIFY
 M:	Jan Kara <jack@suse.cz>
-- 
2.21.0.593.g511ec345e18

