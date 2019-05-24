Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D9A3C282E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 21:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74035217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 21:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404372AbfEXVpQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 17:45:16 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:50350 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2404237AbfEXVpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 17:45:16 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 16674029-1500050 
        for multiple; Fri, 24 May 2019 22:45:08 +0100
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
In-Reply-To: <20190524212627.24256-1-colin.king@canonical.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190524212627.24256-1-colin.king@canonical.com>
Message-ID: <155873430650.6190.1054401334708975483@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH][next] drm/i915/gtt: set err to -ENOMEM on memory allocation
 failure
Date:   Fri, 24 May 2019 22:45:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Colin King (2019-05-24 22:26:27)
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently when the allocation of ppgtt->work fails the error return
> path via err_free returns an uninitialized value in err. Fix this
> by setting err to the appropriate error return of -ENOMEM.
> 
> Addresses-Coverity: ("Uninitialized scalar variable")
> Fixes: d3622099c76f ("drm/i915/gtt: Always acquire struct_mutex for gen6_ppgtt_cleanup")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Saw that last night but got distracted by the panic-on-boot...
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
-Chris
