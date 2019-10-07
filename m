Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CD2C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 21:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 464DB206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 21:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbfJGVtv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 17:49:51 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:51495 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728422AbfJGVtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 17:49:50 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 18757211-1500050 
        for multiple; Mon, 07 Oct 2019 22:49:45 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Colin King <colin.king@canonical.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <157046537209.5063.10118308844290609426@skylake-alporthouse-com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191007154151.23245-1-colin.king@canonical.com>
 <157046537209.5063.10118308844290609426@skylake-alporthouse-com>
Message-ID: <157048498331.8520.2832276261708225981@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH] drm/i915: make array hw_engine_mask static, makes object smaller
Date:   Mon, 07 Oct 2019 22:49:43 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chris Wilson (2019-10-07 17:22:52)
> Quoting Colin King (2019-10-07 16:41:51)
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > Don't populate the array hw_engine_mask on the stack but instead make it
> > static. Makes the object code smaller by 316 bytes.
> > 
> > Before:
> >    text    data     bss     dec     hex filename
> >   34004    4388     320   38712    9738 gpu/drm/i915/gt/intel_reset.o
> > 
> > After:
> >    text    data     bss     dec     hex filename
> >   33528    4548     320   38396    95fc gpu/drm/i915/gt/intel_reset.o
> > 
> > (gcc version 9.2.1, amd64)
> > 
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>

And pushed, thanks for the patch.
-Chris
