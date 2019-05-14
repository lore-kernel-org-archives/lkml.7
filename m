Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9B5C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 16:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A724F2084A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 16:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="KkZWJjOa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfENQxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 12:53:21 -0400
Received: from mout.web.de ([212.227.17.12]:37569 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbfENQxV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 12:53:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1557852774;
        bh=ZOpepmr+7uVZP1DPIyussTqq2lQaOxZ+ZBapMUYeiQU=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=KkZWJjOaBT/YEXquijPQWmawF0VdL119N8ul3MWTLV8dr5gs2oVAJe5vwK2zMF7Yc
         ofgNk8sxjUHnnEWO2CjD/1sfJ1VXOQ9H7c0wtptB/co1exDAq/FWuit5foZD9I6PJr
         VrixczdtR10+LRxRYd5PyFjwvDYZg8yDXlnQfMqQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.131.122.180]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LxweO-1gf2YL3n5I-015J57; Tue, 14
 May 2019 18:52:54 +0200
Subject: [PATCH 3/3] Coccinelle: pci_free_consistent: Extend when constraints
 for two SmPL ellipses
From:   Markus Elfring <Markus.Elfring@web.de>
To:     Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Wen Yang <wen.yang99@zte.com.cn>
Cc:     Coccinelle <cocci@systeme.lip6.fr>,
        LKML <linux-kernel@vger.kernel.org>,
        Yi Wang <wang.yi59@zte.com.cn>
References: <e30b9777-6440-b041-9df9-f1a27ce06c6c@web.de>
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
Message-ID: <c4e9153c-234e-ab5a-0061-221374c2505b@web.de>
Date:   Tue, 14 May 2019 18:52:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <e30b9777-6440-b041-9df9-f1a27ce06c6c@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SSBqRHMCXRy5Q/kUTt/6pwMpi2zKFJYapZe9aoTObboVOUoX9ka
 25it86ZIqghOlbpEgOlRrkVvDUZojn+j1WZ1pk+mTuAa/IGRypwo2PVaWdS0u7MZ/JVcctA
 e0KpVGq2rWNrz6HrjVNCUAwfVFYmeAJmMcFhHD9Z/DcwXPDqwMySEJB4HLN8aWnMjoNQfX9
 LH4KwcAEH2WJ2TzX9PeEg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZE/Evh7kRC4=:ewF9/e6tZvubBw5AcRXM0Q
 ZzZAt6zAvHj8RUv2VlV41pxeHFcqHBXPEFxhgiQkqL8t0OsNNDdTjGDO0v2Wwxt9acqxzAa1z
 VHE+0Y/Z8vyqfnJZVwCnVmPwaR+Ry5cwfLYPPLPMkle2aSWEGcOgFmnMeKTB/rOGqREZJy/VF
 ypWy+MWhyeHnKodFNVJuR41hEIr5NvTukeAyz2YJqv1JOKY4FZjzWBmBlBNb4lNkkq4SVJ36N
 N6APdgBqKOzgZoPp30T9YPM/Q9fB89xDYuXMVBQfU2F74MaX0MdIxlDcCcu0wkFhr3wCZ/Fwy
 xJj7IV2y359zoAzlfaCjdl8o4fWD+6i+SjGUqn154P7qmuJ/RsVVjt7DxhHrqcTn4jAiDuPOx
 sieT40XCNUsJpwlgx8ShWhmCVSuMJ6PdNbs8GFhxdoyk9XsucKGxMXZxxlgbTXAkRrc/oM3YN
 hKBZnymi7ktQrCZsnEmB0WYguSEeWQI4xJqTsKGbdA5rwJSuHllDvXzg9rdh4V0TuBEB27029
 EazXo+/smLcCxVmTmOjmcZh2CdKojHzWQOINyopK5NOqNvdzrJZaQaTqRE7BYa6gyHk4ul2YU
 iy2l3BfUxAABvXU8v/zIbQzLLAoMzr6UKnHVZ5MNwTOhXKOAlC8x5inGCA9os/cnD0NosXgOB
 3F5Hs2k+YvLRF+UgsoGH2alpuz3drSW5Tg6DvAVb1eoeOVR9SZwesAQTD3nhwZ+2jkGyO140m
 yIIt5MXeWxtPOl+Ugegov1mkTQ39zAijRREFkgWbBujHsdIJysPOuWcahbYSVf73sDf6x8ujY
 CGXw3GdE+p/m+FRSiPvDGMyvfD9p137cvzraTOOkAx567lG3Cl0tpmtIDwOCEojChcX6WC0RV
 ywORIDCbu9AVnBexxqqtN1yCuOaVSpvWBnEJB7Q/cpdxvnO9JvW4Z3zOgboKVxj0tlssUp6SS
 DY4dvxl2WgA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 14 May 2019 18:12:15 +0200

A SmPL ellipsis was specified for a search approach so that additional
source code would be tolerated between an assignment to a local variable
and the corresponding null pointer check.

But such code should be restricted.
* The local variable must not be reassigned there.
* It must also not be forwarded to an other assignment target.

Take additional casts for these code exclusion specifications into account
together with optional parentheses.

Fixes: f7b167113753e95ae61383e234f8d10142782ace ("scripts: Coccinelle scri=
pt for pci_free_consistent()")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 scripts/coccinelle/free/pci_free_consistent.cocci | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/scripts/coccinelle/free/pci_free_consistent.cocci b/scripts/c=
occinelle/free/pci_free_consistent.cocci
index 45bc14ece151..48a36adfa3ce 100644
=2D-- a/scripts/coccinelle/free/pci_free_consistent.cocci
+++ b/scripts/coccinelle/free/pci_free_consistent.cocci
@@ -13,13 +13,15 @@ virtual org
 local idexpression id;
 expression x,y,z,e;
 position p1,p2;
-type T;
+type T,T2,T3,T4;
 @@

 id =3D pci_alloc_consistent@p1(x,y,&z)
-... when !=3D e =3D id
+ ... when !=3D id =3D (T2)(e)
+     when !=3D e =3D (T3)(id)
 if (id =3D=3D NULL || ...) { ... return ...; }
 ... when !=3D pci_free_consistent(x,y,id,z)
+    when !=3D id =3D (T4)(e)
     when !=3D if (id) { ... pci_free_consistent(x,y,id,z) ... }
     when !=3D if (y) { ... pci_free_consistent(x,y,id,z) ... }
     when !=3D e =3D (T)id
=2D-
2.21.0

