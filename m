Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E2CC33C9B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 12:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E8532068E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 12:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfK0MkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 07:40:07 -0500
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:50428 "EHLO
        faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726558AbfK0MkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 07:40:04 -0500
Received: from faui04s.informatik.uni-erlangen.de (faui04s.informatik.uni-erlangen.de [131.188.30.149])
        by faui03.informatik.uni-erlangen.de (Postfix) with ESMTP id 74A252416A6;
        Wed, 27 Nov 2019 13:31:02 +0100 (CET)
Received: by faui04s.informatik.uni-erlangen.de (Postfix, from userid 66121)
        id 5873F15E0A86; Wed, 27 Nov 2019 13:31:02 +0100 (CET)
From:   Dorothea Ehrl <dorothea.ehrl@fau.de>
To:     manishc@marvell.com, GR-Linux-NIC-Dev@marvell.com,
        gregkh@linuxfoundation.org, netdev@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     linux-kernel@i4.cs.fau.de, Dorothea Ehrl <dorothea.ehrl@fau.de>,
        Vanessa Hack <vanessa.hack@fau.de>
Subject: [PATCH 1/5] staging/qlge: remove initialising of static local variable
Date:   Wed, 27 Nov 2019 13:30:48 +0100
Message-Id: <20191127123052.16424-1-dorothea.ehrl@fau.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes "ERROR: do not initialise statics to 0" by checkpatch.pl.

Signed-off-by: Dorothea Ehrl <dorothea.ehrl@fau.de>
Co-developed-by: Vanessa Hack <vanessa.hack@fau.de>
Signed-off-by: Vanessa Hack <vanessa.hack@fau.de>
---
 drivers/staging/qlge/qlge_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/qlge/qlge_main.c b/drivers/staging/qlge/qlge_main.c
index 6ad4515311f7..587102aa7fbf 100644
--- a/drivers/staging/qlge/qlge_main.c
+++ b/drivers/staging/qlge/qlge_main.c
@@ -4578,7 +4578,7 @@ static int qlge_probe(struct pci_dev *pdev,
 {
 	struct net_device *ndev = NULL;
 	struct ql_adapter *qdev = NULL;
-	static int cards_found = 0;
+	static int cards_found;
 	int err = 0;

 	ndev = alloc_etherdev_mq(sizeof(struct ql_adapter),
--
2.20.1

