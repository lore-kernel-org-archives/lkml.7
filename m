Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FA8C3A59E
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 13:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDF44206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 13:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfHPNyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 09:54:09 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:37864 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726032AbfHPNyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 09:54:08 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 87C58E7345FA12480F5B;
        Fri, 16 Aug 2019 21:54:04 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Fri, 16 Aug 2019
 21:53:57 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh@kernel.org>,
        <info@metux.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] clk: st: clkgen-fsyn: remove unused variable 'st_quadfs_fs660c32_ops'
Date:   Fri, 16 Aug 2019 21:53:41 +0800
Message-ID: <20190816135341.52248-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/clk/st/clkgen-fsyn.c:70:29: warning:
 st_quadfs_fs660c32_ops defined but not used [-Wunused-const-variable=]

It is never used, so can be removed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/clk/st/clkgen-fsyn.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/st/clkgen-fsyn.c b/drivers/clk/st/clkgen-fsyn.c
index ca1ccdb..a156bd0 100644
--- a/drivers/clk/st/clkgen-fsyn.c
+++ b/drivers/clk/st/clkgen-fsyn.c
@@ -67,7 +67,6 @@ struct clkgen_quadfs_data {
 };
 
 static const struct clk_ops st_quadfs_pll_c32_ops;
-static const struct clk_ops st_quadfs_fs660c32_ops;
 
 static int clk_fs660c32_dig_get_params(unsigned long input,
 		unsigned long output, struct stm_fs *fs);
-- 
2.7.4


