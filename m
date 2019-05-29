Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840D1C04AB3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 07:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66090206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 07:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfE2Ho1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 03:44:27 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:28951 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726101AbfE2HoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 03:44:20 -0400
X-UUID: bc3961119c6541f0ade61bc3d020d143-20190529
X-UUID: bc3961119c6541f0ade61bc3d020d143-20190529
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 660837579; Wed, 29 May 2019 15:44:13 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 29 May 2019 15:44:11 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 29 May 2019 15:44:10 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Li Jun <jun.li@nxp.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Min Guo <min.guo@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Biju Das <biju.das@bp.renesas.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Yu Chen <chenyu56@huawei.com>
Subject: [PATCH v6 04/10] dt-bindings: usb: mtu3: add properties about USB Role Switch
Date:   Wed, 29 May 2019 15:43:42 +0800
Message-ID: <1559115828-19146-5-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1559115828-19146-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1559115828-19146-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now the USB Role Switch is supported, so add properties about it,
and modify some description related.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
v4 no changes

v5 changes:
 1. modify decription about extcon and vbus-supply properties
 2. make this patch depend on [1]

 [1]: [v3] dt-binding: usb: add usb-role-switch property
      https://patchwork.kernel.org/patch/10934835/

v4 no changes
v3 no changes

v2 changes:
  1. fix typo
  2. refer new binding about connector property
---
 .../devicetree/bindings/usb/mediatek,mtu3.txt          | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtu3.txt b/Documentation/devicetree/bindings/usb/mediatek,mtu3.txt
index 3382b5cb471d..3a8300205cdb 100644
--- a/Documentation/devicetree/bindings/usb/mediatek,mtu3.txt
+++ b/Documentation/devicetree/bindings/usb/mediatek,mtu3.txt
@@ -28,8 +28,13 @@ Optional properties:
 	parent's address space
  - extcon : external connector for vbus and idpin changes detection, needed
 	when supports dual-role mode.
+	it's considered valid for compatibility reasons, not allowed for
+	new bindings, and use "usb-role-switch" property instead.
  - vbus-supply : reference to the VBUS regulator, needed when supports
 	dual-role mode.
+	it's considered valid for compatibility reasons, not allowed for
+	new bindings, and put into a usb-connector node.
+	see connector/usb-connector.txt.
  - pinctrl-names : a pinctrl state named "default" is optional, and need be
 	defined if auto drd switch is enabled, that means the property dr_mode
 	is set as "otg", and meanwhile the property "mediatek,enable-manual-drd"
@@ -39,6 +44,8 @@ Optional properties:
 
  - maximum-speed : valid arguments are "super-speed", "high-speed" and
 	"full-speed"; refer to usb/generic.txt
+ - usb-role-switch : use USB Role Switch to support dual-role switch, but
+	not extcon; see usb/generic.txt.
  - enable-manual-drd : supports manual dual-role switch via debugfs; usually
 	used when receptacle is TYPE-A and also wants to support dual-role
 	mode.
@@ -61,6 +68,9 @@ The xhci should be added as subnode to mtu3 as shown in the following example
 if host mode is enabled. The DT binding details of xhci can be found in:
 Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.txt
 
+The port would be added as subnode if use "usb-role-switch" property.
+	see graph.txt
+
 Example:
 ssusb: usb@11271000 {
 	compatible = "mediatek,mt8173-mtu3";
-- 
2.21.0

