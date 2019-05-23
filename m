Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0546C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 10:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EED42081C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 10:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730251AbfEWKNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 06:13:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54372 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726429AbfEWKNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 06:13:40 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A10687FDFF;
        Thu, 23 May 2019 10:13:38 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-101.ams2.redhat.com [10.36.116.101])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 204021001E6F;
        Thu, 23 May 2019 10:13:38 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 0008F16E08; Thu, 23 May 2019 12:13:36 +0200 (CEST)
Date:   Thu, 23 May 2019 12:13:36 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" 
        <virtualization@lists.linux-foundation.org>,
        Dave Airlie <airlied@redhat.com>
Subject: Re: [PATCH] drm/cirrus: remove leftover files
Message-ID: <20190523101336.thknzetzyx3j6sa7@sirius.home.kraxel.org>
References: <20190522103307.12711-1-kraxel@redhat.com>
 <20190522150634.GA26677@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522150634.GA26677@ravnborg.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 23 May 2019 10:13:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 05:06:34PM +0200, Sam Ravnborg wrote:
> On Wed, May 22, 2019 at 12:33:07PM +0200, Gerd Hoffmann wrote:
> > cirrus_drv.h and cirrus_ttm.c are unused since commit ab3e023b1b4c
> > ("drm/cirrus: rewrite and modernize driver"), apparently I ran "rm"
> > instead of "git rm" on them so they are still in present the tree.
> > 
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> 
> Always nice with the code removal patches.
> Will you apply yourself?

Yes.

thanks,
  Gerd

