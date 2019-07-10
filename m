Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B055FC74A21
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88F8A2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbfGJPGl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 11:06:41 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:56619 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727412AbfGJPGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 11:06:41 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 17201151-1500050 
        for multiple; Wed, 10 Jul 2019 16:05:53 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
        intel-gfx@lists.freedesktop.org
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20190710145955.16104-1-janusz.krzysztofik@linux.intel.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?utf-8?q?Micha=C5=82_Wajdeczko?= <michal.wajdeczko@intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
References: <20190710145955.16104-1-janusz.krzysztofik@linux.intel.com>
Message-ID: <156277115126.4055.4509642156764653822@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [RFC PATCH] drm/i915: Join quoted strings and align them with open
 parenthesis
Date:   Wed, 10 Jul 2019 16:05:51 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Janusz Krzysztofik (2019-07-10 15:59:55)
> Follow dim checkpatch recommendations so it doesn't complain now and
> again on consistent modifications of i915_params.c

This is one where we've considered the merits of not rigorously applying
checkpatch.pl and adopted a different convention.
-Chris
