Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BEF1C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 14:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 735B52080D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 14:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731507AbgAIOHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 09:07:48 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:53028 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728280AbgAIOHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 09:07:48 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id F3CB580487;
        Thu,  9 Jan 2020 15:07:43 +0100 (CET)
Date:   Thu, 9 Jan 2020 15:07:42 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Tobias Schramm <t.schramm@manjaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND 0/1] Add support for BOE NV140FHM-N49 panel to
 panel-simple
Message-ID: <20200109140742.GA12940@ravnborg.org>
References: <20200109112952.2620-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109112952.2620-1-t.schramm@manjaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=7gkXJVJtAAAA:8
        a=pGLkceISAAAA:8 a=rveBo4_EAAAA:8 a=mlv0boLxdgtSJDfOXe4A:9
        a=CjuIK1q_8ugA:10 a=E9Po1WZjFZOl8hwRPBS3:22 a=HW1wDYKO1DgdHvS0FfdB:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tobias.

We need binding schema before we can apply this patch.
See patch below.
Please review/ack the patch, then we can process your panel-simple
patch.

	Sam

On Thu, Jan 09, 2020 at 12:29:51PM +0100, Tobias Schramm wrote:
> This patch adds support for the 14 inch BOE NV140FHM-N49 eDP panel to
> the panel-simple driver. The panel is used by the Pinebook Pro.
> 
> Resending with changed CCs due to lack of feedback.


> 
> Tobias Schramm (1):
>   drm/panel: Add support for BOE NV140FHM-N49 panel to panel-simple
> 
>  drivers/gpu/drm/panel/panel-simple.c | 35 ++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
From ad19c4636475bb05ba5c0b6cec2bee85045d628e Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 9 Jan 2020 14:48:41 +0100
Subject: [PATCH] dt-bindings: display: add BOE 14" panel

Add bindings for the BOE NV140FHM-N49 14" 1920x1080 panel.

The panel is used by the pine64 Pinebook Pro.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Tobias Schramm <t.schramm@manjaro.org>
---
 .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index ddc00480b6fe..6c098a0b6e1e 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -35,6 +35,8 @@ properties:
       - ampire,am800480r3tmqwa1h
         # AUO B116XAK01 eDP TFT LCD panel
       - auo,b116xa01
+        # BOE NV140FHM-N49 14.0" FHD a-Si FT panel
+      - boe,nv140fhmn49
         # GiantPlus GPM940B0 3.0" QVGA TFT LCD panel
       - giantplus,gpm940b0
         # Sharp LS020B1DD01D 2.0" HQVGA TFT LCD panel
-- 
2.20.1

