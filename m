Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3BCC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3F9E227BF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfLSTnO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 14:43:14 -0500
Received: from mail.fireflyinternet.com ([109.228.58.192]:57660 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727120AbfLSTnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 14:43:13 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 19638651-1500050 
        for multiple; Thu, 19 Dec 2019 19:43:08 +0000
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
In-Reply-To: <20191219190916.24693-1-colin.king@canonical.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191219190916.24693-1-colin.king@canonical.com>
Message-ID: <157678458608.6469.7303602517496484124@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH][next] drm/i915: fix uninitialized pointer reads on pointers to
 and from
Date:   Thu, 19 Dec 2019 19:43:06 +0000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Colin King (2019-12-19 19:09:16)
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently pointers to and from are not initialized and may contain
> garbage values. This will cause uninitialized pointer reads in the
> call to intel_frontbuffer_track and later checks to see if to and from
> are null.  Fix this by ensuring to and from are initialized to NULL.
> 
> Addresses-Coverity: ("Uninitialised pointer read)"
> Fixes: da42104f589d ("drm/i915: Hold reference to intel_frontbuffer as we track activity")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

"D'oh"
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
-Chris
