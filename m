Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC19C17441
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCB7121D7F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573611903;
	bh=NObG4ppKYgwiPwjuxGjJCTSDOQBfWncIECXrZIt8Aws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IGdoRfbzj8xbHlT5tW0gbtajj5XFoTBeQtwplyJiMclsXYw5wtD+GVoOB4jZ94iCO
	 0/ma8f5ofx2ZW4KgCrGd/hsIV0epOawuQO4nNjn96zqAfijCy97/iPSyQaZeK5pfPp
	 luymenIPqoEqIYM2rqiYR+wd+Z3tTm/IKcKFOEsI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730149AbfKMCZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 21:25:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:40004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727992AbfKMBvt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:51:49 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80ECA204EC;
        Wed, 13 Nov 2019 01:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573609909;
        bh=NObG4ppKYgwiPwjuxGjJCTSDOQBfWncIECXrZIt8Aws=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AsBHJC9TOV/0Gb+pTbnSrwRMFAwWEDp7wSBZd4hJ6oiI1VKwo8FjjJRKO1e8TUhGn
         JLp1kogDrkFTnj80cMZLiyCGdmgr1lajHrAcDkTx3BbjyBHjZg5MNXXPiQbCm6hqdG
         rs8iLj6q0zklqa4s2izhke5ZsZ/CC/iZkleePYJA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 060/209] ARM: dts: at91: sama5d2_ptc_ek: fix bootloader env offsets
Date:   Tue, 12 Nov 2019 20:47:56 -0500
Message-Id: <20191113015025.9685-60-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113015025.9685-1-sashal@kernel.org>
References: <20191113015025.9685-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

[ Upstream commit f602b4871c5f7ac01d37d8b285ca947ba7613065 ]

The offsets for the bootloader environment and its redundant partition
were inverted. Fix the addresses to match our nand flash map available at:

http://www.at91.com/linux4sam/pub/Linux4SAM/SambaSubsections//demo_nandflash_map_lnx4sam5x.png

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts b/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts
index 3b1baa8605a77..2214bfe7aa205 100644
--- a/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts
@@ -92,13 +92,13 @@
 							reg = <0x40000 0xc0000>;
 						};
 
-						bootloaderenv@0x100000 {
-							label = "bootloader env";
+						bootloaderenvred@0x100000 {
+							label = "bootloader env redundant";
 							reg = <0x100000 0x40000>;
 						};
 
-						bootloaderenvred@0x140000 {
-							label = "bootloader env redundant";
+						bootloaderenv@0x140000 {
+							label = "bootloader env";
 							reg = <0x140000 0x40000>;
 						};
 
-- 
2.20.1

