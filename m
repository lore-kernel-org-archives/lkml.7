Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F683FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 18:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 299DD21D7D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 18:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jRww9Y28"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436535AbfJPSTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 14:19:49 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:58002 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732498AbfJPSTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 14:19:48 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9GIJlXk027872;
        Wed, 16 Oct 2019 13:19:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571249987;
        bh=T0Wqvw9FARKK+UyjfGusaRKLYAOtIzt53we2Zr6ccdc=;
        h=From:To:CC:Subject:Date;
        b=jRww9Y28vewKob/xtxXss/lyvbrfvaKdRoz6dJMkj0UXWmfamYo+Ja7tUnefLKAhZ
         rx0K+82FX+cg5D8cHERF+RAt6c13vnPV4pHcqqcK2aCk8Qber1gYNHxJQVDPMffSss
         WVOpUcmWc4ODt0V5yglsDOzloR5J4D9DgJ5rvvf8=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9GIJlo2015378;
        Wed, 16 Oct 2019 13:19:47 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 16
 Oct 2019 13:19:40 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 16 Oct 2019 13:19:40 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9GIJkuB074565;
        Wed, 16 Oct 2019 13:19:46 -0500
Received: from localhost ([10.250.79.55])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id x9GIJjZ07804;
        Wed, 16 Oct 2019 13:19:45 -0500 (CDT)
From:   "Andrew F. Davis" <afd@ti.com>
To:     Jiri Kosina <trivial@kernel.org>
CC:     <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH 04/10] atl1c: remove unneeded conversions to bool
Date:   Wed, 16 Oct 2019 14:19:38 -0400
Message-ID: <20191016181944.25106-1-afd@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Found with scripts/coccinelle/misc/boolconv.cocci.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 drivers/net/ethernet/atheros/atl1c/atl1c_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
index 2b239ecea05f..d6385899762c 100644
--- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
+++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
@@ -1189,7 +1189,7 @@ static void atl1c_start_mac(struct atl1c_adapter *adapter)
 	struct atl1c_hw *hw = &adapter->hw;
 	u32 mac, txq, rxq;
 
-	hw->mac_duplex = adapter->link_duplex == FULL_DUPLEX ? true : false;
+	hw->mac_duplex = adapter->link_duplex == FULL_DUPLEX;
 	hw->mac_speed = adapter->link_speed == SPEED_1000 ?
 		atl1c_mac_speed_1000 : atl1c_mac_speed_10_100;
 
-- 
2.17.1

