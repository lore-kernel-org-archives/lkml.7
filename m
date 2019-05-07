Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CACEC04AAB
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6242A204FD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557208260;
	bh=NcrPVvTGADurwlQBVlmgYHaiY3R30v/dqKCvsv7T/tw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VsL3npGGGwI4519Ocuc6NCLHsawlCt0W8/XXogMhm2QAImcYlqGt91pV8QgNg3zfa
	 KWwro2Wk149OofRYEUn+y9TfCwLInJ/3emLR4N5xWpxM5OKqOf40xqG+zPjsKiJhks
	 wU53VQi8Jonn6zfrbrSIQAUL6mzjWZPhZ6CcgcK8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729248AbfEGFu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 01:50:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:59498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729003AbfEGFkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 01:40:01 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F134F216C8;
        Tue,  7 May 2019 05:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557207600;
        bh=NcrPVvTGADurwlQBVlmgYHaiY3R30v/dqKCvsv7T/tw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T9aGQvs/P42MmyUwNHN2+r8PW3kZGXDxPs9SNdosf4Iqo4yTx5l7tqWHNE/JLFSg5
         Yx2eO7W1gFTujmjACYC5y0tJb5gnpvpeAcggeV1AikveeBDCfwtC+uwg6MlloMzz9n
         Q9JVxOZTCz6hMgxWBuCBhhgd91VIFhnrLYutXzuM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vignesh R <vigneshr@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <alexander.levin@microsoft.com>,
        linux-i2c@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 48/95] i2c: omap: Enable for ARCH_K3
Date:   Tue,  7 May 2019 01:37:37 -0400
Message-Id: <20190507053826.31622-48-sashal@kernel.org>
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

From: Vignesh R <vigneshr@ti.com>

[ Upstream commit 5b277402deac0691226a947df71c581686bd4020 ]

Allow I2C_OMAP to be built for K3 platforms.

Signed-off-by: Vignesh R <vigneshr@ti.com>
Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/i2c/busses/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 45a3f3ca29b3..75ea367ffd83 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -759,7 +759,7 @@ config I2C_OCORES
 
 config I2C_OMAP
 	tristate "OMAP I2C adapter"
-	depends on ARCH_OMAP
+	depends on ARCH_OMAP || ARCH_K3
 	default y if MACH_OMAP_H3 || MACH_OMAP_OSK
 	help
 	  If you say yes to this option, support will be included for the
-- 
2.20.1

