Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D08ADC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 18:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA33B218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 18:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfCOSlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 14:41:40 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:39417 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfCOSlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 14:41:39 -0400
Received: from [192.168.1.110] ([77.2.38.11]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MirfI-1gb17s0I5M-00exYF; Fri, 15 Mar 2019 19:41:20 +0100
Subject: Re: serial driver cleanups v2
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        Richard Genoud <richard.genoud@gmail.com>,
        macro@linux-mips.org,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>, slemieux.tyco@gmail.com,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>, baohua@kernel.org,
        Peter Korsgaard <jacmet@sunsite.dk>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT" 
        <linuxppc-dev@lists.ozlabs.org>
References: <1552602855-26086-1-git-send-email-info@metux.net>
 <CAHp75VeH9isvFkp+AECgsN8du__8tBBp_4zZEVXJ083BdFweeg@mail.gmail.com>
 <afc51d27-3312-cdf4-68a5-4486db1d006b@metux.net>
 <20190315181118.GF9224@smile.fi.intel.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <d9ac8446-c7ff-6e57-5eaa-f1a09d549081@metux.net>
Date:   Fri, 15 Mar 2019 19:41:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190315181118.GF9224@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:SEhWkGTngchVaGOi1VLTckafsrasxjLcF1GzXHt0mnNThnYbRaw
 QfYHKt7uxK+IYwNNtICBankPHlIcLqxdx139j3YzHaskDIfe8r/jK8AyOQhUuNgUIe9tzTC
 WcG9jAOjUZpESxhSdjbcQMp3fY9dKCpffjGyz8EyYPzNQPcvVVBAHa337c3hpGqWvmrOJlm
 VXJ3TblaMwQXQ1Y+/esrw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:R7ZrnfxgAfQ=:rL5sQ46e4F1ZssU4Lie9q8
 TiFQOrT49OGtBxsKHK17dAqW3yKY6TRE3dhUmkzFmidH7HeTMhjU6xv3EcPpE032Ld9YAKPG9
 TTarjVkqwPYxp++a6f/PkxY32EbYfqdFQiL8ShW2dRiM69I9kt1WiaysrZuIrfsUyr+LMsTTC
 rmDtf535Fwm3rn4PXc7C0ytNBIZAdVV8jkhwi7VUjaGyrGcmmZOnZwa9XRs6L01hU4Hi2r1S9
 IjSHSgxw6DvRNdoJfeCuNeH0vlWaKyuds5uzfyC3YhnZs6PaTFv64kKqKiqWgwluSoNtgXKay
 yn6wXU2huXFZnA7oa/TtQdF1CbxQAXfplo3buTpd4c7cPUe2y2/g+u4fm7fAlYi7reI1I9cq8
 MYQsQXgXZwoRmQk/zDjB/YjPQ4JX4yqgm22xM8NfQzrmxIF8IfKCMSlV6YVgqansv2VAY51h+
 tyhJu+5K4oq8rJU4YteauXvjP9xL6/qDyFhue+JZRy5cmPvaJAya5NzEDAcfle2vDwHUTG1OV
 YOmlKy7Ub04Lw9P6FWVGOI9mwhZB0Ztv04yD5NPZ6x0OZfwCzXniRvRQOWbYfE+TrfCO0zGxk
 NUqncL4oNJFDbbEJcmUlfThIEfxfWvBRUKnLyxVNDp2YlYFB1KjORqrY70854HDvW7L8LZln3
 sKl17L2TBqxTnyVtqgBNrCSYXSsWcEHVlzrZizXbaAATCLvDmvQf0lUe12NQDp6vtTg1bCb/c
 EanI9e7fgqqlWPUto8fwIZioEWJ9IEaldROXiZgvT/UmFvBzk0J9dAiNFd8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.03.19 19:11, Andy Shevchenko wrote:

>> The actual goal is generalizing the whole iomem handling, so individual
>> usually just need to call some helpers that do most of the things.
>> Finally, I also wanted to have all io region information consolidated
>> in struct resource.
> 
> That's should be a selling point, not just conversion per se.

hmm, I never was good at selling :o

but I'll try anyways: it shall make the code smaller and easier to
read/understand.

does that count ?

> You have to explain that in each commit message, that the change does bring a
> possible new error message printed.

Ok, I wasn't aware of that. Yes, I missed to read the code of that
function carefully and didn't expect that it does more than just a dumb
wrapper around dev_ioremap() that picks out the params from struct
resource.

OTOH, the name, IMHO, is a bit misleading. Any chance of ever changing
it to a more clear name (eg. devm_request_and_ioremap_resource()) ?

> The performance side of the deal, you are lucky here, is not significant
> because it's slow path.

okay :)


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
