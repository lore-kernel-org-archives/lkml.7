Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3869FC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 08:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9BD320862
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 08:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="a76ctJJz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfEOIHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 04:07:37 -0400
Received: from mout.web.de ([212.227.17.11]:42515 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbfEOIHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 04:07:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1557907624;
        bh=wGgtyG7s8Xi5q2TfCbpHBCs0b9c88mIx0Dghq+S6ssk=;
        h=X-UI-Sender-Class:Subject:Cc:References:To:From:Date:In-Reply-To;
        b=a76ctJJz+YROcMudunJNSJu4g/BP7a2HIJedN4qvcG8CUillkOSf/NeE7MQ/iLqKf
         RIpigOEu4tyUUPJ7GTdv9rexOqN7ZYQdPkyYpirVcZZwGI7LSxFjmHUSkU5NHE4L3P
         4QVyfH8TifCZtcCEjp/M9RF+EyY8ywwxzvIMabuY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([2.244.73.153]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MYNrh-1hDKYb1Mo5-00V98z; Wed, 15
 May 2019 10:07:04 +0200
Subject: Re: [3/3] Coccinelle: pci_free_consistent: Extend when constraints
 for two SmPL ellipses
Cc:     Julia Lawall <julia.lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Yi Wang <wang.yi59@zte.com.cn>,
        Cheng Shengyu <cheng.shengyu@zte.com.cn>,
        Ma Jiang <ma.jiang@zte.com.cn>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
References: <201905151538552354689@zte.com.cn>
To:     Wen Yang <wen.yang99@zte.com.cn>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 mQINBFg2+xABEADBJW2hoUoFXVFWTeKbqqif8VjszdMkriilx90WB5c0ddWQX14h6w5bT/A8
 +v43YoGpDNyhgA0w9CEhuwfZrE91GocMtjLO67TAc2i2nxMc/FJRDI0OemO4VJ9RwID6ltwt
 mpVJgXGKkNJ1ey+QOXouzlErVvE2fRh+KXXN1Q7fSmTJlAW9XJYHS3BDHb0uRpymRSX3O+E2
 lA87C7R8qAigPDZi6Z7UmwIA83ZMKXQ5stA0lhPyYgQcM7fh7V4ZYhnR0I5/qkUoxKpqaYLp
 YHBczVP+Zx/zHOM0KQphOMbU7X3c1pmMruoe6ti9uZzqZSLsF+NKXFEPBS665tQr66HJvZvY
 GMDlntZFAZ6xQvCC1r3MGoxEC1tuEa24vPCC9RZ9wk2sY5Csbva0WwYv3WKRZZBv8eIhGMxs
 rcpeGShRFyZ/0BYO53wZAPV1pEhGLLxd8eLN/nEWjJE0ejakPC1H/mt5F+yQBJAzz9JzbToU
 5jKLu0SugNI18MspJut8AiA1M44CIWrNHXvWsQ+nnBKHDHHYZu7MoXlOmB32ndsfPthR3GSv
 jN7YD4Ad724H8fhRijmC1+RpuSce7w2JLj5cYj4MlccmNb8YUxsE8brY2WkXQYS8Ivse39MX
 BE66MQN0r5DQ6oqgoJ4gHIVBUv/ZwgcmUNS5gQkNCFA0dWXznQARAQABtCZNYXJrdXMgRWxm
 cmluZyA8TWFya3VzLkVsZnJpbmdAd2ViLmRlPokCVAQTAQgAPhYhBHDP0hzibeXjwQ/ITuU9
 Figxg9azBQJYNvsQAhsjBQkJZgGABQsJCAcCBhUICQoLAgQWAgMBAh4BAheAAAoJEOU9Figx
 g9azcyMP/iVihZkZ4VyH3/wlV3nRiXvSreqg+pGPI3c8J6DjP9zvz7QHN35zWM++1yNek7Ar
 OVXwuKBo18ASlYzZPTFJZwQQdkZSV+atwIzG3US50ZZ4p7VyUuDuQQVVqFlaf6qZOkwHSnk+
 CeGxlDz1POSHY17VbJG2CzPuqMfgBtqIU1dODFLpFq4oIAwEOG6fxRa59qbsTLXxyw+PzRaR
 LIjVOit28raM83Efk07JKow8URb4u1n7k9RGAcnsM5/WMLRbDYjWTx0lJ2WO9zYwPgRykhn2
 sOyJVXk9xVESGTwEPbTtfHM+4x0n0gC6GzfTMvwvZ9G6xoM0S4/+lgbaaa9t5tT/PrsvJiob
 kfqDrPbmSwr2G5mHnSM9M7B+w8odjmQFOwAjfcxoVIHxC4Cl/GAAKsX3KNKTspCHR0Yag78w
 i8duH/eEd4tB8twcqCi3aCgWoIrhjNS0myusmuA89kAWFFW5z26qNCOefovCx8drdMXQfMYv
 g5lRk821ZCNBosfRUvcMXoY6lTwHLIDrEfkJQtjxfdTlWQdwr0mM5ye7vd83AManSQwutgpI
 q+wE8CNY2VN9xAlE7OhcmWXlnAw3MJLW863SXdGlnkA3N+U4BoKQSIToGuXARQ14IMNvfeKX
 NphLPpUUnUNdfxAHu/S3tPTc/E/oePbHo794dnEm57LuuQINBFg2+xABEADZg/T+4o5qj4cw
 nd0G5pFy7ACxk28mSrLuva9tyzqPgRZ2bdPiwNXJUvBg1es2u81urekeUvGvnERB/TKekp25
 4wU3I2lEhIXj5NVdLc6eU5czZQs4YEZbu1U5iqhhZmKhlLrhLlZv2whLOXRlLwi4jAzXIZAu
 76mT813jbczl2dwxFxcT8XRzk9+dwzNTdOg75683uinMgskiiul+dzd6sumdOhRZR7YBT+xC
 wzfykOgBKnzfFscMwKR0iuHNB+VdEnZw80XGZi4N1ku81DHxmo2HG3icg7CwO1ih2jx8ik0r
 riIyMhJrTXgR1hF6kQnX7p2mXe6K0s8tQFK0ZZmYpZuGYYsV05OvU8yqrRVL/GYvy4Xgplm3
 DuMuC7/A9/BfmxZVEPAS1gW6QQ8vSO4zf60zREKoSNYeiv+tURM2KOEj8tCMZN3k3sNASfoG
 fMvTvOjT0yzMbJsI1jwLwy5uA2JVdSLoWzBD8awZ2X/eCU9YDZeGuWmxzIHvkuMj8FfX8cK/
 2m437UA877eqmcgiEy/3B7XeHUipOL83gjfq4ETzVmxVswkVvZvR6j2blQVr+MhCZPq83Ota
 xNB7QptPxJuNRZ49gtT6uQkyGI+2daXqkj/Mot5tKxNKtM1Vbr/3b+AEMA7qLz7QjhgGJcie
 qp4b0gELjY1Oe9dBAXMiDwARAQABiQI8BBgBCAAmFiEEcM/SHOJt5ePBD8hO5T0WKDGD1rMF
 Alg2+xACGwwFCQlmAYAACgkQ5T0WKDGD1rOYSw/+P6fYSZjTJDAl9XNfXRjRRyJSfaw6N1pA
 Ahuu0MIa3djFRuFCrAHUaaFZf5V2iW5xhGnrhDwE1Ksf7tlstSne/G0a+Ef7vhUyeTn6U/0m
 +/BrsCsBUXhqeNuraGUtaleatQijXfuemUwgB+mE3B0SobE601XLo6MYIhPh8MG32MKO5kOY
 hB5jzyor7WoN3ETVNQoGgMzPVWIRElwpcXr+yGoTLAOpG7nkAUBBj9n9TPpSdt/npfok9ZfL
 /Q+ranrxb2Cy4tvOPxeVfR58XveX85ICrW9VHPVq9sJf/a24bMm6+qEg1V/G7u/AM3fM8U2m
 tdrTqOrfxklZ7beppGKzC1/WLrcr072vrdiN0icyOHQlfWmaPv0pUnW3AwtiMYngT96BevfA
 qlwaymjPTvH+cTXScnbydfOQW8220JQwykUe+sHRZfAF5TS2YCkQvsyf7vIpSqo/ttDk4+xc
 Z/wsLiWTgKlih2QYULvW61XU+mWsK8+ZlYUrRMpkauN4CJ5yTpvp+Orcz5KixHQmc5tbkLWf
 x0n1QFc1xxJhbzN+r9djSGGN/5IBDfUqSANC8cWzHpWaHmSuU3JSAMB/N+yQjIad2ztTckZY
 pwT6oxng29LzZspTYUEzMz3wK2jQHw+U66qBFk8whA7B2uAU1QdGyPgahLYSOa4XAEGb6wbI FEE=
Message-ID: <c143337b-a28c-4a63-f22a-421c283969d0@web.de>
Date:   Wed, 15 May 2019 10:06:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <201905151538552354689@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
X-Provags-ID: V03:K1:vcZkvzz4u/9fmS4znTYwPin3Ufd3nU+TSiPufr3CN+WGeMuNYuE
 VtqqU9hdJ5B8wcRRN7fc02mVU5cyJWCBCnbX9azC2E1s8Rf8rVY1zIzhJHXWCr3+BUcaERV
 wNbqtEd8Nqa5FQUPJYYJftR5o51/Ody+hJ6bnmt1SpuMlmB+T9hGjrhq5Qk5go/yN6cQI6J
 HNRoDl5NZV8IeKdjM3cwg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VpntcQ0WQP0=:rWduy9LweeQOGJgZhJ2A0w
 j465NpeAFotSa7gHKstnJKWXeDv4Apuum/YbILlgB6CQOo73DfZRTs/rI/GWGy6elXmRPECaC
 sSuVw0Tn4WHHmMQZNDftbwp/yUSEt3gxcCwhTtJTG4BYlqI1b1lh2O+Nd6kEFF+YtqQvaazVp
 ozuABXMtPxM/fiK6lg2uHaNDvlOPIvFhhRhryY3zzHDLuXsAmmsSNRJmPgrLeUG0fl3j816bg
 pdvmkQP+phA+ITsnAmM5wH3YSKk2hHtTCA1DWC48GVxoN5wWY1ch5fkropcNqSkZQPIWjYB8M
 INiEDUOUSiE1/lt3WYGGUK3n7INwRfYt4mpR+uB15x2E3J83ZywPzeZvh6qzzCvaeDYMRJUh2
 skh3N32YHqwyI1ut7W7p0iIg2w57tlyuXWVZRBInmd1TUZ1TjA5RINat7+2iLFSInKlG5q0Zu
 JGUw9N9sTZOd1+/nMPNL6Sw3lAEHil4jvLR7LCbl4rPPBoAVLB7qOBZYVIlXUsIbDVWCVQpTg
 RbfMMWJWuRthf2XbbUp6E8iFvSo5QKDo1c/Wbxykd/I0TRKV76t/VQG60SApv79zC1D5z0BjB
 u9j3ZEm6vD87HcNym2xortGL1XQTQefDJmVYrnlWu4bwyQqUREIsZhd+hrxHRWd37/ThRiDOx
 /+2xwu6VKwoZdmzXY6b7vpwn5f7OPA2/snVb738H3weWNaWm8N6YR4z8yxkZphXb1NuYNSkwp
 8j0kZ3BN4R3frpQ93GxP1ixuDXYwy2NECTQOKsobpHkS99Lu9QD6x5YCgKWQx6JRxKvKk+iuy
 QwPYJAzR8+JBiNDan6leWPvTgxNP6c8QTwHTIvD9xIdJW6ce4yKNvmum7MphQXmus43VH2U93
 Kp7Hy0L8Zg1vbkmx+DL1ZHakA/T4GokYu9ijXRPzvcdFMIwTYVGPh+7Gr4QrkIxLHZ9xrg9U3
 3GdTEwzbHKw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't think it is an environmental issue.

You are right about taking other parameters better into account.


> Theoretically, the original SmPL should find bugs.

I expect also that both script versions should display a warning.


> Although, I still send you my environmental information:

Thanks.


> spatch version 1.0.7 compiled with OCaml version 4.06.0

This shows that our software variants are recent enough.


> You may not take a serious look at the pci_free_consistent.cocci script,

I try to handle my update suggestions and your constructive feedback seriously.


> it needs to pass in the virtual variable report.

I did that a moment later.

I would like to apologise for a temporarily inappropriate parameter selection.
How will the clarification of the shown software behaviour evolve further?

Regards,
Markus
