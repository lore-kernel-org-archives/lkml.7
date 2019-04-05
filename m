Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BD6C282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5865E20651
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qVML4Xxa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731582AbfDER3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 13:29:07 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:56324 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731690AbfDER3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 13:29:04 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x35HT2X5131007;
        Fri, 5 Apr 2019 12:29:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554485342;
        bh=s4ndvrZgEDLY14jKjIVuslAI+tMO/F73zDB118TBf3E=;
        h=From:To:Subject:Date:In-Reply-To:References;
        b=qVML4Xxa46nG9ippoIkfolQHRSwa9tgSHPapc1yrjvhV05buk/UETDQxRWz4kAS7P
         akw7xIiaSf24xzLvEfGLI34rBBT0UJu19HlUXe3GE/WBtj44gLvrIAoSgjUC1lGfcc
         +FMbao464DGuc3pmHiqpyzNMseIT+1pqCDlwzuLw=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x35HT10f096360
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 Apr 2019 12:29:02 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 5 Apr
 2019 12:29:01 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 5 Apr 2019 12:29:01 -0500
Received: from uda0868495.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x35HSsuY095744;
        Fri, 5 Apr 2019 12:29:00 -0500
From:   Murali Karicheri <m-karicheri2@ti.com>
To:     <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <arvid.brodin@alten.se>,
        <a-kramer@ti.com>
Subject: [PATCH net 11/14] net: hsr: add blank line after function declaration
Date:   Fri, 5 Apr 2019 13:31:33 -0400
Message-ID: <20190405173136.18050-12-m-karicheri2@ti.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190405173136.18050-1-m-karicheri2@ti.com>
References: <20190405173136.18050-1-m-karicheri2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a blank line after function declaration as suggested by
checkpatch.pl -f

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 net/hsr/hsr_framereg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
index cba4b2486050..14f816149489 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -49,6 +49,7 @@ static bool seq_nr_after(u16 a, u16 b)
 
 	return (((s16)(b - a)) < 0);
 }
+
 #define seq_nr_before(a, b)		seq_nr_after((b), (a))
 #define seq_nr_after_or_eq(a, b)	(!seq_nr_before((a), (b)))
 #define seq_nr_before_or_eq(a, b)	(!seq_nr_after((a), (b)))
-- 
2.17.0

