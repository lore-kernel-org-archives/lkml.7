Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E36BC33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 14:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E97AC2073D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 14:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbgAGOC1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 09:02:27 -0500
Received: from mail.fireflyinternet.com ([109.228.58.192]:51921 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728064AbgAGOC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 09:02:26 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 19796487-1500050 
        for multiple; Tue, 07 Jan 2020 14:02:24 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     airlied@linux.ie, daniel@ffwll.ch, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, matthew.auld@intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@intel.com,
        ville.syrjala@linux.intel.com, yuehaibing@huawei.com
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20200107135014.36472-1-yuehaibing@huawei.com>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20200107135014.36472-1-yuehaibing@huawei.com>
Message-ID: <157840574163.2273.4582403791224219763@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH -next] drm/i915: Add missing include file <linux/math64.h>
Date:   Tue, 07 Jan 2020 14:02:21 +0000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting YueHaibing (2020-01-07 13:50:14)
> Fix build error:
> ./drivers/gpu/drm/i915/selftests/i915_random.h: In function i915_prandom_u32_max_state:
> ./drivers/gpu/drm/i915/selftests/i915_random.h:48:23: error:
>  implicit declaration of function mul_u32_u32; did you mean mul_u64_u32_div? [-Werror=implicit-function-declaration]
>   return upper_32_bits(mul_u32_u32(prandom_u32_state(state), ep_ro));
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 7ce5b6850b47 ("drm/i915/selftests: Use mul_u32_u32() for 32b x 32b -> 64b result")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
-Chris
