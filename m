Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA423C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 02:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F2AA2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 02:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbfD3CGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 22:06:00 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:18028 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729238AbfD3CGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 22:06:00 -0400
Received-SPF: SoftFail (esa5.microchip.iphmx.com: domain of
  wesley.sheng@microchip.com is inclined to not designate
  208.19.99.222 as permitted sender) identity=mailfrom;
  client-ip=208.19.99.222; receiver=esa5.microchip.iphmx.com;
  envelope-from="wesley.sheng@microchip.com";
  x-sender="wesley.sheng@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@smtp.microsemi.com) identity=helo;
  client-ip=208.19.99.222; receiver=esa5.microchip.iphmx.com;
  envelope-from="wesley.sheng@microchip.com";
  x-sender="postmaster@smtp.microsemi.com";
  x-conformance=spf_only
Authentication-Results: esa5.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=wesley.sheng@microchip.com; spf=None smtp.helo=postmaster@smtp.microsemi.com; dmarc=fail (p=none dis=none) d=microchip.com
X-IronPort-AV: E=Sophos;i="5.60,412,1549954800"; 
   d="scan'208";a="29360171"
Received: from unknown (HELO smtp.microsemi.com) ([208.19.99.222])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Apr 2019 19:05:55 -0700
Received: from AUSMBX3.microsemi.net (10.201.34.33) by AUSMBX2.microsemi.net
 (10.201.34.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 29 Apr
 2019 21:05:53 -0500
Received: from server1.microsemi.net (10.188.119.166) by ausmbx3.microsemi.net
 (10.201.34.33) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 29 Apr 2019 21:05:51 -0500
From:   Wesley Sheng <wesley.sheng@microchip.com>
To:     <jdmason@kudzu.us>, <dave.jiang@intel.com>, <allenbh@gmail.com>,
        <linux-ntb@googlegroups.com>, <linux-kernel@vger.kernel.org>
CC:     <wesleyshenggit@sina.com>, <logang@deltatee.com>,
        Wesley Sheng <wesley.sheng@microchip.com>
Subject: [PATCH] NTB: correct ntb_dev_ops and ntb_dev comment typos
Date:   Tue, 30 Apr 2019 18:04:29 +0800
Message-ID: <1556618669-2434-1-git-send-email-wesley.sheng@microchip.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment for ntb_dev_ops and ntb_dev incorrectly referred to
ntb_ctx_ops and ntb_device.

Signed-off-by: Wesley Sheng <wesley.sheng@microchip.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 include/linux/ntb.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/ntb.h b/include/linux/ntb.h
index 56a92e3..604abc8 100644
--- a/include/linux/ntb.h
+++ b/include/linux/ntb.h
@@ -205,7 +205,7 @@ static inline int ntb_ctx_ops_is_valid(const struct ntb_ctx_ops *ops)
 }
 
 /**
- * struct ntb_ctx_ops - ntb device operations
+ * struct ntb_dev_ops - ntb device operations
  * @port_number:	See ntb_port_number().
  * @peer_port_count:	See ntb_peer_port_count().
  * @peer_port_number:	See ntb_peer_port_number().
@@ -404,7 +404,7 @@ struct ntb_client {
 #define drv_ntb_client(__drv) container_of((__drv), struct ntb_client, drv)
 
 /**
- * struct ntb_device - ntb device
+ * struct ntb_dev - ntb device
  * @dev:		Linux device object.
  * @pdev:		PCI device entry of the ntb.
  * @topo:		Detected topology of the ntb.
-- 
2.7.4

