Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3326C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B9A520857
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbfCKNjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:39:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44594 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727388AbfCKNjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:39:21 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 63E123082E6A;
        Mon, 11 Mar 2019 13:39:21 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-175.ams2.redhat.com [10.36.117.175])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 146C860CBC;
        Mon, 11 Mar 2019 13:39:21 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id E2CF117532; Mon, 11 Mar 2019 14:39:19 +0100 (CET)
Date:   Mon, 11 Mar 2019 14:39:19 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bochs: Fix NULL dereference on atomic_disable helper
Message-ID: <20190311133919.azyhtioxf23duf3g@sirius.home.kraxel.org>
References: <20190310212150.xhhb4abzm7j3ain2@smtp.gmail.com>
 <20190311062200.4mtel3j5fjxtxrcf@sirius.home.kraxel.org>
 <20190311101159.t6mbzm5sdwuh5muc@smtp.gmail.com>
 <20190311130716.6hjqci43clic5lxx@sirius.home.kraxel.org>
 <20190311132358.GF2665@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311132358.GF2665@phenom.ffwll.local>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Mon, 11 Mar 2019 13:39:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> > IIRC the drm code checks for the atomic_enable callback presence to
> > figure whenever it should take the atomic or legacy code paths.
> 
> It should check for drm_driver->mode_config.funcs.atomic_commit for that,
> see drm_drv_uses_atomic_modeset(). Anything else should be a bug.
> 
> Or do you mean the fallback to the old crtc helper prepare/commit
> callbacks?

Probably the later.  There was some reason why I've left in the empty
bochs_crtc_atomic_enable() callback ...

cheers,
  Gerd

