Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC97C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E19AA20833
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbfFQOil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 10:38:41 -0400
Received: from andre.telenet-ops.be ([195.130.132.53]:42178 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728307AbfFQOil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:38:41 -0400
Received: from ramsan ([84.194.111.163])
        by andre.telenet-ops.be with bizsmtp
        id Rqed2000H3XaVaC01qedVW; Mon, 17 Jun 2019 16:38:39 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hcsmL-0002JI-C4; Mon, 17 Jun 2019 16:38:37 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hcsmL-0001Lr-AU; Mon, 17 Jun 2019 16:38:37 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] net: hns3: Add missing newline at end of file
Date:   Mon, 17 Jun 2019 16:38:36 +0200
Message-Id: <20190617143836.5154-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"git diff" says:

    \ No newline at end of file

after modifying the file.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/net/ethernet/hisilicon/hns3/hns3vf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/Makefile b/drivers/net/ethernet/hisilicon/hns3/hns3vf/Makefile
index 6193f8fa7cf34aa1..53804d95ea900e03 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/Makefile
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/Makefile
@@ -6,4 +6,4 @@
 ccflags-y := -I $(srctree)/drivers/net/ethernet/hisilicon/hns3
 
 obj-$(CONFIG_HNS3_HCLGEVF) += hclgevf.o
-hclgevf-objs = hclgevf_main.o hclgevf_cmd.o hclgevf_mbx.o
\ No newline at end of file
+hclgevf-objs = hclgevf_main.o hclgevf_cmd.o hclgevf_mbx.o
-- 
2.17.1

