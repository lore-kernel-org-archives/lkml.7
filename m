Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF1AC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 08:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F41E222CE3
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 08:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404751AbfHWIcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 04:32:15 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:28176 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392871AbfHWIcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 04:32:12 -0400
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  Nicolas.Ferre@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Nicolas.Ferre@microchip.com";
  x-sender="Nicolas.Ferre@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Nicolas.Ferre@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=Nicolas.Ferre@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: bXLyaoh69WWWe7r7rFVrHA+SP2Zb5se6JRIYfCcPj4fG855QHEdIqARfdTecHAonPWEobbyEnA
 9hduoVhEPX/0KrW9zV5wULo+N3Z68FSPKjvoRmd5lf3vxO3G1lkI+Z/UAw+mwqSYzo5vilmyvM
 f9ffMlHvmxK8y7gOejKem/XmVEM2zwzwujPZpJ3FDwVizC/iDkDioQVeR85yzRPYD5PfHQuvaj
 MOoGKjP6g++BEEsQwXQ/i8nco41FaB7sKPFW4AAVVvStevIPHAZ43ESS5IjGIkGfafQB6HDT+G
 R8c=
X-IronPort-AV: E=Sophos;i="5.64,420,1559545200"; 
   d="scan'208";a="46268125"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Aug 2019 01:32:11 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 23 Aug 2019 01:32:11 -0700
Received: from tenerife.corp.atmel.com (10.10.85.251) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Fri, 23 Aug 2019 01:32:09 -0700
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH 2/3] MAINTAINERS: at91: remove the TC entry
Date:   Fri, 23 Aug 2019 10:31:57 +0200
Message-ID: <20190823083158.2649-2-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190823083158.2649-1-nicolas.ferre@microchip.com>
References: <20190823083158.2649-1-nicolas.ferre@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"MICROCHIP TIMER COUNTER (TC) AND CLOCKSOURCE DRIVERS" is better
removed because one file entry is outdated and basically, the
maintainer's pool of Alexandre, Ludovic and myself is better suited.

drivers/misc/atmel_tclib.c file is going away in a patch to come and
drivers/clocksource/tcb_clksrc.c file is actually named timer-atmel-tcb.c.
This new name is catches by AT91 entry regular expression.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 MAINTAINERS | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index da7630c727be..c28a28d4cac9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10691,13 +10691,6 @@ S:	Supported
 F:	drivers/misc/atmel-ssc.c
 F:	include/linux/atmel-ssc.h
 
-MICROCHIP TIMER COUNTER (TC) AND CLOCKSOURCE DRIVERS
-M:	Nicolas Ferre <nicolas.ferre@microchip.com>
-L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-S:	Supported
-F:	drivers/misc/atmel_tclib.c
-F:	drivers/clocksource/tcb_clksrc.c
-
 MICROCHIP USBA UDC DRIVER
 M:	Cristian Birsan <cristian.birsan@microchip.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.17.1

