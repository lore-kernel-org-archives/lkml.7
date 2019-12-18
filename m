Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D83C2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 08:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB433218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 08:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="xCM86XwV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfLRI5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 03:57:39 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:17524 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725799AbfLRI5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 03:57:39 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBI8sRD0008071;
        Wed, 18 Dec 2019 09:57:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=xY69+K3CDt8WIn1tRsSBo05iiqi+wQiVGkvAfv6jSUA=;
 b=xCM86XwVU/qOBfZeW2/Wv3PbksC+Ts74s/aZM6VvyknPr4fHVNQoRuG3nO1VFTEO2vG7
 sjZjDMLG5JbW0EKUImtlgs0uN6o7TSUUnkbbZd/b6kDODcqUAdu3N4gL9+zM8CgpSfwQ
 J0K0f3DBANleVqZcEAHKVVaK7uZ9zmRSS1sl/IgzzLf7GEJf6ENDhQI8jSOCZOEwsYJ2
 1y4LKjyZtCdzbv5OSqq0jknVaWV3/MQoknxXMj47HcGFuNsy2ILp3WDm6CX0VwRGrlWZ
 Mmgd3XwbNBM9j9F8mEukjU68/nxWYSqi1xzry19qyYooREdo2NT5RJ6774APcOi2/a1D Ng== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2wvpd1kam2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Dec 2019 09:57:25 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0CF3D10003B;
        Wed, 18 Dec 2019 09:57:19 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3B2E9220826;
        Wed, 18 Dec 2019 09:57:19 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG3NODE1.st.com (10.75.127.7)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 18 Dec 2019 09:57:18
 +0100
From:   Arnaud Pouliquen <arnaud.pouliquen@st.com>
To:     Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Fabien Dessenne <fabien.dessenne@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH] ARM: dts: stm32: update mlahb node according to the bindings
Date:   Wed, 18 Dec 2019 09:57:10 +0100
Message-ID: <20191218085710.2142-1-arnaud.pouliquen@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-18_02:2019-12-17,2019-12-18 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update of the mlahb node according to to DT bindings using json-schema

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 arch/arm/boot/dts/stm32mp157c.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index ed8b258256d7..be04eab7f139 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -1513,10 +1513,11 @@
 		};
 	};
 
-	mlahb {
-		compatible = "simple-bus";
+	mlahb: ahb {
+		compatible = "st,mlahb", "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
+		ranges;
 		dma-ranges = <0x00000000 0x38000000 0x10000>,
 			     <0x10000000 0x10000000 0x60000>,
 			     <0x30000000 0x30000000 0x60000>;
-- 
2.17.1

