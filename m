Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1809C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 11:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 980D8217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 11:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LIpbrj4+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfIZLTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 07:19:23 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:48894 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbfIZLTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 07:19:22 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x8QBJHP2022830;
        Thu, 26 Sep 2019 06:19:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1569496757;
        bh=Os/g4h37INHFj009+Nb83YilihmshiNyFyAPP5WINzY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=LIpbrj4+UXDaUeHOqsFfQsn7slxWprVyMuUEs/N0QfHZtdpJKio9GL2SOp1U9BByR
         lmBXfSe9zmo4Mh7Wq2UF9pAjcUUXvSF9OgihgHczj2VsKWw8vv4xCXU7iSm0Cxa4Cd
         SDiyjwNG/yjX6jbatu5rW3bC/+iY+xHqf9JYmk0w=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x8QBJHfL078251
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 26 Sep 2019 06:19:17 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 26
 Sep 2019 06:19:17 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 26 Sep 2019 06:19:09 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8QBJAdt013885;
        Thu, 26 Sep 2019 06:19:15 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dan.j.williams@intel.com>, <devicetree@vger.kernel.org>
Subject: [PATCH v3 2/3] dt-bindings: dma: ti-edma: Document dma-channel-mask for EDMA
Date:   Thu, 26 Sep 2019 14:19:53 +0300
Message-ID: <20190926111954.9184-3-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190926111954.9184-1-peter.ujfalusi@ti.com>
References: <20190926111954.9184-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similarly to paRAM slots, channels can be used by other cores.

The common dma-channel-mask property can be used for specifying the
available channels.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 Documentation/devicetree/bindings/dma/ti-edma.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/ti-edma.txt b/Documentation/devicetree/bindings/dma/ti-edma.txt
index 4bbc94d829c8..014187088020 100644
--- a/Documentation/devicetree/bindings/dma/ti-edma.txt
+++ b/Documentation/devicetree/bindings/dma/ti-edma.txt
@@ -42,6 +42,11 @@ Optional properties:
 - ti,edma-reserved-slot-ranges: PaRAM slot ranges which should not be used by
 		the driver, they are allocated to be used by for example the
 		DSP. See example.
+- dma-channel-mask: Mask of usable channels.
+		Single uint32 for EDMA with 32 channels, array of two uint32 for
+		EDMA with 64 channels. See example and
+		Documentation/devicetree/bindings/dma/dma-common.yaml
+
 
 ------------------------------------------------------------------------------
 eDMA3 Transfer Controller
@@ -91,6 +96,9 @@ edma: edma@49000000 {
 	ti,edma-memcpy-channels = <20 21>;
 	/* The following PaRAM slots are reserved: 35-44 and 100-109 */
 	ti,edma-reserved-slot-ranges = <35 10>, <100 10>;
+	/* The following channels are reserved: 35-44 */
+	dma-channel-mask = <0xffffffff>, /* Channel 0-31 */
+			   <0xffffe007>; /* Channel 32-63 */
 };
 
 edma_tptc0: tptc@49800000 {
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

