Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E275C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E099D2084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554201202;
	bh=+GMc8q0iF4wJkUixs7FbySZIt8Pq5pR/RJwIBoIYuu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bt+SeQ9q1G92K41CRl6Zymphkx6pqpJfM+Zw/7MJpVOmJYt40km47ZykmE7WPE9qt
	 DkzHRNNh8YJgNrcHVRhbqf5uXupkWfQIyt5XqsY+oEoueVR+HNgqUG44zVGn4j2E2q
	 3evOvobmbDoqWu0kXAa+3S1TAEXYmUCUQzBtXVpI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730440AbfDBKcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 06:32:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:36186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729252AbfDBKcp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 06:32:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24A2421473;
        Tue,  2 Apr 2019 10:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554201164;
        bh=+GMc8q0iF4wJkUixs7FbySZIt8Pq5pR/RJwIBoIYuu8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ao6QJeP3hD3yuJGOu5ekOaj6eogb2ID0tbOUxfvZ5RYoMyCf1J7j0EFyxtOQ7bnv0
         702IMB6B5KXQ21xLmWUiJC+xBNjUWtYaWPGYB2GTr65f2zSdVd3poTYpEjPYq/Mp6l
         E9oHLjJ+1y6lcRZGvxjCbf/qV1fxcZcxjFRNMSSE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     devel@driverdev.osuosl.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>
Subject: [PATCH 04/16] staging: sm750fb: add proper SPDX identifier to driver
Date:   Tue,  2 Apr 2019 12:31:51 +0200
Message-Id: <20190402103203.14959-5-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190402103203.14959-1-gregkh@linuxfoundation.org>
References: <20190402103203.14959-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default all files without license information are under the default
license of the kernel, which is GPL version 2.  Because of this, add the
GPL-2.0 identifier to the sm750fb driver which did not have any license
identifiers in it at all.

Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Teddy Wang <teddy.wang@siliconmotion.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/sm750fb/ddk750.h       | 1 +
 drivers/staging/sm750fb/ddk750_swi2c.c | 1 +
 drivers/staging/sm750fb/ddk750_swi2c.h | 1 +
 drivers/staging/sm750fb/sm750.c        | 1 +
 4 files changed, 4 insertions(+)

diff --git a/drivers/staging/sm750fb/ddk750.h b/drivers/staging/sm750fb/ddk750.h
index 734010324a8f..482c1c6ba422 100644
--- a/drivers/staging/sm750fb/ddk750.h
+++ b/drivers/staging/sm750fb/ddk750.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  *         Copyright (c) 2007 by Silicon Motion, Inc. (SMI)
  *
diff --git a/drivers/staging/sm750fb/ddk750_swi2c.c b/drivers/staging/sm750fb/ddk750_swi2c.c
index 19c5ffc72b16..5c0ac747ea2b 100644
--- a/drivers/staging/sm750fb/ddk750_swi2c.c
+++ b/drivers/staging/sm750fb/ddk750_swi2c.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *         Copyright (c) 2007 by Silicon Motion, Inc. (SMI)
  *
diff --git a/drivers/staging/sm750fb/ddk750_swi2c.h b/drivers/staging/sm750fb/ddk750_swi2c.h
index 3b8a96d6d25a..5868feea791b 100644
--- a/drivers/staging/sm750fb/ddk750_swi2c.h
+++ b/drivers/staging/sm750fb/ddk750_swi2c.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  *         Copyright (c) 2007 by Silicon Motion, Inc. (SMI)
  *
diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index e1a892e3b3ad..105089b97bf5 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/errno.h>
-- 
2.21.0

