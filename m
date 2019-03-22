Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D0B8C10F03
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5747821841
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbfCVPuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:50:04 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:47715 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfCVPuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:50:04 -0400
Received: from wuerfel.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mhl8Y-1gTv0W3b4S-00djqU; Fri, 22 Mar 2019 16:49:32 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [BACKPORT 4.4.y 22/25] usb: renesas_usbhs: gadget: fix unused-but-set-variable warning
Date:   Fri, 22 Mar 2019 16:44:13 +0100
Message-Id: <20190322154425.3852517-23-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190322154425.3852517-1-arnd@arndb.de>
References: <20190322154425.3852517-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:1zbLgMJ6UdcfbbLrnAhs0F7V3us4vKTcxOwFmyGU0N/10ybZgRE
 ED53FIXpRAfBiH0ccO5Eu4NWKKW1FG1fcV7qbnsKjkz3rEKK8To833eGkRCIDJ8il+83nKz
 WeOJIqYfc2n8dB+r24eOPo5mRlXJYKm28MkAL7vF2nI8+H0pFsvuirU5DGCXnsxPoFHlAuD
 6xYM7LU5e5oap8/2dt7rg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Yla2KSO6I3c=:Kh9bpEPu/6xf11vu+oSgdr
 n+vvitCcc4b1sUH8dDiQNX70t3EzOwA/0QK0qvzdK6Y+qZbPSq/rLUnFnqgKNrUzXokYEjgmV
 gPBv+yliIQq8ds2TePkdEl9Pmz5eOOiq8N93FUuEvlQbsRn9Y79Z23krIrervGjHBHyv0Lukb
 cqQ8zQiE1ojm7ev7Jr4jd8AndKEcBAmsBGrBR35byduKUlVVXoU2/iWCIasUuwuSsIA5Xtx6+
 kvb5RbfbPE8WJYwBjbmmNmk7Rrwqr+ynGFVbLX9nwW0hw6N5AkwBahu1FUbJ/M0oZ4pnPn2rM
 1EjETdjtSiBMFaguUF8WxAuX1U76TfNfzvIbjT06eqKS2hLBlUxsYP4zuPRTCNUjyt9FjucXO
 mXwWr/bp5SIhM101OdP3j5fpR2snI0fNGYBK+CY8mteaun0QZ6V+R/1skH5woPFVNR4IgGh9I
 qQHfPzP8iPdXxy0Li8ympIWfbspwedhNmpo0uM7pshOCQk1yxrLgl3HPmHPSdSuISJxZjWsZ2
 Xe5guXDv+k4u4ENNqKMLqrM+LpoB0q9/nTdskdsBY5cvTDDzDs9rejocQirvUl/IV+HMrGW6r
 6DMe+zTngq+JVRIv9r19wzJ/LeLt54Vx2W82WpX+soJ28BgDrrxFcs86zGJyZ2Eth7SjGrqBP
 0gcJTC5hatKT6F88rL5ECfoKoOGMIy9erdCKFuKRiFB+8o7HXBUZQPvO3mu4Tjobc/28pHp65
 JvgamV00R9JFwb3XR3ntwc8cithK/9ZLLFjKsw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

The commit b8b9c974afee ("usb: renesas_usbhs: gadget: disable all eps
when the driver stops") causes the unused-but-set-variable warning.
But, if the usbhsg_ep_disable() will return non-zero value, udc/core.c
doesn't clear the ep->enabled flag. So, this driver should not return
non-zero value, if the pipe is zero because this means the pipe is
already disabled. Otherwise, the ep->enabled flag is never cleared
when the usbhsg_ep_disable() is called by the renesas_usbhs driver first.

Fixes: b8b9c974afee ("usb: renesas_usbhs: gadget: disable all eps when the driver stops")
Fixes: 11432050f070 ("usb: renesas_usbhs: gadget: fix NULL pointer dereference in ep_disable()")
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
(cherry picked from commit b7d44c36a6f6d956e1539e0dd42f98b26e5a4684)
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/renesas_usbhs/mod_gadget.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/usb/renesas_usbhs/mod_gadget.c b/drivers/usb/renesas_usbhs/mod_gadget.c
index 8647d2c2a8c4..c5553028e616 100644
--- a/drivers/usb/renesas_usbhs/mod_gadget.c
+++ b/drivers/usb/renesas_usbhs/mod_gadget.c
@@ -641,14 +641,11 @@ static int usbhsg_ep_disable(struct usb_ep *ep)
 	struct usbhsg_uep *uep = usbhsg_ep_to_uep(ep);
 	struct usbhs_pipe *pipe;
 	unsigned long flags;
-	int ret = 0;
 
 	spin_lock_irqsave(&uep->lock, flags);
 	pipe = usbhsg_uep_to_pipe(uep);
-	if (!pipe) {
-		ret = -EINVAL;
+	if (!pipe)
 		goto out;
-	}
 
 	usbhsg_pipe_disable(uep);
 	usbhs_pipe_free(pipe);
-- 
2.20.0

