Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD886C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 09:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D71820C01
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 09:18:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfEGJSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 05:18:04 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.114]:55720 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726505AbfEGJSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 05:18:03 -0400
Received: from [85.158.142.200] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-b.eu-central-1.aws.symcld.net id BB/A7-24742-84D41DC5; Tue, 07 May 2019 09:18:00 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIIsWRWlGSWpSXmKPExsUyo1hfUtfd92K
  MwYEpBhbH2p6wWzQvXs9mcXnXHDaLRctamR1YPDat6mTz2D93DbvH501yAcxRrJl5SfkVCawZ
  Z7dNYyw4qVXx7dpJpgbGpSpdjFwcQgJrGCU2vX/L2sXIwcEmoCvRdce0i5GTQ0RAXmLW24uMI
  DXMAvMZJY41djCDJIQFrCT6n21gB7FZBFQkfp78zQhi8wo4Six9tBusRkJATuLmuU5miLigxM
  mZT1hAbGYBCYmDL14wg+wSEpCVOHopFqJcQeLslomMExh5ZiHpmIWkYwEj0ypGi6SizPSMktz
  EzBxdQwMDXUNDY11TXWNjvcQq3SS91FLd5NS8kqJEoKReYnmxXnFlbnJOil5easkmRmDQpRSy
  Ku5gnLM8/RCjJAeTkiiviP3FGCG+pPyUyozE4oz4otKc1OJDjDIcHEoSvHXeQDnBotT01Iq0z
  Bxg+MOkJTh4lER440HSvMUFibnFmekQqVOMilLivNwgCQGQREZpHlwbLOYuMcpKCfMyMjAwCP
  EUpBblZpagyr9iFOdgVBLmrQKZwpOZVwI3/RXQYiagxfM6zoEsLklESEk1MMrX7an8zrRCQeH
  TYp1r0n62wQ3fRJ7d3TfRzO7uTM5OFUX/0v5Vy0/xeb4Kzjz13Oj3BX1xh1/ypi8scvWXWE89
  Ys2bZ3HcbXFC/bmgzkMN3feuGG9RMn7PcCIjR+mB7fJAwdtvyl0OyLin6ZcrrJ8ruVCQizfh/
  bzgR0/99u3edszk03N/byWW4oxEQy3mouJEANHTAp60AgAA
X-Env-Sender: cst@phaseone.com
X-Msg-Ref: server-22.tower-245.messagelabs.com!1557220679!5904377!1
X-Originating-IP: [152.115.47.25]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 978 invoked from network); 7 May 2019 09:17:59 -0000
Received: from unknown (HELO Exchange2.phaseone.com) (152.115.47.25)
  by server-22.tower-245.messagelabs.com with AES256-SHA encrypted SMTP; 7 May 2019 09:17:59 -0000
Received: from cstu16.phaseone.com (172.16.2.207) by Exchange2.phaseone.com
 (172.16.1.180) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 7 May
 2019 11:17:58 +0200
From:   "Claus H. Stovgaard" <cst@phaseone.com>
To:     <linux-usb@vger.kernel.org>
CC:     "Claus H. Stovgaard" <cst@phaseone.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] usb: gadget: configfs: Add lpm_Ux_disable
Date:   Tue, 7 May 2019 11:09:43 +0200
Message-ID: <1557220655-123090-1-git-send-email-cst@phaseone.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.2.207]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When combining dwc3 with an redriver for a USB Type-C device solution, it
sometimes have problems with leaving U1/U2 for certain hosts, resulting in
link training errors and reconnects. This create an interface via
configfs for disabling U1/U2, enabling a workaround for devices based on
dwc3.

Signed-off-by: Claus H. Stovgaard <cst@phaseone.com>
---
 drivers/usb/dwc3/ep0.c        |  9 ++++++-
 drivers/usb/gadget/configfs.c | 56 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/usb/gadget.h    |  6 ++++-
 3 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 8efde17..5b2d26b 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -379,6 +379,8 @@ static int dwc3_ep0_handle_u1(struct dwc3 *dwc, enum usb_device_state state,
 	if ((dwc->speed != DWC3_DSTS_SUPERSPEED) &&
 			(dwc->speed != DWC3_DSTS_SUPERSPEED_PLUS))
 		return -EINVAL;
+	if (dwc->gadget_driver->lpm_U1_disable)
+		return -EINVAL;
 
 	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
 	if (set)
@@ -401,6 +403,8 @@ static int dwc3_ep0_handle_u2(struct dwc3 *dwc, enum usb_device_state state,
 	if ((dwc->speed != DWC3_DSTS_SUPERSPEED) &&
 			(dwc->speed != DWC3_DSTS_SUPERSPEED_PLUS))
 		return -EINVAL;
+	if (dwc->gadget_driver->lpm_U2_disable)
+		return -EINVAL;
 
 	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
 	if (set)
@@ -626,7 +630,10 @@ static int dwc3_ep0_set_config(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 			 * nothing is pending from application.
 			 */
 			reg = dwc3_readl(dwc->regs, DWC3_DCTL);
-			reg |= (DWC3_DCTL_ACCEPTU1ENA | DWC3_DCTL_ACCEPTU2ENA);
+			if (!dwc->gadget_driver->lpm_U1_disable)
+				reg |= DWC3_DCTL_ACCEPTU1ENA;
+			if (!dwc->gadget_driver->lpm_U2_disable)
+				reg |= DWC3_DCTL_ACCEPTU2ENA;
 			dwc3_writel(dwc->regs, DWC3_DCTL, reg);
 		}
 		break;
diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
index 0251299..2ee9d10 100644
--- a/drivers/usb/gadget/configfs.c
+++ b/drivers/usb/gadget/configfs.c
@@ -229,6 +229,56 @@ static ssize_t gadget_dev_desc_bcdUSB_store(struct config_item *item,
 	return len;
 }
 
+static ssize_t gadget_dev_desc_lpm_U1_disable_show(struct config_item *item,
+		char *page)
+{
+	struct gadget_info *gi = to_gadget_info(item);
+
+	return sprintf(page, "%d\n",
+		       gi->composite.gadget_driver.lpm_U1_disable);
+}
+
+static ssize_t gadget_dev_desc_lpm_U1_disable_store(struct config_item *item,
+		const char *page, size_t len)
+{
+	struct gadget_info *gi = to_gadget_info(item);
+	bool disable;
+	int ret;
+
+	ret = strtobool(page, &disable);
+	if (!ret) {
+		gi->composite.gadget_driver.lpm_U1_disable = disable;
+		ret = len;
+	}
+
+	return ret;
+}
+
+static ssize_t gadget_dev_desc_lpm_U2_disable_show(struct config_item *item,
+		char *page)
+{
+	struct gadget_info *gi = to_gadget_info(item);
+
+	return sprintf(page, "%d\n",
+		       gi->composite.gadget_driver.lpm_U2_disable);
+}
+
+static ssize_t gadget_dev_desc_lpm_U2_disable_store(struct config_item *item,
+		const char *page, size_t len)
+{
+	struct gadget_info *gi = to_gadget_info(item);
+	bool disable;
+	int ret;
+
+	ret = strtobool(page, &disable);
+	if (!ret) {
+		gi->composite.gadget_driver.lpm_U2_disable = disable;
+		ret = len;
+	}
+
+	return ret;
+}
+
 static ssize_t gadget_dev_desc_UDC_show(struct config_item *item, char *page)
 {
 	char *udc_name = to_gadget_info(item)->composite.gadget_driver.udc_name;
@@ -299,6 +349,8 @@ CONFIGFS_ATTR(gadget_dev_desc_, idVendor);
 CONFIGFS_ATTR(gadget_dev_desc_, idProduct);
 CONFIGFS_ATTR(gadget_dev_desc_, bcdDevice);
 CONFIGFS_ATTR(gadget_dev_desc_, bcdUSB);
+CONFIGFS_ATTR(gadget_dev_desc_, lpm_U1_disable);
+CONFIGFS_ATTR(gadget_dev_desc_, lpm_U2_disable);
 CONFIGFS_ATTR(gadget_dev_desc_, UDC);
 
 static struct configfs_attribute *gadget_root_attrs[] = {
@@ -310,6 +362,8 @@ static struct configfs_attribute *gadget_root_attrs[] = {
 	&gadget_dev_desc_attr_idProduct,
 	&gadget_dev_desc_attr_bcdDevice,
 	&gadget_dev_desc_attr_bcdUSB,
+	&gadget_dev_desc_attr_lpm_U1_disable,
+	&gadget_dev_desc_attr_lpm_U2_disable,
 	&gadget_dev_desc_attr_UDC,
 	NULL,
 };
@@ -1408,6 +1462,8 @@ static const struct usb_gadget_driver configfs_driver_template = {
 		.name		= "configfs-gadget",
 	},
 	.match_existing_only = 1,
+	.lpm_U1_disable = 0,
+	.lpm_U2_disable = 0,
 };
 
 static struct config_group *gadgets_make(
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 7595056..25fe72b 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -619,7 +619,9 @@ static inline int usb_gadget_activate(struct usb_gadget *gadget)
  *	this driver will be bound to any available UDC.
  * @pending: UDC core private data used for deferred probe of this driver.
  * @match_existing_only: If udc is not found, return an error and don't add this
- *      gadget driver to list of pending driver
+ *      gadget driver to list of pending driver.
+ * @lpm_U1_disable: Instruct the UDC to disable U1 if possible.
+ * @lpm_U2_disable: Instruct the UDC to disable U2 if possible.
  *
  * Devices are disabled till a gadget driver successfully bind()s, which
  * means the driver will handle setup() requests needed to enumerate (and
@@ -684,6 +686,8 @@ struct usb_gadget_driver {
 	char			*udc_name;
 	struct list_head	pending;
 	unsigned                match_existing_only:1;
+	unsigned		lpm_U1_disable:1;
+	unsigned		lpm_U2_disable:1;
 };
 
 
-- 
2.7.4

