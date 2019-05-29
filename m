Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F61C072B1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 02:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8B2521721
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 02:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbfE2CyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 22:54:18 -0400
Received: from mga09.intel.com ([134.134.136.24]:64361 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726557AbfE2CyR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 22:54:17 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 May 2019 19:54:17 -0700
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 28 May 2019 19:54:15 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hVojG-000Iee-HW; Wed, 29 May 2019 10:54:14 +0800
Date:   Wed, 29 May 2019 10:54:02 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Zhongzhu Liu <liuzhongzhu@huawei.com>
Cc:     kbuild-all@01.org, netdev@vger.kernel.org,
        Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Weihang Li <liweihang@hisilicon.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next] net: hns3: hclge_dbg_get_m7_stats_info() can be
 static
Message-ID: <20190529025402.GA14936@lkp-kbuild18>
References: <201905291024.VVfliT6e%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201905291024.VVfliT6e%lkp@intel.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 33a90e2f20e6 ("net: hns3: add support for dump firmware statistics by debugfs")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 hclge_debugfs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
index ed1f533..4fbed47a 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
@@ -921,7 +921,7 @@ static void hclge_dbg_dump_rst_info(struct hclge_dev *hdev)
 		 hdev->rst_stats.reset_cnt);
 }
 
-void hclge_dbg_get_m7_stats_info(struct hclge_dev *hdev)
+static void hclge_dbg_get_m7_stats_info(struct hclge_dev *hdev)
 {
 	struct hclge_desc *desc_src, *desc_tmp;
 	struct hclge_get_m7_bd_cmd *req;
