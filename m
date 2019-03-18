Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76745C10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B07B2133D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbfCRQ1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 12:27:49 -0400
Received: from mout.gmx.net ([212.227.15.19]:59977 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726719AbfCRQ1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 12:27:49 -0400
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MMT1y-1h6UOv0f1y-008MEv; Mon, 18
 Mar 2019 17:27:43 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     virtualization@lists.linux-foundation.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] tools/virtio/ringtest: Remove bogus definition of BUG_ON()
Date:   Mon, 18 Mar 2019 17:27:34 +0100
Message-Id: <20190318162735.20706-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:XX0Ang4KROrA4VDaUcOTj9GArUG8RsEmzn+XZAkLuEiqmbMCvIo
 D63Q6hziPgy2b1Nz+gcmWi8sbpb23PFwy8Icgjpo8BQnfKdBR/xOJq/l3XPyl5gJfWFwrOh
 zczenhZxg1lryIaXdIdCb3Y3BK4eOEaxPy5jZ40K/I5V1HynLgZ4jzcsRoJGRRstlwW4Llk
 SWf/PiIZfwI45CDDDwlrg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BEjiwPB241A=:Ky59Y7+g/JwuoRWDZmkiR2
 duwQAZDw0YktCPZ5rZ0V7gwGF3RmVMNsfiAvAqYzUtZesW9yNiwLU967yhVeoNE420R1ljfMo
 mzMmyjLgSADTzQDSBesvfbRdjCqiZIQg3T/urMdEY6lQEFD3oNITLOCKrHNQ/VVbiwTYXh87K
 G2bixbUGm94AJJkVEraGaPWs4G13zYqOgjCkLd+AcIJNcyGZlsXpjaJ6AWPtUU0yIqiuACksh
 GfudV8VwCzgH2AUKskq4PrLEjq4+Y96JmawrjtQ7o+nwG+898dQKL2cAoPd4QIlaJR3k4kaPs
 Ea9QIR9mXyUQawTtLYr3bCFR8hibJkoWGFO7xh7kBItGr5wBcZ8sxGCkhNlPq3y8opA0UYYWr
 50Am5h6VTcFA/QJYM2aRcmN8ILeERL7cYxgnQCjBvYHv/411Nqf9YroR0cqyOOdPuwYIMuctn
 gMCnrH3qmjUGGdspoTCn6EePFZm91wk5N9cVzB1uclWHmxI/Z5YRHPCMfSruunRCqKiLqHdhr
 w3dxMgCOuXFphKoL6q6c3O7qDX6yVRWdT/MESsD9PwR4K+SH8RoLxWcxV7aR3MSH308A0/2mY
 oS5qS1fRtB4JKCfKQpbzhVN4qau3dKzOa4R5knNG8tuEm4imb4gq0IJi6W8o5OJBcrFoRaaCk
 E0mfPV7ZMUQcl6rnh0N4QETaSf5qjHCc2bJQ/lXUznmz9QfYPjxxedZuP5ltBW8zA9n4BMyLY
 wmzIwY9OfpntQU+AXt8dm0/5atgB5i4/70+sV7aHCTxQpeiEUIlQSVEePhWrzXZ4L+SHKQcRJ
 U9wimDJBbt7i6YwE1pZ20efxdn8Xcimtiz9gZbl788v08N6l5WysAfqZ1UbcTMWZ5g5zsnN1n
 grdQHwyCulGimmjqANIyxgtYwWeI2mpUFUlnk8xAgXaYDl0yImijFxe5RbgZplnHDOg0cd+4e
 Ri1oTsbLoLw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BUG_ON(x) should raise an error if x is true, but assert(x) raises an
error if x is false. Remove this bogus definition of BUG_ON(), which
isn't used anyway.

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---

Previous copy of v1:
https://lore.kernel.org/lkml/20190129140443.31161-1-j.neuschaefer@gmx.net/
---
 tools/virtio/ringtest/ptr_ring.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/virtio/ringtest/ptr_ring.c b/tools/virtio/ringtest/ptr_ring.c
index 2d566fbd236b..c9b26335f891 100644
--- a/tools/virtio/ringtest/ptr_ring.c
+++ b/tools/virtio/ringtest/ptr_ring.c
@@ -18,7 +18,6 @@
 #define ALIGN(x, a) (((x) + (a) - 1) / (a) * (a))
 #define SIZE_MAX        (~(size_t)0)
 #define KMALLOC_MAX_SIZE SIZE_MAX
-#define BUG_ON(x) assert(x)
 
 typedef pthread_spinlock_t  spinlock_t;
 
-- 
2.20.1

