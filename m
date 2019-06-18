Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E0EC31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 09:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A48BC206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 09:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729453AbfFRJfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 05:35:53 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:43819 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729113AbfFRJfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 05:35:52 -0400
Received: from [192.168.1.110] ([95.114.66.109]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MALql-1hkZRC0XyV-00Bwv7; Tue, 18 Jun 2019 11:35:37 +0200
Subject: Re: drivers: Inline code in devm_platform_ioremap_resource() from two
 functions
To:     Markus Elfring <Markus.Elfring@web.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     cocci@systeme.lip6.fr, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Himanshu Jha <himanshujha199640@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
References: <20190406061112.31620-1-himanshujha199640@gmail.com>
 <f09006a3-691c-382a-23b8-8e9ff5b4a5f1@web.de>
 <alpine.DEB.2.21.1906081925090.2543@hadrien>
 <7b4fe770-dadd-80ba-2ba4-0f2bc90984ef@web.de>
 <f573b2d3-11d0-92b5-f8ab-4c4b6493e152@metux.net>
 <032e347f-e575-c89c-fa62-473d52232735@web.de>
 <910a5806-9a08-adf4-4fba-d5ec2f5807ff@metux.net>
 <efc38197-f846-142d-fbaf-93327c2669c9@web.de>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <714a38fe-a733-7264-bb06-d94bd58a245a@metux.net>
Date:   Tue, 18 Jun 2019 11:35:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <efc38197-f846-142d-fbaf-93327c2669c9@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:QGOge7wGLS9wYOerll1EkGFgYhDGxxcXgNUpFw4ODbRJSI2IvQu
 EgNQDoUgqQPHmht+B4xha2yiDDCKlybReidxeoCxJ+rwoIdIkF5oOJWDdQN/PLJCYmtwsdY
 +k18JXBNva47Mqa/rQYAaiK0ltc20AueHqyQs7YbJfXMYwzLgf15a5PbvYUgkskfDAZUZwZ
 fKheijEjcUDc9U6yv4onQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:D189xkVVdIU=:GM0TjioBmaopMMZ9spYJwQ
 /GhJviRrSe4I/q2z8eiefDW9PTfL5f4N4KVWWRcVEqHG9mLc0DA99q6Y0ju2o0fUoCberydJX
 4BC4/bu3rJdvu/cP47IU4PTARHfFiUK45y6i7RwQYXgVZn9JoDM3W+XkPI5iPEPEATyCJTr48
 HOHBKoIO3s8E1tB31GqfjnFmIvI+sfnyNErcJfWbPyz+lzk6bhrmAV9tWvWTElDitBNyMtcrE
 /nw5ALsfbLExblh5UGhOHQ2uC6108yz0eUy7apSIDNa5rgX00meSVXZPR78zyD0uggmsY5ucD
 VkoGTI2PltiXzWFHICPdnK3bkGqXL5Z0Vce6aLH6Vc9Zea+25eUhtIIP6A94NQTTFE8XAronH
 WfI2YM+T6hbasa7Gmv/S412YZJot2Tgwz+Q2lwX1qIcdhTjVTbyjlDvjRWHQdsIhR2mICxgJE
 Bw8X/o9kRGQaN3X9JC1CIYEHsuPZyPQnjYBH/4a80KApu/eVGNztSLllSfiGIX3mNFxnfKHOd
 DHt36lWR3wnKxVUDh7DdQl/87N9x2X2O9Q6+JJ1QLTULsRtXOlRhT+TwSNhG2Ub0GGtTkZa3E
 jyHeGe3ZBj+bR7qPT9nMsJtLr6/o3t26k1xbdQYYSowkC7oC+qFpz3cPNUwBIaukQsuKpSVoE
 a6OxgLI13fyHWNRDnPsF+A7xdgMCyygZ+k/QSX3mWeb+TTNxLPtRvZA1YFE1kver6JbACU4If
 wxOR78EAJ7zu1ExTKYfWAm57352UHhTpWexv9GOB2cuxephEghAJ7PqnbnA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.06.19 07:37, Markus Elfring wrote:
>>> Two function calls were combined in this function implementation.
>>> Inline corresponding code so that extra error checks can be avoided here.
>>
>> What exactly is the purpose of this ?
> 
> I suggest to take another look at the need and relevance of involved
> error checks in the discussed function combination.

Sorry, don't have the time for guessing and trying to reproduce your
thoughts. That's why we have patch descriptions / commit messages.
It would be a lot easier for all of us if you just desribe the exact
problem you'd like to solve and your approach to do so.

>> Looks like a notable code duplication ...
> 
> This can be.

I doubt that code duplication is appreciated, as this increases the
maintenance overhead. (actually, we're usually trying to reduce that,
eg. by using lots of generic helpers).

>> I thought we usually try to reduce this, instead of introducing new ones.
> 
> Would you like to check the software circumstances once more
> for the generation of a similar code structure by a C compiler
> (or optimiser)?

As said: unfortunately, I don't have the time to do that - you'd have to
tell us, what exactly you've got in mind.

If it's just about some error checks which happen to be redundant in a
particular case, you'll have to show that this case is a *really* hot
path (eg. irq, syscall, scheduling, etc) - but I don't see that here.

What's the exact scenario you're trying to optimize ? Any actual
measurements on how your patch improves that ?


Look, I understand that you'd like to squeeze out maximum performance,
but this has to be practically maintainable. I could list a lot of
things that I don't need in particular use cases and would like to
introduce build knobs for, but I have to understand that maintainers
have to be pretty reluctant towards those things.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
