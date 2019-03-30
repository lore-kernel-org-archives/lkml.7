Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D74C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BCC1218D9
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553907058;
	bh=pyCUEdYnOVBkpjFHKJttTK/1Gr26sqZeEbxuaxgbPMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JTvDgGCTWTFAReTEkZwE0AtuoZipy/MkpEQFGP0uLStasRWFABYpU1dkW7BUxSBgX
	 aUjGP0ZaVwXXZZKuCdAtUMnxfSOrRU96N+5iFpu5r1nbfUz5bGn/L6TEb/JeVCKiPB
	 SxHoT02or8T3jveLEXek8skVy3sRaKzctfn3SKtU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730543AbfC3Au5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 20:50:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:57514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730465AbfC3Au4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:50:56 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 889B6218D8;
        Sat, 30 Mar 2019 00:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553907055;
        bh=pyCUEdYnOVBkpjFHKJttTK/1Gr26sqZeEbxuaxgbPMo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nsK0WHiug7BfeWOwwmJCTEo81gWHq+8MeFUAY2/A5r1PLAze37tT7hr0DCjLN89NX
         KLvjHe8fpTm8xXelpKE7RCqOpsOFH/6nkD5Mz8PlzCPIM9b4z3k4QMipdZUxSHp9jQ
         t8bIubBLyEGxNjdnQxabEq+gsC5BxTsB9tzS6NLU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Petr=20=C5=A0tetiar?= <ynezz@true.cz>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Paul Burton <paul.burton@mips.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 06/67] mips: bcm47xx: Enable USB power on Netgear WNDR3400v2
Date:   Fri, 29 Mar 2019 20:49:46 -0400
Message-Id: <20190330005047.25998-6-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330005047.25998-1-sashal@kernel.org>
References: <20190330005047.25998-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Štetiar <ynezz@true.cz>

[ Upstream commit cdb8faa00e3fcdd0ad10add743516d616dc7d38e ]

Eric has reported on OpenWrt's bug tracking system[1], that he's not
able to use USB devices on his WNDR3400v2 device after the boot, until
he turns on GPIO #21 manually through sysfs.

1. https://bugs.openwrt.org/index.php?do=details&task_id=2170

Cc: Rafał Miłecki <zajec5@gmail.com>
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Reported-by: Eric Bohlman <ericbohlman@gmail.com>
Tested-by: Eric Bohlman <ericbohlman@gmail.com>
Signed-off-by: Petr Štetiar <ynezz@true.cz>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/bcm47xx/workarounds.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/bcm47xx/workarounds.c b/arch/mips/bcm47xx/workarounds.c
index 46eddbec8d9f..0ab95dd431b3 100644
--- a/arch/mips/bcm47xx/workarounds.c
+++ b/arch/mips/bcm47xx/workarounds.c
@@ -24,6 +24,7 @@ void __init bcm47xx_workarounds(void)
 	case BCM47XX_BOARD_NETGEAR_WNR3500L:
 		bcm47xx_workarounds_enable_usb_power(12);
 		break;
+	case BCM47XX_BOARD_NETGEAR_WNDR3400V2:
 	case BCM47XX_BOARD_NETGEAR_WNDR3400_V3:
 		bcm47xx_workarounds_enable_usb_power(21);
 		break;
-- 
2.19.1

