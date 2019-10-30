Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1696CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 10:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F4C120862
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 10:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="XLGbyR8m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfJ3Kox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 06:44:53 -0400
Received: from mout.web.de ([217.72.192.78]:38779 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726713AbfJ3Kox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 06:44:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1572432268;
        bh=uAXWlEiYmxo2aJOlUhC7GVJccn79q1+QQsh5oi8tbtQ=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=XLGbyR8mMNf+uTYvj8DlCZgdvFqHTJlqwoiK7uvKz/8/0oyTMSiYGKFcKSWULVLTX
         gy1cIu4878X9p4qNNs3mf4jQlKsGQYV+E0bPudoDnxmvaJkDKjyap2MomSOBGNvzx+
         RrSZDk3CM/R1P3ZlfGk3uLmkjzP3BNGvzzZcI06Q=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.104.79]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MGign-1iCGwn0DfF-00DYzO; Wed, 30
 Oct 2019 11:44:28 +0100
Subject: Re: drivers/phy/tegra: Completion for exception handling in probe
 functions with SmPL?
From:   Markus Elfring <Markus.Elfring@web.de>
To:     linux-tegra@vger.kernel.org, Coccinelle <cocci@systeme.lip6.fr>
Cc:     JC Kuo <jckuo@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Thierry Reding <treding@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Navid Emamdoost <emamd001@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        YueHaibing <yuehaibing@huawei.com>
References: <fe6868a4-01f5-2832-9081-7643be0ab4a1@web.de>
 <3e3f40db-2422-c64d-3825-35f8c2471eb7@web.de>
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
Message-ID: <161bbb97-09d9-f128-bd25-ef9348534144@web.de>
Date:   Wed, 30 Oct 2019 11:44:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <3e3f40db-2422-c64d-3825-35f8c2471eb7@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EgTK2eG0kGIb8LH20nEljck1rGiWAitgvb1fylQu6ysG1dpetPE
 mT8E0H+pUPfhjg9Yzyh8m7xNeSzlNfn8Ysx1e3LY7JGUvNmVcsUzm4Hlf67shfkVCfBEnYC
 SLppvbo9UA4EweSwBMpLgdaV0/3yhRy42NCKSemOYt0m5rHXFyuotnlEpn7dz32TZWCotBL
 8R9MfIJ4ie2Ov/MGPU4jQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tyXXpGMv85A=:uovQwbsWYfUhJb/p7tku9R
 xkMgJJJ9vnAkZGxx31MbiNhswzIkH3VcITNQ8m9utpTaJp+OYSxLbUcN357oP74KasNlERhQc
 P67C9dHxbmKuh6otKVqpLCWgPLtEwWluJRu8WPhsiuUxKqu0RS7GsEOn4TtY0j/ldn3Q5m9wq
 qXp6vPwNn08E5e6W1paMnGcYvy1dO7Gxt1Yrcz6iT7sWxaDVyAB9rCnt59/dFku6bNunybS4v
 OWUXH9rk4TQk1odXzsxrlbgNaUl6tYmWb4+jS5Dt9cyFua360aM6/WDtRB2uTQPJ45ftqa2Lj
 9rt6I2GRgpellihZik/9vfsqRCaA4/DDDfYePIKJEkCqyPsVnFF+Um7KXEDrbIOLgyKZrcWur
 cq87jNie7Neytct0vcsFUAXbVey3OxiNjffRQfFqgLW0lWZXMMU9YL9GGrPMtCxY1t08lBYLB
 6slY8y4KbWAPbc1oBeRchdK61cUQjYqC4E20i0RCfdafUs0eRNbKyXQ5CAVH06ORrrQu1wg5o
 gpmtJub/nHb0KJ1PVmcfz6BCgbVjj+K2T581Y2hPXOu+hGKa8W5MbFDruXYjuM1UP4DJwZzNz
 WWCda//cdTmbSQvXoTqe86bWAwtVeKRzHXZscnbkKq2bhbZ2HClDG0iK0smLY40wQnP3/Xg6f
 jsvVFZL5EjkpVj8KsJ2L9IZadaLeog85BLrE/TBujxwAPrIiSljxXjPzTaui05A5MfEQbXYJ8
 J+dB3ns30tvL1oOuRENw31BrjPTJQt8i1PQqSJOTEcagBXjk1528baZAd28xhGMj4a+5LcvrR
 5pZyyyU22iLPLsfrcl0gQi3NoWY+11nT2Q8thhEkGtvavFIhMBxN11LzM3P3K66ZqLjR2bcA9
 tEZKMuhgb8f1NXIXphpK3mJlhLR3qK+qHIhL+9wa161ebIEqIZwvxQ6gXRljnStRLwOsEIJgb
 7QpByrm9MyJCulCFQcl+22bz/TL02z1VYoqerQuaBxSFryXH1Sxomnhqr5fTjmtFqJHEnQNXe
 sL4oNIinc8t2o99qMWjVAYzZ7aSWov+NFI1M80uwQuCYBCltXYXd3r3uJ4b329yYkvUnZlhCy
 rb1m43TE3REG/txE5kpRHIEgGLpCrUEexoR7hWX/I6erj8qCMhgm/WfqRyNuU5BFtswSpklDl
 PMkF0cf/69nu8zFD39rAUHHpPgOQfj5Jji/9oj+jmk4l/0wmn2GRE4UvrzVwPsfOPleQzx9k0
 5v7A2hsgNoK/CkOIJvzAL/aJKDdwo6or+4MQzOUyoNLK8+IaA1+AeDCqcqzI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Will any search pattern variations become more interesting for correspon=
ding
> automatic software transformations?

I hoped to achieve something together with the semantic patch language
by the following transformation approach.

@adjustment@
expression object;
identifier exit;
@@
 object =3D kzalloc(...)
 ...
 if (...)
-{  kfree(object);
    goto
-        exit
+        release_memory
    ;
-}
 ... when any
 device_unregister(...);
-exit
+release_memory
 :
+kfree(object);
 return ERR_PTR(...);


Do you find such a change suggestion reasonable (in principle)?

But I stumble on another unexpected test result.

elfring@Sonne:~/Projekte/Linux/next-patched> spatch drivers/phy/tegra/xusb=
-tegra186.c ~/Projekte/Coccinelle/janitor/complete_exception_handling_in_p=
robe_functions1.cocci
init_defs_builtins: /usr/local/bin/../lib/coccinelle/standard.h
HANDLING: drivers/phy/tegra/xusb-tegra186.c


How would you like to clarify why diff hunks were not generated
for functions like =E2=80=9Ctegra186_usb2_pad_probe=E2=80=9D and =E2=80=9C=
tegra186_usb3_pad_probe=E2=80=9D
in such an use case?
https://elixir.bootlin.com/linux/v5.4-rc2/source/drivers/phy/tegra/xusb-te=
gra186.c#L445
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dr=
ivers/phy/tegra/xusb-tegra186.c?id=3Dbbf711682cd570697086e88388a2c718da918=
894#n445

Regards,
Markus
