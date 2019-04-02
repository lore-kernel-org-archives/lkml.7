Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1ECCC10F00
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C155A20883
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554201144;
	bh=sD6zTus7bi2Qqn3F/hCyag97KG7kHn0XIckfgB6F7gQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n6zA3JHs1obJl07hWNkuTbVDJvZYiXGotPJOCcSxkRbl7Deb69HMz3TKtFQ6U+UlP
	 aJhSv2JiT5AmpySfmKgIkUtMgxeQXNrevt6zNmpeLnMRzA2dhaL5qcq1lsNuAgW/cM
	 poItWUjtdQUQjlPPB6qiQciqyWabWGY4DZSr98Z8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730341AbfDBKcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 06:32:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:35506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbfDBKcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 06:32:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F99F21473;
        Tue,  2 Apr 2019 10:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554201140;
        bh=sD6zTus7bi2Qqn3F/hCyag97KG7kHn0XIckfgB6F7gQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lp+bFQzkx3ZV6UEXNrIQdKkkS7Mz4xP2/3xl2djWQs+q+qTtfwaUuZcD5kXKZZV9x
         YbCBrYPdgdoDX7n/sxOIwNNhIq70kazwCkf4NAtqHJjZYH+1iHe6zlqBSJPAmUzapX
         lTUDKd0FxWX3EuRsv56rZkn1jHuPeid72mSqbdC4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     devel@driverdev.osuosl.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 10/16] staging: ralink-gdma: add proper SPDX identifiers on ralink-gdma file
Date:   Tue,  2 Apr 2019 12:31:57 +0200
Message-Id: <20190402103203.14959-11-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190402103203.14959-1-gregkh@linuxfoundation.org>
References: <20190402103203.14959-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ralink-gdma.c driver did not have a SPDX identifier on it, so fix
that up.  At the same time, remove the "free form" text that specified
the license of the file, as that is impossible for any tool to properly
parse.

Cc: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/ralink-gdma/ralink-gdma.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/ralink-gdma/ralink-gdma.c b/drivers/staging/ralink-gdma/ralink-gdma.c
index b6d484532269..a032e5f966b3 100644
--- a/drivers/staging/ralink-gdma/ralink-gdma.c
+++ b/drivers/staging/ralink-gdma/ralink-gdma.c
@@ -1,12 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *  Copyright (C) 2013, Lars-Peter Clausen <lars@metafoo.de>
  *  GDMA4740 DMAC support
- *
- *  This program is free software; you can redistribute it and/or modify it
- *  under  the terms of the GNU General	 Public License as published by the
- *  Free Software Foundation;  either version 2 of the License, or (at your
- *  option) any later version.
- *
  */
 
 #include <linux/dmaengine.h>
-- 
2.21.0

