Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6248BC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3695B20663
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:10:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfCGAKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 19:10:31 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:50847 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfCGAKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 19:10:30 -0500
Received: from [192.168.1.110] ([95.118.27.116]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N64FC-1gzXxg0rsG-016QsF; Thu, 07 Mar 2019 01:10:16 +0100
Subject: Re: [PATCH 2/3] x86: apuv2: fix input dependencies
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Linus Walleij <linusw@kernel.org>,
        Enrico Weigelt <info@metux.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org
References: <20190304201930.1622839-1-arnd@arndb.de>
 <20190304201930.1622839-2-arnd@arndb.de>
 <a94c3c6a-481e-96a5-74e1-8c3299c74129@metux.net>
 <CAK8P3a0vdhCTNTF-K0mXjRWkPvv0qr3nf_52=8n6zTa7p3ELLw@mail.gmail.com>
 <54a7d035-155f-c47b-1db1-acb851b3aec6@metux.net>
 <CAHp75Vcd0eNCBtxb1huMBGFF9JXmropHv2YA1eh-yK3iMFfuFQ@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <82c978b2-e9c4-e178-e4b7-621729c2cee4@metux.net>
Date:   Thu, 7 Mar 2019 01:10:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAHp75Vcd0eNCBtxb1huMBGFF9JXmropHv2YA1eh-yK3iMFfuFQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:MloCdW3sSYfzcOWJsSDRJl+kXq8oJVMJuIs2KT+ATagaT+a/6aG
 +73MbvR4afK8aBQ2Au86BBEcEpar3esOjHCdsPTIvjn64JavukHQIJY3P9v94nYGNgZ6SlO
 hjG4wCfWuhdicD+Hojlj0+Waawc7jzh3UkKQGcFXTM2sZjP8sdxg3Lu0oI3BVOIY8wslC7M
 fGp/V85tpz7Tu9PEOr6yA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Id01FdiGr1o=:NP8pfoXNumMgSRvQrKK2MD
 N/Smo4ru+9hJnNStAGXXQGIpC7nhMN5gyb+TeiuyxGoYxr3PuStKzY/H7I5GIveKZrqTF3jPI
 yfQdYaFPYL+qF8qazr2tNvJTV2jAZDBa+r6OzqM845B2S5M9/7If0FYLKPpIbxLeisDsNKWNe
 LsWTiHABTRAytDOrea+xqaP2UGHpGmS6eroRDk32rj3c3kFd2Gs4Hb8JHIzxr6sNSqby/OHNB
 ODRzvyfoHh/WJMml1MADPl9IJD+h6yg84BOLtNwp1wYPAOtyHQIer0AbHsQJQFIooIVo5xR8j
 1NGEtmQJG85JeblmJ9u2fmLhCLnXzzPxOa7SA2qkiYRpdRg1Tel/O66LRMzLiSuQelJMlkpzu
 HD14K41Xf9Lk/2xxq3g7fPo2X7OZtSna5AvAvD5Vf7n6tgUuZ7V4TOd1JiQOUBtNc3q+SXm4E
 G+83fILYpYEoCM7mb51pg5YOWog2ryvT2RMifG9g+GfZrWzfMYGSwvNyM9JKelBzczTWPTaKP
 z+X+NgrYDq/fU9lHNWv6UYpaEwrCdQoUduPwrWtTZkqp+FOgwj4CyIF1Yf4S1WwXOLgJASyeJ
 NVTAmVTdvayEjXV3Pd5/64ERFKUWIXCbIkFYkG440aGEUkok9aYirL0JIirNsG+dZm6oHEw5x
 dRwr7/mquzcB/4S+nU+kZ08INMTCHH9boM8pJeSGIRxhcSNFOKoZ2GiCRS0Zuzj5dqtOdQrwP
 djaa3U7/38shT9ZH8lsZFFKEyeasviPULfjAH5A627VXBU1lwZhERI8+iPk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.03.19 14:56, Andy Shevchenko wrote:
> 
> Darren gave a talk about merging kernel configs to get something like
> you want to.
> This tool is quite long already lying around. merge_config.sh in your
> kernel source tree.

Yes, that's similar to how some distros (eg. yocto) do it.

But my requirements are a bit more complex:

In my final meta-config, I just wanna say:

* i have board A (possibly multiple boards)
* i need features X, Y, Z (eg. eth, display, can, ext4, acl, ...)

And that shall be all to generate a minimal config for exactly those
requirements.

Doing that by just putting config snippets together, quickly turns into
a maintenance hell. At least you'd need recursive dependencies and some
if/else logic.

That's why I've written kmct:

https://github.com/metux/kmct


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
