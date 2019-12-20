Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CF6C2D0C0
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 07:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1BF224679
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 07:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfLTHfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 02:35:23 -0500
Received: from smtp25.cstnet.cn ([159.226.251.25]:33806 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725941AbfLTHfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 02:35:21 -0500
X-Greylist: delayed 792 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Dec 2019 02:33:15 EST
Received: from localhost.localdomain (unknown [159.226.5.100])
        by APP-05 (Coremail) with SMTP id zQCowACXAaENdvxdzOzbAw--.612S3;
        Fri, 20 Dec 2019 15:19:42 +0800 (CST)
From:   Xu Wang <vulab@iscas.ac.cn>
To:     gregkh@linuxfoundation.org
Cc:     pawell@cadence.com, balbi@kernel.org, peter.chen@nxp.com,
        rogerq@ti.com, colin.king@canonical.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: cdns3: gadget: Remove unneeded variable ret
Date:   Fri, 20 Dec 2019 07:19:38 +0000
Message-Id: <1576826378-4387-1-git-send-email-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: zQCowACXAaENdvxdzOzbAw--.612S3
X-Coremail-Antispam: 1UD129KBjvdXoWrKFyDJF4rKw43KrW7Xr4UCFg_yoWfAFc_Cr
        109r17Wa4qq3s8Cw1UC3W3G34vk3WDX3WkXFs7Kry3AFyUt34xZryUArWkCFyUZr4UGF1D
        Cw1xKFZrCF93JjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbw8YjsxI4VWDJwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC2
        0s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
        0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
        14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20x
        vaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
        6r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j8GYLUUUUU=
X-Originating-IP: [159.226.5.100]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgMKA10Teec3MgAAsZ
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unneeded variable ret used to store return value,just return 0.

Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
---
 drivers/usb/cdns3/gadget.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
index 4c1e755..73b75a3 100644
--- a/drivers/usb/cdns3/gadget.c
+++ b/drivers/usb/cdns3/gadget.c
@@ -2389,7 +2389,6 @@ static int cdns3_gadget_udc_stop(struct usb_gadget *gadget)
 	struct cdns3_endpoint *priv_ep;
 	u32 bEndpointAddress;
 	struct usb_ep *ep;
-	int ret = 0;
 	int val;
 
 	priv_dev->gadget_driver = NULL;
@@ -2413,7 +2412,7 @@ static int cdns3_gadget_udc_stop(struct usb_gadget *gadget)
 	writel(0, &priv_dev->regs->usb_ien);
 	writel(USB_CONF_DEVDS, &priv_dev->regs->usb_conf);
 
-	return ret;
+	return 0;
 }
 
 static const struct usb_gadget_ops cdns3_gadget_ops = {
-- 
2.7.4

