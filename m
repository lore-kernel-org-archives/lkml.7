Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDDBDFA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 18:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FA0D21D7C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 18:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="iz5MIiNO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436579AbfJPST7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 14:19:59 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:42948 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732498AbfJPSTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 14:19:54 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9GIJrtO075094;
        Wed, 16 Oct 2019 13:19:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571249993;
        bh=nySnbiUxuIsqbHhqmn0FbBUD6yHOrtqrKQi9klsEvvE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=iz5MIiNOwqZQfNBBwrDOoWvUS2w+PpF8Cc/kkETVf4ojMSY+qIUp5WXrI8LpZTO+t
         /6F12bkCIixukUeZ3ArtIomeChLXATUg5rbgSN9+Y2FA+dfB7iJS/yO8m2Y0S7ND+/
         ri9f9Y9lzkmXmmzu/0b3DAVk+mRBAVcu57iDIIiA=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9GIJrom067465
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Oct 2019 13:19:53 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 16
 Oct 2019 13:19:52 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 16 Oct 2019 13:19:46 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9GIJqGK074664;
        Wed, 16 Oct 2019 13:19:52 -0500
Received: from localhost ([10.250.79.55])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id x9GIJpZ07913;
        Wed, 16 Oct 2019 13:19:51 -0500 (CDT)
From:   "Andrew F. Davis" <afd@ti.com>
To:     Jiri Kosina <trivial@kernel.org>
CC:     <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH 07/10] [SCSI] Buslogic: Remove unneeded conversions to bool
Date:   Wed, 16 Oct 2019 14:19:41 -0400
Message-ID: <20191016181944.25106-4-afd@ti.com>
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
 drivers/scsi/BusLogic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/BusLogic.c b/drivers/scsi/BusLogic.c
index c25e8a54e869..6a0a74e9edc9 100644
--- a/drivers/scsi/BusLogic.c
+++ b/drivers/scsi/BusLogic.c
@@ -2236,7 +2236,7 @@ static bool __init blogic_inquiry(struct blogic_adapter *adapter)
 					"INQUIRE INSTALLED DEVICES ID 0 TO 7");
 		for (tgt_id = 0; tgt_id < 8; tgt_id++)
 			adapter->tgt_flags[tgt_id].tgt_exists =
-				(installed_devs0to7[tgt_id] != 0 ? true : false);
+				(installed_devs0to7[tgt_id] != 0);
 	}
 	/*
 	   Issue the Inquire Setup Information command.
-- 
2.17.1

