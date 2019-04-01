Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439A7C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1676C2133D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbfDAKwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 06:52:09 -0400
Received: from mx.socionext.com ([202.248.49.38]:29122 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbfDAKwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 06:52:09 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 01 Apr 2019 19:52:07 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 700DD18028D;
        Mon,  1 Apr 2019 19:52:07 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Mon, 1 Apr 2019 19:52:07 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 4FAA81A1EAE;
        Mon,  1 Apr 2019 19:52:07 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.119.83])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 42ED9120487;
        Mon,  1 Apr 2019 19:52:07 +0900 (JST)
Subject: Re: [PATCH] dt-bindings: cpu: Fix JSON schema
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        ARM-SoC Maintainers <arm@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190318100521.29109-1-maxime.ripard@bootlin.com>
 <CAL_JsqJ_LYycXazkdP2Q=e-jynKiX+z5En0bz0AWpDjsevwQTg@mail.gmail.com>
 <20190401091050.cwph7xlpv3pmkwnq@flea>
From:   "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Message-ID: <78bb248e-56b8-b825-e763-583f75148eb3@socionext.com>
Date:   Mon, 1 Apr 2019 19:52:06 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190401091050.cwph7xlpv3pmkwnq@flea>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

Thanks for pointing my bug.

On 2019/04/01 18:10, Maxime Ripard wrote:
> Hi Sugaya, Arnd, Olof,
> 
> On Thu, Mar 28, 2019 at 02:35:54PM -0500, Rob Herring wrote:
>> +arm-soc
>>
>> On Mon, Mar 18, 2019 at 5:05 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>>>
>>> Commit fd73403a4862 ("dt-bindings: arm: Add SMP enable-method for
>>> Milbeaut") added support for a new cpu enable-method, but did so using
>>> tabulations to ident. This is however invalid in the syntax, and resulted
>>> in a failure when trying to use that schemas for validation.
>>>
>>> Use spaces instead of tabs to indent to fix this.
>>>
>>> Fixes: fd73403a4862 ("dt-bindings: arm: Add SMP enable-method for Milbeaut")
>>> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
>>> ---
>>>   Documentation/devicetree/bindings/arm/cpus.yaml | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>>
>> This should be applied to arm-soc tree having the commit.
> 
> Could you pick up that patch?
> 

I got it.
My mission is to resubmit your fix-patch added my singned-off tag and
Rob's reviewed tag...right?

Thanks,
Sugaya Taichi

> Thanks!
> Maxime
> 
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
> 

