Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F36C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 05:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43FDC2068F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 05:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574402346;
	bh=fartVLOhnNSRIT/tr81MwxpOnOPAeQcYz5Tr9R0c+A4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZHNyGc1g6Zk+YJWxEERleBxFbGaUOEF6WdsDdxF9nDarT2w4GvtE5+P/XQVVdmBDY
	 PTbbbNqU2sRAqfx80el9+bBiUpqDGInjOEaU4o0zgn5RX/St279Gl92Cc4rFbzYWlz
	 7KPzkh3Yuj8w26YV5OEOnBDXska9sH1gh7EDpdp4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbfKVF7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 00:59:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:36616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729579AbfKVF57 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 00:57:59 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28BCD20717;
        Fri, 22 Nov 2019 05:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574402279;
        bh=fartVLOhnNSRIT/tr81MwxpOnOPAeQcYz5Tr9R0c+A4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uRuxfQK8Mi96FG++I53fhohHrJZT5Nr+/Gt6DhryIQVaaOotEsEkhTxfhZDidEaaS
         LHSxNjnp4RuXsZSMBVJj+U9yv4Y/cG8GH0eH+dSgdMbilwXQdlqvswCnduGRGyOgst
         PAA8Fx6OwHVoM/CZQYhkxL/K+FxnXtOySuPFiwjw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yunsheng Lin <linyunsheng@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 118/127] net: hns3: Change fw error code NOT_EXEC to NOT_SUPPORTED
Date:   Fri, 22 Nov 2019 00:55:35 -0500
Message-Id: <20191122055544.3299-116-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122055544.3299-1-sashal@kernel.org>
References: <20191122055544.3299-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

[ Upstream commit 4a402f47cfce904051cd8b31bef4fe2910d9dce9 ]

According to firmware error code definition, the error code of 2
means NOT_SUPPORTED, this patch changes it to NOT_SUPPORTED.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c | 2 ++
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
index 8b511e6e0ce9d..396ea0db71023 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
@@ -251,6 +251,8 @@ int hclge_cmd_send(struct hclge_hw *hw, struct hclge_desc *desc, int num)
 			if ((enum hclge_cmd_return_status)desc_ret ==
 			    HCLGE_CMD_EXEC_SUCCESS)
 				retval = 0;
+			else if (desc_ret == HCLGE_CMD_NOT_SUPPORTED)
+				retval = -EOPNOTSUPP;
 			else
 				retval = -EIO;
 			hw->cmq.last_status = (enum hclge_cmd_status)desc_ret;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
index 758cf39481312..3823ae6303ad6 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
@@ -52,7 +52,7 @@ struct hclge_cmq_ring {
 enum hclge_cmd_return_status {
 	HCLGE_CMD_EXEC_SUCCESS	= 0,
 	HCLGE_CMD_NO_AUTH	= 1,
-	HCLGE_CMD_NOT_EXEC	= 2,
+	HCLGE_CMD_NOT_SUPPORTED	= 2,
 	HCLGE_CMD_QUEUE_FULL	= 3,
 };
 
-- 
2.20.1

