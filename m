Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743A5C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B99C206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbfDCPuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 11:50:04 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:52029 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfDCPuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 11:50:00 -0400
X-Originating-IP: 90.88.30.125
Received: from localhost.localdomain (aaubervilliers-681-1-89-125.w90-88.abo.wanadoo.fr [90.88.30.125])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id E6BE01BF207;
        Wed,  3 Apr 2019 15:49:56 +0000 (UTC)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Eben Upton <eben@raspberrypi.org>,
        Daniel Stone <daniel@fooishbar.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH v4 0/4] drm/vc4: Binner BO management improvements
Date:   Wed,  3 Apr 2019 17:48:52 +0200
Message-Id: <20190403154856.9470-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v3:
* Split changes into more commits when possible;
* Reworked binner bo alloc condition as discussed.

Changes since v2:
* Removed deprecated sentence about fristopen;
* Added collected Reviewed-By tags.

Changes since v1:
* Squashed the two final patches into one.

Paul Kocialkowski (4):
  drm/vc4: Reformat and export binner bo allocation helper
  drm/vc4: Check for V3D before binner bo alloc
  drm/vc4: Check for the binner bo before handling OOM interrupt
  drm/vc4: Allocate binner bo when starting to use the V3D

 drivers/gpu/drm/vc4/vc4_bo.c  | 32 ++++++++++++++++++++++++++++++++
 drivers/gpu/drm/vc4/vc4_drv.c |  9 +++++++++
 drivers/gpu/drm/vc4/vc4_drv.h |  5 +++++
 drivers/gpu/drm/vc4/vc4_irq.c |  3 +++
 drivers/gpu/drm/vc4/vc4_v3d.c | 23 ++++++-----------------
 5 files changed, 55 insertions(+), 17 deletions(-)

-- 
2.21.0

