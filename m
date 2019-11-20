Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C35E7C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 971552251E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574257283;
	bh=sQh4Zt8A1arLPOqnpOUwICeXnrQlFAcd5K4SPGrn8Ro=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=k+fddYHUzwzi5RK7UAlbqsLGcXS1LhQ9ihzYhGwEcQTLlQrukm2U5TbdhhrNoT0og
	 fFh9xtym7Hstq+0fPvnYo71r6shSaKE1g36UwwblC1vLpuQzVmmYeMM0prniFGgGLy
	 xa73cJM0pRjWfEl6mfv4uKopmSL1ukw25x70gwIA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731369AbfKTNlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:41:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:49100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731362AbfKTNlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:41:20 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7865D224FC;
        Wed, 20 Nov 2019 13:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257279;
        bh=sQh4Zt8A1arLPOqnpOUwICeXnrQlFAcd5K4SPGrn8Ro=;
        h=From:To:Cc:Subject:Date:From;
        b=j8Juw7SAFLG44sxbN2azVdvyzhHMSenYIPESRF5HakSp6ds0bFnzRqXRv3lhQletN
         uvXeO71xpX5IIwPWZzLktxM/VvKZI43J6fabIFvqHeN7/niwuey9Vj6J6a7SecHyVA
         iEPs+BXFfK/KTDONFNpKRj5XAdiSSbDOh9zmEupk=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] macintosh: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:41:15 +0800
Message-Id: <20191120134115.14918-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/macintosh/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/macintosh/Kconfig b/drivers/macintosh/Kconfig
index 574e122ae105..cbd46c1c5bf7 100644
--- a/drivers/macintosh/Kconfig
+++ b/drivers/macintosh/Kconfig
@@ -178,7 +178,7 @@ config THERM_ADT746X
 	depends on I2C && I2C_POWERMAC && PPC_PMAC && !PPC_PMAC64
 	help
 	  This driver provides some thermostat and fan control for the
-          iBook G4, and the ATI based aluminium PowerBooks, allowing slightly
+	  iBook G4, and the ATI based aluminium PowerBooks, allowing slightly
 	  better fan behaviour by default, and some manual control.
 
 config WINDFARM
@@ -214,7 +214,7 @@ config WINDFARM_PM91
 	select I2C_POWERMAC
 	help
 	  This driver provides thermal control for the PowerMac9,1
-          which is the recent (SMU based) single CPU desktop G5
+	  which is the recent (SMU based) single CPU desktop G5
 
 config WINDFARM_PM112
 	tristate "Support for thermal management on PowerMac11,2"
@@ -242,7 +242,7 @@ config PMAC_RACKMETER
 	depends on PPC_PMAC
 	help
 	  This driver provides some support to control the front panel
-          blue LEDs "vu-meter" of the XServer macs.
+	  blue LEDs "vu-meter" of the XServer macs.
 
 config SENSORS_AMS
 	tristate "Apple Motion Sensor driver"
-- 
2.17.1

