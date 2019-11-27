Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D29C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 12:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1C592068E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 12:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfK0MkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 07:40:05 -0500
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:50424 "EHLO
        faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726540AbfK0MkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 07:40:04 -0500
Received: from faui04s.informatik.uni-erlangen.de (faui04s.informatik.uni-erlangen.de [131.188.30.149])
        by faui03.informatik.uni-erlangen.de (Postfix) with ESMTP id B65EE241837;
        Wed, 27 Nov 2019 13:31:02 +0100 (CET)
Received: by faui04s.informatik.uni-erlangen.de (Postfix, from userid 66121)
        id 9582315E0CF3; Wed, 27 Nov 2019 13:31:02 +0100 (CET)
From:   Dorothea Ehrl <dorothea.ehrl@fau.de>
To:     manishc@marvell.com, GR-Linux-NIC-Dev@marvell.com,
        gregkh@linuxfoundation.org, netdev@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     linux-kernel@i4.cs.fau.de, Dorothea Ehrl <dorothea.ehrl@fau.de>,
        Vanessa Hack <vanessa.hack@fau.de>
Subject: [PATCH 4/5] staging/qlge: remove braces in conditional statement
Date:   Wed, 27 Nov 2019 13:30:51 +0100
Message-Id: <20191127123052.16424-4-dorothea.ehrl@fau.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191127123052.16424-1-dorothea.ehrl@fau.de>
References: <20191127123052.16424-1-dorothea.ehrl@fau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes "WARNING: braces {} are not necessary for single
statement blocks" and "WARNING: braces {} are not necessary for any arm
of this statement" by checkpatch.pl.

Signed-off-by: Dorothea Ehrl <dorothea.ehrl@fau.de>
Co-developed-by: Vanessa Hack <vanessa.hack@fau.de>
Signed-off-by: Vanessa Hack <vanessa.hack@fau.de>
---
 drivers/staging/qlge/qlge_main.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/qlge/qlge_main.c b/drivers/staging/qlge/qlge_main.c
index f5ab6cc7050a..d19709bcdc20 100644
--- a/drivers/staging/qlge/qlge_main.c
+++ b/drivers/staging/qlge/qlge_main.c
@@ -4101,11 +4101,11 @@ static int qlge_change_mtu(struct net_device *ndev, int new_mtu)
 	struct ql_adapter *qdev = netdev_priv(ndev);
 	int status;

-	if (ndev->mtu == 1500 && new_mtu == 9000) {
+	if (ndev->mtu == 1500 && new_mtu == 9000)
 		netif_err(qdev, ifup, qdev->ndev, "Changing to jumbo MTU.\n");
-	} else if (ndev->mtu == 9000 && new_mtu == 1500) {
+	else if (ndev->mtu == 9000 && new_mtu == 1500)
 		netif_err(qdev, ifup, qdev->ndev, "Changing to normal MTU.\n");
-	} else
+	else
 		return -EINVAL;

 	queue_delayed_work(qdev->workqueue,
@@ -4113,9 +4113,8 @@ static int qlge_change_mtu(struct net_device *ndev, int new_mtu)

 	ndev->mtu = new_mtu;

-	if (!netif_running(qdev->ndev)) {
+	if (!netif_running(qdev->ndev))
 		return 0;
-	}

 	status = ql_change_rx_buffers(qdev);
 	if (status) {
--
2.20.1

