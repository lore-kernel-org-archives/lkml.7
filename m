Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC9AC32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 21:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA18E2186A
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 21:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389482AbfHGVdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 17:33:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:23399 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730138AbfHGVdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 17:33:18 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BD4753DE02;
        Wed,  7 Aug 2019 21:33:17 +0000 (UTC)
Received: from whitewolf.redhat.com (ovpn-121-222.rdu2.redhat.com [10.10.121.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ECA21600C6;
        Wed,  7 Aug 2019 21:33:13 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     "Daniel Vetter" <daniel@ffwll.ch>,
        "David Airlie" <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, "Ben Skeggs" <bskeggs@redhat.com>,
        "Lyude Paul" <lyude@redhat.com>,
        "Laurent Pinchart" <laurent.pinchart@ideasonboard.com>,
        "Karol Herbst" <karolherbst@gmail.com>,
        "Ilia Mirkin" <imirkin@alum.mit.edu>
Subject: [PATCH 0/2] drm/nouveau: CRTC Runtime PM ref tracking fixes
Date:   Wed,  7 Aug 2019 17:32:59 -0400
Message-Id: <20190807213304.9255-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 07 Aug 2019 21:33:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just some runtime PM fixes for some much less noticeable runtime PM ref
tracking issues that I got reminded of when fixing some unrelated issues
with nouveau.

Lyude Paul (2):
  drm/nouveau/dispnv04: Grab/put runtime PM refs on DPMS on/off
  drm/nouveau/dispnv50: Fix runtime PM ref tracking for non-blocking
    modesets

 drivers/gpu/drm/nouveau/dispnv04/crtc.c | 18 +++---------
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 38 +++++++++++--------------
 drivers/gpu/drm/nouveau/nouveau_drv.h   |  3 --
 3 files changed, 21 insertions(+), 38 deletions(-)

-- 
2.21.0

