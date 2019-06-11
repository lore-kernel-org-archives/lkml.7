Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B18BC43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 07:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAA6A21721
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 07:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404384AbfFKHUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 03:20:50 -0400
Received: from shell.v3.sk ([90.176.6.54]:60887 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404370AbfFKHUr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 03:20:47 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 08580104F71;
        Tue, 11 Jun 2019 09:20:44 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id h-TpdfOBHDGP; Tue, 11 Jun 2019 09:20:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 28B86104F7C;
        Tue, 11 Jun 2019 09:20:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id L3AopJJZki8D; Tue, 11 Jun 2019 09:20:24 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 2C003104F7E;
        Tue, 11 Jun 2019 09:20:23 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Eric Piel <eric.piel@tremplin-utc.net>
Cc:     Daniel Mack <daniel@caiaq.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] misc: lis3lv02d: Switch to SPDX header
Date:   Tue, 11 Jun 2019 09:20:18 +0200
Message-Id: <20190611072018.2978605-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original license text had a typo ("publishhed") which would be
likely to confuse automated licensing auditing tools. Let's just switch
to SPDX instead of fixing the wording.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/misc/lis3lv02d/lis3lv02d_spi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/misc/lis3lv02d/lis3lv02d_spi.c b/drivers/misc/lis3lv=
02d/lis3lv02d_spi.c
index e575475123c8..d7f17c59f3e7 100644
--- a/drivers/misc/lis3lv02d/lis3lv02d_spi.c
+++ b/drivers/misc/lis3lv02d/lis3lv02d_spi.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * lis3lv02d_spi - SPI glue layer for lis3lv02d
  *
  * Copyright (c) 2009 Daniel Mack <daniel@caiaq.de>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  publishhed by the Free Software Foundation.
  */
=20
 #include <linux/module.h>
--=20
2.21.0

