Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E127FA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 18:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E792721A49
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 18:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UmD9kM2J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403905AbfJPSPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 14:15:00 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:58330 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403818AbfJPSPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 14:15:00 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9GIEwPV062798;
        Wed, 16 Oct 2019 13:14:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571249698;
        bh=ptFPEunnPjgZe5N6JTByY+mk1A/SSazFT48SXkQiKeQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=UmD9kM2JratZOPJIOVxQEAb3ADWk6DmrwgcgW3wwGAfMcUiiKvhBcZIC3tJuPCq2L
         pMIwS6BW+QkGdJzhlfwXzEpXHmPEdBT3hQpMlLU3dkXk4JqLH48e7IK+/uLtWdn9zv
         W2M+NKGQOrqejYAe3z+dsKcRZLWyTOcSkweGj2sY=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9GIEw2k026229
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Oct 2019 13:14:58 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 16
 Oct 2019 13:14:51 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 16 Oct 2019 13:14:51 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9GIEwQZ087886;
        Wed, 16 Oct 2019 13:14:58 -0500
Received: from localhost ([10.250.79.55])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id x9GIEuZ02543;
        Wed, 16 Oct 2019 13:14:57 -0500 (CDT)
From:   "Andrew F. Davis" <afd@ti.com>
To:     Jiri Kosina <trivial@kernel.org>
CC:     <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH 03/10] mtd: nand: qcom: remove unneeded conversions to bool
Date:   Wed, 16 Oct 2019 14:14:36 -0400
Message-ID: <20191016181443.24790-2-afd@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191016181443.24790-1-afd@ti.com>
References: <20191016181443.24790-1-afd@ti.com>
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
 drivers/mtd/nand/raw/qcom_nandc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 7bb9a7e8e1e7..b437b0c79cf2 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -1767,8 +1767,7 @@ static int parse_read_errors(struct qcom_nand_host *host, u8 *data_buf,
 			 * ERASED_CW bits are set.
 			 */
 			if (host->bch_enabled) {
-				erased = (erased_cw & ERASED_CW) == ERASED_CW ?
-					 true : false;
+				erased = (erased_cw & ERASED_CW) == ERASED_CW;
 			/*
 			 * For RS ECC, HW reports the erased CW by placing
 			 * special characters at certain offsets in the buffer.
-- 
2.17.1

