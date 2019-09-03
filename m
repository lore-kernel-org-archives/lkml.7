Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628EFC3A5A5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 06:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4077F20828
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 06:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfICGRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 02:17:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39446 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbfICGRR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 02:17:17 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 04868315C00C;
        Tue,  3 Sep 2019 06:17:17 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-67.ams2.redhat.com [10.36.117.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8ECA060A9F;
        Tue,  3 Sep 2019 06:17:16 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 5037A46D3; Tue,  3 Sep 2019 08:17:15 +0200 (CEST)
Date:   Tue, 3 Sep 2019 08:17:15 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     dri-devel@lists.freedesktop.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        open list <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>, Sean Paul <sean@poorly.run>
Subject: Re: [PATCH 2/5] drm/vram: use drm_gem_ttm_print_info
Message-ID: <20190903061715.5rwdcnt3h77lybi7@sirius.home.kraxel.org>
References: <20190902124126.7700-1-kraxel@redhat.com>
 <20190902124126.7700-3-kraxel@redhat.com>
 <c3cd7018-b7a1-a0e0-c08b-26fbddca1f92@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3cd7018-b7a1-a0e0-c08b-26fbddca1f92@suse.de>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Tue, 03 Sep 2019 06:17:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> > @@ -169,6 +169,7 @@ config DRM_VRAM_HELPER
> >  	tristate
> >  	depends on DRM
> >  	select DRM_TTM
> > +	select DRM_TTM_HELPER
> 
> I thought that VRAM helpers already depend on TTM helpers.

No, they don't.  Patch #1 adds them ;)

cheers,
  Gerd

