Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529FBC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 15:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FAB420838
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 15:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394864AbfIFPdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 11:33:12 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:60027 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfIFPdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 11:33:12 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Mwwhv-1iLQpm1LR5-00yQot; Fri, 06 Sep 2019 17:33:05 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     David Howells <dhowells@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] [don't apply] watch_queue: disable sample
Date:   Fri,  6 Sep 2019 17:32:36 +0200
Message-Id: <20190906153249.1864324-2-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190906153249.1864324-1-arnd@arndb.de>
References: <20190906153249.1864324-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:s7LPzVXx1AJcu2lZxoaxETHXyBTWZCi5uuZHceTd7xmKWVYH64/
 P54VqDE9IQNixadRhryh7ZFIl83Ore9NrMOZvT3DMt10/MyjaDHk5x239xvF1o1Txdg+0dS
 jOwnD8QIBufqBUVa1v8h6bnKEhZHti2cLiHUMhwlwvCy+Hb8EwRyS6J7he9vfAfiU1OGN/H
 2zvHpocrBQdapMUoBsnKw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QteUEtZ8coQ=:ZWe4eD/tcSVz70zIJy7uSw
 ZvnnparMxVq87+j4LEwOmEfKn45AOwhcCMD7OiakzbWuYQyDdhNuHspDZKFn8batrFibFclFZ
 c4BhsbUPZbhf56m2TW4voOSmCqQi35FmHFEyb8bLteZlZHVV0NSYghCt5VMh1AtE1+ZlI/fpo
 eoCQdQswkHJYOn1tqRhW/FXlKJ0c6CS9NJ5aerAyAfgtdiF1jqKUFEFviscuecz9gA5AsyzNA
 HOMLCJ+6COKeREaqiISM72Bit9Gtu0Jgmo/aS4fN80tu9jnKoCT0lVwjb91tkkpVioK6x7bR8
 MkmuNQFPget5mEIMGkRoNhqzUYy5qQu29awB/56bquNcT3urUQ3/2DFyzNrlcFGwaTrIfkoJ1
 tbbfzFDeo5cJfN7S2cPWonh59qj2PjqcnvrEosotfC8rnHcAVvjICfYqwkBf5RKYkG2UOs94j
 evdSbNEDY54OzEDgWZSxIlEWJvxG6yoUr0n6xMJQeUz5NlioDeFBFXrEv5fLgOHM3nFDc6OJs
 p6xJm1MoxAK243XIlBsuaMAbkWd0UMPNY/bPuVsFlmGAupyQ65kMU39WN/YDUJo4FGp+5p6n7
 IJ+CT7HCf7lGQSB0244pKB6jKDLQX39x5XW0k6Yaj6/QBZLAOVPNM922uwVQ+uMWtBIVzbNFP
 6C37wI058WU1mgnw9x6s7EEmrbhLw0jS+G9iIhBEh393gl8Lv30PrAehfnYUcgd3ado8iSoUy
 PNitBkqzRHKmUEJGIU1H5fV3c9xvjQ/fMO+h52Qwlzc11JVqBWxwFSlhzvzqBbr0YASIcie8V
 RcQ079WzlDFA2F5LEGN6yOQHwirVg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building in a separate object directory causes a compilation
failure for a missing header:

samples/watch_queue/watch_test.c:23:10: fatal error: linux/watch_queue.h: No such file or directory

I could not figure out why this does not work and applied this
patch locally. It would be good to fix this properly for 5.4
instead.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 samples/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/Makefile b/samples/Makefile
index a61a39047d02..068b28113be9 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -20,4 +20,4 @@ obj-$(CONFIG_SAMPLE_TRACE_PRINTK)	+= trace_printk/
 obj-$(CONFIG_VIDEO_PCI_SKELETON)	+= v4l/
 obj-y					+= vfio-mdev/
 subdir-$(CONFIG_SAMPLE_VFS)		+= vfs
-subdir-$(CONFIG_SAMPLE_WATCH_QUEUE)	+= watch_queue
+#subdir-$(CONFIG_SAMPLE_WATCH_QUEUE)	+= watch_queue
-- 
2.20.0

