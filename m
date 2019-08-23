Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C293C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 08:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09AE221848
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 08:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392968AbfHWIcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 04:32:10 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:12078 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392871AbfHWIcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 04:32:10 -0400
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  Nicolas.Ferre@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Nicolas.Ferre@microchip.com";
  x-sender="Nicolas.Ferre@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Nicolas.Ferre@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa5.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=Nicolas.Ferre@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: Q7roEyGfP3D24oom/bMEm4mk2qWr1EVxRCdbO6JDt/H9xmqfKyPVoDqrGvlWKT2yb3KT3yuDPo
 0c83iFnyax5VCohQmxMorytonPd8zNkrU+7LaWdRBni4BsT70BKSyL2xGjyx7cei9ua0o1uUh3
 shqRDiVkxx/sDQAgmpeauD79Tpn71kDLn64cb8hgxcVOdZc9Ct2eJkc1X3UUkd1Drrg8ujUEob
 xJPdaYHj/2ob6V210C+BwUlR27dKRygep7sY4FXL+KABYogGFdWKE+UZEkec5ly5zpwDtv4oii
 /yU=
X-IronPort-AV: E=Sophos;i="5.64,420,1559545200"; 
   d="scan'208";a="44733631"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Aug 2019 01:32:11 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 23 Aug 2019 01:32:09 -0700
Received: from tenerife.corp.atmel.com (10.10.85.251) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Fri, 23 Aug 2019 01:32:08 -0700
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH 1/3] MAINTAINERS: at91: Collect all pinctrl/gpio drivers in same entry
Date:   Fri, 23 Aug 2019 10:31:56 +0200
Message-ID: <20190823083158.2649-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrei's address is not valid anymore, collect all pinctrl/gpio
entries in the common "PIN CONTROLLER - MICROCHIP AT91" one
and remove the PIOBU specific one.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 MAINTAINERS | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d214d3ebfb54..da7630c727be 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10679,12 +10679,6 @@ M:	Nicolas Ferre <nicolas.ferre@microchip.com>
 S:	Supported
 F:	drivers/power/reset/at91-sama5d2_shdwc.c
 
-MICROCHIP SAMA5D2-COMPATIBLE PIOBU GPIO
-M:	Andrei Stefanescu <andrei.stefanescu@microchip.com>
-L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-L:	linux-gpio@vger.kernel.org
-F:	drivers/gpio/gpio-sama5d2-piobu.c
-
 MICROCHIP SPI DRIVER
 M:	Nicolas Ferre <nicolas.ferre@microchip.com>
 S:	Supported
@@ -12768,6 +12762,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-gpio@vger.kernel.org
 S:	Supported
 F:	drivers/pinctrl/pinctrl-at91*
+F:	drivers/gpio/gpio-sama5d2-piobu.c
 
 PIN CONTROLLER - FREESCALE
 M:	Dong Aisheng <aisheng.dong@nxp.com>
-- 
2.17.1

