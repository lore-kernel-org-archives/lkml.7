Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A051AC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 13:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53AF22184B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 13:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VR+AQi4e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731109AbfDEN2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 09:28:30 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:46834 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbfDEN2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 09:28:18 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x35DSE8D122883;
        Fri, 5 Apr 2019 08:28:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554470894;
        bh=uZrwMdWEXIZpgAdUWh2ybbMYRG/nzzJUihtSUAku2hM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=VR+AQi4eziUo2OIplP205j/o4M6Npj8z8E+3853pmJEBhmFPtbsw0BuD05FFK0ZhG
         /1C6Zstfwl12vu381sbKentvoSfHlDdIuDPCJLmR76jZsdZMdZQ9wUtZGymkzXls4U
         KfKd5TgjhTCV5d59QB7Z5pqvH9eI6llmNjyhg3JE=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x35DSEeT119494
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 Apr 2019 08:28:14 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 5 Apr
 2019 08:28:13 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 5 Apr 2019 08:28:13 -0500
Received: from lta0400828d.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x35DS8dE057878;
        Fri, 5 Apr 2019 08:28:11 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <tony@atomide.com>
CC:     <robh+dt@kernel.org>, <s-anna@ti.com>, <nm@ti.com>,
        <lokeshvutla@ti.com>, <linux-omap@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Roger Quadros <rogerq@ti.com>
Subject: [PATCH 1/2] dt-binding: arm: omap: Add information for AM5748
Date:   Fri, 5 Apr 2019 16:28:05 +0300
Message-ID: <20190405132806.20772-2-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190405132806.20772-1-rogerq@ti.com>
References: <20190405132806.20772-1-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT binding details for AM5748 SoC and AM5748 IDK.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 Documentation/devicetree/bindings/arm/omap/omap.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
index 2ecc712bf707..1c1e48fd94b5 100644
--- a/Documentation/devicetree/bindings/arm/omap/omap.txt
+++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
@@ -92,6 +92,9 @@ SoCs:
 - DRA718
   compatible = "ti,dra718", "ti,dra722", "ti,dra72", "ti,dra7"
 
+- AM5748
+  compatible = "ti,am5748", "ti,dra762", "ti,dra7"
+
 - AM5728
   compatible = "ti,am5728", "ti,dra742", "ti,dra74", "ti,dra7"
 
@@ -184,6 +187,9 @@ Boards:
 - AM57XX SBC-AM57x
   compatible = "compulab,sbc-am57x", "compulab,cl-som-am57x", "ti,am5728", "ti,dra742", "ti,dra74", "ti,dra7"
 
+- AM5748 IDK
+  compatible = "ti,am5748-idk", "ti,am5748", "ti,dra762", "ti,dra7";
+
 - AM5728 IDK
   compatible = "ti,am5728-idk", "ti,am5728", "ti,dra742", "ti,dra74", "ti,dra7"
 
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

