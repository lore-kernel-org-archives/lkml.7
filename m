Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3749C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 15:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A141E217F5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 15:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731988AbfKFPHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 10:07:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:41344 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731929AbfKFPHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 10:07:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DA53BB143;
        Wed,  6 Nov 2019 15:07:17 +0000 (UTC)
Message-ID: <82d17114302562e0c553e2ea936974f77734e86b.camel@suse.de>
Subject: Re: [PATCH 1/7] dt-bindings: gpu: mali-midgard: Tidy up conversion
 to YAML
From:   Andreas =?ISO-8859-1?Q?F=E4rber?= <afaerber@suse.de>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-realtek-soc@lists.infradead.org,
        LAKML <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Maxime Ripard <mripard@kernel.org>,
        Guillaume Gardet <guillaume.gardet@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org
Date:   Wed, 06 Nov 2019 16:07:39 +0100
In-Reply-To: <CAL_JsqL3NOstoa5ZY1JE9e3Ay=WTmz153H-KbHErhi-GBX-5GA@mail.gmail.com>
References: <20191104013932.22505-1-afaerber@suse.de>
         <20191104013932.22505-2-afaerber@suse.de>
         <CAL_JsqL3NOstoa5ZY1JE9e3Ay=WTmz153H-KbHErhi-GBX-5GA@mail.gmail.com>
Organization: SUSE Linux GmbH
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, den 06.11.2019, 08:24 -0600 schrieb Rob Herring:
> On Sun, Nov 3, 2019 at 7:40 PM Andreas Färber <afaerber@suse.de>
> wrote:
> > Instead of grouping alphabetically by third-party vendor, leading
> > to
> > one-element enums, sort by Mali model number, as done for Utgard.
> > 
> > This already allows us to de-duplicate two "arm,mali-t760" sections
> > and
> > will make it easier to add new vendor compatibles.
> 
> That was the intent. Not sure how I messed that up...
> 
> This patch is problematic because there's changes in arm-soc juno/dt
> branch and there's now a patch for exynos5420 (t628). I'd propose I
> apply this such that we don't get a merge conflict with juno/dt and
> we
> finish resorting after rc1 (or when both branches are in Linus'
> tree).

This series has dependencies for the Realtek-side RFC patches and is
not yet ready to merge, so you can take this prep PATCH through your
tree for v5.6 probably, or feel free to rebase/rework as you see fit -
I'd just appreciate being credited at least via Reported-by. :)

Thanks,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)

