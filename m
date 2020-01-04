Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5451C32770
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 16:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD1252465B
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 16:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578155368;
	bh=5+5FiSYgcTbDhFiX3JpSiUoaYWTv82CfD8GhHmUpAog=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=n7kfUMxWTwS1uUlVbhn5BqkWjoppbunzRPcyZ39i5+KSMHiLoLdSyCVU1Sc19VYE2
	 MrhBAwxmkZg51cugzJDqHp+CGC3m1gZkR1ruCydxA5nqE99xGf1bK8NSZMNe24Lctq
	 JbIK0JovDjFx/UfpLrENIYLmDBEvbEA369u7Vw20=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgADQ31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 11:29:27 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:43109 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbgADQ31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 11:29:27 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 004GSaoq029321;
        Sun, 5 Jan 2020 01:28:36 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 004GSaoq029321
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1578155317;
        bh=BCbtz6rrc6jSvrHHlVpTqOC3pSISW0eDFtaFXvtYM3o=;
        h=From:To:Cc:Subject:Date:From;
        b=JHz5tHHohM/sW7N+Cy4N3GCI3+kamahEwpbzEddjwuS5Nug2R0nzw43vbjAIhr90O
         Gy2IkEKWs4RB2G797wbNhcW3D1gLHSqfIH1O/7GravvV+o/g+J3bIZ+DTNIvYMndCk
         T+DCwzVJU8yloxqV1NiV1Et4xoxyftcLqJKC4ZZTSySgao5vW2PfjBdF1I8vAwPtxy
         8BhBjzxgx0Ct7GsHOZBrHTCapk6GMROxTG+PYwR7o476tlu+hlgZyQQ0yN2P6yShul
         wC8QuOiF2lkcQ0r3hDtc/Yaj+M+LULOmccX/EKCpiDaNoAnGNPgX4p5y0C2GeOW4vk
         l7jNVW0vI7dvA==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com,
        Masahiro Yamada <masahiroy@kernel.org>,
        devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
Subject: [PATCH] staging: vc04_service: remove unused header include path
Date:   Sun,  5 Jan 2020 01:28:29 +0900
Message-Id: <20200104162829.20400-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I can build drivers/staging/vc04_services without this.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 drivers/staging/vc04_services/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/Makefile b/drivers/staging/vc04_services/Makefile
index afe43fa5a6d7..54d9e2f31916 100644
--- a/drivers/staging/vc04_services/Makefile
+++ b/drivers/staging/vc04_services/Makefile
@@ -13,5 +13,5 @@ vchiq-objs := \
 obj-$(CONFIG_SND_BCM2835)	+= bcm2835-audio/
 obj-$(CONFIG_VIDEO_BCM2835)	+= bcm2835-camera/
 
-ccflags-y += -Idrivers/staging/vc04_services -D__VCCOREVER__=0x04000000
+ccflags-y += -D__VCCOREVER__=0x04000000
 
-- 
2.17.1

