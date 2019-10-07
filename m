Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EABEECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 554CB20700
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="cvqSztD3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbfJGPnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 11:43:31 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:57796 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727745AbfJGPna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 11:43:30 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x97FR3kF010334;
        Mon, 7 Oct 2019 17:43:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=STMicroelectronics;
 bh=dFvDcqWSN9ZbPn6Iz1Ez8EPfIWgepjOMcf7c/b7HLcQ=;
 b=cvqSztD3kA0SpQpl/2pcf8xyIeDN1yes1fd+4zndlONjSllxAQyPh1FLpWumvFnnvVt3
 JjHcV/BrzI4XAA4XIU1m1dwfhPXr+z1c9oppKVIHTyVPlAS6mbrUilxSvvkPS207vySE
 tPiFOUQKzX72eBWZL8kYy6i3u3XTcQrxN+Mvg2qnFHk1JSkU2ZL1EKbHbV+CJErTwj13
 Q63ZxB/thrL69oP13UrOSowaOaoz4r6ezoYv6YccpIoKATwJiAB3ebjAz8pISFw//WMs
 tuF3a9L+RoSiTY/arhMFbnI2ejgiGQdpx5GVq1h1vVSWcIaUAiKwacgMpaH8U9UZEvLK vg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2vej2p35kb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Oct 2019 17:43:18 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 37765100039;
        Mon,  7 Oct 2019 17:43:17 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E1E0E2B1E43;
        Mon,  7 Oct 2019 17:43:17 +0200 (CEST)
Received: from localhost (10.75.127.50) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 7 Oct 2019 17:43:17
 +0200
From:   Antonio Borneo <antonio.borneo@st.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     Antonio Borneo <antonio.borneo@st.com>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Himadri Pandya <himadri18.07@gmail.com>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        Shobhit Kukreti <shobhitkukreti@gmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] staging: rtl8723bs: fix typo of "mechanism" in comment
Date:   Mon, 7 Oct 2019 17:43:03 +0200
Message-ID: <20191007154306.95827-2-antonio.borneo@st.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191007154306.95827-1-antonio.borneo@st.com>
References: <20191007154306.95827-1-antonio.borneo@st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG8NODE1.st.com (10.75.127.22) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-07_03:2019-10-07,2019-10-07 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo s/mechansim/mechanism/

Signed-off-by: Antonio Borneo <antonio.borneo@st.com>
---
 drivers/staging/rtl8723bs/hal/hal_btcoex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_btcoex.c b/drivers/staging/rtl8723bs/hal/hal_btcoex.c
index 6e4a1fcb8790..d5793e4614bf 100644
--- a/drivers/staging/rtl8723bs/hal/hal_btcoex.c
+++ b/drivers/staging/rtl8723bs/hal/hal_btcoex.c
@@ -1315,7 +1315,7 @@ void EXhalbtcoutsrc_DisplayBtCoexInfo(PBTC_COEXIST pBtCoexist)
 
 /*
  * Description:
- *Run BT-Coexist mechansim or not
+ *Run BT-Coexist mechanism or not
  *
  */
 void hal_btcoex_SetBTCoexist(struct adapter *padapter, u8 bBtExist)
-- 
2.23.0

