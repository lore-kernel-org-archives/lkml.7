Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69391FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CEAD206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573215185;
	bh=/WDj+UaCQBC6rLVEd/0zDBRi5NNk/rG3ku09g+amH2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i9oISKX3fP0Ozy5eOqhIFgjOEYwZc7fyHhZyH3p5UI5Qw0dm+aFExkREjbon0NpQZ
	 7uuj+VHH0HwQP/yWB9A5j2/MogVFygouzONfgA3pqhlvKuYgEAwt2xCQpK3g9nPMgy
	 fgsXW+TLR+rS+3vBJKXfImE7g2vlkrrXGq9Qf1vg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392008AbfKHMND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 07:13:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:51432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732681AbfKHLib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:38:31 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C2AF21D7B;
        Fri,  8 Nov 2019 11:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213111;
        bh=/WDj+UaCQBC6rLVEd/0zDBRi5NNk/rG3ku09g+amH2s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wFMBF6i0m3FW53SbPhfI/f4opCGnTBxsJSkIQfKg3hs4UzcsCx0hyRLr3AJ5D3cwu
         3M/HvGeYJBwcsirmP7WEUKa0baCAlc2B64O6Hdqyw2zsYq0k+VAmoU4zuPJQMwlZ1H
         A5QU6nRU9m7ID5bWwDsJW4LgpDRPA6HjLWvZfJyc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
        Tony Brelinski <tonyx.brelinski@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 033/205] ice: Fix and update driver version string
Date:   Fri,  8 Nov 2019 06:35:00 -0500
Message-Id: <20191108113752.12502-33-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108113752.12502-1-sashal@kernel.org>
References: <20191108113752.12502-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>

[ Upstream commit 9ea47d81a7f17c6b77211ab75fbca2127719ad39 ]

Remove the "ice" prefix for the driver version string and bump version
to 0.7.1-k.

Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Tested-by: Tony Brelinski <tonyx.brelinski@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index e1f95e7a51393..00c833cd2b3ae 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -7,7 +7,7 @@
 
 #include "ice.h"
 
-#define DRV_VERSION	"ice-0.7.0-k"
+#define DRV_VERSION	"0.7.1-k"
 #define DRV_SUMMARY	"Intel(R) Ethernet Connection E800 Series Linux Driver"
 const char ice_drv_ver[] = DRV_VERSION;
 static const char ice_driver_string[] = DRV_SUMMARY;
-- 
2.20.1

