Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7FECA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 15:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 567EF2064A
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 15:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503225AbfJXP2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 11:28:36 -0400
Received: from baptiste.telenet-ops.be ([195.130.132.51]:47606 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503214AbfJXP2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 11:28:35 -0400
Received: from ramsan ([84.195.182.253])
        by baptiste.telenet-ops.be with bizsmtp
        id HTUa210095USYZQ01TUa4M; Thu, 24 Oct 2019 17:28:34 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iNf2Q-00078Q-2o; Thu, 24 Oct 2019 17:28:34 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iNf2Q-0007zr-0n; Thu, 24 Oct 2019 17:28:34 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Li Yang <leoyang.li@nxp.com>, Felipe Balbi <balbi@kernel.org>,
        Bin Liu <b-liu@ti.com>, Jiri Kosina <trivial@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH trivial] usb: Spelling s/enpoint/endpoint/
Date:   Thu, 24 Oct 2019 17:28:33 +0200
Message-Id: <20191024152833.30698-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix misspellings of "endpoint".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/usb/dwc2/core.h             | 2 +-
 drivers/usb/gadget/udc/fsl_qe_udc.h | 4 ++--
 drivers/usb/gadget/udc/mv_u3d.h     | 2 +-
 drivers/usb/musb/musb_gadget.c      | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
index d08d070a0fb6f598..968e03b89d04d5d8 100644
--- a/drivers/usb/dwc2/core.h
+++ b/drivers/usb/dwc2/core.h
@@ -134,7 +134,7 @@ struct dwc2_hsotg_req;
  * @target_frame: Targeted frame num to setup next ISOC transfer
  * @frame_overrun: Indicates SOF number overrun in DSTS
  *
- * This is the driver's state for each registered enpoint, allowing it
+ * This is the driver's state for each registered endpoint, allowing it
  * to keep track of transactions that need doing. Each endpoint has a
  * lock to protect the state, to try and avoid using an overall lock
  * for the host controller as much as possible.
diff --git a/drivers/usb/gadget/udc/fsl_qe_udc.h b/drivers/usb/gadget/udc/fsl_qe_udc.h
index 2c537a904ee73950..53ca0ff7c2cbd48c 100644
--- a/drivers/usb/gadget/udc/fsl_qe_udc.h
+++ b/drivers/usb/gadget/udc/fsl_qe_udc.h
@@ -333,8 +333,8 @@ struct qe_udc {
 	u32 resume_state;       /* USB state to resume*/
 	u32 usb_state;          /* USB current state */
 	u32 usb_next_state;     /* USB next state */
-	u32 ep0_state;          /* Enpoint zero state */
-	u32 ep0_dir;            /* Enpoint zero direction: can be
+	u32 ep0_state;          /* Endpoint zero state */
+	u32 ep0_dir;            /* Endpoint zero direction: can be
 				USB_DIR_IN or USB_DIR_OUT*/
 	u32 usb_sof_count;      /* SOF count */
 	u32 errors;             /* USB ERRORs count */
diff --git a/drivers/usb/gadget/udc/mv_u3d.h b/drivers/usb/gadget/udc/mv_u3d.h
index 982625b7197a0d9c..66b84f792f646bb9 100644
--- a/drivers/usb/gadget/udc/mv_u3d.h
+++ b/drivers/usb/gadget/udc/mv_u3d.h
@@ -138,7 +138,7 @@ struct mv_u3d_op_regs {
 	u32	doorbell;	/* doorbell register */
 };
 
-/* control enpoint enable registers */
+/* control endpoint enable registers */
 struct epxcr {
 	u32	epxoutcr0;	/* ep out control 0 register */
 	u32	epxoutcr1;	/* ep out control 1 register */
diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index 2cb31fc0cd601eb4..f62ffaede1abba48 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -1315,7 +1315,7 @@ static int musb_gadget_dequeue(struct usb_ep *ep, struct usb_request *request)
 }
 
 /*
- * Set or clear the halt bit of an endpoint. A halted enpoint won't tx/rx any
+ * Set or clear the halt bit of an endpoint. A halted endpoint won't tx/rx any
  * data but will queue requests.
  *
  * exported to ep0 code
-- 
2.17.1

