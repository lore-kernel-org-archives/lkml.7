Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59330C00307
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 09:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 338BA2086D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 09:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbfIIJng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 05:43:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49822 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbfIIJnf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 05:43:35 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A7085191C68A;
        Mon,  9 Sep 2019 09:43:35 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-59.ams2.redhat.com [10.36.117.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 448AC6012A;
        Mon,  9 Sep 2019 09:43:35 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 5AF6716E19; Mon,  9 Sep 2019 11:43:34 +0200 (CEST)
Date:   Mon, 9 Sep 2019 11:43:34 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     "Koenig, Christian" <Christian.Koenig@amd.com>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Huang, Ray" <Ray.Huang@amd.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 8/8] drm/ttm: remove embedded vma_offset_manager
Message-ID: <20190909094334.w6jlsxs7w4kto4u4@sirius.home.kraxel.org>
References: <20190905070509.22407-1-kraxel@redhat.com>
 <20190905070509.22407-9-kraxel@redhat.com>
 <d276f21e-fa03-aa68-4bf7-b154a7dc3e2e@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d276f21e-fa03-aa68-4bf7-b154a7dc3e2e@amd.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.70]); Mon, 09 Sep 2019 09:43:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 09, 2019 at 07:02:33AM +0000, Koenig, Christian wrote:
> Am 05.09.19 um 09:05 schrieb Gerd Hoffmann:
> > No users left.  Drivers either setup vma_offset_manager themself
> > (vmwgfx) or pass the gem vma_offset_manager to ttm_bo_device_init
> > (all other drivers).
> >
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> 
> Patches #4, #5 and #8 in this series are Reviewed-by: Christian König 
> <christian.koenig@amd.com>
> 
> I can't see the rest in my inbox anywhere. Have you send all of them to 
> dri-devel?

Yes, they are all on dri-devel, but only a subset is Cc'ed to you.
Patches 2-7 switch drivers one-by-one, and I guess you only got the
ones where you are listed as driver maintainer/reviewer in MAINTAINERS.

cheers,
  Gerd

