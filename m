Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F23A8C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 09:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE584206BA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 09:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730758AbfKHJMM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 04:12:12 -0500
Received: from mail.fireflyinternet.com ([109.228.58.192]:55766 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730645AbfKHJMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 04:12:12 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 19124954-1500050 
        for multiple; Fri, 08 Nov 2019 09:12:08 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20191108051356.29980-1-yamada.masahiro@socionext.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Mika Kuoppala <mika.kuoppala@linux.intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20191108051356.29980-1-yamada.masahiro@socionext.com>
Message-ID: <157320432699.9461.10436519336108145423@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH 1/2] drm/i915: change to_mock() to an inline function
Date:   Fri, 08 Nov 2019 09:12:07 +0000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Masahiro Yamada (2019-11-08 05:13:55)
> Since this function is defined in a header file, it should be
> 'static inline' instead of 'static'.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
-Chris
