Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21012C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 20:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9F58222D2
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 20:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389371AbfIRUAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 16:00:43 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:48685 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389356AbfIRUAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 16:00:42 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MBmI6-1iMncA0xDQ-00CBd2; Wed, 18 Sep 2019 22:00:30 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Liu, Chuansheng" <chuansheng.liu@intel.com>,
        Tejun Heo <tj@kernel.org>, Steve Winslow <swinslow@gmail.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ahci: stop exporting ahci_em_messages
Date:   Wed, 18 Sep 2019 22:00:14 +0200
Message-Id: <20190918200028.2247535-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:bpP25I+L2snij/kUqvLgw3zHSK9dhWbjzC82+IB6twYDHAFGQcr
 5mHV298wUutxqh5H8Q2yMZUqYznPqCkvmIqG6u5Kh672WygjToVZh0s6f8lm3imYrJzwLbT
 P1/e2gR8o6motJ+cDDMjVWt4l7XtghqMV+sEid255iuWxRJHeDJKQ6sQhTtiNsMohDFr4qy
 y4y5tq7fCFsPx2oaNdaNA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xAQ/KbzZe6w=:2FqdJaohZIwFU+qEOP2oOw
 F5ILF5tw/IuNk88r4Ibh28YVfTi6JlZG9n3Qa4SN6HfN2yIQEQRezbyrqyQ5XUn4BRQe2im66
 Vq+EOV9sCRYptdYn79nalJ8SKBPsXOuDt9V7Emf9LIjLAHbSsQP3WmecXwgx7o23rMFeki+RJ
 nmRvu2lFs1wwSpJdcZgQIuLZDQBSCBQ12dYBV9kXTBqTDxlw+64e7UOAK6YbMOff0iXuk/mji
 tDhRAKidxjGUl+gAudMlmOAoh0aVO5Q54b2b0Q4SSIfr3XjdvOOiaZKIk4UIhEKrl3H2Hlica
 GaAvi6u2D1eOhfk1ItmZsEVHOCw7EMu/H0y1zmhFTbPpH8Ds5xvqlntLIKmcCoc8Cud9NrvL2
 RqDgRzHiU+/+J652oY+z2Dc5W72sgXsnXOcS1coPV2Dss0CGIptBUMkvF2aN0Evd8k5z0yNHB
 F7EkvrmQ81ZC3wldoCURDUHWzUZFLhhz5SVaRuWumzkfRxDnwubL6HRR3FvPwdj5dLybKbJaX
 fYAlXbdppNaraVctdtQ7qxauidoYCoOrTGwdC9iKci9XAS+ykYEgUXcqNl0OKewyk11c9STWe
 bxiFzOAAATemrNkb9DPnD2FvCqa3BbX0sdJXbYptdXz9tH7UuOQLmUBCSfaf4C8SD2AD1/EfJ
 99ZeZff6grEz/CbFGq4k+AWsnYD+NYeVyIE9doZJChQbOlxFa/tSMP1vT/IwIB6seRNLaMaxb
 mqkrWDDrEDmGnqbBw/ShhMEpqJwfWaI7PIXWh3ttujdL20KhpG7tn87NrjPJvqXTZ4sgwB76K
 2PgQKpfWuDMNtDrNM2oWtVO1Nv83NlICCRic8GdFF5dlMQtiCVHZOjubW3QEOw8D2XTx3L5kx
 JeBhQHDS9NdMWsN7fr0w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The symbol is now static and not used elswhere, which
leads to a warning message:

WARNING: "ahci_em_messages" [vmlinux] is a static EXPORT_SYMBOL_GPL

Fixes: ed08d40cdec4 ("ahci: Changing two module params with static and __read_mostly")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/ata/libahci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index e4c45d3cca79..bff369d9a1a7 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -175,7 +175,6 @@ struct ata_port_operations ahci_pmp_retry_srst_ops = {
 EXPORT_SYMBOL_GPL(ahci_pmp_retry_srst_ops);
 
 static bool ahci_em_messages __read_mostly = true;
-EXPORT_SYMBOL_GPL(ahci_em_messages);
 module_param(ahci_em_messages, bool, 0444);
 /* add other LED protocol types when they become supported */
 MODULE_PARM_DESC(ahci_em_messages,
-- 
2.20.0

