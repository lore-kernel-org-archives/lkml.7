Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7654AC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 07:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D81A2133D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 07:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfDIHX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 03:23:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49946 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbfDIHXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 03:23:53 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6F2B3916C4;
        Tue,  9 Apr 2019 07:23:53 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-65.ams2.redhat.com [10.36.116.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 21E7F5C28D;
        Tue,  9 Apr 2019 07:23:53 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 6C09B16E03; Tue,  9 Apr 2019 09:23:52 +0200 (CEST)
Date:   Tue, 9 Apr 2019 09:23:52 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@linux.ie>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: linux-next: manual merge of the drm-misc tree with the drm tree
Message-ID: <20190409072352.2qcuarc76kjgnhkm@sirius.home.kraxel.org>
References: <20190409113410.3d2a8afc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190409113410.3d2a8afc@canb.auug.org.au>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 09 Apr 2019 07:23:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 11:34:10AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the drm-misc tree got conflicts in:
> 
>   drivers/gpu/drm/cirrus/cirrus_drv.h
>   drivers/gpu/drm/cirrus/cirrus_ttm.c
> 
> between commits:
> 
>   aa8e2435b3d4 ("drm/ttm: Define a single DRM_FILE_PAGE_OFFSET constant")
>   7d1500f9fbfc ("drm/ttm: Remove file_page_offset parameter from ttm_bo_device_init()")
>   bed2dd84212e ("drm/ttm: Quick-test mmap offset in ttm_bo_mmap()")
> 
> from the drm tree and commit:
> 
>   ab3e023b1b4c ("drm/cirrus: rewrite and modernize driver.")
> 
> from the drm-misc tree.
> 
> I fixed it up (I just removed the files) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

Ping drm-misc maintainers.  Time to update drm-misc-next with a
backmerge I think?

thanks,
  Gerd

