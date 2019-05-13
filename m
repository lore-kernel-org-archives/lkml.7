Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C1CC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 11:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0B9D2070D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 11:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="EmXJpt6q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729465AbfEMLdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 07:33:31 -0400
Received: from mout.web.de ([217.72.192.78]:49161 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729381AbfEMLda (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 07:33:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1557747190;
        bh=hWKKnFRsa+3m1hGtDBpvsWB9iedCXp+Cnv6KBMp460U=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=EmXJpt6q71TOdWlKFjYa0ykP6gYHb0U9xJLupE8vvWHDUtv9smSR+h2aRqC8vYMa/
         HvOL9QG2YbTNJE7xoN+60fCbPgVZ+/NapclSWKa56/B6DU0wYF3LCma8xzTgpYqieJ
         DIk9aTeMAnL2H7zBVfgNSgjJ+qazSFG64ENsCp3A=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.135.147.80]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M9os0-1hWn2E2tDs-00B6gi; Mon, 13
 May 2019 13:33:10 +0200
Subject: Re: [1/5] Coccinelle: put_device: Adjust a message construction
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Wen Yang <wen.yang99@zte.com.cn>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org, Yi Wang <wang.yi59@zte.com.cn>
References: <1553321671-27749-1-git-send-email-wen.yang99@zte.com.cn>
 <e34d47fe-3aac-5b01-055d-61d97cf50fe7@web.de>
 <308f5571-68f3-7505-d5ad-59ee68091959@web.de>
 <alpine.DEB.2.20.1905131133570.3616@hadrien>
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
Message-ID: <97f32bc1-f7ff-5777-21b5-5c4f85bb7276@web.de>
Date:   Mon, 13 May 2019 13:33:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1905131133570.3616@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kEajgUNaCNA/r3NAUORSFSPJCcCHfStgEhz7ys7p7Z+y8KlKhGw
 xG7rICOYzYV1P5c5GsSBfIz/4c038XB2XCH/FkGf/QV1ZdcjW83JrPtyalIAQdOVfcZy1Yc
 8GZuYet2FqeEubEfnazccOpZcd6j2Df0i/O8y8otxipeRu4jlm9BNqiPSmQFtf1b5i8KhL5
 6rm1ZYmP4C/yHmKDPJsNA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9XNn3HGI/vg=:yjoz1i8hZIqAd1q6Xbc5CM
 28+dxQMhV4eXUJUySb/WfXNqqSKceacQT0gXvJRgGnzPs3dVhqg6doq/1l/8kCzhAz6mnVhaN
 9tNArmaDK0MjHEN7/znKaEJEYfsggMgd5tCRxnl58e+R33W2Ug5o3hleUdQuBlkWY9n2mTg0V
 OWRPj5Ul98RzwmI2ROk37CtuCr51o/1M+Y9hYIYFqXt9vbRDYBIRQR6q4jTM0+9j9yFOmTMA4
 5n4qXJKsPu/rmio12zESuyqY07nQKdJ1sKxtPr2FUECzGFaQm17MvPJzrkGSza2HnDOY1Ehh0
 oQ9odV5WaQ67B9vf2aAXOwGTOjcqOSIMcefKqCr0Lk2Np1jOAB4SFGAG0p3z8Dr66KRGURfeU
 Nk7oopxgS1GhAvW4xbdSdAkUvpL2CL4IFQwS/AG9z6+SgehIzLZbjeCbPsI9xZRDypUdcKz8/
 1QzTpfqw6XGwVYPc15DhCKGZ6pIfteQHW56f2qnsMxMQzbiq5+hH+JtqG76UQ2fqBjNWAivrw
 gbzSEJ5a1NWXi+nnU97HLY7hkHJBmgqFxBbqPInd2Tdk6+Iw638Ucw6fOVVz/CxnBCJy2LjQd
 tYHJjFXqITiJ1/IPfBA/7+jrP+gj0W+pbjUauEfdbGYKhhGOFmZ7RG4GQEBNPgazRWpyE6uFc
 4zeINiNCSfzEgoXRu3xdenFhDk34palmHUqCm2M1p2FCERRpnuURL9mwSTGQTsWu5nDDWS7K7
 9CdTmoLntiyJCtFA0T1E8a3Lyl6nQIRr7YAnJxDbTLxqQBc05d5swRhCsD1aa7pkkPwOfJLYa
 ZvyqIlQN0Ir6SJ3251KfVPx0XDvLB8CendmJqlGD4vSCw0PA/ZIZaEbaZnII+gFtc0Jgy44nU
 Puiqwwnu2YvcAH4Z6HmZau6HDykc4suUFRFa3i21I0azEp2V8DP8ZPseWauWdV4xHE9m9y7WI
 9jm/STVnRqg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Thus simplify a message construction in a SmPL rule by concatenating te=
xt
>> with two plus operators less.
>
> Is there any way to unindent, so that the string doesn't exceed 80 chara=
cters,
> or at least no so much?

How does your concern fit to the string literal tolerance from
the Linux coding style?


> On the other hand, I would have much preferred the original msg =3D code=
.
> I don't understand why it is so offensive.

I suggested again to avoid the use of extra variables in such cases
(also in the discussed bit of Python source code within a SmPL script).

Regards,
Markus
