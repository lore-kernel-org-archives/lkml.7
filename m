Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E801C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06DDC2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfDCN0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 09:26:41 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:7296 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726269AbfDCN0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 09:26:37 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x33DLcme019196;
        Wed, 3 Apr 2019 15:23:43 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2rmgev46jg-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 03 Apr 2019 15:23:43 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 901E834;
        Wed,  3 Apr 2019 13:23:42 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 63FE629C0;
        Wed,  3 Apr 2019 13:23:42 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 3 Apr 2019
 15:23:42 +0200
Received: from localhost (10.201.23.16) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.435.0; Wed, 3 Apr 2019 15:23:41
 +0200
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <alsa-devel@alsa-project.org>,
        <robh@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <olivier.moysan@st.com>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@st.com>,
        <apatard@mandriva.com>
Subject: [PATCH 1/7] ASoC: dt-bindings: update cs42l51 bindings
Date:   Wed, 3 Apr 2019 15:23:31 +0200
Message-ID: <1554297817-14154-2-git-send-email-olivier.moysan@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554297817-14154-1-git-send-email-olivier.moysan@st.com>
References: <1554297817-14154-1-git-send-email-olivier.moysan@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.16]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-03_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible, reg, regulator, and reset
to Cirrus CS42L51 audio codec bindings.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 Documentation/devicetree/bindings/sound/cs42l51.txt | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/cs42l51.txt b/Documentation/devicetree/bindings/sound/cs42l51.txt
index 4b5de33ce377..acbd68ddd2cb 100644
--- a/Documentation/devicetree/bindings/sound/cs42l51.txt
+++ b/Documentation/devicetree/bindings/sound/cs42l51.txt
@@ -1,6 +1,17 @@
 CS42L51 audio CODEC
 
+Required properties:
+
+  - compatible : "cirrus,cs42l51"
+
+  - reg : the I2C address of the device for I2C.
+
 Optional properties:
+  - VL-supply, VD-supply, VA-supply, VAHP-supply: power supplies for the device,
+    as covered in Documentation/devicetree/bindings/regulator/regulator.txt.
+
+  - reset-gpios : GPIO specification for the reset pin. If specified, it will be
+    deasserted before starting the communication with the codec.
 
   - clocks : a list of phandles + clock-specifiers, one for each entry in
     clock-names
@@ -14,4 +25,9 @@ cs42l51: cs42l51@4a {
 	reg = <0x4a>;
 	clocks = <&mclk_prov>;
 	clock-names = "MCLK";
+	VL-supply = <&reg_audio>;
+	VD-supply = <&reg_audio>;
+	VA-supply = <&reg_audio>;
+	VAHP-supply = <&reg_audio>;
+	reset-gpios = <&gpiog 9 GPIO_ACTIVE_LOW>;
 };
-- 
2.7.4

