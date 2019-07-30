Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53C2C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73BE4208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388486AbfG3SqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:46:02 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42946 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387744AbfG3Sp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:45:59 -0400
Received: from floko.floko.floko (unknown [IPv6:2804:431:c7f1:ce2f:ec1:e6e6:2e9f:e76e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: koike)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id A508728B911;
        Tue, 30 Jul 2019 19:45:53 +0100 (BST)
From:   Helen Koike <helen.koike@collabora.com>
To:     linux-rockchip@lists.infradead.org
Cc:     devicetree@vger.kernel.org, eddie.cai.linux@gmail.com,
        mchehab@kernel.org, heiko@sntech.de, jacob2.chen@rock-chips.com,
        jeffy.chen@rock-chips.com, zyc@rock-chips.com,
        linux-kernel@vger.kernel.org, tfiga@chromium.org,
        hans.verkuil@cisco.com, laurent.pinchart@ideasonboard.com,
        sakari.ailus@linux.intel.com, kernel@collabora.com,
        ezequiel@collabora.com, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, zhengsq@rock-chips.com,
        Helen Koike <helen.koike@collabora.com>
Subject: [PATCH v8 14/14] MAINTAINERS: add entry for Rockchip ISP1 driver
Date:   Tue, 30 Jul 2019 15:42:56 -0300
Message-Id: <20190730184256.30338-15-helen.koike@collabora.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190730184256.30338-1-helen.koike@collabora.com>
References: <20190730184256.30338-1-helen.koike@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MAINTAINERS entry for the rockchip isp1 driver.

Signed-off-by: Helen Koike <helen.koike@collabora.com>
---

Changes in v8: None
Changes in v7: None

 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6426db5198f0..7f38abcb4114 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13743,6 +13743,14 @@ F:	drivers/hid/hid-roccat*
 F:	include/linux/hid-roccat*
 F:	Documentation/ABI/*/sysfs-driver-hid-roccat*
 
+ROCKCHIP ISP V1 DRIVER
+M:	Helen Koike <helen.koike@collabora.com>
+L:	linux-media@vger.kernel.org
+S:	Maintained
+F:	drivers/media/platform/rockchip/isp1/
+F:	Documentation/devicetree/bindings/media/rockchip-isp1.txt
+F:	Documentation/devicetree/bindings/media/rockchip-mipi-dphy.txt
+
 ROCKCHIP RASTER 2D GRAPHIC ACCELERATION UNIT DRIVER
 M:	Jacob chen <jacob2.chen@rock-chips.com>
 L:	linux-media@vger.kernel.org
-- 
2.22.0

