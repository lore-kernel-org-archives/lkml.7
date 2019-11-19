Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D183C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BFFE222DC
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574141161;
	bh=/WDj+UaCQBC6rLVEd/0zDBRi5NNk/rG3ku09g+amH2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MxRi6pzSMA4ksGf2qALXeoR0d43+So0a+T9SBsPEfuueTQude75FMkZmy3AbAQt4F
	 1i8t8TDnfjAX/Fr7DAuTQXJwSf6A9QnbWGWBZFF0ve8vbpLXz3kb1QeEpYNPT2RdHv
	 CSBaT0CyHnlWd0HXZ1btOxfkqU8GrWRXM2UvCCfA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbfKSF0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:26:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:43892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727849AbfKSFZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:25:58 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29F0F21823;
        Tue, 19 Nov 2019 05:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574141157;
        bh=/WDj+UaCQBC6rLVEd/0zDBRi5NNk/rG3ku09g+amH2s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FfTvUpi7wCiNkc4OsWvM8Y2uchXvR+7hRXCEZi2pJvpRSBagYsXJh+cirxFXj96z/
         566sNZWe8oqP5efrM00N+PAwBnigw3Mq0nwRQuH3hHga6ooGnBcQWHPZEQNearMebO
         E/KZIvm+1K6NALTDYQlAr9Br2ZbONjE30GP5TH24=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
        Tony Brelinski <tonyx.brelinski@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 065/422] ice: Fix and update driver version string
Date:   Tue, 19 Nov 2019 06:14:22 +0100
Message-Id: <20191119051403.893600135@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051400.261610025@linuxfoundation.org>
References: <20191119051400.261610025@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



