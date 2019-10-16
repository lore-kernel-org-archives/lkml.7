Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D215FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 18:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BB7321D7C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 18:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vb38/JCe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436600AbfJPSUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 14:20:06 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:42952 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436572AbfJPST6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 14:19:58 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9GIJvcL075102;
        Wed, 16 Oct 2019 13:19:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571249997;
        bh=N5VSvwJ5qURebXf5FE2PesK5k+3jrpC1c7PgKk2mcmo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=vb38/JCezQ0a4STiCxXt0ibuetSbnWBmKLCApQ0Dj6a0lg5oNKSsoWa5q61/fq4QA
         f4CQplLtIBKtRXhBQ/TgpP0v6m5n9iIhpCtUaBBmaTwe1hnjwNiMm7LYXLghBgd68F
         wNovl8gnA9zYcZj4IPqRNli5NLBsr69xRHsDuwhc=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9GIJvBw015494;
        Wed, 16 Oct 2019 13:19:57 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 16
 Oct 2019 13:19:57 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 16 Oct 2019 13:19:50 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9GIJvSs074733;
        Wed, 16 Oct 2019 13:19:57 -0500
Received: from localhost ([10.250.79.55])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id x9GIJuZ07995;
        Wed, 16 Oct 2019 13:19:56 -0500 (CDT)
From:   "Andrew F. Davis" <afd@ti.com>
To:     Jiri Kosina <trivial@kernel.org>
CC:     <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH 10/10] ath5k: Remove unneeded conversions to bool
Date:   Wed, 16 Oct 2019 14:19:44 -0400
Message-ID: <20191016181944.25106-7-afd@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191016181944.25106-1-afd@ti.com>
References: <20191016181944.25106-1-afd@ti.com>
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
 drivers/net/wireless/ath/ath5k/ani.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath5k/ani.c b/drivers/net/wireless/ath/ath5k/ani.c
index 0624333f5430..850c608b43a3 100644
--- a/drivers/net/wireless/ath/ath5k/ani.c
+++ b/drivers/net/wireless/ath/ath5k/ani.c
@@ -501,7 +501,7 @@ ath5k_ani_calibration(struct ath5k_hw *ah)
 
 	if (as->ofdm_errors > ofdm_high || as->cck_errors > cck_high) {
 		/* too many PHY errors - we have to raise immunity */
-		bool ofdm_flag = as->ofdm_errors > ofdm_high ? true : false;
+		bool ofdm_flag = as->ofdm_errors > ofdm_high;
 		ath5k_ani_raise_immunity(ah, as, ofdm_flag);
 		ath5k_ani_period_restart(as);
 
-- 
2.17.1

