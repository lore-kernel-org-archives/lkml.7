Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D36C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7B5E20643
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbfDSS7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:59:15 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:36382 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728542AbfDSS7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:59:14 -0400
Received: from relay10.mail.gandi.net (unknown [217.70.178.230])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id D101C3A501E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 09:04:42 +0000 (UTC)
Received: from aptenodytes (aaubervilliers-681-1-42-238.w90-88.abo.wanadoo.fr [90.88.160.238])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id A1BC024000E;
        Fri, 19 Apr 2019 09:04:41 +0000 (UTC)
Message-ID: <2f50f2a610a0870e43abfcdc35fc8255b6273590.camel@bootlin.com>
Subject: Re: [git pull] drm fixes for 5.1-rc6
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Dave Airlie <airlied@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Fri, 19 Apr 2019 11:04:41 +0200
In-Reply-To: <CAPM=9twvtLWe=Z8uMHG47H7NSSYQWEpD+yvs-Dt-FMzcZMZpCg@mail.gmail.com>
References: <CAPM=9twvtLWe=Z8uMHG47H7NSSYQWEpD+yvs-Dt-FMzcZMZpCg@mail.gmail.com>
Organization: Bootlin
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2019-04-18 at 13:40 +1000, Dave Airlie wrote:
> Since Easter is looming for me, I'm just pushing whatever is in my
> tree, I'll see what else turns up and maybe I'll send another pull
> early next week if there is anything.

Note that I submitted some drm/sun4i fixes which looked trivial and got
merged to drm-misc fixes yesterday, but there is a call order issue
there that I missed. I sent out a fixup for it earlier today, so it
would be good to include it along with the initial fixes before the
next PR.

The fixup is at: https://patchwork.freedesktop.org/patch/300883/

Just to be perfectly clear: it doesn't affect this PR, we just need to
be careful about the next one.

Cheers and sorry for the inconvenience,

Paul

> tegra:
> - stream id programming fix
> - avoid divide by 0 for bad hdmi audio setup code
> 
> ttm:
> - Hugepages fix
> - refcount imbalance in error path fix
> 
> amdgpu:
> - GPU VM fixes for Vega/RV
> - DC AUX fix for active DP-DVI dongles
> - DC fix for multihead regression.
> 
> Dave.
> 
> drm-fixes-2019-04-18:
> drm tegra, amdgpu fixes
> The following changes since commit dc4060a5dc2557e6b5aa813bf5b73677299d62d2:
> 
>   Linux 5.1-rc5 (2019-04-14 15:17:41 -0700)
> 
> are available in the Git repository at:
> 
>   git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-04-18
> 
> for you to fetch changes up to 00fd14ff3017f64a9a03a08291e4be0d87bedc17:
> 
>   Merge branch 'drm-fixes-5.1' of
> git://people.freedesktop.org/~agd5f/linux into drm-fixes (2019-04-18
> 06:56:35 +1000)
> 
> ----------------------------------------------------------------
> drm tegra, amdgpu fixes
> 
> ----------------------------------------------------------------
> Alex Deucher (1):
>       drm/amdgpu/gmc9: fix VM_L2_CNTL3 programming
> 
> Arnd Bergmann (1):
>       gpu: host1x: Program stream ID to bypass without SMMU
> 
> Christian König (3):
>       drm/ttm: fix out-of-bounds read in ttm_put_pages() v2
>       drm/ttm: fix start page for huge page check in ttm_put_pages()
>       drm/ttm: fix incrementing the page pointer for huge pages
> 
> Dave Airlie (2):
>       Merge tag 'drm/tegra/for-5.1-rc6' of
> git://anongit.freedesktop.org/tegra/linux into drm-fixes
>       Merge branch 'drm-fixes-5.1' of
> git://people.freedesktop.org/~agd5f/linux into drm-fixes
> 
> David Francis (1):
>       drm/amd/display: If one stream full updates, full update all planes
> 
> Lin Yi (1):
>       drm/ttm: fix dma_fence refcount imbalance on error path
> 
> Martin Leung (1):
>       drm/amd/display: extending AUX SW Timeout
> 
> Thierry Reding (1):
>       drm/tegra: hdmi: Setup audio only if configured
> 
> wentalou (1):
>       drm/amdgpu: shadow in shadow_list without tbo.mem.start cause
> page fault in sriov TDR
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   |  1 +
>  drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c      |  1 +
>  drivers/gpu/drm/amd/display/dc/core/dc.c     | 19 +++++++++++++++++++
>  drivers/gpu/drm/amd/display/dc/dc.h          |  3 +++
>  drivers/gpu/drm/amd/display/dc/dce/dce_aux.c |  9 ++++++---
>  drivers/gpu/drm/amd/display/dc/dce/dce_aux.h |  6 +++---
>  drivers/gpu/drm/tegra/hdmi.c                 | 12 +++++++++---
>  drivers/gpu/drm/ttm/ttm_bo.c                 |  4 +++-
>  drivers/gpu/drm/ttm/ttm_page_alloc.c         | 13 +++++++------
>  drivers/gpu/host1x/hw/channel_hw.c           |  8 ++++++--
>  10 files changed, 58 insertions(+), 18 deletions(-)
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

