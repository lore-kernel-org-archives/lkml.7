Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CF8C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F111420679
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="Munmuilw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbfJKOGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 10:06:17 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:37624 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728483AbfJKOGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 10:06:15 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9BDuP5F008342;
        Fri, 11 Oct 2019 16:05:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=X2MS2dG8XiA3LBnlrQGs02rZISjkvk2yFLJA4idPnL4=;
 b=Munmuilwc1UmIcseIEJAD8efaUj9y6slZeTesd7CZgqCl+PiswJ2JcsHR/1DgKPJM0mW
 IBqBOzedqFx2MkLPt+eIzYtDy8FWjcG3u27nDmdbFNbQ9Lmmb1Uqa8M2abtS0LZcpovV
 UhXsdcLvSx37jpaNp8d64S+9JVh9ODsRKOOl1dubfGJemORltTc+GwqrKkr+0FlRgrJS
 6jG5zMFegf2z4vnnKkZGEdRgxesoFNhp2eYH6n80O98wEoyJ9WVW5BXRe8U86lSh+dak
 CUiq8xt+J1xYlaJir//H28W5VGMhAnXp3v6zoKr+zjWBCrEz9b1+PdDMz/KBE4HiLpo9 pA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2vegn1a8r1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Oct 2019 16:05:41 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3FA0C10002A;
        Fri, 11 Oct 2019 16:05:41 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 329A82AD739;
        Fri, 11 Oct 2019 16:05:41 +0200 (CEST)
Received: from localhost (10.75.127.51) by SFHDAG6NODE2.st.com (10.75.127.17)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 11 Oct 2019 16:05:40
 +0200
From:   Pascal Paillet <p.paillet@st.com>
To:     <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <p.paillet@st.com>
Subject: [PATCH 4/4] ARM: dts: stm32: disable active-discharge for vbus_otg on stm32mp157a-avenger96
Date:   Fri, 11 Oct 2019 16:05:33 +0200
Message-ID: <20191011140533.32619-5-p.paillet@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011140533.32619-1-p.paillet@st.com>
References: <20191011140533.32619-1-p.paillet@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG4NODE3.st.com (10.75.127.12) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-11_08:2019-10-10,2019-10-11 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Active discharge is not needed on vbus_otg and generate unneeded current
consumption.

Signed-off-by: Pascal Paillet <p.paillet@st.com>
---
 arch/arm/boot/dts/stm32mp157a-avenger96.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/stm32mp157a-avenger96.dts b/arch/arm/boot/dts/stm32mp157a-avenger96.dts
index d1cc42a92d3f..628c74a45a25 100644
--- a/arch/arm/boot/dts/stm32mp157a-avenger96.dts
+++ b/arch/arm/boot/dts/stm32mp157a-avenger96.dts
@@ -252,7 +252,6 @@
 				regulator-name = "vbus_otg";
 				interrupts = <IT_OCP_OTG 0>;
 				interrupt-parent = <&pmic>;
-				regulator-active-discharge = <1>;
 			};
 
 			vbus_sw: pwr_sw2 {
-- 
2.17.1

