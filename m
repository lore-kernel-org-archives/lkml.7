Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248DDC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE0F9216F4
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565127968;
	bh=JRxs4CjZsR9Mwk1SkqyAGfhLAqxCj8GtLVUw0Wj+tr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ECVETUPPkhX5TTYvh0rfbienE6U17uDYN6HFG4/eAwDoTu90gFUWmI6LplIdSv1Ce
	 QiDQLUGjlsCc68DpjLJGDxJssXVPZmuuDWXZWB4m6vrf7k76n9Jok5WsdhgjlJHphp
	 Ks412YxqYlJJbwbiLrPLtu/S3lp/bDugdC4zBotM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbfHFVqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 17:46:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:51400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727088AbfHFVdf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 17:33:35 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B4E4216F4;
        Tue,  6 Aug 2019 21:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565127214;
        bh=JRxs4CjZsR9Mwk1SkqyAGfhLAqxCj8GtLVUw0Wj+tr8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mdftATFeAVABEVh2zaeYcT9dtkRN15z3Sg7hWUO9IErS5dsVQqm9vy1PdDOx84pWM
         i391tVwoz6qbVX0JCOFCsh4tlN1DIgRxp84ll4+Zg2AM6qMrby7osSSN1Jh5kK/fNx
         QRWdi+kyCDuf5T0K2rRVzyUy3ntPEO/F66L+0ALw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     YueHaibing <yuehaibing@huawei.com>, Hulk Robot <hulkci@huawei.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.2 11/59] xen/pciback: remove set but not used variable 'old_state'
Date:   Tue,  6 Aug 2019 17:32:31 -0400
Message-Id: <20190806213319.19203-11-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190806213319.19203-1-sashal@kernel.org>
References: <20190806213319.19203-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit 09e088a4903bd0dd911b4f1732b250130cdaffed ]

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/xen/xen-pciback/conf_space_capability.c: In function pm_ctrl_write:
drivers/xen/xen-pciback/conf_space_capability.c:119:25: warning:
 variable old_state set but not used [-Wunused-but-set-variable]

It is never used so can be removed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/xen/xen-pciback/conf_space_capability.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/xen/xen-pciback/conf_space_capability.c b/drivers/xen/xen-pciback/conf_space_capability.c
index 73427d8e01161..e5694133ebe57 100644
--- a/drivers/xen/xen-pciback/conf_space_capability.c
+++ b/drivers/xen/xen-pciback/conf_space_capability.c
@@ -116,13 +116,12 @@ static int pm_ctrl_write(struct pci_dev *dev, int offset, u16 new_value,
 {
 	int err;
 	u16 old_value;
-	pci_power_t new_state, old_state;
+	pci_power_t new_state;
 
 	err = pci_read_config_word(dev, offset, &old_value);
 	if (err)
 		goto out;
 
-	old_state = (pci_power_t)(old_value & PCI_PM_CTRL_STATE_MASK);
 	new_state = (pci_power_t)(new_value & PCI_PM_CTRL_STATE_MASK);
 
 	new_value &= PM_OK_BITS;
-- 
2.20.1

