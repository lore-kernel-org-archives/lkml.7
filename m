Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5578ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 12:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92CCA2064B
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 12:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405174AbfJQMaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 08:30:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46922 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727054AbfJQMaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 08:30:20 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BCDAE308FFB1;
        Thu, 17 Oct 2019 12:30:20 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-43.ams2.redhat.com [10.36.116.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6356E1001DF0;
        Thu, 17 Oct 2019 12:30:20 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 74FB316E2D; Thu, 17 Oct 2019 14:30:19 +0200 (CEST)
Date:   Thu, 17 Oct 2019 14:30:19 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     "Koenig, Christian" <Christian.Koenig@amd.com>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "Huang, Ray" <Ray.Huang@amd.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 06/11] drm/ttm: factor out ttm_bo_mmap_vma_setup
Message-ID: <20191017123019.ovnexoryrziwkj7d@sirius.home.kraxel.org>
References: <20191016115203.20095-1-kraxel@redhat.com>
 <20191016115203.20095-7-kraxel@redhat.com>
 <c08921f8-8ae9-55aa-c472-6b660b96576b@amd.com>
 <398f5818-296d-67cc-2447-d3075187bf0c@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <398f5818-296d-67cc-2447-d3075187bf0c@amd.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 17 Oct 2019 12:30:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 11:06:33AM +0000, Koenig, Christian wrote:
> Am 16.10.19 um 14:18 schrieb Christian König:
> > Am 16.10.19 um 13:51 schrieb Gerd Hoffmann:
> >> Factor out ttm vma setup to a new function.
> >> Reduces code duplication a bit.
> >>
> >> v2: don't change vm_flags (moved to separate patch).
> >> v4: make ttm_bo_mmap_vma_setup static.
> >>
> >> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> >
> > Reviewed-by: Christian König <christian.koenig@amd.com> for this one 
> > and #7 in the series.
> 
> Any objections that I add these two to my drm-ttm-next pull request or 
> did you wanted to merge that through some other tree?

Pushed series to drm-misc-next a few minutes ago (before I saw your mail).

cheers,
  Gerd

