Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7729C10F14
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 17:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABB6421D81
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 17:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbfJBRoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 13:44:20 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57806 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfJBRoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 13:44:19 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id 5270228F755
Subject: Re: net-next/master boot bisection: v5.3-13203-gc01ebd6c4698 on
 bcm2836-rpi-2-b
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        David Miller <davem@davemloft.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        mgalka@collabora.com, Mark Brown <broonie@kernel.org>,
        matthew.hart@linaro.org, Kevin Hilman <khilman@baylibre.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        tomeu.vizoso@collabora.com, urezki@gmail.com,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Changbin Du <changbin.du@intel.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sri Krishna chowdary <schowdary@nvidia.com>,
        Catalin Marinas <catalin.marinas@arm.com>
References: <5d94766b.1c69fb81.6d9f4.dc6d@mx.google.com>
 <d8357536-6750-d9ba-e114-30944d8f95ab@collabora.com>
 <20191002.102417.205729199993915832.davem@davemloft.net>
 <CAK7LNAR2Cx+3z6QUO_WSURc2Cq6sQhxB5R+U2EyvVnk_s5cn0g@mail.gmail.com>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
Message-ID: <fbd08878-a422-2ed4-a26a-292334306aaa@collabora.com>
Date:   Wed, 2 Oct 2019 18:44:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAK7LNAR2Cx+3z6QUO_WSURc2Cq6sQhxB5R+U2EyvVnk_s5cn0g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/10/2019 18:26, Masahiro Yamada wrote:
> On Thu, Oct 3, 2019 at 2:24 AM David Miller <davem@davemloft.net> wrote:
>>
>> From: Guillaume Tucker <guillaume.tucker@collabora.com>
>> Date: Wed, 2 Oct 2019 18:21:31 +0100
>>
>>> It seems like this isn't the case on the Raspberry Pi 2b with
>>> bcm2835_defconfig.  Here's an example of the kernel errors:
>>
>> This has been fixed upstream I believe, it was some ARM assembler issue
>> or something like that.
>>
>> In any event, definitely not a networking problem. :-)

Quite, and there was also a bisection on the clk-next branch.  If
some subsystem branches don't rebase with the fix and the problem
keeps happening then we'll be disabling boot bisections for them
temporarily to avoid email noise.

On a side note, we're also planning to add a way to mark a
revision as fixed to stop reporting particular failures that have
been fixed upstream - but that's not possible at the moment.

> The fix and related discussions are available.
> 
> https://lore.kernel.org/patchwork/patch/1132785/

Great, thanks!  Sorry I missed that thread.  Thank you also for
having mentioned the kernelci.org bot in the fix.

Guillaume
