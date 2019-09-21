Return-Path: <SRS0=64FT=XQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABADC49ED7
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 06:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6819E206C2
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 06:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eW+EhBn+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730959AbfIUGBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Sep 2019 02:01:16 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36662 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbfIUGBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 02:01:16 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8L5x1mW117678;
        Sat, 21 Sep 2019 06:01:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=ZyiwSeEGzds6Tayem+cozqIaU30foXBbsBlsKJ9fHw0=;
 b=eW+EhBn+BEhUPgrgyvzI7wE9dZfU3w1caOYfiTy0GkXQ+ucIjuoaql3/19/i6WbK0XCE
 NeJX8fNd9+YijuIOE8n8kWY/Mzd4iyJbDtA7YvTUH2gU7rSKEn6Yzx0yrbq3lr794PpY
 tJkNps340b3Zuv6xrvJiuE+rL88Bd2HrdgE94OCQPfpVLHoqrSjg07fU4r9Oc698JgCa
 +S4KRicMM+3vGM3kpyiO6ARbM/b9RpgEuESqIH4BJN5Sho5fVqruZwbQRMsuQLG9q3Iw
 G+htzVeW//feDvYIovIJiCixcBK66lHHMUSIIQwv0I4venpdYBCcCbBJ7cuUnZvCbfJs hA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2v5cgqg4v7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 21 Sep 2019 06:01:07 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8L5wk14100503;
        Sat, 21 Sep 2019 06:01:07 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2v590eapem-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 21 Sep 2019 06:01:07 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8L615GK016658;
        Sat, 21 Sep 2019 06:01:05 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 20 Sep 2019 23:01:04 -0700
Date:   Sat, 21 Sep 2019 09:00:59 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Marek Behun <marek.behun@nic.cz>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] firmware: turris-mox-rwtm: small white space cleanup
Message-ID: <20190921060059.GC18726@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9386 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909210065
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9386 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909210066
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch deletes a stray tab.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
I don't use Fixes tags for whitespace but the commit that added this
driver was commit 389711b37493 ("firmware: Add Turris Mox rWTM firmware
driver").  When we're adding a driver, it really helps if we use the
prefix that the driver will have.  So instead of "firmware:" it would be
"firmware: turris-mox-rwtm:" or whatever...

Presumably everyone will copy whatever I choose so this only really
affects me.

 drivers/firmware/turris-mox-rwtm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/turris-mox-rwtm.c b/drivers/firmware/turris-mox-rwtm.c
index 72be58960e54..e27f68437b56 100644
--- a/drivers/firmware/turris-mox-rwtm.c
+++ b/drivers/firmware/turris-mox-rwtm.c
@@ -197,7 +197,7 @@ static int mox_get_board_info(struct mox_rwtm *rwtm)
 		rwtm->serial_number = reply->status[1];
 		rwtm->serial_number <<= 32;
 		rwtm->serial_number |= reply->status[0];
-			rwtm->board_version = reply->status[2];
+		rwtm->board_version = reply->status[2];
 		rwtm->ram_size = reply->status[3];
 		reply_to_mac_addr(rwtm->mac_address1, reply->status[4],
 				  reply->status[5]);
-- 
2.20.1

