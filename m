Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740F2C4649B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 15:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A2BC216E3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 15:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CEukuNRy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbfGEPNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 11:13:40 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:56984 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbfGEPNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 11:13:39 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x65FDZ8Y087596;
        Fri, 5 Jul 2019 10:13:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1562339615;
        bh=X5SQUumkW58Zgp2FI1ph9B4uenobpRYKTZ55G7V38jk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=CEukuNRy3wkAEheclq4mBFDybaEU9p6Z87439S5jVmmWPEn/eKjWInZ1H1w9W+uyD
         AOyrO8FSKJCO+1bj71XytWrVcVMEGh61LCcarM7MyLP8ytC/GYTgWPhC/tbhVJ3vI5
         BIO4bTmTbobu7HJuNu/CXYLBANAStyYosRm+JAnA=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x65FDZB0012878
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 Jul 2019 10:13:35 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 5 Jul
 2019 10:13:35 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 5 Jul 2019 10:13:35 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x65FDYQk095136;
        Fri, 5 Jul 2019 10:13:34 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Santosh Shilimkar <ssantosh@kernel.org>
CC:     Sekhar Nori <nsekhar@ti.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [RESEND PATCH next v2 6/6] ARM: configs: keystone: enable cpts
Date:   Fri, 5 Jul 2019 18:12:47 +0300
Message-ID: <20190705151247.30422-7-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190705151247.30422-1-grygorii.strashko@ti.com>
References: <20190705151247.30422-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable CPTS support which is present in Network Coprocessor Gigabit
Ethernet (GbE) Switch Subsystem.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 arch/arm/configs/keystone_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/keystone_defconfig b/arch/arm/configs/keystone_defconfig
index 72fee57aad2f..0b2281407ecf 100644
--- a/arch/arm/configs/keystone_defconfig
+++ b/arch/arm/configs/keystone_defconfig
@@ -136,6 +136,7 @@ CONFIG_BLK_DEV_SD=y
 CONFIG_NETDEVICES=y
 CONFIG_TI_KEYSTONE_NETCP=y
 CONFIG_TI_KEYSTONE_NETCP_ETHSS=y
+CONFIG_TI_CPTS=y
 CONFIG_MARVELL_PHY=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
-- 
2.17.1

