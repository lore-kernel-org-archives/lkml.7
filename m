Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80328FA372C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 10:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49352206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 10:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387736AbfKGKDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 05:03:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:42382 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726866AbfKGKDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 05:03:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1C88CB2EE;
        Thu,  7 Nov 2019 10:03:28 +0000 (UTC)
Subject: Re: [PATCH 1/7] dt-bindings: gpu: mali-midgard: Tidy up conversion to
 YAML
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
References: <20191104013932.22505-1-afaerber@suse.de>
 <20191104013932.22505-2-afaerber@suse.de>
 <CAL_JsqL3NOstoa5ZY1JE9e3Ay=WTmz153H-KbHErhi-GBX-5GA@mail.gmail.com>
 <82d17114302562e0c553e2ea936974f77734e86b.camel@suse.de>
 <CAL_JsqLDFefWVdiPuAktctuBpBeOvG-OVhX2aZn=UaiN55nodg@mail.gmail.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <3c9d7a8c-94e4-60b9-9a84-f368e227666e@suse.de>
Date:   Thu, 7 Nov 2019 11:03:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLDFefWVdiPuAktctuBpBeOvG-OVhX2aZn=UaiN55nodg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 06.11.19 um 16:34 schrieb Rob Herring:
> On Wed, Nov 6, 2019 at 9:07 AM Andreas Färber <afaerber@suse.de> wrote:
>> Am Mittwoch, den 06.11.2019, 08:24 -0600 schrieb Rob Herring:
>>> This patch is problematic because there's changes in arm-soc juno/dt
>>> branch and there's now a patch for exynos5420 (t628). I'd propose I
>>> apply this such that we don't get a merge conflict with juno/dt and
>>> we
>>> finish resorting after rc1 (or when both branches are in Linus'
>>> tree).
>>
>> This series has dependencies for the Realtek-side RFC patches and is
>> not yet ready to merge, so you can take this prep PATCH through your
>> tree for v5.6 probably, or feel free to rebase/rework as you see fit -
>> I'd just appreciate being credited at least via Reported-by. :)
> 
> I was assuming the non-RFC patches are good to go, so I was going to
> pick up 1, 2, and 7.

Actually 1, 2 and 4 should be good to go; 7 if you fix the subject or if
I respin. Also 6 if you can have someone check that no new properties
will be needed for 470 (no Linux driver support yet).

All but 1 assuming you'll be okay to add SoC-specific restrictions on
clocks/resets/domains later, once we've fully figured it out (cf. cover
letter for current errors - looking into power domains next).

Regards,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
