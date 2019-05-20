Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4534CC04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 09:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25E4820644
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 09:06:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731804AbfETJGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 05:06:42 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:45408 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725772AbfETJGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 05:06:41 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4K93qE0011871;
        Mon, 20 May 2019 04:06:29 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail1.cirrus.com (mail1.cirrus.com [141.131.3.20])
        by mx0b-001ae601.pphosted.com with ESMTP id 2sjefmt40w-1;
        Mon, 20 May 2019 04:06:29 -0500
Received: from EDIEX02.ad.cirrus.com (unknown [198.61.84.81])
        by mail1.cirrus.com (Postfix) with ESMTP id 3BBCF611C8B4;
        Mon, 20 May 2019 04:06:29 -0500 (CDT)
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Mon, 20 May
 2019 10:06:28 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Mon, 20 May 2019 10:06:28 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id A0B862DA;
        Mon, 20 May 2019 10:06:28 +0100 (BST)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <lee.jones@linaro.org>
CC:     <arnd@arndb.de>, <natechancellor@gmail.com>,
        <ottosabart@seberm.com>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH 2/4 RESEND] mfd: madera: Fix bad reference to pinctrl.txt file
Date:   Mon, 20 May 2019 10:06:26 +0100
Message-ID: <20190520090628.29061-2-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190520090628.29061-1-ckeepax@opensource.cirrus.com>
References: <20190520090628.29061-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=593 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905200066
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Otto Sabart <ottosabart@seberm.com>

The pinctrl.txt file was converted into reStructuredText and moved into
driver-api folder. This patch updates the broken reference.

Fixes: 5a9b73832e9e ("pinctrl.txt: move it to the driver-api book")
Signed-off-by: Otto Sabart <ottosabart@seberm.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 include/linux/mfd/madera/pdata.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/mfd/madera/pdata.h b/include/linux/mfd/madera/pdata.h
index 8dc852402dbb1..dd00ab824e5be 100644
--- a/include/linux/mfd/madera/pdata.h
+++ b/include/linux/mfd/madera/pdata.h
@@ -34,7 +34,8 @@ struct madera_codec_pdata;
  * @micvdd:	    Substruct of pdata for the MICVDD regulator
  * @irq_flags:	    Mode for primary IRQ (defaults to active low)
  * @gpio_base:	    Base GPIO number
- * @gpio_configs:   Array of GPIO configurations (See Documentation/pinctrl.txt)
+ * @gpio_configs:   Array of GPIO configurations (See
+ *		    Documentation/driver-api/pinctl.rst)
  * @n_gpio_configs: Number of entries in gpio_configs
  * @gpsw:	    General purpose switch mode setting. Depends on the external
  *		    hardware connected to the switch. (See the SW1_MODE field
-- 
2.11.0

