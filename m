Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D55BC3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 09:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E703B20828
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 09:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387454AbfIEJbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 05:31:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53602 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbfIEJbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 05:31:01 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B39673C917;
        Thu,  5 Sep 2019 09:31:01 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-72.ams2.redhat.com [10.36.117.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 64D5519C69;
        Thu,  5 Sep 2019 09:31:01 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 9C34031E8D; Thu,  5 Sep 2019 11:31:00 +0200 (CEST)
Date:   Thu, 5 Sep 2019 11:31:00 +0200
From:   "kraxel@redhat.com" <kraxel@redhat.com>
To:     Thomas Hellstrom <thellstrom@vmware.com>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        Linux-graphics-maintainer <Linux-graphics-maintainer@vmware.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "airlied@linux.ie" <airlied@linux.ie>
Subject: Re: [PATCH 7/8] drm/vmwgfx: switch to own vma manager
Message-ID: <20190905093100.unhknpzio74oqkmw@sirius.home.kraxel.org>
References: <20190905070509.22407-1-kraxel@redhat.com>
 <20190905070509.22407-8-kraxel@redhat.com>
 <8bec5487c9d698d35297033fe48f6bbd6ad98466.camel@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8bec5487c9d698d35297033fe48f6bbd6ad98466.camel@vmware.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 05 Sep 2019 09:31:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 08:31:34AM +0000, Thomas Hellstrom wrote:
> On Thu, 2019-09-05 at 09:05 +0200, Gerd Hoffmann wrote:
> > Add struct drm_vma_offset_manager to vma_private, initialize it and
> > pass it to ttm_bo_device_init().
> > 
> > With this in place the last user of ttm's embedded vma offset manager
> > is gone and we can remove it (in a separate patch).
> > 
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> >  drivers/gpu/drm/vmwgfx/vmwgfx_drv.h | 1 +
> >  drivers/gpu/drm/vmwgfx/vmwgfx_drv.c | 6 +++++-
> >  2 files changed, 6 insertions(+), 1 deletion(-)
> > 
> > 
> 
> Reviewed-by: Thomas Hellström <thellstrom@vmware.com>
> 
> I assume this will be merged through drm-misc?

Yes, that is the plan (after collecting acks for all drivers).

cheers,
  Gerd

