Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A12CFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79948217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729377AbfC2K6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 06:58:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56378 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727788AbfC2K6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 06:58:18 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 49932308620F;
        Fri, 29 Mar 2019 10:58:18 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-18.ams2.redhat.com [10.36.116.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E142860852;
        Fri, 29 Mar 2019 10:58:17 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 04944A1E0; Fri, 29 Mar 2019 11:58:16 +0100 (CET)
Date:   Fri, 29 Mar 2019 11:58:16 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] drm/atomic-helper: Make atomic_enable/disable crtc
 callbacks optional
Message-ID: <20190329105816.5mru5gcvjoxrtuhp@sirius.home.kraxel.org>
References: <20190314184845.gjmvkamobj4dilyp@smtp.gmail.com>
 <20190315110031.GY2665@phenom.ffwll.local>
 <20190325112906.p4zfgom3by3f2zu4@smtp.gmail.com>
 <20190326075003.GH2665@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326075003.GH2665@phenom.ffwll.local>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 29 Mar 2019 10:58:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 08:50:03AM +0100, Daniel Vetter wrote:
> On Mon, Mar 25, 2019 at 08:29:06AM -0300, Rodrigo Siqueira wrote:
> > On 03/15, Daniel Vetter wrote:
> > > On Thu, Mar 14, 2019 at 03:48:45PM -0300, Rodrigo Siqueira wrote:
> > > > Allow atomic_enable and atomic_disable operations from
> > > > drm_crtc_helper_funcs struct optional. With this, the target display
> > > > drivers don't need to define a dummy function if they don't need one.
> > > > 
> > > > Changes since v2:
> > > > * Don't make funcs optional
> > > > * Update kerneldoc for atomic_enable/disable
> > > > * Replace "if (funcs->atomic_enable)" by "if (funcs->commit)"
> > > > * Improve commit message
> > > > 
> > > > Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> > > 
> > > Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > 
> > Hi,
> > Is it ok if I apply this patch?
> 
> Sure.
> -Daniel

Hmm, seems to not be applied yet.  Pushed to drm-misc-fixes.

cheers,
  Gerd

