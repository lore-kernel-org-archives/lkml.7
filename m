Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30966C3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 21:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE2DD20674
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 21:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="A3wowv/M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730678AbfIDVF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 17:05:28 -0400
Received: from mx1.riseup.net ([198.252.153.129]:47224 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730214AbfIDVF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 17:05:27 -0400
Received: from bell.riseup.net (bell-pn.riseup.net [10.0.1.178])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (verified OK))
        by mx1.riseup.net (Postfix) with ESMTPS id E80261A652C;
        Wed,  4 Sep 2019 14:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1567631127; bh=RLM1V7holiv5uXxR58b5zPqf00nxc2ymX8fdlGsPBOs=;
        h=From:To:Subject:Date:From;
        b=A3wowv/MIngUNkpsgk59MMoIHhiDyIi6FhwyI39b9jnKZgmF0poaC7Jh0GD4dSm+K
         PYmi5kdloCu8LfuedeZmcW3Jtxvs2kKNd2VvHjmgdGtdBMAv75hw1NKs1RANcqaZ8n
         7qdLwlMEg2vM+uzjZqcjLOXQu0AXcIf1ggjwietE=
X-Riseup-User-ID: 4E284FA5E98CD97C1A4A4A34D27E74924627F18E6477D22557B90FBBC61CF950
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by bell.riseup.net (Postfix) with ESMTPSA id 63C952231D9;
        Wed,  4 Sep 2019 14:05:25 -0700 (PDT)
From:   Leandro Ribeiro <leandrohr@riseup.net>
To:     lkcamp@lists.libreplanetbr.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: [PATCH] staging: rtl8723bs: Remove return statement from void function
Date:   Wed,  4 Sep 2019 21:06:31 +0000
Message-Id: <20190904210631.13599-1-leandrohr@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following checkpatch warning:

"WARNING: void function return statements are not generally useful"

Signed-off-by: Leandro Ribeiro <leandrohr@riseup.net>
---
 drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c b/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
index 79c1e3edb189..7760fd0eb6c9 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
@@ -1406,7 +1406,6 @@ void rtl8723b_set_ap_wowlan_cmd(struct adapter *padapter, u8 enable)
 	rtl8723b_set_Fw_AP_Offload_Cmd(padapter, enable);
 	msleep(10);
 	DBG_871X_LEVEL(_drv_always_, "-%s()-\n", __func__);
-	return ;
 }
 #endif /* CONFIG_AP_WOWLAN */
 
-- 
2.20.1

