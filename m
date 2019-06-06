Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C58BC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 15:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDE2E20868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 15:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729556AbfFFPzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 11:55:50 -0400
Received: from 6.mo2.mail-out.ovh.net ([87.98.165.38]:60478 "EHLO
        6.mo2.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728871AbfFFPzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 11:55:49 -0400
X-Greylist: delayed 598 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Jun 2019 11:55:48 EDT
Received: from player697.ha.ovh.net (unknown [10.108.57.49])
        by mo2.mail-out.ovh.net (Postfix) with ESMTP id BCCE719E396
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2019 17:39:41 +0200 (CEST)
Received: from armadeus.com (lfbn-1-7591-179.w90-126.abo.wanadoo.fr [90.126.248.179])
        (Authenticated sender: sebastien.szymanski@armadeus.com)
        by player697.ha.ovh.net (Postfix) with ESMTPSA id 20984697A803;
        Thu,  6 Jun 2019 15:39:22 +0000 (UTC)
From:   =?UTF-8?q?S=C3=A9bastien=20Szymanski?= 
        <sebastien.szymanski@armadeus.com>
To:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-media@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        =?UTF-8?q?S=C3=A9bastien=20Szymanski?= 
        <sebastien.szymanski@armadeus.com>
Subject: [PATCH v2 3/3] media: dt-bindings: imx7-csi: add i.MX6UL/L support
Date:   Thu,  6 Jun 2019 17:38:25 +0200
Message-Id: <20190606153825.8183-3-sebastien.szymanski@armadeus.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190606153825.8183-1-sebastien.szymanski@armadeus.com>
References: <20190606153825.8183-1-sebastien.szymanski@armadeus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 3728136069398615236
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudeggedgledvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document "fsl,imx6ul-csi" entry.

Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
---

Changes for v2:
 - New patch to document new "fsl,imx6ul-csi" entry.

 Documentation/devicetree/bindings/media/imx7-csi.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/media/imx7-csi.txt b/Documentation/devicetree/bindings/media/imx7-csi.txt
index 3c07bc676bc3..49e9af19b3ea 100644
--- a/Documentation/devicetree/bindings/media/imx7-csi.txt
+++ b/Documentation/devicetree/bindings/media/imx7-csi.txt
@@ -9,7 +9,7 @@ to connect directly to external CMOS image sensors.
 
 Required properties:
 
-- compatible    : "fsl,imx7-csi";
+- compatible    : "fsl,imx7-csi" or "fsl,imx6ul-csi";
 - reg           : base address and length of the register set for the device;
 - interrupts    : should contain CSI interrupt;
 - clocks        : list of clock specifiers, see
-- 
2.19.2

