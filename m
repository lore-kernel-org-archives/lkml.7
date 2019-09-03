Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D04FC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E807123789
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567528066;
	bh=0JIc5Xd51Cvq9nD6MJO5pe1/yMiw9hOTdQiacZjbLt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QjE0OJ8YlDWy+m8ZKWySWQXWMpVu8PP8RywKQ3ydP/PaotFKSAO4jZLnTOPLCd/D5
	 l6IGwLu8LyNVv/5Jvqm3l85zI6aAKBWEHHv4Qr1yJJpRFpU0S5r4npWfN/w7qDRITR
	 EoPTDuJjB5VqiDr9RCcgmZC+6Cci5XhWevjHz7X8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730508AbfICQ1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 12:27:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:49026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730464AbfICQ1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 12:27:37 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E26512343A;
        Tue,  3 Sep 2019 16:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567528056;
        bh=0JIc5Xd51Cvq9nD6MJO5pe1/yMiw9hOTdQiacZjbLt8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KvEWwP2E9ocMniCmIzwUVTnlrtf6ekAW34+oRPV7uVXRUnrcaiAsUmVtaT7FCfU1s
         qlZ7H2LcWE6G0Cy2kCxbSBwRZQZpDL7YVJiCvLyH9SKGUtVe1Ibqb/d23uKnRW2SP/
         qRxTb47AADs8l3aI9gLQfm5LHfNDulKQExbkg9L8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ihab Zhaika <ihab.zhaika@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 072/167] iwlwifi: add new card for 9260 series
Date:   Tue,  3 Sep 2019 12:23:44 -0400
Message-Id: <20190903162519.7136-72-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190903162519.7136-1-sashal@kernel.org>
References: <20190903162519.7136-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ihab Zhaika <ihab.zhaika@intel.com>

[ Upstream commit 3941310cf665b8a7965424d2a185c80782faa030 ]

Add one PCI ID for 9260 series.

CC: <stable@vger.kernel.org> # 4.14+
Signed-off-by: Ihab Zhaika <ihab.zhaika@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index d3a1c13bcf6f1..0982bd99b1c3c 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -601,6 +601,7 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0x2526, 0x2030, iwl9560_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x2526, 0x2034, iwl9560_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x2526, 0x4010, iwl9260_2ac_cfg)},
+	{IWL_PCI_DEVICE(0x2526, 0x4018, iwl9260_2ac_cfg)},
 	{IWL_PCI_DEVICE(0x2526, 0x4030, iwl9560_2ac_cfg)},
 	{IWL_PCI_DEVICE(0x2526, 0x4034, iwl9560_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x2526, 0x40A4, iwl9460_2ac_cfg)},
-- 
2.20.1

