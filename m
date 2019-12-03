Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A829C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB4F120684
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575412809;
	bh=CFbyICVMg0BGL5eCOv0DJz8yDGSEwWUHhTT7v4gPrhY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vW4184cSFLoBGpuk2t5OptQDkwXsiR7j83HDcqDMYw3FaWLYhbS5n1TkyhxqwwH3x
	 /lL23v7n81Cg4yeMMuiokqV527m9kMwQyuluNeAYBVYO1V59QuHpJsdjkudTb/kNIn
	 MT/HJepyad6AW1zRCEoJiLCGQH0LqFDMRBpXDPYI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbfLCWkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:40:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:51726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728347AbfLCWkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:40:06 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8161F2080A;
        Tue,  3 Dec 2019 22:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575412806;
        bh=CFbyICVMg0BGL5eCOv0DJz8yDGSEwWUHhTT7v4gPrhY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lBQhtJLpDOj8tDNldMM1I7Au9ZmEfrWI/Kl9jMi1aaaF9fuqBuGnl7k/uJr7a+tRw
         rAa11On9Z2FQMxxGNNsoZw9BFnx1ifCRx2RbX44rZEq+Iwz0gBACqX+EqEUhplSpHr
         dNbap9K/CZk4/iwGdZurYy50VpfBRCnbCJtaMBLE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 023/135] reset: fix reset_control_ops kerneldoc comment
Date:   Tue,  3 Dec 2019 23:34:23 +0100
Message-Id: <20191203213010.195456013@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203213005.828543156@linuxfoundation.org>
References: <20191203213005.828543156@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit f430c7ed8bc22992ed528b518da465b060b9223f ]

Add a missing short description to the reset_control_ops documentation.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
[p.zabel@pengutronix.de: rebased and updated commit message]
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/reset-controller.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/reset-controller.h b/include/linux/reset-controller.h
index 9326d671b6e6c..8675ec64987bb 100644
--- a/include/linux/reset-controller.h
+++ b/include/linux/reset-controller.h
@@ -7,7 +7,7 @@
 struct reset_controller_dev;
 
 /**
- * struct reset_control_ops
+ * struct reset_control_ops - reset controller driver callbacks
  *
  * @reset: for self-deasserting resets, does all necessary
  *         things to reset the device
-- 
2.20.1



