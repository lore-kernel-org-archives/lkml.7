Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35CAEC0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 23:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1353221738
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 23:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbfGDX6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 19:58:12 -0400
Received: from smtprelay0147.hostedemail.com ([216.40.44.147]:45332 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727829AbfGDX6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 19:58:02 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id D8E168368EFC;
        Thu,  4 Jul 2019 23:58:01 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: ring36_631e347fc9527
X-Filterd-Recvd-Size: 1477
Received: from joe-laptop.perches.com (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Thu,  4 Jul 2019 23:58:01 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: [PATCH 6/8] net: nixge: Fix misuse of strlcpy
Date:   Thu,  4 Jul 2019 16:57:46 -0700
Message-Id: <ab064ed18bee3e59431afb742dfe7a570d7d0b58.1562283944.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <cover.1562283944.git.joe@perches.com>
References: <cover.1562283944.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Probable cut&paste typo - use the correct field size.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/net/ethernet/ni/nixge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ni/nixge.c b/drivers/net/ethernet/ni/nixge.c
index 96f7a9818294..0b384f97d2fd 100644
--- a/drivers/net/ethernet/ni/nixge.c
+++ b/drivers/net/ethernet/ni/nixge.c
@@ -990,7 +990,7 @@ static void nixge_ethtools_get_drvinfo(struct net_device *ndev,
 				       struct ethtool_drvinfo *ed)
 {
 	strlcpy(ed->driver, "nixge", sizeof(ed->driver));
-	strlcpy(ed->bus_info, "platform", sizeof(ed->driver));
+	strlcpy(ed->bus_info, "platform", sizeof(ed->bus_info));
 }
 
 static int nixge_ethtools_get_coalesce(struct net_device *ndev,
-- 
2.15.0

