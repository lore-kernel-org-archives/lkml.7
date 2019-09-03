Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCBB1C3A5A5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 06:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB1FA215EA
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 06:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfICGUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 02:20:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59974 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbfICGUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 02:20:54 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5110C10C6964;
        Tue,  3 Sep 2019 06:20:54 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-67.ams2.redhat.com [10.36.117.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 01DE65D6B7;
        Tue,  3 Sep 2019 06:20:54 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id C038A783D; Tue,  3 Sep 2019 08:20:52 +0200 (CEST)
Date:   Tue, 3 Sep 2019 08:20:52 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     dri-devel@lists.freedesktop.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        open list <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>, Sean Paul <sean@poorly.run>
Subject: Re: [PATCH 3/5] drm/vram: add vram-mm debugfs file
Message-ID: <20190903062052.nn57achxfkvnpysr@sirius.home.kraxel.org>
References: <20190902124126.7700-1-kraxel@redhat.com>
 <20190902124126.7700-4-kraxel@redhat.com>
 <2110d38c-1793-a5c9-921c-94ccfe2205cb@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2110d38c-1793-a5c9-921c-94ccfe2205cb@suse.de>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.65]); Tue, 03 Sep 2019 06:20:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> > +++ b/include/drm/drm_gem_vram_helper.h
> > @@ -123,6 +123,7 @@ int drm_gem_vram_driver_dumb_mmap_offset(struct drm_file *file,
> >   * &struct drm_driver with default functions.
> >   */
> >  #define DRM_GEM_VRAM_DRIVER \
> > +	.debugfs_init             = drm_vram_mm_debugfs_init, \
> 
> > +int drm_vram_mm_debugfs_init(struct drm_minor *minor);
> 
> I cannot find a caller of this function. Will this be called form
> drm_debugfs_init()?

Yes, via drm_driver->debugfs_init which is set above.

cheers,
  Gerd

