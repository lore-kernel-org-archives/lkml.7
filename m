Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2420C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 17:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89E4925EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 17:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559238408;
	bh=MDRHN3oiGSWxzqVI+2qCH0ZE7uUl6PNvpqbyhaqmMNs=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=s4LceXAwQmid0JJtLoqpLe0rVPR6LM7G6IDUBq8QAeTQl4rVDvPQx1QtTCWAn8r8F
	 oRndnukfQxT4loNO489jqhTzvklyYAmbm/fSxhe42aZJQL+jr2XKe/P57VSMMBRq/m
	 DV3jJvkkrzU4G9QldAT3KeDNNrgusUmcM11w4b2o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfE3Rqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 13:46:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:42254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbfE3Rqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 13:46:47 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72F5925EA2;
        Thu, 30 May 2019 17:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559238406;
        bh=MDRHN3oiGSWxzqVI+2qCH0ZE7uUl6PNvpqbyhaqmMNs=;
        h=From:To:Cc:Subject:Date:From;
        b=q9spEw85dT/YRiGo02ciR42KO8dzRxuPW6eXOTPUut8RAP6yYOyas9L1WLzr+47lb
         EN1/ISCYcYJgv1463T3M1pITof9rKfjCPkyJgeF0XU9a9ZPIQHXBAsst7qZFNQSLcl
         shzcqsR02akFR8Mh5AYZghWjwDM0k+yBUz8Uy7ho=
From:   Sasha Levin <sashal@kernel.org>
To:     dmitry.torokhov@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: input: serio: Add a module desription to the hyperv_keyboard driver
Date:   Thu, 30 May 2019 13:46:45 -0400
Message-Id: <20190530174645.18147-1-sashal@kernel.org>
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
 drivers/input/serio/hyperv-keyboard.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/serio/hyperv-keyboard.c b/drivers/input/serio/hyperv-keyboard.c
index a8b9be3e28db7..7935e52b54358 100644
--- a/drivers/input/serio/hyperv-keyboard.c
+++ b/drivers/input/serio/hyperv-keyboard.c
@@ -440,5 +440,7 @@ static void __exit hv_kbd_exit(void)
 }
 
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Microsoft Hyper-V Synthetic Keyboard Driver");
+
 module_init(hv_kbd_init);
 module_exit(hv_kbd_exit);
-- 
2.20.1

