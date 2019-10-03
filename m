Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7A0C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 15:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24BEF21D81
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 15:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570118336;
	bh=uJycNw4DL+U+YCISpHKsr1iB52emBHrVSbHwAuMW0VY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eil9BtEJR5K7Gi8AE6iQvKtlyg/kOB3DpS3d7XkszQfkPbiEQ+vmoi0XJ0ziFlQVJ
	 13zhuFohT3Ns/wsW4qwg0WdZGTI/GPCfOQz45aj8HP9hs3MQ+Q2rp5xWEj1LDAFxkv
	 jiTPHSG9TC9hNKXs5ZGjrQENigvZc+RlFawro9Xs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730059AbfJCP6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 11:58:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:41724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728773AbfJCP6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 11:58:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 118E3207FF;
        Thu,  3 Oct 2019 15:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570118330;
        bh=uJycNw4DL+U+YCISpHKsr1iB52emBHrVSbHwAuMW0VY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lp4lHbiLVDStTXKmA8jEarTnlxGJEDsbR8KR2W1jYwqXSDLmc1SGV9fYGOjW/YwGy
         If3+oTnLURSjGNLtsDQkCFWcVh/tcNjzm98zHwOuL3Na9Mh3Mz8iB4+opVtT/Up2vO
         nrHxgozRLRh5GE2VX7UNd+/DGaTTCBUrsHbbfRWY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kevin Easton <kevin@guarana.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>,
        syzbot+98156c174c5a2cad9f8f@syzkaller.appspotmail.com
Subject: [PATCH 4.4 71/99] libertas: Add missing sentinel at end of if_usb.c fw_table
Date:   Thu,  3 Oct 2019 17:53:34 +0200
Message-Id: <20191003154331.703444750@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154252.297991283@linuxfoundation.org>
References: <20191003154252.297991283@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kevin Easton <kevin@guarana.org>

[ Upstream commit 764f3f1ecffc434096e0a2b02f1a6cc964a89df6 ]

This sentinel tells the firmware loading process when to stop.

Reported-and-tested-by: syzbot+98156c174c5a2cad9f8f@syzkaller.appspotmail.com
Signed-off-by: Kevin Easton <kevin@guarana.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/libertas/if_usb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/libertas/if_usb.c b/drivers/net/wireless/libertas/if_usb.c
index dff08a2896a38..d271eaf1f9499 100644
--- a/drivers/net/wireless/libertas/if_usb.c
+++ b/drivers/net/wireless/libertas/if_usb.c
@@ -49,7 +49,8 @@ static const struct lbs_fw_table fw_table[] = {
 	{ MODEL_8388, "libertas/usb8388_v5.bin", NULL },
 	{ MODEL_8388, "libertas/usb8388.bin", NULL },
 	{ MODEL_8388, "usb8388.bin", NULL },
-	{ MODEL_8682, "libertas/usb8682.bin", NULL }
+	{ MODEL_8682, "libertas/usb8682.bin", NULL },
+	{ 0, NULL, NULL }
 };
 
 static struct usb_device_id if_usb_table[] = {
-- 
2.20.1



