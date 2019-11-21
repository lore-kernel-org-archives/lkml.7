Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF873C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 09:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C58AD2067D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 09:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbfKUJ4m convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 04:56:42 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:43841 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfKUJ4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 04:56:42 -0500
Received: from [192.168.1.176] ([37.4.249.139]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mxm7U-1hd7P62Opq-00zCP9; Thu, 21 Nov 2019 10:56:38 +0100
Subject: Re: BCM2835 maintainership
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Stefan Wahren <wahrenst@gmx.net>, linux-kernel@vger.kernel.org,
        Eric Anholt <eric@anholt.net>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
References: <68580738-4ecf-3bb7-5720-6e5b6dafcfeb@gmx.net>
 <e225fdf0-1044-cc3e-89f8-a569596e8bce@gmail.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Openpgp: preference=signencrypt
Autocrypt: addr=stefan.wahren@i2se.com; keydata=
 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 AQ==
Message-ID: <52c0e259-9130-fa56-a036-dec95d4bd7d4@i2se.com>
Date:   Thu, 21 Nov 2019 10:56:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <e225fdf0-1044-cc3e-89f8-a569596e8bce@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Provags-ID: V03:K1:ZKrFEQKh0r5+Cjemk1EJES9nCeyr8sxa7zVcraYtSZ3b755gIWr
 wjyz5KcnjOqdGlWn4rdKUpiWog+H8pJTE+x+Nzd05bDEr4kK2H25/9fXYstLSanUW3jzewx
 Tj4xc0FpFBgHKYn9PU7QO9c9IIkMD5wPMGsGCVeVZuU4WQyKjStTD793LdkmH0/V01JsqIg
 89mNEpTsMX6o+EI5hRICQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nopXtamzJXc=:uagwP3eQLw+KO2KD+MUAZp
 9DSLyxrkrfOVbximLq/IhMXH9neuQjRDxGk7VhAIIYAq8Gi5WP/VHmXR6bBqSVlsCm8hN09jS
 Xl/D/3wUpRHyf++j4PMlC1LtbyKclUJs/qXrv7eS+ZZWCxJbk2EGJcEZ3TOAnRF495z20IaoQ
 V1RtO9VpIliFbRqua4QFt7JbilRinPUFcdvpZ5ABx+TrMiCoKvFMKZHpXnH7wh4PEQrEo4c2c
 gtYkMPntwifXboNGJuRJRfD/JDlZFrvopEvI/glJ841e9xFtBZ5MyCkQble0j6AzIvbOWK6LU
 8wp3Osu9KjwfNjv70ilIh6KgnQiaavwv2ETSv41W2WEseq1JEZF/cXAU5okOrAIsLd1yppb/p
 1hFQPp+BP2JcpktF3thqns93I54+IX/+01JTyN09n6g+UDC77fFQ0L/GvUT1PgZvPUaz8j3fd
 JtqpPd5nWttOJuVPPqV8W2Sl5WBTcFBP2N2siEm72cSKM/9/HYlsnYFRmpS70lT742bcg481E
 2xxwx44YN4aiEJdKH2Vh9k9CKw7JFZEWjFK5ZRGKIZxf8i3S0IC2D+mnsnRqKrQsqmhleFToZ
 hK3vQbL4531n7DnT4vGOgx4G5KuNeCpU4qjk3qUjYqYizgG+5VVl8IOSo1a/QN8GvxIZMZVdD
 snYAfPP0b4+9g7HjXgFxdPy1AIDcIT5yljmJjaU96VjtBq+ZyWUTMbM+MlbXXtW75KYjXcsbM
 ySJ4J2Q1NwrTOGZVm/xnTfLS7Ab1JKa/VFEhYleyEgUIybOq+yeF0SU1CPKAss8ZxBJFxOmBJ
 t5Wc/svl0yrq2l5CEmT1j9aVASGCGdNB0yCUkz3SEd/Z4rvCbFCi2W87oKvxTOng/qb3o3ywC
 2tByHphWvFo9hTD4HLRhkRUvhYUj9pOFP6htUlysM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 20.11.19 um 22:54 schrieb Florian Fainelli:
> On 11/20/19 3:38 AM, Stefan Wahren wrote:
>> Hello,
>>
>> i need to announce that i step back as BCM2835 maintainer with the end
>> of this year. Maintainership was a fun ride, but at the end i noticed
>> that it needed more time for doing it properly than my available spare time.
>>
>> Nicolas Saenz Julienne is pleased be my successor and i wish him all the
>> best on his way.
>>
>> Finally i want to thank all the countless contributors and maintainers
>> for helping to integrate the Raspberry Pi into the mainline Kernel.
> Thanks Stefan, it has been great working with you on BCM2835
> maintenance. Do you mind making this statement official with a
> MAINTAINERS file update?

Sure, but first we should define the future BCM2835 git repo. I like to
hear Eric's opinion about that, since he didn't step back.

>
> Take care.

