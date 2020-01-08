Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B7D6C00523
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 08:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C69C206F0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 08:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lOu8FJNm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgAHIaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 03:30:19 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:54718 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbgAHIaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 03:30:18 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0088UEZZ063778;
        Wed, 8 Jan 2020 02:30:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578472214;
        bh=vxhkMBsN2pPnCv5+ROibr/eTdfzg7Vv+kXmb+sy+smY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=lOu8FJNmMe1Omv8nea5tIA2Eh0S2KMeJjMDBKJcUFAolwEA+zNwAotsIY7QUD1ppc
         fsghIbAh60FKX68cQnMk/Z+mjdw1OFwY23DKc6T4OdwlkUpcxlOc9rWB/4BvqhFYUO
         Q7xwaNAIEgjYyp5ylGyDfgaN7rT0jJLH7Z0YiD0Q=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0088UEqK035046;
        Wed, 8 Jan 2020 02:30:14 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 8 Jan
 2020 02:30:13 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 8 Jan 2020 02:30:13 -0600
Received: from jadmar.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0088U8vZ048698;
        Wed, 8 Jan 2020 02:30:11 -0600
From:   Jyri Sarha <jsarha@ti.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <tomi.valkeinen@ti.com>, <praneeth@ti.com>, <yamonkar@cadence.com>,
        <sjakhade@cadence.com>, <robh+dt@kernel.org>, <kishon@ti.com>,
        <jsarha@ti.com>, <rogerq@ti.com>
Subject: [PATCH v2 1/2] dt-bindings: phy: Add PHY_TYPE_DP definition
Date:   Wed, 8 Jan 2020 10:30:07 +0200
Message-ID: <e38387d6bfc38c76e2335b549da409291366e9ac.1578471433.git.jsarha@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1578471433.git.jsarha@ti.com>
References: <cover.1578471433.git.jsarha@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add definition for DisplayPort phy type.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
Reviewed-by: Roger Quadros <rogerq@ti.com>
Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 include/dt-bindings/phy/phy.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/phy/phy.h b/include/dt-bindings/phy/phy.h
index b6a1eaf1b339..1f3f866fae7b 100644
--- a/include/dt-bindings/phy/phy.h
+++ b/include/dt-bindings/phy/phy.h
@@ -16,5 +16,6 @@
 #define PHY_TYPE_USB2		3
 #define PHY_TYPE_USB3		4
 #define PHY_TYPE_UFS		5
+#define PHY_TYPE_DP		6
 
 #endif /* _DT_BINDINGS_PHY */
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

