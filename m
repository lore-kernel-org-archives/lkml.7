Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B885C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 13:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B73F42082F
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 13:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Fro7vvXo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbfI2NNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 09:13:41 -0400
Received: from mout.web.de ([212.227.15.4]:52705 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbfI2NNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 09:13:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1569762787;
        bh=dSp57Oa8v9ZZeJqzmn8tjEApN8VU8saj/sUmtIa+GLY=;
        h=X-UI-Sender-Class:To:References:Subject:From:Cc:Date:In-Reply-To;
        b=Fro7vvXoFslY6TRUVHhNAoZSTlH/l4Uj4npe+yHgCMrkL/CzUW9Fz0HYT3c3gCpqb
         7IzIb9D7Gc5Suy0xeQVCEWh8atbnhIMKIr4W7QylQJ2UQ6SVLOwvNFjtizyFGVk4j9
         b28wUozpjFZaBHXk1u+PLuoGVwLXPBJ/3gp9CKfM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.99.91]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MNt4V-1iDCMz3zY3-007SlJ; Sun, 29
 Sep 2019 15:13:07 +0200
To:     Coccinelle <cocci@systeme.lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matthias Maennich <maennich@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Yue Haibing <yuehaibing@huawei.com>
References: <20190928094245.45696-1-yuehaibing@huawei.com>
Subject: Re: [Cocci] [RFC PATCH] scripts: Fix coccicheck failed
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, Martijn Coenen <maco@android.com>
Message-ID: <7664d59f-78cf-7644-0ee8-304b3d78d752@web.de>
Date:   Sun, 29 Sep 2019 15:12:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20190928094245.45696-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PwQo5qCzTegsEBms1RpHKmRjCEpW0EqLwQTqtSi6tReF4EJ9Fku
 XShnV38l98JkzFH3MlDIsvGyx8Y2LFgqJohS31H6IetwS4HDE36Lo4tIk+pE0psj15VkPFR
 4YKMPd/rJqRhtHAQ7bEcO8+pX+6x/7krh0vv/ooupoalf/dy3CxeuYHN8rTcoujKMxeDD4Z
 s5IdUcSy1NjqinUbuhOpg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sEtkCVBulQ4=:D9aUJ4qjB7WtHeLCnZpwi6
 g16cI2dR76u+RyX2fJSlEukCtMRz7mEmx11G6aqQdBAjlIF3ZXXgB1fE6NA1sLhNN+1qxH5Mj
 BDFRctl0sfjjx4uIvPmFl82iGtSJJ6ZNxiuBGgo9OiO7gc3W1dvBpe+Vd0XN/p+kUbfKwipA0
 H/kcNltCGzKAyEmwfwa8YW1Fz970MRph765/PXssznqhkRRypK37bG54a1bzy4205nJtY6nLd
 867nRFiS6tYoS+q+MLQR4WSHImeFZDshAjqpVRFLJqE17kmvy82Xi6UOOXh+z98YUSBr/tA0q
 LyzizyqpAOrvZJRtND4E5UTRSVzb4PhixCdk4XHSw5eVIIgcGRfW3V0WsvgNfSIJG9A5HfUOU
 zbxC+noGkHiIOD5R9jnydAe6zK2OEkJZeQUEn6YLHJGyYWzGe21+iTwRmzB3oqB+UNxq8/V5g
 iBBkxS6rmDotOG+a2aWs2PREs5lbnDU555NxjZjegAqJfRbRnN88NLR1eOOJOBUbBrSYl9Cun
 xQIEqEgz0Jwgfe+wHo7ZgubJ5E1ZMO/pGkn3yHWCCpPER++ra1hv/ZBq3d83XBh3jc+JSKjae
 lhxNAoxPTbhrhZwk5WjLBW0zvcDDKSmRLd47Qorf6do/p/93i3F67etxVVq5GtQJHfCIliHkz
 g6qrJC81Pjdw8fgZQZJPFBNg126twBv39bkLKiGF+Y0M+x9jAAqqxwJ3n3UViGCJ2Cfmfr3Ng
 f5FoIlgj7kC8EeF9h6ppHzX8kNF5Nz2sIdCT3G4TfpKz6aS+R2oY9NTVn17UuDfgCfj+EloWc
 wW38z6CbPas72QHmns2aTnSdjyWnOxAxJr7tYKx3OkowS+pi/ZN2LcDCjajijFyt7l6CYRpJX
 /TuqmADIPU9FHTyiVXS4OHiaskKQifzTuP1bXJMq9pKDQUz+0pT+HWnM0c6tzYTyqw1uhMh68
 ebXzt2zMUFrIzELO3fjRsvTC4dkzwwQ6aSS6YuGKUjclMqSEMqa+FdcuW8STMJSEslQ/vR4jf
 XWupAJQ1uuudzWsbPuv4yPOnlmu1jArEN9Rnb8vz7lfRca0nK4oIOkaMYlPjiGoDXk535z9Yh
 ZLS+QVQE0yBtYktToWPM5Gdr+uInVrVXrmwlNlcbTqO4zQ5AWlb7AvdE0QvpT9Yy+DVzopzsr
 gNuRW6lpBTe413qs+tsN1Y31hUZDq2JKWhdMhu+8ccPrG8rAICxc0E6XBoijhSlycAnfNGvPU
 0Q4MHA38YnGdwzewiRZ+TfthYBqoVFOiNGuHNSrv3uOJDvWUwm0IAcMZ0d6M=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  rename scripts/{coccinelle/misc =3D> }/add_namespace.cocci (100%)

I hope that such a SmPL script can be also independently used from
the other known call interface.

I suggest to think a bit more about the desired directory hierarchy.
If you would like to keep these files generally within a (sub)folder
of =E2=80=9Cscripts/coccinelle=E2=80=9D, other solutions should be taken i=
nto account.
How do you think about to adjust the filter command?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/sc=
ripts/coccicheck?id=3D02dc96ef6c25f990452c114c59d75c368a1f4c8f#n257

* Which criteria should be finally chosen for automatic script execution?

* Would you like to reconsider any more consequences around collateral evo=
lution?

Regards,
Markus
