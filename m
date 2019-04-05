Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0359C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 13:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACCB92184B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 13:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PW63e0Iq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730870AbfDEN2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 09:28:19 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:58156 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfDEN2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 09:28:16 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x35DSCoR075810;
        Fri, 5 Apr 2019 08:28:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554470892;
        bh=8XS5BPUvq8IzQIugc7I+dAr4uyg2IoPaKNRdBShsdgo=;
        h=From:To:CC:Subject:Date;
        b=PW63e0IqVa5060L/LGRa/hJdledDFZVbPukhVu7nOguwfIGXCXd51ZS5DKK2uFcvE
         wUVzCQNEV0AKr7UdFQ5LPE9QAQHf1ffaHVCfEoYJOstgLw6de/a+vio7AD5SgX+gek
         0LwLPA6/Od9eNJsfEok16FcRcywedCYCBnyYcS3g=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x35DSCA6113574
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 Apr 2019 08:28:12 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 5 Apr
 2019 08:28:10 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 5 Apr 2019 08:28:10 -0500
Received: from lta0400828d.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x35DS8dD057878;
        Fri, 5 Apr 2019 08:28:08 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <tony@atomide.com>
CC:     <robh+dt@kernel.org>, <s-anna@ti.com>, <nm@ti.com>,
        <lokeshvutla@ti.com>, <linux-omap@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Roger Quadros <rogerq@ti.com>
Subject: [PATCH 0/2] ARM: dts: dra7: Introduce AM57 dtsi files
Date:   Fri, 5 Apr 2019 16:28:04 +0300
Message-ID: <20190405132806.20772-1-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

AM5 and DRA7 SoC families have different set of modules
in them so the SoC sepecific dtsi files need to be seperated.

e.g. Some of the major differences between AM576 and DRA76

	DRA76x	AM576x

USB3		x
USB4		x
ATL		x
VCP		x
MLB		x
ISS		x
PRU-ICSS1		x
PRU-ICSS2		x

This patch only deals with disabling USB3, USB4 and ATL for
AM57 variants.

cheers,
-roger

Roger Quadros (2):
  dt-binding: arm: omap: Add information for AM5748
  ARM: dts: dra7: Separate AM57 dtsi files

 .../devicetree/bindings/arm/omap/omap.txt     |  6 ++++
 arch/arm/boot/dts/am5718.dtsi                 | 32 ++++++++++++++++++
 arch/arm/boot/dts/am571x-idk.dts              |  2 +-
 arch/arm/boot/dts/am5728.dtsi                 | 33 +++++++++++++++++++
 arch/arm/boot/dts/am572x-idk.dts              |  5 ++-
 arch/arm/boot/dts/am5748.dtsi                 | 33 +++++++++++++++++++
 arch/arm/boot/dts/am574x-idk.dts              |  4 +--
 arch/arm/boot/dts/am57xx-cl-som-am57x.dts     |  2 +-
 arch/arm/boot/dts/dra7-l4.dtsi                |  6 ++--
 9 files changed, 113 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm/boot/dts/am5718.dtsi
 create mode 100644 arch/arm/boot/dts/am5728.dtsi
 create mode 100644 arch/arm/boot/dts/am5748.dtsi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

