Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFD3C606CF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 12:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E19C20651
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 12:55:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfGJMzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 08:55:08 -0400
Received: from mga14.intel.com ([192.55.52.115]:5131 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbfGJMzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 08:55:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2019 05:55:07 -0700
X-IronPort-AV: E=Sophos;i="5.63,474,1557212400"; 
   d="scan'208";a="341065021"
Received: from jkrzyszt-desk.igk.intel.com (HELO jkrzyszt-desk.ger.corp.intel.com) ([172.22.244.18])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2019 05:55:05 -0700
From:   Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?utf-8?B?TWljaGHFgg==?= Wajdeczko <michal.wajdeczko@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/6] Rename functions to match their entry points
Date:   Wed, 10 Jul 2019 14:54:59 +0200
Message-ID: <34737143.LqZMGNDrZD@jkrzyszt-desk.ger.corp.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <156276282845.11940.4812142560907762693@skylake-alporthouse-com>
References: <20190710123631.26575-1-janusz.krzysztofik@linux.intel.com> <156276282845.11940.4812142560907762693@skylake-alporthouse-com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, July 10, 2019 2:47:08 PM CEST Chris Wilson wrote:
> Quoting Janusz Krzysztofik (2019-07-10 13:36:25)
> > Need for this was identified while working on split of driver unbind
> > path into _remove() and _release() parts.  Consistency in function
> > naming has been recognized as helpful when trying to work out which
> > phase the code is in.
> > 
> > What I'm still not sure about is desired depth of that modification -
> > how deep should we go down with renaming to not override meaningfull
> > function names.  Please advise if you think still more deep renaming
> > makes sense.
> 
> I did a double take over "driver_release" but by the end I was in
> agreement.
> 
> The early_release though, that is worth a bit of artistic license to say
> early_probe pairs with late_release.

OK, I'll fix it, as well as other issues pointed out by dim, and resubmit.

Thanks,
Janusz

> -Chris
> 




