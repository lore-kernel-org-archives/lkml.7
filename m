Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B798EC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F24F204FD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557208206;
	bh=SIb/1gjRI1WaMCeRFJQ+4i7vI4IVNO/tAt0IJhTH+wQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zvo7uy3BW5D96bAkeLn18/42wjJGq2OvdugyGr1JbkenZgP8HnUDkMcdUJUhhXrbs
	 MidtKj/dD8EkJdGqx9im3mbfN64wLiaEZrIS1iZ1E2Np9d90xNsO6tadzK0/KhyUJD
	 BwQVbi2tghAi/BvZBdoawYjDg0PC2dphHU0yNnOc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729068AbfEGFkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 01:40:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:59724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729054AbfEGFkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 01:40:14 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 362F7216C8;
        Tue,  7 May 2019 05:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557207613;
        bh=SIb/1gjRI1WaMCeRFJQ+4i7vI4IVNO/tAt0IJhTH+wQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GG1/P5qdJPBQScvB3puVKT/2ipSxiCMuJY2LRMeozmjXqrb7144JTkINhyM07v8qq
         KduMxjl2JNpYvdv9AwAtDrUpCcP67qR/C3TLB9slo/FN/U4U0by6p7mIg0GM3ylSxM
         YgKepnC8eBoNX3FzIeblRcJSOBtaRWfzmXP7PEZc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lubomir Rintel <lkundrak@v3.sk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>,
        devel@driverdev.osuosl.org
Subject: [PATCH AUTOSEL 4.14 57/95] staging: olpc_dcon: add a missing dependency
Date:   Tue,  7 May 2019 01:37:46 -0400
Message-Id: <20190507053826.31622-57-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190507053826.31622-1-sashal@kernel.org>
References: <20190507053826.31622-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lubomir Rintel <lkundrak@v3.sk>

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
index d277f048789e..8c6cc61d634b 100644
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

