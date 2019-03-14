Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF050C10F06
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7815D20854
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="hL5caiKC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbfCNWE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 18:04:28 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:58524 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbfCNWE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 18:04:27 -0400
Received: from Q.home (cpc85428-aztw29-2-0-cust223.18-1.cable.virginm.net [82.38.144.224])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1FE3531C;
        Thu, 14 Mar 2019 23:04:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1552601065;
        bh=ntGQrEGiZvFjVkrEnllKcuJUJORdnkm5UhhS/7AHqLs=;
        h=From:To:Cc:Subject:Date:From;
        b=hL5caiKC4uRDjp9ihOKkIAvg96gfKxq9DlZIxnUghteoI5HDBl4FhXJzCT8I0iSop
         jwQK9ydS84J1rCQeV5OCyW6ECJem8rSWR7cTKg9WRvsXHAPrjDdF4CI4x73b8GxJh5
         J6vHpTI5nSblsBeHrfKawQrIyd6K1um94N3lSD7Q=
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
To:     linux-renesas-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>
Cc:     linux-kernel@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Subject: [PATCH 0/3] drm: rcar-du: Cleanup minor CRTC issues
Date:   Thu, 14 Mar 2019 22:04:17 +0000
Message-Id: <20190314220420.32487-1-kieran.bingham+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Three fairly trivial cleanup patches from while I've been working on the CRTC
code on rcar-du.

The first is a small spelling error in the drm_crtc_state documentation, and
the following two are more directly cleaning up the rcar-du.

Kieran Bingham (3):
  drm: fix subtle spelling error in drm_crtc_state
  drm: rcar-du: crtc: make local functions static
  drm: rcar-du: Remove unused prototypes

 drivers/gpu/drm/rcar-du/rcar_du_crtc.c | 9 +++++----
 drivers/gpu/drm/rcar-du/rcar_du_crtc.h | 2 --
 include/drm/drm_crtc.h                 | 2 +-
 3 files changed, 6 insertions(+), 7 deletions(-)

-- 
2.19.1

