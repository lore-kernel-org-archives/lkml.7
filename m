Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F39C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 13:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFACF2081C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 13:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbfECND4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 09:03:56 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46972 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfECND4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 09:03:56 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gportay)
        with ESMTPSA id 909AA263ADE
From:   =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     =?utf-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay@savoirfairelinux.com>
Subject: [PATCH] uapi libc compat: fix spelling typo
Date:   Fri,  3 May 2019 09:04:01 -0400
Message-Id: <20190503130401.27294-1-gael.portay@collabora.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gaël PORTAY <gael.portay@savoirfairelinux.com>

Replace 'm' with 'n' in "comflicting".

Signed-off-by: Gaël PORTAY <gael.portay@savoirfairelinux.com>
---
 include/uapi/linux/libc-compat.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/libc-compat.h b/include/uapi/linux/libc-compat.h
index 8254c937c9f4..50ec41c4b660 100644
--- a/include/uapi/linux/libc-compat.h
+++ b/include/uapi/linux/libc-compat.h
@@ -21,7 +21,7 @@
  *      e.g. #include <linux/libc-compat.h>
  *     This include must be as early as possible.
  *
- * (b) In libc-compat.h add enough code to detect that the comflicting
+ * (b) In libc-compat.h add enough code to detect that the conflicting
  *     userspace libc header has been included first.
  *
  * (c) If the userspace libc header has been included first define a set of
-- 
2.21.0

