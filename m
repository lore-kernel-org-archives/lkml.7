Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E23C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 18:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8A1820705
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 18:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730284AbgAHSqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 13:46:49 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59916 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730250AbgAHSqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 13:46:46 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: koike)
        with ESMTPSA id A5F8829131A
From:   Helen Koike <helen.koike@collabora.com>
To:     linux-rockchip@lists.infradead.org
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        eddie.cai.linux@gmail.com, mchehab@kernel.org, heiko@sntech.de,
        gregkh@linuxfoundation.org, andrey.konovalov@linaro.org,
        linux-kernel@vger.kernel.org, tfiga@chromium.org,
        robh+dt@kernel.org, hans.verkuil@cisco.com,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        joacim.zetterling@gmail.com, kernel@collabora.com,
        ezequiel@collabora.com, linux-media@vger.kernel.org,
        jacob-chen@iotwrt.com, linux-arm-kernel@lists.infradead.org,
        Helen Koike <helen.koike@collabora.com>
Subject: [PATCH v13 11/11] MAINTAINERS: add entry for Rockchip ISP1 driver
Date:   Wed,  8 Jan 2020 15:44:54 -0300
Message-Id: <20200108184454.825725-12-helen.koike@collabora.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200108184454.825725-1-helen.koike@collabora.com>
References: <20200108184454.825725-1-helen.koike@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MAINTAINERS entry for the rockchip isp1 driver.

Signed-off-by: Helen Koike <helen.koike@collabora.com>

---

Changes in v13: None
Changes in v12: None
Changes in v11: None
Changes in v10: None
Changes in v9:
- Move to staging

Changes in v8: None
Changes in v7: None

 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 87f3d89d44a2..5ed1287cbb1c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14117,6 +14117,12 @@ F:	drivers/hid/hid-roccat*
 F:	include/linux/hid-roccat*
 F:	Documentation/ABI/*/sysfs-driver-hid-roccat*
 
+ROCKCHIP ISP V1 DRIVER
+M:	Helen Koike <helen.koike@collabora.com>
+L:	linux-media@vger.kernel.org
+S:	Maintained
+F:	drivers/staging/media/rkisp1/
+
 ROCKCHIP RASTER 2D GRAPHIC ACCELERATION UNIT DRIVER
 M:	Jacob Chen <jacob-chen@iotwrt.com>
 M:	Ezequiel Garcia <ezequiel@collabora.com>
-- 
2.24.0

