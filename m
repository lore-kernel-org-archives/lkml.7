Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA27BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 18:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91BDD21917
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 18:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbfCVS04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 14:26:56 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:59643 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbfCVS04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 14:26:56 -0400
Received: from [192.168.1.110] ([95.115.33.167]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MA7b8-1hIuOI130c-00BZEf; Fri, 22 Mar 2019 19:26:48 +0100
Subject: Re: [PATCH] Respond:add support for SUNIX Multi-I/O board
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Morris Ku <saumah@gmail.com>, gregkh <gregkh@linuxfoundation.org>,
        morris_ku@sunix.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190315100614.25027-1-saumah@gmail.com>
 <ef1abb26-4c88-1b11-da25-f6891bee0e21@metux.net>
 <CAK8P3a1TkKtG3E3U0xxpJrf=qph0dkn27Apd99EaHMAPOfPtpw@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <a2758c4b-ac49-e731-46b0-6990c3534da7@metux.net>
Date:   Fri, 22 Mar 2019 19:26:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1TkKtG3E3U0xxpJrf=qph0dkn27Apd99EaHMAPOfPtpw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:bSe+Olam9USK9i2uYUIcf8hKg6LQRrsne84NaUsaxvdAPmTH7Vu
 jxi81wIAfHi2SxTORg+ez2mHiaif6iujtitzIni8fIVIluwYRSsqdLiO1kmUDfD4ULjdaEn
 HXAUA0Sc8WbboA+skoVt0A2IYBggn75ZefrRDa2ldFVE57l7bzvI3LRa+Lh0e+KLjjqc3c4
 jFdpn9Y3i7Qz+xqNBQz4Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fOXTrWO7Pzo=:NiLwjYy//DnkBhhDbobLwZ
 8NA0ee1rEB3H6+WDbIN3hPzq6iL+95K9bpvaDIy1rPfwfkMm1EDbLIstIEU3f6cgn4aozsrNA
 l6PYiIkn5zxyQMEi7Q0KfLFXsxvBgPY9BqtKL4Wgd2Tqk9SRH2ljZJ34LvT37o6fHwtojfnPU
 akn1J+TpsFal5ySNH+kB8vl1XsdNaqnsaHY2y/F79KQyybll591ji41C0hRjQ4AJcFu66TrXQ
 +teJ3J3KrKpJ/sR///ztuJ8oeDZV7Mto+TfIhrifCB8UoVvg7DiQbxfNQL5TEj6T7bRFG8/8U
 aTdTWSya1IMVUIgsgtcafdWz5gIeGt08DIr19wbUGMejSZJ3rDVqf2YLT9dAq3jTTObtQlFkA
 4bNXwHpFE7Y/e7625lUZk6VT7yi6PKHgOQyVIpVU9jV6LHzLaSUQdG6VhKSgmvV2gkecgd2Bq
 qT2y+vpJoP7Ag9lm7uhkFw+nVCNUdxHDC3rb2HpIF92gy2GzdYqCZNMGo/K1IWk3/tTi8yB8z
 ACjaUEhhvAgtCjSj8PUAgUuT82FxXlN2ZIqPN3dW7FbX+yW5HXCcCx4LmXlwKhzsLZa47F8FE
 MeotpFARtX5vZb+baTyvasxQz1KzUXP7qIeT4jegN5cVd7jfsG3KVB1d1zZx3qLJQ8WGsEAzb
 ZJV/mjkjrFT1CGsTYcSKMkzC8rOevGR6COuVppklXO/dl54rMzSIgRBhWZz+zqCNifquaLtHC
 21ZXzS2L7xHM3dsRulV9w8GiMYE9YuvqZkUCURwwXFld713IAYH0UsNTjxE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.03.19 09:53, Arnd Bergmann wrote:

> I think serial port drivers typically have a limit on the number of
> ports, so we likely need the same here. 

Except for earlycon (haven't had a closer look at it yet), I don't see
any hard reason for that (maybe Greg could give us more insight here).
I seriously doubt that these boards could be relevant for earlycon.
(hard to find a machine that needs serial earlycon while not having some
uart on-board ;-))

> However the number of boards should not be limited in the mfd driver
> that just exports the serial ports to the serial driver.

Exactly. And there should be any global arrays for these boards, where
every access runs through. Or even worse: looping through it, to find
the right entry, within ISRs.

>>> +> +static int snx_ser_port_total_cnt;
>>> +> +static int snx_par_port_total_cnt;
>>> +> +
>>> +> +int snx_board_count;
>>> +> +
>>> +> +static struct snx_ser_driver sunix_ser_reg = {
>>> +> +     .dev_name = "ttySNX",
>>> +> +     .major = 0,
>>> +> +     .minor = 0,
>>> +> +     .nr = (SNX_SER_TOTAL_MAX + 1),
>>> +> +};
>>> +
>>> +can't this be const ?
>>> +
>>> i prefer keep it in current format.
>>
>> Why ? do you ever have to write into this struct ?
> 
> I think this will just go away after the rewrite into a proper
> layered driver, so it doesn't matter.

That's exactly the point, which I've been repeating over and over again.

By the way, one more weird thing that slipped trough my previous
reviews: he's redefining standard structs and typecasting them.
Actually, he copy+paste'd large parts of the serial and parport
subsystems.

> The best way I can think of to do this would be to have a nested
> irqchip in the mfd driver that handles the per-board interrupt and
> provides a unique irq number to the individual port drivers.
> This makes a very simple irq handler in the port driver, and keeps
> the multiplexing where it belongs.

Exactly. That's the way it works w/ lot's of other composite devices.
(I recall some exotic daq cards that work similar way)

@Morris: please try to find a fitting generic, configurable irqchip
driver first. If you don't find one, talk to us and give us a detailed
explaination how that part of your cards actually works, so we could
write some generic driver. I might have some customer specific devices
that could also benefit from that.

--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
