Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CAAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55EBE20828
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbfCZGVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:21:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45754 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726042AbfCZGVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:21:09 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 43DA5C05686F;
        Tue, 26 Mar 2019 06:21:09 +0000 (UTC)
Received: from nyewale.gsslab.pnq.redhat.com (unknown [10.76.0.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5D90B19C5B;
        Tue, 26 Mar 2019 06:21:07 +0000 (UTC)
From:   "Nitin U. Yewale" <nyewale@redhat.com>
To:     airlied@linux.ie, daniel@ffwll.ch, linux-kernel@vger.kernel.org
Cc:     loberman@redhat.com, "Nitin U. Yewale" <nyewale@redhat.com>
Subject: [PATCH] Change in comment for the list_empty() routine.
Date:   Tue, 26 Mar 2019 11:51:03 +0530
Message-Id: <20190326062103.6775-1-nyewale@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 26 Mar 2019 06:21:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

In one of the observations it was noticed that list_empty() routine
returns true when the list is empty (head->next == head) OR False
otherwise. Hence the proposed patch.

Thank you,
Nitin Yewale

Signed-off-by: Nitin U. Yewale <nyewale@redhat.com>
---
 drivers/gpu/drm/nouveau/include/nvif/list.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/include/nvif/list.h b/drivers/gpu/drm/nouveau/include/nvif/list.h
index 8af5d144ecb0..12bf7e3333e4 100644
--- a/drivers/gpu/drm/nouveau/include/nvif/list.h
+++ b/drivers/gpu/drm/nouveau/include/nvif/list.h
@@ -226,10 +226,7 @@ static inline void list_move_tail(struct list_head *list,
 /**
  * Check if the list is empty.
  *
- * Example:
- * list_empty(&bar->list_of_foos);
- *
- * @return True if the list contains one or more elements or False otherwise.
+ * @return True if the list is empty (head->next == head) or False otherwise.
  */
 static inline bool
 list_empty(struct list_head *head)
-- 
2.17.2

