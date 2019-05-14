Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19814C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 05:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC7D820879
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 05:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="eBevBaf0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfENF4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 01:56:13 -0400
Received: from mout.web.de ([212.227.17.12]:45869 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725562AbfENF4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 01:56:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1557813347;
        bh=ZN/didN9u3mF/8P+UH4HgO1wNWrauNcQ56uVTAGh1hY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=eBevBaf0oydISvv06Ii7ZO1voirXJSdDTyujcWMZbj23NVYmkcwaJev5gt4DI1L3u
         3uCKa6nqWvbdUrdmrbMX1RA73ZlRrIqbsnGCp+OGvS+CuN+xf4zO6dSmzP7pFcgag1
         pLwZQ867hBCLGBiXYHj/ImjWlwGmAaEZBnePOoMQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.131.122.180]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MS290-1hEpo11Zj0-00TEQu; Tue, 14
 May 2019 07:55:47 +0200
Subject: Re: [4/5] Coccinelle: put_device: Extend when constraints for two
 SmPL ellipses
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Wen Yang <wen.yang99@zte.com.cn>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org, Yi Wang <wang.yi59@zte.com.cn>
References: <1553321671-27749-1-git-send-email-wen.yang99@zte.com.cn>
 <e34d47fe-3aac-5b01-055d-61d97cf50fe7@web.de>
 <6f08d4d7-5ffc-11c0-8200-cade7d294de6@web.de>
 <alpine.DEB.2.20.1905131130530.3616@hadrien>
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
Message-ID: <4116e083-9e21-62d7-10b7-5cb26594144c@web.de>
Date:   Tue, 14 May 2019 07:55:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1905131130530.3616@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3zyjaDu5jTX+gOtrR2DqvrsR+wc6K8837fqdfMEV7L+/E3U2KfH
 y2ga82y1ZxpEPQ3Do2V3osAfTckW+i+8Rq3Hrtqax4ooOw4vJvoML35eJObpUSPLxpV27sx
 Hbupm/QrH+P7hDvBeKtbRTLNkYTrY2XbSg4+B3IHWIC5T34y9Y17WJu0MfIiSQ2NRR8W2bT
 iPcRPpn10iXb1YmtOXM1Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RQZWWZ1n6G0=:3canBtIVbDR+L4T3A8vkzx
 OW1/EUcwYXuJxoQgVurv4X/6Wq78pIo/KlUI7e9hELUzyAUhP2RcQPlR96EYfu/FDypzcIqSH
 3SF8RLc+m7zkvtuFrHnoZyHw7/V0JUfnTj8Zl58fvpXSAs2+uy7gknOAoa4EUNTONW9hnEz+y
 IwYniBwhJYH2qCDx5iiZgcWa9Nkn0U9GGOKa9i8BTWHHEX6Aut98RETTIuvXdPFTYiTsaZWtW
 5LgfHxf1B9i+neTGpmlUd4kQIgchTlP4hbrXl2ZxNByzns7UbUzE/cVTKjvdTlPg5opANYDV0
 OJ7pvbhou4pEl8xAy3ZHeB2PQCcy4PK7TUp4WJiTd1D7d6mM8NgIg3kGysL6nfa3OnpSdqvTE
 3DyEP1kP4Q4cHJuvD4RIuHK9U3LJHEwzoMs8X4coWa3DsC55z7OIQEjtmiTVCFeRM/g78g515
 8aWlspE8wrlDXb9J//2wVIF6HOqqbq6tNjHHxtmzWLfgZIv/fXYcjGKa5zPgaoso+E9bMrtLr
 dG1eu3BFjYbJMeg76+bEj2IDi5D48ielO8jZUDZkTwa2mRsJrzqw4IuMxQjhFDyUz0THJUNn2
 4Nmta+CzFtxx1m8UrnIoFphMWS5ZfoqThkZKfT/gIKusN9RNbCNLnhzCwW2Iew2hcHKy69XdB
 SIKHZvRZ5qauB1LQTA7IIv5KV3rEa7BOUBu/3NbPuJvpXNzrGPlgaOfT4CV6FafGlxoYKb1Rl
 P8BAZ7tj1fn85wEJvDGwVotuRUDPkeOIFLUwXUfBlkBvDApMUDF+pohrz4mp/JZJ1/Fh27Ti1
 er1gN5cbmZ+H+/59kv9Yq2MbVmo+oxqrQfPAolvXCl3YJIsfl1i0WBo2F3cP+b24MYcfPauWw
 wU8Ox3rW87UthqPCXdjTTfJl/yBMLjooYKxHsYPnI4ioZXeWgw1Lo7kw/nogdsSYuqMD8+Mdt
 yJwZUP7UhQg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> A SmPL ellipsis was specified for a search approach so that additional
>> source code would be tolerated between an assignment to a local variabl=
e
>> and the corresponding null pointer check.
>>
>> But such code should be restricted.
>> * The local variable must not be reassigned there.
>> * It must also not be forwarded to an other assignment target.
>>
>> Take additional casts for these code exclusion specifications into acco=
unt
>> together with optional parentheses.
>
> NACK.

Can you agree to any information which I presented in the commit message?


> You don't need so many type metavariables.

It seems that the Coccinelle software can cope also with my SmPL code addi=
tion.
You might feel uncomfortable with the suggested changes for a while.


> Type metavariables in the same ... can be the same.

Such information is good to know for the proper usage of specifications
after a SmPL ellipsis.

* Can it become required to identify involved source code placeholders
  by extra metavariables?

* Would you like to clarify the probability any more how often the shown
  type casts will be identical?

Regards,
Markus
