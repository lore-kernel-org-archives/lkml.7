Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C755C2D0C8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 02:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C91E420684
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 02:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DF0hO7Ku"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfLWCZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Dec 2019 21:25:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26267 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726291AbfLWCZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 21:25:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577067957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=i8/u9Ju6Fy8iBdXdwrlY6oE1+XkJvdBR0HuedlqPOIU=;
        b=DF0hO7KuaJV8dl2rX0R0XMSrdGA/5CGL19/NKXXvBTgN9obyUdxGkSAzPHnJtSx3qtRoX7
        +yDAL0jCMMwBO4FEkjGiGl+6B5OSRxYRm5x5RxuOFBOdqQ3i4r1GJ2KmRwW58Ko1QifiD2
        CkZICbVW8hpkj+pzVbnnyvrTR6w2XnU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-UWRXfYPKMNmuG-7q4Vkp0Q-1; Sun, 22 Dec 2019 21:25:53 -0500
X-MC-Unique: UWRXfYPKMNmuG-7q4Vkp0Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A6048184B442;
        Mon, 23 Dec 2019 02:25:52 +0000 (UTC)
Received: from llong.com (ovpn-120-70.rdu2.redhat.com [10.10.120.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B3C7376FE2;
        Mon, 23 Dec 2019 02:25:47 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>
Subject: [PATCH] locking/qspinlock: Fix inaccessible URL of MCS lock paper
Date:   Sun, 22 Dec 2019 21:25:32 -0500
Message-Id: <20191223022532.14864-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It turns out that the URL of the MCS lock paper listed in the source
code is no longer accessible. I did got question about where the paper
was. This patch updates the URL to one that is still accessible.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/qspinlock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 2473f10c6956..1d008d2333c0 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -34,7 +34,7 @@
  * MCS lock. The paper below provides a good description for this kind
  * of lock.
  *
- * http://www.cise.ufl.edu/tr/DOC/REP-1992-71.pdf
+ * https://www.cs.rochester.edu/u/scott/papers/1991_TOCS_synch.pdf
  *
  * This queued spinlock implementation is based on the MCS lock, however to make
  * it fit the 4 bytes we assume spinlock_t to be, and preserve its existing
-- 
2.18.1

