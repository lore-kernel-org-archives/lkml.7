Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B53C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F39CA2183F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbfC1QN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:13:28 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:51477 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbfC1QN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 12:13:28 -0400
Received: from localhost.localdomain (aaubervilliers-681-1-91-136.w90-88.abo.wanadoo.fr [90.88.32.136])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 39E5924000F;
        Thu, 28 Mar 2019 16:13:24 +0000 (UTC)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Eric Anholt <eric@anholt.net>,
        Eben Upton <eben@raspberrypi.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH v3 0/2] drm/vc4: Binner BO management improvements
Date:   Thu, 28 Mar 2019 17:13:04 +0100
Message-Id: <20190328161306.22757-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v2:
* Removed deprecated sentence about fristopen;
* Added collected Reviewed-By tags.

Changes since v1:
* Squashed the two final patches into one.

Paul Kocialkowski (2):
  drm/file: Rehabilitate the firstopen hook for non-legacy drivers
  drm/vc4: Allocated/liberate the binner BO at firstopen/lastclose

 drivers/gpu/drm/drm_file.c    |  3 +--
 drivers/gpu/drm/vc4/vc4_drv.c | 26 ++++++++++++++++++++++++++
 drivers/gpu/drm/vc4/vc4_drv.h |  1 +
 drivers/gpu/drm/vc4/vc4_irq.c |  3 +++
 drivers/gpu/drm/vc4/vc4_v3d.c | 15 +--------------
 include/drm/drm_drv.h         |  3 ---
 6 files changed, 32 insertions(+), 19 deletions(-)

-- 
2.21.0

