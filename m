Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D447CC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2C48206DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WEONsH/y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbfCELsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 06:48:05 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:41930 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727636AbfCELsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 06:48:05 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x25BcWpC085698;
        Tue, 5 Mar 2019 11:48:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=Er9wq5/hynA8JimssSrRhF6Va+znFUSD+NbMMRsnAfY=;
 b=WEONsH/yb+yEDtGeSEolkhHc0K4tjpNSPo8f1Ky/L7tceBlcLefrZYJcyDc7UFtrOoHy
 gUld3zoj/nvtbdMXMG1IOUVR+SPtsXmMwS3C5oU3J6lt/IhxZ1p2+4WP0lrFqMU8ty1c
 syGhWFTXjjnh96vhtoQTR4OJ/bfu0+D6oYAmfGunjr7sRr8SOUBQTDx5rcOmrGhsGh1N
 HN3NNf8yZSwEWuGAWE8GYgBTFyCpMcWZ/li+Fbo7/dLVjltIPymiWn1+bgjIdtcXwF0l
 Vw3XqvskMqSoLvHblpwQ6nGf/18rPwvoyOwtRXOoXoITYkG7SJ8qxKsNsSGX7XRHqER4 3g== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2qyh8u4urc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Mar 2019 11:48:00 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x25BlspE008337
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Mar 2019 11:47:54 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x25BlsCR015316;
        Tue, 5 Mar 2019 11:47:54 GMT
Received: from kadam (/197.157.34.180)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 05 Mar 2019 03:47:53 -0800
Date:   Tue, 5 Mar 2019 14:47:46 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     RickyWu <ricky_wu@realtek.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] misc: rtsx: clean up some indenting
Message-ID: <20190305114746.GA17627@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9185 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903050081
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These lines weren't indented far enough.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/misc/cardreader/rts5260.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/cardreader/rts5260.c b/drivers/misc/cardreader/rts5260.c
index da22bcb62b04..4a2589bdc8ce 100644
--- a/drivers/misc/cardreader/rts5260.c
+++ b/drivers/misc/cardreader/rts5260.c
@@ -455,13 +455,13 @@ static void rts5260_pwr_saving_setting(struct rtsx_pcr *pcr)
 		pcr_dbg(pcr, "Set parameters for L1.2.");
 		rtsx_pci_write_register(pcr, PWR_GLOBAL_CTRL,
 					0xFF, PCIE_L1_2_EN);
-	rtsx_pci_write_register(pcr, RTS5260_DVCC_CTRL,
+		rtsx_pci_write_register(pcr, RTS5260_DVCC_CTRL,
 					RTS5260_DVCC_OCP_EN |
 					RTS5260_DVCC_OCP_CL_EN,
 					RTS5260_DVCC_OCP_EN |
 					RTS5260_DVCC_OCP_CL_EN);
 
-	rtsx_pci_write_register(pcr, PWR_FE_CTL,
+		rtsx_pci_write_register(pcr, PWR_FE_CTL,
 					0xFF, PCIE_L1_2_PD_FE_EN);
 	} else if (lss_l1_1) {
 		pcr_dbg(pcr, "Set parameters for L1.1.");
-- 
2.17.1

