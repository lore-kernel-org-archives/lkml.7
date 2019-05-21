Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CABC04E87
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 17:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 495B621019
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 17:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="jhWzize6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbfEURRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 13:17:08 -0400
Received: from mout.gmx.net ([212.227.15.18]:60433 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727898AbfEURRI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 13:17:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1558459018;
        bh=b4tRpAFHn5wBHWDLYGRT+s66QoAqsqd+5/YjAdJgvwY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=jhWzize6hBJEhBZZGwBwTWeW0qHX0/eYGnGshNFRIxy3KhXKjdcMgp4KXuOfAowHs
         S2IsziUABL3OhLEhC+JKWXaW3bcs6icBbvTMcnQlDs8IN8RDBTO3jIC4JoS4XJe5Sa
         VH/Hosgo7mrnmwFYHqMrqpYwEai84UpGDrTvCcF4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.186.77]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MaZrd-1hE5ZL0OvR-00K6gR; Tue, 21
 May 2019 19:16:58 +0200
Subject: Re: [PATCH] parisc: Kconfig: remove ARCH_DISCARD_MEMBLOCK
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1557898882-28507-1-git-send-email-rppt@linux.ibm.com>
 <20190521155440.GD24470@rapoport-lnx>
From:   Helge Deller <deller@gmx.de>
Openpgp: preference=signencrypt
Autocrypt: addr=deller@gmx.de; keydata=
 xsBNBFDPIPYBCAC6PdtagIE06GASPWQJtfXiIzvpBaaNbAGgmd3Iv7x+3g039EV7/zJ1do/a
 y9jNEDn29j0/jyd0A9zMzWEmNO4JRwkMd5Z0h6APvlm2D8XhI94r/8stwroXOQ8yBpBcP0yX
 +sqRm2UXgoYWL0KEGbL4XwzpDCCapt+kmarND12oFj30M1xhTjuFe0hkhyNHkLe8g6MC0xNg
 KW3x7B74Rk829TTAtj03KP7oA+dqsp5hPlt/hZO0Lr0kSAxf3kxtaNA7+Z0LLiBqZ1nUerBh
 OdiCasCF82vQ4/y8rUaKotXqdhGwD76YZry9AQ9p6ccqKaYEzWis078Wsj7p0UtHoYDbABEB
 AAHNHEhlbGdlIERlbGxlciA8ZGVsbGVyQGdteC5kZT7CwJIEEwECADwCGwMGCwkIBwMCBhUI
 AgkKCwQWAgMBAh4BAheAFiEE9M/0wAvkPPtRU6Boh8nBUbUeOGQFAlrHzIICGQEACgkQh8nB
 UbUeOGT1GAgAt+EeoHB4DbAx+pZoGbBYp6ZY8L6211n8fSi7wiwgM5VppucJ+C+wILoPkqiU
 +ZHKlcWRbttER2oBUvKOt0+yDfAGcoZwHS0P+iO3HtxR81h3bosOCwek+TofDXl+TH/WSQJa
 iaitof6iiPZLygzUmmW+aLSSeIAHBunpBetRpFiep1e5zujCglKagsW78Pq0DnzbWugGe26A
 288JcK2W939bT1lZc22D9NhXXRHfX2QdDdrCQY7UsI6g/dAm1d2ldeFlGleqPMdaaQMcv5+E
 vDOur20qjTlenjnR/TFm9tA1zV+K7ePh+JfwKc6BSbELK4EHv8J8WQJjfTphakYLVM7ATQRQ
 zyD2AQgA2SJJapaLvCKdz83MHiTMbyk8yj2AHsuuXdmB30LzEQXjT3JEqj1mpvcEjXrX1B3h
 +0nLUHPI2Q4XWRazrzsseNMGYqfVIhLsK6zT3URPkEAp7R1JxoSiLoh4qOBdJH6AJHex4CWu
 UaSXX5HLqxKl1sq1tO8rq2+hFxY63zbWINvgT0FUEME27Uik9A5t8l9/dmF0CdxKdmrOvGMw
 T770cTt76xUryzM3fAyjtOEVEglkFtVQNM/BN/dnq4jDE5fikLLs8eaJwsWG9k9wQUMtmLpL
 gRXeFPRRK+IT48xuG8rK0g2NOD8aW5ThTkF4apznZe74M7OWr/VbuZbYW443QQARAQABwsBf
 BBgBAgAJBQJQzyD2AhsMAAoJEIfJwVG1HjhkNTgH/idWz2WjLE8DvTi7LvfybzvnXyx6rWUs
 91tXUdCzLuOtjqWVsqBtSaZynfhAjlbqRlrFZQ8i8jRyJY1IwqgvHP6PO9s+rIxKlfFQtqhl
 kR1KUdhNGtiI90sTpi4aeXVsOyG3572KV3dKeFe47ALU6xE5ZL5U2LGhgQkbjr44I3EhPWc/
 lJ/MgLOPkfIUgjRXt0ZcZEN6pAMPU95+u1N52hmqAOQZvyoyUOJFH1siBMAFRbhgWyv+YE2Y
 ZkAyVDL2WxAedQgD/YCCJ+16yXlGYGNAKlvp07SimS6vBEIXk/3h5Vq4Hwgg0Z8+FRGtYZyD
 KrhlU0uMP9QTB5WAUvxvGy8=
Message-ID: <f88c865d-b571-8539-8b5d-4881f076e084@gmx.de>
Date:   Tue, 21 May 2019 19:16:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190521155440.GD24470@rapoport-lnx>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:z6yPIt9fr6IA4tatm73yNXLnn3vTEXWwetcw645+ZriqnF8CXI/
 21xu47v7RzjVGqnlSPuXjkPSK1YDPekXiyQc1O9Ff/nVxkO6pIlImWauvF43NbioI3lhoW5
 yfR3CUdKrpXz701fEG69tWWjJBGD9TbwvvqlWse8dUpymMzYxURjnLHbUhhRr4yYZTMUtgs
 BlaX7karSGCK8uxdysa6Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:R8tia37MbDU=:crN8G17NP8W9NgwjNMuxH0
 2RtLsSlCm2P2NvTjilwAzzLRFZ3WRaezXrEzh7TpNkL36Ss2Fk7f3mBdc2Hc2mgJG58bwPuKZ
 mIdveewiWbd9TcNTUkPHENQZznnXWhuOfgqrQmovjNUMGUK0WhBuqlpPJi91DbeVrOtJB7w0y
 HxfdS5JGLixWP55CrBUtuTMvTA1D+yK/qm8vKnKaJbz6zOsHCqf+O8+9YGNRJ11GElstm/O3H
 Kn/hYYtGZ1k3KAIrMjvcSKreFGOMClRU4fv/P46yjX66WuVfDyFJ0Ks0KIv14/x2t9BMy5V7c
 AZHt1GYX9R+8kaVwHzOpBIfZ82+A8pHBcgm3spZvNNo9oQvwjTAe/8kwEpoLmzH9MtTiSaGWI
 OZhhODdNF5vg1a6lmoMcS6btRqlIayWg5eF+rSZOAsweh9ozRRpck5+jXgjYz418ceL/tzATO
 6PJSsuVR+UUrbps4llT5WNozsxnZDaPQnYh2kYrVP82YA+Hlc5+ikWBnMvD/XgZCiDnii9w+E
 XDZE34O9eQoIgY5AFwiQdSwrd815SQU0PKdi4N7mrudDL6u/KX2C31VGBenXGs5yt3+non7ll
 UkGexAg+EkjpKPP7lOWSMykaqj4RHmKyh5uEjvApqTBu7h8aRlv5PM+pXBa+FAEI9yxLhWuMb
 3lvPU4iV+q2FCd/XlFzmJVV/iP/d2EViTQc48CTJt/iKRbAOJ3SgD5ow14ExCnYDp0qG5X1k7
 0Zq0/gildS5mUBf1sVHbUIyNtEXvJyw/xd2cpBqc8uM2acA2cZmOX6OIc2h89jd3YTO0EUfs3
 oPy/Pbr7LO6sez5UY5+Px8JLJhBbooMDLprZZ2CyvE7j/wCtNHR5Kt8eVYXdGPTrJ7TFI1vTt
 /APCEGtDK2dFXRPISwsyHK+gQ+mKBNY9bZEWOIIRnPrJNzynCEIqcnqsIkfEpS4zTx+H1XZxj
 o0gXIe/kcpCeyF90H23Nd9FFHaoEVPZaqiw846Pas4cO3u+QJeOd1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.05.19 17:54, Mike Rapoport wrote:
> Gentle ping ...

No need to hurry.
It's already included in my git for-next tree:
https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git/lo=
g/?h=3Dfor-next

Helge

>
> On Wed, May 15, 2019 at 08:41:22AM +0300, Mike Rapoport wrote:
>> Since commit 350e88bad496 ("mm: memblock: make keeping memblock memory
>> opt-in rather than opt-out") the default behaviour is to discard memblo=
ck
>> data after init and the ARCH_DISCARD_MEMBLOCK is obsolete.
>>
>> Remove it.
>>
>> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
>> ---
>>  arch/parisc/Kconfig | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
>> index 09407ed..13b95125 100644
>> --- a/arch/parisc/Kconfig
>> +++ b/arch/parisc/Kconfig
>> @@ -36,7 +36,6 @@ config PARISC
>>  	select GENERIC_STRNCPY_FROM_USER
>>  	select SYSCTL_ARCH_UNALIGN_ALLOW
>>  	select SYSCTL_EXCEPTION_TRACE
>> -	select ARCH_DISCARD_MEMBLOCK
>>  	select HAVE_MOD_ARCH_SPECIFIC
>>  	select VIRT_TO_BUS
>>  	select MODULES_USE_ELF_RELA
>> --
>> 2.7.4
>>
>

