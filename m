Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DACC10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 130CF2083E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="tp/JGGxX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731353AbfDJLb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 07:31:59 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:46686 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727206AbfDJLb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 07:31:59 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3ABMB3P011442;
        Wed, 10 Apr 2019 13:31:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=iXJ27yRW7mkwOiFyqhG7XtrIqvyiAEPYXp3jsHoxd3g=;
 b=tp/JGGxXDsXHHb6PaF6c9QhPvHe0Qzo4uOiHHFSjz1sLTme7BQYlHVDaTiCEhvam6Vhp
 yono0/C/++w/rYNA3lK15MQGxdsoz7pLjvmYeHeXP73cTX4w6TMa373Rn1+GC0PtSosy
 ce4g1CNjEOkJaU0rjehA/gox4udyKQuwH3PYTxdL1z0JnUfAC3JPVr4MrTBEOrQzCoiV
 lm219xOijGrqmiDs2/cQl9Y8d9lyf71+1z237gadj5r7zNPE9ZEt7Oy5MxYzYOdQIY+F
 E6nMDK6srykbwZ7WAChLlBKJ7Rqeji6qQ3McrDoc6DpTooeMBPTI7vz3THuSd1n+vwaI lg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2rpr7wqsfw-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 10 Apr 2019 13:31:44 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 248EE3A;
        Wed, 10 Apr 2019 11:31:43 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0104115BB;
        Wed, 10 Apr 2019 11:31:42 +0000 (GMT)
Received: from localhost (10.75.127.48) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 10 Apr 2019 13:31:42
 +0200
From:   Alexandre Torgue <alexandre.torgue@st.com>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, <arnd@arndb.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: [PATCH 1/5] dt-bindings: pinctrl: stm32: add new entry for package information
Date:   Wed, 10 Apr 2019 13:30:20 +0200
Message-ID: <1554895824-25709-2-git-send-email-alexandre.torgue@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554895824-25709-1-git-send-email-alexandre.torgue@st.com>
References: <1554895824-25709-1-git-send-email-alexandre.torgue@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-10_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "st,package" entry. Possibles values are:
-STM32MP_PKG_AA for LFBGA448 (18*18) package
-STM32MP_PKG_AB for LFBGA354 (16*16) package
-STM32MP_PKG_AC for TFBGA361 (12*12) package
-STM32MP_PKG_AD for TFBGA257 (10*10) package

Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>

diff --git a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
index 48df30a..0016925 100644
--- a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
@@ -57,6 +57,8 @@ Optional properties:
  - st,bank-ioport: should correspond to the EXTI IOport selection (EXTI line
    used to select GPIOs as interrupts).
  - hwlocks: reference to a phandle of a hardware spinlock provider node.
+ - st,package: Indicates the SOC package used.
+   More details in include/dt-bindings/pinctrl/stm32-pinfunc.h
 
 Example 1:
 #include <dt-bindings/pinctrl/stm32f429-pinfunc.h>
diff --git a/include/dt-bindings/pinctrl/stm32-pinfunc.h b/include/dt-bindings/pinctrl/stm32-pinfunc.h
index b5a2174..e6fb8ad 100644
--- a/include/dt-bindings/pinctrl/stm32-pinfunc.h
+++ b/include/dt-bindings/pinctrl/stm32-pinfunc.h
@@ -32,5 +32,11 @@
 
 #define STM32_PINMUX(port, line, mode) (((PIN_NO(port, line)) << 8) | (mode))
 
+/*  package information */
+#define STM32MP_PKG_AA	0x1
+#define STM32MP_PKG_AB	0x2
+#define STM32MP_PKG_AC	0x4
+#define STM32MP_PKG_AD	0x8
+
 #endif /* _DT_BINDINGS_STM32_PINFUNC_H */
 
-- 
2.7.4

