Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D0AC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 20:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C9CD217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 20:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hsSLeSMn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfDWUAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 16:00:30 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:45926 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbfDWUA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 16:00:29 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3NK0PKk031471;
        Tue, 23 Apr 2019 15:00:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1556049625;
        bh=Pg+o5n7L1YZxKf5EiCMinEtPFiNKknYLPvuflBfKW+Q=;
        h=From:To:CC:Subject:Date;
        b=hsSLeSMn1Nrw3L4R0lIpCsx0l3D4xNa0NWAZRapKronvOMbF9tadQmnv+Lhqkn/Ak
         uPxDWQEp67DGt0WIaiAqYFZDdiS2By0I4jFMpJsmPrUKmO2lavqOcJNo9trohN/9Qg
         I4jkFGmAK2aV3tsMftyOR48b+fFYahmSpfF4wAA4=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3NK0PUG104238
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 23 Apr 2019 15:00:25 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 23
 Apr 2019 15:00:24 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 23 Apr 2019 15:00:24 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3NK0Omc076635;
        Tue, 23 Apr 2019 15:00:24 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>
CC:     <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH] MAINTAINERS: LEDs: Add designated reviewer for LED subsystem
Date:   Tue, 23 Apr 2019 15:00:24 -0500
Message-ID: <20190423200024.29538-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.21.0.5.gaeb582a983
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a designated reviewer for the LED subsystem as there
are already two maintainers assigned.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3671fdea5010..ee0b10484194 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8708,6 +8708,7 @@ F:	scripts/leaking_addresses.pl
 LED SUBSYSTEM
 M:	Jacek Anaszewski <jacek.anaszewski@gmail.com>
 M:	Pavel Machek <pavel@ucw.cz>
+R:	Dan Murphy <dmurphy@ti.com>
 L:	linux-leds@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/j.anaszewski/linux-leds.git
 S:	Maintained
-- 
2.21.0.5.gaeb582a983

