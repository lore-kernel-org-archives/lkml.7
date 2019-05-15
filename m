Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9631C072AD
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80E75216F4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557919215;
	bh=Mdzso0n6Y2cRilWrPApcH6XZH0UplbFVE/NfqqY9/s8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s/uE8E9XNRozCTxHEjchpUJBrfc3o68SoBHmomg8rdePbO7Z80sYYtVafvHAGADH3
	 S4jr1LG4MsZkgEjce44fhoqZfiOEehvLXVrGUKqpZS2BTHQYPkoPZGsYh3l9wZIjuz
	 iJh07MPVtahBsUZvMdyCCB00ca4NgQr2GpMgPy+I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731067AbfEOLUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:20:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:57900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729438AbfEOLUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:20:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F0DB2084F;
        Wed, 15 May 2019 11:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557919203;
        bh=Mdzso0n6Y2cRilWrPApcH6XZH0UplbFVE/NfqqY9/s8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mEs9W5eX/qm/W94pLyGkzh8HzasM8TrMu0rhIKxsl1Hz85ZTgywSbC73SqfaKFgGx
         y4+tgJjBTxZkxAO8y/52W1p2FLHwEKrohsSKalxqTxeaD0+5d4DbagevVMfgbYz5eE
         xbiKEjw1z9LlR8czUBZHyt48K6m1WzDWQQaZ7QkA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 061/115] staging: olpc_dcon: add a missing dependency
Date:   Wed, 15 May 2019 12:55:41 +0200
Message-Id: <20190515090703.975269496@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090659.123121100@linuxfoundation.org>
References: <20190515090659.123121100@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 33f49571d75024b1044cd02689ad2bdb4924cc80 ]

  WARNING: unmet direct dependencies detected for BACKLIGHT_CLASS_DEVICE
    Depends on [n]: HAS_IOMEM [=y] && BACKLIGHT_LCD_SUPPORT [=n]
    Selected by [y]:
    - FB_OLPC_DCON [=y] && STAGING [=y] && X86 [=y] && OLPC [=y] && FB [=y]
                        && I2C [=y] && (GPIO_CS5535 [=n] || GPIO_CS5535 [=n]=n)

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/staging/olpc_dcon/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/olpc_dcon/Kconfig b/drivers/staging/olpc_dcon/Kconfig
index d277f048789e6..8c6cc61d634bf 100644
--- a/drivers/staging/olpc_dcon/Kconfig
+++ b/drivers/staging/olpc_dcon/Kconfig
@@ -2,6 +2,7 @@ config FB_OLPC_DCON
 	tristate "One Laptop Per Child Display CONtroller support"
 	depends on OLPC && FB
 	depends on I2C
+	depends on BACKLIGHT_LCD_SUPPORT
 	depends on (GPIO_CS5535 || GPIO_CS5535=n)
 	select BACKLIGHT_CLASS_DEVICE
 	---help---
-- 
2.20.1



