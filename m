Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BC2C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 16:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96F3D20835
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 16:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Mjz2Fcb3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbfCQQtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 12:49:07 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:37248 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfCQQtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 12:49:06 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4A82923A;
        Sun, 17 Mar 2019 17:49:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1552841344;
        bh=KOaFVh+xYTBEqvvpZgomjr9iED43Z4IqL1UfkpzDs0o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mjz2Fcb3O9kIVyzK/Im5M0r77hdJGqjIrOtu3O6YUQIAmyppHhum2f3PQsyWRE6d/
         wUmvfogPHgHqeyY8YjqZDqvr9fcHZIMSvSJ2imG9HBuBzgjvzqt8Rv987jqQqsbpS6
         WvEZaUEv7Y8fqkGbjSnbjWUmyaIyTN1UOET6cX4o=
Date:   Sun, 17 Mar 2019 18:48:56 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     linux-renesas-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] drm: rcar-du: Cleanup minor CRTC issues
Message-ID: <20190317164856.GG17898@pendragon.ideasonboard.com>
References: <20190314220420.32487-1-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190314220420.32487-1-kieran.bingham+renesas@ideasonboard.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

Thank you for the patches.

On Thu, Mar 14, 2019 at 10:04:17PM +0000, Kieran Bingham wrote:
> Three fairly trivial cleanup patches from while I've been working on the CRTC
> code on rcar-du.
> 
> The first is a small spelling error in the drm_crtc_state documentation, and
> the following two are more directly cleaning up the rcar-du.
> 
> Kieran Bingham (3):
>   drm: fix subtle spelling error in drm_crtc_state
>   drm: rcar-du: crtc: make local functions static
>   drm: rcar-du: Remove unused prototypes

For the whole series:

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

and taken in my tree.

>  drivers/gpu/drm/rcar-du/rcar_du_crtc.c | 9 +++++----
>  drivers/gpu/drm/rcar-du/rcar_du_crtc.h | 2 --
>  include/drm/drm_crtc.h                 | 2 +-
>  3 files changed, 6 insertions(+), 7 deletions(-)

-- 
Regards,

Laurent Pinchart
