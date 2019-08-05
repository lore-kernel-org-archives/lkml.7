Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012EDC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 12:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D61CB2086D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 12:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbfHEMGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 08:06:41 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:49745 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727553AbfHEMGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 08:06:41 -0400
Received: from [192.168.1.110] ([77.7.70.5]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N0G5n-1iIikw2Pxv-00xL1r; Mon, 05 Aug 2019 14:06:33 +0200
Subject: Re: [PATCH v2] platform/x86/pcengines-apuv2: use KEY_RESTART for
 front button
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
References: <1564081563-28322-1-git-send-email-info@metux.net>
 <CAHp75Vem8QZVGx6x0p3JgxA6kH3pG+1_zU=cgiDUDSC5p2ODDQ@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <0b2802f8-5732-52e9-0a95-b28d23239ecd@metux.net>
Date:   Mon, 5 Aug 2019 14:06:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHp75Vem8QZVGx6x0p3JgxA6kH3pG+1_zU=cgiDUDSC5p2ODDQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:zILWaArSokcPaTMpjpK3s3auy6+xy9QkB0Sqa2fjj1HM1dZqmuv
 Ix+8GcRmNF/cR+R/tnxMEOWSW35LhjP0MIHQxt3iIncqiO/ZCntlzayFcV6n++CK9mD3MMM
 OmmW4PmGr2SDGSdUUxfMHtJ6pzX/GJ9Y5Lpjab/+E5CAS3/qFpG0BcfM6U8ikkoQh4XXlXv
 wHGzMMTVRrdHSvVsnM/RA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7g3//ffHaGE=:oheL3/eOGxapi9Z74+a1jf
 Ci8EQp5GHXvBIInQ30to+5OqO7cScSglZu4fjaQHal2dI9/1vXTSzOLSvZaVnnqgbnEujFuQj
 djcvLNXN/ndJ1eskLjO29pphZBryHQ9q5nkUygnJViNufpLCrGEyIpZ1U5m29MVgY9nhQUNGV
 OA72esDWVkmKC/Ny6DtZxrgs9YIG+BEia6EIlTLN+wsVQic3OWleRWYANEBXBBzwbx64UoYCh
 vbtjQyswTGdxeyEdjc45LpSMan8Dw82I0Jas5Sga5aCtHfUpe2OJ4Od+Fmd82BsdQIgikU3CR
 timBRvHZJSLfjo7GU2RApQqHg1kDmKbIq42Virdfz4oivJ1CRRihmso4Xk5sccZPpx5dKvyUb
 wq5Fgvy0R2k0KDIzkZcD+yR9ZzpwpHXkdZoJfgZwlzSBaSR+9Yqo5wp61FKwKoMrA5pjNW1Nj
 9/OngJ0IBcbyn3tWt0V2/PTmUnptge+Z2mqnGcOZ87cTZepM3lJmUkz9wQ/DQBKvEU2t7xYFL
 jCZiXoKsZpLiFGDJzyzEWDcnb9P3obU35eiADOXe0a7kHYQupC7GpCzEQ3zl5rD2VMhu7wVFT
 fM18Fy6XaK8Jr0UA3BXAs0TVXxZQMCf1hIF2KlMtb3jUPYGRlTu0eJoq8/evHFxbgWfSpp+j+
 lBiMUZsSve2TGsKVi6DJBDFWkol/BEV2ClOlxhUGYSd73/7GQ9BOrZDTo9mSxQdjMW7pHyfhI
 bpa4ragtRgnueIkpajFtKHccKyDNjmw1Rp7RayIf28A/svQNQgX6VjD+QWU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.08.19 17:00, Andy Shevchenko wrote:

Hi,

> On Thu, Jul 25, 2019 at 10:06 PM Enrico Weigelt, metux IT consult
> <info@metux.net> wrote:
>>
>> From: Enrico Weigelt <info@metux.net>
>>
>> The keycode KEY_RESTART is more appropriate for the front button,
>> as most people use it for things like restart or factory reset.
>>
> 
> Applied, thanks!

thx.

> 
>> Signed-off-by: Enrico Weigelt <info@metux.net>
>> Fixes: f8eb0235f65989fc5521c40c78d1261e7f25cdbe ("x86: pcengines apuv2 gpio/leds/keys platform driver")
> 
> Please, use allowed minimum (12 nowadays) characters of hash.

hmm, do you happen to know how to configure tig to show the short hash ?


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
