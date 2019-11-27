Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0366C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 12:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 917BA2068E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 12:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfK0MkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 07:40:07 -0500
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:50420 "EHLO
        faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726546AbfK0MkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 07:40:04 -0500
Received: from faui04s.informatik.uni-erlangen.de (faui04s.informatik.uni-erlangen.de [IPv6:2001:638:a000:4130:131:188:30:149])
        by faui03.informatik.uni-erlangen.de (Postfix) with ESMTP id 89A2C24163F;
        Wed, 27 Nov 2019 13:31:02 +0100 (CET)
Received: by faui04s.informatik.uni-erlangen.de (Postfix, from userid 66121)
        id 7016815E0581; Wed, 27 Nov 2019 13:31:02 +0100 (CET)
From:   Dorothea Ehrl <dorothea.ehrl@fau.de>
To:     manishc@marvell.com, GR-Linux-NIC-Dev@marvell.com,
        gregkh@linuxfoundation.org, netdev@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     linux-kernel@i4.cs.fau.de, Dorothea Ehrl <dorothea.ehrl@fau.de>,
        Vanessa Hack <vanessa.hack@fau.de>
Subject: [PATCH 2/5] staging/qlge: add blank lines after declarations
Date:   Wed, 27 Nov 2019 13:30:49 +0100
Message-Id: <20191127123052.16424-2-dorothea.ehrl@fau.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191127123052.16424-1-dorothea.ehrl@fau.de>
References: <20191127123052.16424-1-dorothea.ehrl@fau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes "WARNING: Missing a blank line after declarations" by
checkpatch.pl.

Signed-off-by: Dorothea Ehrl <dorothea.ehrl@fau.de>
Co-developed-by: Vanessa Hack <vanessa.hack@fau.de>
Signed-off-by: Vanessa Hack <vanessa.hack@fau.de>
---
 drivers/staging/qlge/qlge_ethtool.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/staging/qlge/qlge_ethtool.c b/drivers/staging/qlge/qlge_ethtool.c
index 0c3f8eb34094..c03153b95844 100644
--- a/drivers/staging/qlge/qlge_ethtool.c
+++ b/drivers/staging/qlge/qlge_ethtool.c
@@ -332,6 +332,7 @@ static void ql_update_stats(struct ql_adapter *qdev)
 static void ql_get_strings(struct net_device *dev, u32 stringset, u8 *buf)
 {
 	int index;
+
 	switch (stringset) {
 	case ETH_SS_TEST:
 		memcpy(buf, *ql_gstrings_test, QLGE_TEST_LEN * ETH_GSTRING_LEN);
@@ -412,6 +413,7 @@ static void ql_get_drvinfo(struct net_device *ndev,
 			   struct ethtool_drvinfo *drvinfo)
 {
 	struct ql_adapter *qdev = netdev_priv(ndev);
+
 	strlcpy(drvinfo->driver, qlge_driver_name, sizeof(drvinfo->driver));
 	strlcpy(drvinfo->version, qlge_driver_version,
 		sizeof(drvinfo->version));
@@ -703,12 +705,14 @@ static int ql_set_pauseparam(struct net_device *netdev,
 static u32 ql_get_msglevel(struct net_device *ndev)
 {
 	struct ql_adapter *qdev = netdev_priv(ndev);
+
 	return qdev->msg_enable;
 }

 static void ql_set_msglevel(struct net_device *ndev, u32 value)
 {
 	struct ql_adapter *qdev = netdev_priv(ndev);
+
 	qdev->msg_enable = value;
 }

--
2.20.1

