Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E50BCA9EB7
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 08:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 538DB2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 08:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390194AbfJWIQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 04:16:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:54084 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389987AbfJWIQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 04:16:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 23006BFE2;
        Wed, 23 Oct 2019 08:16:50 +0000 (UTC)
Subject: Re: [PATCH v5.1 RESEND] dt-bindings: hwrng: Add Samsung Exynos 5250+
 True RNG bindings
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?=c5=81ukasz_Stelmach?= <l.stelmach@samsung.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Joe Perches <joe@perches.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org,
        Otto Sabart <ottosabart@seberm.com>,
        Rob Herring <robh@kernel.org>
References: <CGME20190111132222eucas1p1d80caf8ba30422bc5fe1a1fac4cf48e8@eucas1p1.samsung.com>
 <CAL_JsqKt-ujsB-t9A=4dEAjqrvcquUG+qF3tFg1YCqmup_5wcw@mail.gmail.com>
 <20190111132139.12333-1-l.stelmach@samsung.com>
 <CAJKOXPfM+EUzBBBhrtSFw5-e7hiimsFT8okcd8J9gGyFdzd2+w@mail.gmail.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <58f7d127-b798-04b8-1bc6-d37a8af273f7@suse.de>
Date:   Wed, 23 Oct 2019 10:16:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAJKOXPfM+EUzBBBhrtSFw5-e7hiimsFT8okcd8J9gGyFdzd2+w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

Am 26.03.19 um 12:42 schrieb Krzysztof Kozlowski:
> On Fri, 11 Jan 2019 at 14:22, Łukasz Stelmach <l.stelmach@samsung.com> wrote:
>>
>> Add binding documentation for the True Random Number Generator
>> found on Samsung Exynos 5250+ SoCs.
>>
>> Acked-by: Rob Herring <robh@kernel.org>
>> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
>> Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
>> ---
> 
> Rob,
> Could you apply this directly? You acked this some time ago but it
> never went through drivers tree. Lukasz resent this patch and it is
> waiting since then.
> The driver implementing compatible is already in mainline.

For some reason this text file in linux-next is lonely in devicetree/...
rather than living in Documentation/devicetree/... - please fix that.
The patch here looks correct, so not sure what went wrong:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/devicetree/bindings/rng/samsung,exynos5250-trng.txt?h=next-20191023&id=85552c22f03c9066c33f26f34538b67fee6a91a8

Thanks,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
