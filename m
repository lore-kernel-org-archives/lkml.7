Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C12E7C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9155720674
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575413747;
	bh=u0pEInAzhM+Of0cRAEW1Duv+Swgvq9rgar9zk6OYqZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qgHQUu/0ddnvEwTogRNsHcwCqOESx0ufa6n0YmvJgkshBFnuuZ5nfnatFdj/+b2BX
	 520S4f/cmjci+v3eXi87BGiW1ZRuMGi2NvcQ3KKuhAeIgWp34bPUbqK5eSA0agkcxr
	 83wJ2/33XfKT7DCaZoP00MVKG/27a4nyKanVgao8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729646AbfLCWzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:55:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:50262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730191AbfLCWzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:55:44 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4008B2053B;
        Tue,  3 Dec 2019 22:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575413743;
        bh=u0pEInAzhM+Of0cRAEW1Duv+Swgvq9rgar9zk6OYqZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Db5ydlGOBS4B8dgxElwXhdoxcsKUd1jo65rE14xQrz00O0X3VG41DMFWKFvVE1EaE
         saOa7pn0S9q/FXsvL5OR1uMrPtRn4u+R/ZlNych3bJTEa/TLA1Cqea0Ruj/D6Pjwub
         KC0ndgzF2yR07Y7ksN9U3tocw69IGw/FqiDOIBdU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yunsheng Lin <linyunsheng@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 244/321] net: hns3: Change fw error code NOT_EXEC to NOT_SUPPORTED
Date:   Tue,  3 Dec 2019 23:35:10 +0100
Message-Id: <20191203223439.834119609@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203223427.103571230@linuxfoundation.org>
References: <20191203223427.103571230@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 690f62ed87dca..09a4d87429cea 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
@@ -260,6 +260,8 @@ int hclge_cmd_send(struct hclge_hw *hw, struct hclge_desc *desc, int num)
 
 			if (desc_ret == HCLGE_CMD_EXEC_SUCCESS)
 				retval = 0;
+			else if (desc_ret == HCLGE_CMD_NOT_SUPPORTED)
+				retval = -EOPNOTSUPP;
 			else
 				retval = -EIO;
 			hw->cmq.last_status = desc_ret;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
index 821d4c2f84bd3..d7520686509fd 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
@@ -39,7 +39,7 @@ struct hclge_cmq_ring {
 enum hclge_cmd_return_status {
 	HCLGE_CMD_EXEC_SUCCESS	= 0,
 	HCLGE_CMD_NO_AUTH	= 1,
-	HCLGE_CMD_NOT_EXEC	= 2,
+	HCLGE_CMD_NOT_SUPPORTED	= 2,
 	HCLGE_CMD_QUEUE_FULL	= 3,
 };
 
-- 
2.20.1



