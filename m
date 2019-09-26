Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CA8C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 16:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C94721D56
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 16:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569515245;
	bh=u1q5qLrARxZMkf8IFtp9nfpIDy7AKfqEhQ449JI2JOQ=;
	h=Subject:From:To:Cc:References:Date:In-Reply-To:List-ID:From;
	b=MWasXAcY08i6hO3Mt/GS9fnPOMGX/1vU0t5Ib8eRAYS2acVQzQN6g/SlO2h41i3VH
	 anDOdaGHPS6j8RBT40L6HPDWGfFwAY6BZyFJSOCdebMs7keb+HQ+49+f8Gec1wk2If
	 bUDiQllZznSlI0LoyXUOTzkYKFPh//rP9qNxedEk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbfIZQ1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 12:27:24 -0400
Received: from foss.arm.com ([217.140.110.172]:54312 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbfIZQ1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 12:27:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1DAF628;
        Thu, 26 Sep 2019 09:27:23 -0700 (PDT)
Received: from [10.1.197.61] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D09E3F534;
        Thu, 26 Sep 2019 09:27:21 -0700 (PDT)
Subject: Re: [PATCH 10/35] irqchip/gic-v4.1: VPE table (aka GICR_VPROPBASER)
 allocation
From:   Marc Zyngier <maz@kernel.org>
To:     Zenghui Yu <yuzenghui@huawei.com>, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20190923182606.32100-1-maz@kernel.org>
 <20190923182606.32100-11-maz@kernel.org>
 <155660c2-7f30-e188-ca8d-c37fabea6d97@huawei.com>
 <6f4ccdfd-4b63-04cb-e7c0-f069e620127f@kernel.org>
 <14111988-74c9-12c3-1322-1580ff6ba11f@huawei.com>
 <c4d63ccd-b5b2-007f-6174-1a9d20f3669d@kernel.org>
Openpgp: preference=signencrypt
Autocrypt: addr=maz@kernel.org; prefer-encrypt=mutual; keydata=
 mQINBE6Jf0UBEADLCxpix34Ch3kQKA9SNlVQroj9aHAEzzl0+V8jrvT9a9GkK+FjBOIQz4KE
 g+3p+lqgJH4NfwPm9H5I5e3wa+Scz9wAqWLTT772Rqb6hf6kx0kKd0P2jGv79qXSmwru28vJ
 t9NNsmIhEYwS5eTfCbsZZDCnR31J6qxozsDHpCGLHlYym/VbC199Uq/pN5gH+5JHZyhyZiNW
 ozUCjMqC4eNW42nYVKZQfbj/k4W9xFfudFaFEhAf/Vb1r6F05eBP1uopuzNkAN7vqS8XcgQH
 qXI357YC4ToCbmqLue4HK9+2mtf7MTdHZYGZ939OfTlOGuxFW+bhtPQzsHiW7eNe0ew0+LaL
 3wdNzT5abPBscqXWVGsZWCAzBmrZato+Pd2bSCDPLInZV0j+rjt7MWiSxEAEowue3IcZA++7
 ifTDIscQdpeKT8hcL+9eHLgoSDH62SlubO/y8bB1hV8JjLW/jQpLnae0oz25h39ij4ijcp8N
 t5slf5DNRi1NLz5+iaaLg4gaM3ywVK2VEKdBTg+JTg3dfrb3DH7ctTQquyKun9IVY8AsxMc6
 lxl4HxrpLX7HgF10685GG5fFla7R1RUnW5svgQhz6YVU33yJjk5lIIrrxKI/wLlhn066mtu1
 DoD9TEAjwOmpa6ofV6rHeBPehUwMZEsLqlKfLsl0PpsJwov8TQARAQABtB1NYXJjIFp5bmdp
 ZXIgPG1hekBrZXJuZWwub3JnPokCUQQTAQoAOwIbAwULCQgHAgYVCgkICwIEFgIDAQIeAQIX
 gBYhBJ/VHFPgtWMY/ZWcPSPQ0LrRPXpDBQJdHcKPAhkBAAoJECPQ0LrRPXpDOHcP/06Yh7n1
 hIylY21WGwF4FzkurwwuWKGvU6DdcOPTf8xuSrmxBblMCP8PdBNeDbNm5yzpnt6mO4qnMuO1
 KyrDQLn3vyc3KnjqjiJkNLBYTi34zaVgD9RHsHjWA6kcVkeqhY3yr+4Ax+Y96+ZABCt5/4ur
 cNxkNuyDrPyrFPa8PN1RHcCvO8ywRtz3qf8aLwuoK/jg3yKsGIyBbJz5D/Cm+CpReGSdJwRm
 oIsGCj0QIALC0ZEtH6GjPKIf2FFG62Tz6HNWrr4foJj7rRTZSpIYU2pflwudYMApALeF/jPi
 05wBBny+FwmGKV25Wgz8XFvGAt/v5if9fHxy8qpobR3IbSyrwmJrl5jnND+/zt/q8/BmjYHX
 1EyFqlO0Z4KokxkHCczg3J15WJmn9T7n5tBNxQ7/7CJ18WGCIuPSwLtffq0uYv9/b5JyMe/l
 RE81Gpi5MabCmi0PdfCsxxLpXXtSFGIOLPyMRBGFPCGcrKJIoN47U7Yo8rw01YCtkNtyVW4a
 +mQg/xSPsNOO3I6qwPB/+vEpHnFoeeEa2jb+xW/SI9PuGVS3b4D8h4+iv7MOZngUYXqOaP3m
 mCMGWwMkDTbJTsvETIothBlcefqmk23CpNnUJJK+NyQyC21ZpTlVrfkYM66X0NNLdC1AZ/FI
 d8FBGo4YyYfiB7N6boU//2dbtfMyuQINBE6Jf0UBEADP9qXS2Alpn967SIj/Fo+TcMo0i+v1
 KwoV7aF/cJWPGuIdxF+hN+uLJyCVTC28q+G8HZjylC5Z8u0/0fHcf5gjlrvw87a1TUIl1jky
 iZ3f9okG5QU/luVvHqf50sN6lCHJCsCnaZULc0inhPjyfhjEvg6DQw5HK1Y1J7KAhK9Git3D
 uoOYSxrvCAWwtQiWEqaZXlVW/7AA51hd0n1Lyf5eCvFJOAePl/dCqQO1PTIbw0wsuZiRmk7B
 agy6Z6qf8qmk9j+5MjBthMPnqrVSKsMMHmQNEvrbqqbrecXTQHLI9j7oFcfbZcPyyaN/Z4fD
 azMQIb+WkPiSdiPFE4hy10L6AtGHP42V/yUQea+MeCISt+DL+U4h/4BX2W8MXdvO2NYzmg/Z
 YZ5HtUl+TFxe3gk93IMgfoYEruNsPtsWJd/q8yIUKsV4Wj9t9rf294pSTtNGWdfXeCiAhnGp
 Hoi+mQbQ/E67ZEYnsCN79KPK1AVrY3A0YIN7Vsfz3Cb2Z8NbcG5kXWjb7L55WqQ9mPSbN8KE
 SyI0gBjoo8MxV0icgth1NQALkfbqOP0JHiK0FRyMT+0yWXSfbBhFnXhj88z5Six8CF9h8323
 bT3oz0l5uSydNuqnbSR4MwQG9zcoGRugR+hAtTTw0OjudxF6K10tbbEgIKeWQ0hRAZJaUVU9
 xNDawwARAQABiQIfBBgBAgAJBQJOiX9FAhsMAAoJECPQ0LrRPXpDCwUP/1PjLfQ7RaczAiBx
 TxPZzZbApu+Y9tpTYsOpl5sd3FAN6ZfrkRkK/80AuYp0DbYxVJsBpB6qwMPkphuYLIJzOKUn
 WL62lmgljmQkAsdZaWgjpTKLazXMDCUyS0BnOAYycjnkh+fR0A4rSnyjLv8o0Yc0/Al4crOk
 dJGDKxDdLW3tXBTiZMUm1dBoEUwxeDysi0/kZ3KCsUHvJRsbpOeteGkaQUGtCz2n5Iq8KpFL
 cbD52q5D1BH5AZZyIQEfC5Jp3mC7tAL21o3yQlB+6n6ckvxUa0AqAavUCBHH9r9X9ACKQNu3
 /SghL+TGUh1xgnTXG4ysNd/WMWGYZl2hxSg0mSAtvWIUCXl1pXwxA6upyIb7q2ct5kodjjEI
 GiKBXsTwrAQTnJR/EFLTJGt41v6mMq1fqlKvVn90ij613+wd8Qd99oxQhE28mUF6pqMFftm9
 6yRUVp+YSuQfscL7sSshqqgzho6H9nSpdswSMWxYDnJVe8KglZIcUiYv0Gjo9swakjT14GuQ
 1rV93pEZyS2tfoo18ZnY84QKYoYtPIMLz+RvXzRikMkRE3jxLRAFrdG+3TqjM2AWBkVa+7ku
 Lk+lj+38zsACQuJVO2WFmclbIQmtCL07addPOUbU96oYfZqG5HGfu3EDmPk8dkRl0vVnjodo
 2Y3aFlL+gnr1zUMjlFzD
Organization: Approximate
Message-ID: <5d915f55-785b-72f5-498b-8c17148dd3a9@kernel.org>
Date:   Thu, 26 Sep 2019 17:27:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <c4d63ccd-b5b2-007f-6174-1a9d20f3669d@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/09/2019 16:57, Marc Zyngier wrote:
> On 26/09/2019 16:19, Zenghui Yu wrote:
>> Hi Marc,
>>
>> Two more questions below.
>>
>> On 2019/9/25 22:41, Marc Zyngier wrote:
>>> On 25/09/2019 14:04, Zenghui Yu wrote:
>>>> Hi Marc,
>>>>
>>>> Some questions about this patch, mostly to confirm that I would
>>>> understand things here correctly.
>>>>
>>>> On 2019/9/24 2:25, Marc Zyngier wrote:
>>>>> GICv4.1 defines a new VPE table that is potentially shared between
>>>>> both the ITSs and the redistributors, following complicated affinity
>>>>> rules.
>>>>>
>>>>> To make things more confusing, the programming of this table at
>>>>> the redistributor level is reusing the GICv4.0 GICR_VPROPBASER register
>>>>> for something completely different.
>>>>>
>>>>> The code flow is somewhat complexified by the need to respect the
>>>>> affinities required by the HW, meaning that tables can either be
>>>>> inherited from a previously discovered ITS or redistributor.
>>>>>
>>>>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>>>>> ---
>>>>
>>>> [...]
>>>>
>>>>> @@ -1962,6 +1965,65 @@ static bool its_parse_indirect_baser(struct its_node *its,
>>>>>    	return indirect;
>>>>>    }
>>>>>    
>>>>> +static u32 compute_common_aff(u64 val)
>>>>> +{
>>>>> +	u32 aff, clpiaff;
>>>>> +
>>>>> +	aff = FIELD_GET(GICR_TYPER_AFFINITY, val);
>>>>> +	clpiaff = FIELD_GET(GICR_TYPER_COMMON_LPI_AFF, val);
>>>>> +
>>>>> +	return aff & ~(GENMASK(31, 0) >> (clpiaff * 8));
>>>>> +}
>>>>> +
>>>>> +static u32 compute_its_aff(struct its_node *its)
>>>>> +{
>>>>> +	u64 val;
>>>>> +	u32 svpet;
>>>>> +
>>>>> +	/*
>>>>> +	 * Reencode the ITS SVPET and MPIDR as a GICR_TYPER, and compute
>>>>> +	 * the resulting affinity. We then use that to see if this match
>>>>> +	 * our own affinity.
>>>>> +	 */
>>>>> +	svpet = FIELD_GET(GITS_TYPER_SVPET, its->typer);
>>
>> The spec says, ITS does not share vPE table with Redistributors when
>> SVPET==0.  It seems that we miss this rule and simply regard SVPET as
>> GICR_TYPER_COMMON_LPI_AFF here.  Am I wrong?
> 
> Correct. I missed the case where the ITS doesn't share anything. That's
> pretty unlikely though (you loose all the benefit of v4.1, and I don't
> really see how you'd make it work reliably).

Actually, this is already handled...

> 
>>
>>>>> +	val  = FIELD_PREP(GICR_TYPER_COMMON_LPI_AFF, svpet);
>>>>> +	val |= FIELD_PREP(GICR_TYPER_AFFINITY, its->mpidr);
>>>>> +	return compute_common_aff(val);
>>>>> +}
>>>>> +
>>>>> +static struct its_node *find_sibbling_its(struct its_node *cur_its)
>>>>> +{
>>>>> +	struct its_node *its;
>>>>> +	u32 aff;
>>>>> +
>>>>> +	if (!FIELD_GET(GITS_TYPER_SVPET, cur_its->typer))
>>>>> +		return NULL;

... here. If SVPET is 0, there is no sibling, and we'll allocate a VPE
table as usual.

Thanks,

	M.
-- 
Jazz is not dead, it just smells funny...
