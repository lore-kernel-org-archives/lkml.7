Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4F2C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 12:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E76C2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 12:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="qsE0OJiB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729835AbfEMMXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 08:23:16 -0400
Received: from mout.web.de ([212.227.15.14]:44831 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729166AbfEMMXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 08:23:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1557750174;
        bh=20TVBHRuTWtg0alTE2UCtQ/s952TDCeQX9+E0IqGVcg=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=qsE0OJiBQbEK4Ml5D1pPa/IEt+pNscq2taNdMXAD2Of/o9tDbe5JKcyslNkc3V22K
         4UjVB+FGbG/gXVqFGDcB+qOsYoEJ9MibVyluvVtm9KVGRuot6qF+W4yF2XK6dEDdmc
         9O/+OJGUdoXEHXKpvSawdRywzE+130nt+ceH8yWs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.135.147.80]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MSGXj-1hFLIj2vlr-00TWlW; Mon, 13
 May 2019 14:22:54 +0200
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
 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 FEE=
Message-ID: <66250f72-c433-28c7-a224-6f248339ec4c@web.de>
Date:   Mon, 13 May 2019 14:22:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1905131130530.3616@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Z+kVEjxzeiese5IioESc091OQOP+yS11c4nDuaM7p2xzPWhUsPz
 h1aBiOrUX/YGa1uUDwWhdPiGo8BkccdpRXp+4Rxp/RIwzrtkG0sTk8RdG/qRGu0UwF/xn+u
 JItgEx2ijotITjazC+z/FIMI/nOzkfsgLosmXEhvQv5k7Pbi19yAA5ADtdTa5MovgLyQGRG
 tyiMga3JoennL8b0qOSWg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:B9xl4uTWLwA=:PemekqlA209qJ1xFCCw78y
 2gxvVMU46Qr74cvHkxncpGRtkVh3joLxdZq5qy/g5R/fVhhIsGRk1bRyExk+1HJnh5M3v5Yrx
 UHaJAAwR9W0SBZWJhPqfe3cIqE0L1gYJMk50l+FvZOIw8W6T8ChpSIA0ukTBZ+RTay5zHvctW
 YynPVLa0i3VW8uObat+YubHWeq9EItUQ4ool9fJ+eJmA51wzVb5mwTF3YYB9lWsXZ3o9gPRRv
 xAZO/6ywSy98QeKsX0zHov8smVJ08TYn9ZoJeYHjrzLN2gIzXITDFxamX30tcfQ6y3prI4dVN
 2EUXuNLSWqcWIUb7KBweOj/PXFIhw6Al9LleC2VRGjLYDXhI81E+h3Rp2ehT+BAvfOc5CMM84
 Bz5ceIa2aioOrZiM2Bbv1QGNaqsodpnFCKpy+39tszBlCkMawi2VcG1x4VN8YkIw96cyuLPdq
 RB0Qr8xz0UV+8IuJwjilqQvoVfmtIWO5h7JnGAkaYJflXoZLq56002V7N2pR8VH8JZzevJXgo
 SCrZHwwaWWGy02I6SEWDGN1kaBnesGZrqLgp0jfPyO4Yqtt3eBy8L85EYQoBMDe+GfILGjfjU
 gHHaUfgaxn0lHyufgkQuaTIlLlBDiHzb6VDpFelvsgn0DqVkoVxTWCcSVPZfS9bFG7v4/sSIR
 XMn+SKqVeX7DWPTikJL0+PNYbQIpP02Nwt1t3nU7V6MA4kGb2/0SsG2e9Jp4pVZSh4zui1jSw
 ggYo8N4jtVlc9O7xMIuQvZ9SuG6cjdX5sbZQniBDEl/F7aHKFHfS8Fu34HXY2+5+NI+hLKjbY
 26l9a7ATwu3kHArrMBLRYGkG8roNeipgrhxjET3xeIRGXQvkHh2vHxJ8yS/cUlLYyAVGlpIFa
 kvEHNSlyRFnOkfqQN4xbJKNLJI33E8AseawvYQqYZmbNl5yL5u4s7HvpmhUR9UT6uqX4GAzpc
 ZgAHB/w6BGg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Take additional casts for these code exclusion specifications into acco=
unt
>> together with optional parentheses.
>
> NACK.

I find this rejection surprising.


> You don't need so many type metavariables.

I got an other software development opinion for this aspect.

Yesterday we started to clarify consequences from the isomorphism specific=
ation
=E2=80=9Cdrop_cast=E2=80=9D (for SmPL code).
https://github.com/coccinelle/coccinelle/blob/32d3b89ad909316464344a5f61a8=
092d8d702321/standard.iso#L52

Information like the following influenced my design decision to add three
metavariables here.

elfring@Sonne:~/Projekte/Linux/next-patched> spatch --parse-cocci scripts/=
coccinelle/free/put_device.cocci
=E2=80=A6
warning: iso drop_cast does not match the code below on line -1
T (T )id

pure metavariable T is matched against the following nonpure code:
T
=E2=80=A6


> Type metavariables in the same ... can be the same.

I would find it also occasionally nice when multiple SmPL ellipses
can refer to identical type casts.

* The under-documented =E2=80=9Ctype purity=E2=80=9D hinders this at the m=
oment.

* But I got the impression that it can be safer to distinguish these
  code variants better.

Regards,
Markus
