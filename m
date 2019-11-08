Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 889ECC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 09:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A91621D7E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 09:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731646AbfKHJ4G convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 04:56:06 -0500
Received: from mail.fireflyinternet.com ([109.228.58.192]:64497 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731522AbfKHJ4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 04:56:04 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 19125519-1500050 
        for multiple; Fri, 08 Nov 2019 09:55:58 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20191108094142.25942-1-yamada.masahiro@socionext.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Abdiel Janulgue <abdiel.janulgue@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        David Airlie <airlied@linux.ie>,
        Matthew Auld <matthew.auld@intel.com>,
        Mika Kuoppala <mika.kuoppala@linux.intel.com>,
        Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
        Paulo Zanoni <paulo.r.zanoni@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        dri-devel@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20191108094142.25942-1-yamada.masahiro@socionext.com>
Message-ID: <157320695719.9461.4158455736119200291@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH v2] drm/i915: make more headers self-contained
Date:   Fri, 08 Nov 2019 09:55:57 +0000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Masahiro Yamada (2019-11-08 09:41:42)
> The headers in the gem/selftests/, gt/selftests, gvt/, selftests/
> directories have never been compile-tested, but it would be possible
> to make them self-contained.
> 
> This commit only addresses missing <linux/types.h> and forward
> struct declarations.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Thanks a lot for doing this,
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
-Chris
