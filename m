Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228F6C606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 07:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F16CC21537
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 07:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbfGIHE0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 03:04:26 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:55405 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725818AbfGIHE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 03:04:26 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 17179194-1500050 
        for multiple; Tue, 09 Jul 2019 08:04:07 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     =?utf-8?q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>,
        Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20190709065800.2354-1-janusz.krzysztofik@linux.intel.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?utf-8?q?Micha=C5=82_Wajdeczko?= <michal.wajdeczko@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
References: <20190709065800.2354-1-janusz.krzysztofik@linux.intel.com>
Message-ID: <156265584538.9375.16081841013219935184@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH] drm/i915: Fix reporting of size of created GEM object
Date:   Tue, 09 Jul 2019 08:04:05 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Janusz Krzysztofik (2019-07-09 07:58:00)
> Commit e163484afa8d ("drm/i915: Update size upon return from
> GEM_CREATE") (re)introduced reporting of actual size of created GEM
> objects, possibly rounded up on object alignment.  Unfortunately, its
> implementation resulted in a possible use-after-free bug.  The bug has
> been fixed by commit 929eec99f5fd ("drm/i915: Avoid use-after-free in
> reporting create.size") at the cost of possibly incorrect value being
> reported as actual object size.
> 
> Safely restore correct reporting by capturing actual size of created
> GEM object before a reference to the object is put.
> 
> Fixes: 929eec99f5fd ("drm/i915: Avoid use-after-free in reporting create.size")

This doesn't do anything.
-Chris
