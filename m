Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBFFC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 17:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EEDB2339F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 17:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559237844;
	bh=wQKK3l2c7JjJ2uCsqAXoKCIKXYMc7HnMy5u3awvrXf8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=u3SeYNj68Uw7Qo7ZRZW7kP9wS+5zgmMZK+MUxQxSXR2TwL7HrLRthAkHEmGjMwa0L
	 md2etrW/NXWUvYf9CJxEDBA70LYjpdM/cCyLo2Kdo+pBdZ/rpu2fs9b8ZN44mGbtT/
	 xumFH1xOBvAyaE6n1wQawIQ/KHDScD1WJ5Ms/69k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfE3RhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 13:37:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:34586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726280AbfE3RhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 13:37:23 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1928A20644;
        Thu, 30 May 2019 17:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559237842;
        bh=wQKK3l2c7JjJ2uCsqAXoKCIKXYMc7HnMy5u3awvrXf8=;
        h=From:To:Cc:Subject:Date:From;
        b=oa3E3qmDjpRmKDPLuk/sH2HP689fQrmofARJcxp+7KDU9L0NWKl3OhKgiW+xVM59K
         SSjVEIJ0occnl5Eq3QSR3+ivUHJEQCIg2zeFvlbFqfjUCouZgLciAKd43mYbxApF97
         ldy5w4CFO5MEGDcor9cDiycGJ5FiOz7ggvOYK4v4=
From:   Sasha Levin <sashal@kernel.org>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: hid: Add a module description line to the hid_hyperv driver
Date:   Thu, 30 May 2019 13:37:20 -0400
Message-Id: <20190530173720.17994-1-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joseph Salisbury <Joseph.Salisbury@microsoft.com>

This patch only adds a MODULE_DESCRIPTION statement to the driver.
This change is only cosmetic, so there should be no runtime impact.

Signed-off-by: Joseph Salisbury <joseph.salisbury@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-hyperv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
index 704049e62d58a..d3311d714d359 100644
--- a/drivers/hid/hid-hyperv.c
+++ b/drivers/hid/hid-hyperv.c
@@ -614,5 +614,7 @@ static void __exit mousevsc_exit(void)
 }
 
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Microsoft Hyper-V Synthetic HID Driver");
+
 module_init(mousevsc_init);
 module_exit(mousevsc_exit);
-- 
2.20.1

