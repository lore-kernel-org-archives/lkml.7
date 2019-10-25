Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A514CA9EBC
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 09:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B46221D71
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 09:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394277AbfJYJea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 05:34:30 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:55002 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730207AbfJYJe3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 05:34:29 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5DC944AADF4BD93F2232;
        Fri, 25 Oct 2019 17:34:27 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Fri, 25 Oct 2019
 17:34:17 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <agross@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] clk: qcom: remove unneeded semicolon
Date:   Fri, 25 Oct 2019 17:33:32 +0800
Message-ID: <20191025093332.27592-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unneeded semicolon.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/clk/qcom/clk-rcg2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
index b98b81e..99c4bfa 100644
--- a/drivers/clk/qcom/clk-rcg2.c
+++ b/drivers/clk/qcom/clk-rcg2.c
@@ -206,7 +206,7 @@ static int _freq_tbl_determine_rate(struct clk_hw *hw, const struct freq_tbl *f,
 		break;
 	default:
 		return -EINVAL;
-	};
+	}
 
 	if (!f)
 		return -EINVAL;
@@ -319,7 +319,7 @@ static int __clk_rcg2_set_rate(struct clk_hw *hw, unsigned long rate,
 		break;
 	default:
 		return -EINVAL;
-	};
+	}
 
 	if (!f)
 		return -EINVAL;
-- 
2.7.4


