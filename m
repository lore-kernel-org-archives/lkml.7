Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F87C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 094F320862
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574142681;
	bh=SYK3cbFOH5p92qBycnjfraI6rejI7ktNpDJLkusLl1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KNgJs89RGWuiz7nHR7OUMudxt0uk3Q0Ckne/6oajJywiROf8kt4kIyqNaD9rSAkMm
	 a6rG02ztD1/8fRLXi+4yTN4SAiXBsb/KztkM+cA3XnyhW5VsrXhCDwCfXG2QaTfEct
	 IhoxaTNPZrwAZeCYgKWYyrWEnEbXNMB2cJdVmbGY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731768AbfKSFvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:51:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:48658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731758AbfKSFvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:51:16 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9E25208C3;
        Tue, 19 Nov 2019 05:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574142676;
        bh=SYK3cbFOH5p92qBycnjfraI6rejI7ktNpDJLkusLl1w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OJ/LUZU39u/PLeK3TRiEXg0804v90RZucnogERtDK0cNojaa17iJBw2dXkMHid03S
         yPzPvzpFlK/bz+1INEqaNbcVgC98nFGSwFMXEKFyt8mIjGYo9oKGD/pxjH+IyDsKVU
         Uc0SvfXf3Yac1rnKyG25HhI/EwN4Gm8sqNM+gz88=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 161/239] ARM: dts: ux500: Correct SCU unit address
Date:   Tue, 19 Nov 2019 06:19:21 +0100
Message-Id: <20191119051333.379209838@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051255.850204959@linuxfoundation.org>
References: <20191119051255.850204959@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 2f217d24ecaec2012e628d21e244eef0608656a4 ]

The unit address of the Cortex-A9 SCU device node contains one zero too
many.  Remove it.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/ste-dbx5x0.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ste-dbx5x0.dtsi b/arch/arm/boot/dts/ste-dbx5x0.dtsi
index 2310a4e97768c..3dc0028e108b3 100644
--- a/arch/arm/boot/dts/ste-dbx5x0.dtsi
+++ b/arch/arm/boot/dts/ste-dbx5x0.dtsi
@@ -197,7 +197,7 @@
 			      <0xa0410100 0x100>;
 		};
 
-		scu@a04100000 {
+		scu@a0410000 {
 			compatible = "arm,cortex-a9-scu";
 			reg = <0xa0410000 0x100>;
 		};
-- 
2.20.1



