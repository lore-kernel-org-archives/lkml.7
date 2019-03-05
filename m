Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BDEC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 08:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 714572082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 08:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbfCEIaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 03:30:25 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:22901 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726026AbfCEI35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 03:29:57 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x258BUOC008394;
        Tue, 5 Mar 2019 09:29:42 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2qyhgar6md-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 05 Mar 2019 09:29:42 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 10DD531;
        Tue,  5 Mar 2019 08:29:41 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E1D211674;
        Tue,  5 Mar 2019 08:29:40 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 5 Mar 2019
 09:29:40 +0100
Received: from localhost (10.201.23.166) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 5 Mar 2019 09:29:40
 +0100
From:   Christophe Roullier <christophe.roullier@st.com>
To:     <robh@kernel.org>, <davem@davemloft.net>, <joabreu@synopsys.com>,
        <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <peppe.cavallaro@st.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <christophe.roullier@st.com>, <andrew@lunn.ch>
Subject: [PATCH V3 5/6] dt-bindings: net: stmmac: remove syscfg clock property
Date:   Tue, 5 Mar 2019 09:29:27 +0100
Message-ID: <1551774568-11732-6-git-send-email-christophe.roullier@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551774568-11732-1-git-send-email-christophe.roullier@st.com>
References: <1551774568-11732-1-git-send-email-christophe.roullier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.166]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-05_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syscfg clock is no more needed.

Signed-off-by: Christophe Roullier <christophe.roullier@st.com>
---
 Documentation/devicetree/bindings/net/stm32-dwmac.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/stm32-dwmac.txt b/Documentation/devicetree/bindings/net/stm32-dwmac.txt
index 3524e80..a90eef1 100644
--- a/Documentation/devicetree/bindings/net/stm32-dwmac.txt
+++ b/Documentation/devicetree/bindings/net/stm32-dwmac.txt
@@ -14,8 +14,7 @@ Required properties:
 - clock-names: Should be "stmmaceth" for the host clock.
 	       Should be "mac-clk-tx" for the MAC TX clock.
 	       Should be "mac-clk-rx" for the MAC RX clock.
-	       For MPU family need to add also "ethstp" for power mode clock and,
-	                                       "syscfg-clk" for SYSCFG clock.
+	       For MPU family need to add also "ethstp" for power mode clock
 - interrupt-names: Should contain a list of interrupt names corresponding to
            the interrupts in the interrupts property, if available.
 		   Should be "macirq" for the main MAC IRQ
-- 
2.7.4

