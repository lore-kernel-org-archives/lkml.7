Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E2BC3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 21:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DAC9205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 21:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732707AbfHOV2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 17:28:22 -0400
Received: from mail.bugwerft.de ([46.23.86.59]:36394 "EHLO mail.bugwerft.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730302AbfHOV2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 17:28:21 -0400
Received: from localhost.localdomain (pD95EF8C6.dip0.t-ipconnect.de [217.94.248.198])
        by mail.bugwerft.de (Postfix) with ESMTPSA id B914029B85B;
        Thu, 15 Aug 2019 21:24:17 +0000 (UTC)
From:   Daniel Mack <daniel@zonque.org>
To:     gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Mack <daniel@zonque.org>
Subject: [PATCH v2 2/2] uio: Documentation: Add information on using uio_pdrv_genirq with DT
Date:   Thu, 15 Aug 2019 23:28:07 +0200
Message-Id: <20190815212807.25058-2-daniel@zonque.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190815212807.25058-1-daniel@zonque.org>
References: <20190815212807.25058-1-daniel@zonque.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a paragraph to describe the use of the "of_id" module parameter,
along with the new DT property.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 Documentation/driver-api/uio-howto.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/driver-api/uio-howto.rst b/Documentation/driver-api/uio-howto.rst
index 25f50eace28b..b9f28641ddf0 100644
--- a/Documentation/driver-api/uio-howto.rst
+++ b/Documentation/driver-api/uio-howto.rst
@@ -408,6 +408,13 @@ handler code. You also do not need to know anything about the chip's
 internal registers to create the kernel part of the driver. All you need
 to know is the irq number of the pin the chip is connected to.
 
+When used in a device-tree enabled system, the driver needs to be
+probed with the ``"of_id"`` module parameter set to the ``"compatible"``
+string of the node the driver is supposed to handle. By default, the
+node's name (without the unit address) is exposed as name for the
+UIO device in userspace. To set a custom name, a property named
+``"linux,uio-name"`` may be specified in the DT node.
+
 Using uio_dmem_genirq for platform devices
 ------------------------------------------
 
-- 
2.21.0

