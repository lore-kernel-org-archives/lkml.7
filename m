Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9347C76188
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 10:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F69D2085A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 10:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbfGUKii (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 06:38:38 -0400
Received: from smtp10.smtpout.orange.fr ([80.12.242.132]:41615 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbfGUKih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 06:38:37 -0400
Received: from localhost.localdomain ([92.140.204.221])
        by mwinf5d33 with ME
        id fNeW2000F4n7eLC03NeWau; Sun, 21 Jul 2019 12:38:35 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 21 Jul 2019 12:38:35 +0200
X-ME-IP: 92.140.204.221
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     jon.maloy@ericsson.com, ying.xue@windriver.com, davem@davemloft.net
Cc:     netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] tipc: Fix a typo
Date:   Sun, 21 Jul 2019 12:38:11 +0200
Message-Id: <20190721103811.29724-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/tipc_toprsv_listener_data_ready/tipc_topsrv_listener_data_ready/
(r and s switched in topsrv)

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
The function name could also be removed from the comment. It does not
bring any useful information IMHO.
---
 net/tipc/topsrv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/tipc/topsrv.c b/net/tipc/topsrv.c
index f345662890a6..ca8ac96d22a9 100644
--- a/net/tipc/topsrv.c
+++ b/net/tipc/topsrv.c
@@ -476,7 +476,7 @@ static void tipc_topsrv_accept(struct work_struct *work)
 	}
 }
 
-/* tipc_toprsv_listener_data_ready - interrupt callback with connection request
+/* tipc_topsrv_listener_data_ready - interrupt callback with connection request
  * The queued job is launched into tipc_topsrv_accept()
  */
 static void tipc_topsrv_listener_data_ready(struct sock *sk)
-- 
2.20.1

