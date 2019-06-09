Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF6EC28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 08:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CC7C2089E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 08:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="TpcOjKwf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbfFII4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 04:56:03 -0400
Received: from mout.web.de ([212.227.15.4]:49955 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727884AbfFII4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 04:56:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1560070546;
        bh=yWKywYw0sHaVLOotH7c9LtTSfYfsAFBvYCxGv700zxE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=TpcOjKwfhXcdS7UV9guaO26+AUkea3jN+H4iVnWEdsnhHObPt2QM8xa6QrGkjfshs
         XZhuC28QpdhPHGB1lIGnDuNvyBB9Eyrrqpl0aEZNqoDuJ7UGcpKMf4Fx1+7ZKx1PpD
         TUMW332K9BBRRYu4Y9T+LGmfCCbSM79h0sHbf+rE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.4] ([2.244.77.74]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LnSOM-1gtQSN30BC-00heRC; Sun, 09
 Jun 2019 10:55:45 +0200
Subject: Re: Coccinelle: api: add devm_platform_ioremap_resource script
To:     Julia Lawall <julia.lawall@lip6.fr>,
        Himanshu Jha <himanshujha199640@gmail.com>
Cc:     cocci@systeme.lip6.fr, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
References: <20190406061112.31620-1-himanshujha199640@gmail.com>
 <f09006a3-691c-382a-23b8-8e9ff5b4a5f1@web.de>
 <alpine.DEB.2.21.1906081925090.2543@hadrien>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <7b4fe770-dadd-80ba-2ba4-0f2bc90984ef@web.de>
Date:   Sun, 9 Jun 2019 10:55:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1906081925090.2543@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JDSlyCoTpTsPKOQ677p0YWGseBYr8HGllMkZiK9aphYVpDna+in
 SzvU0jbR4UgnupEymNoBCKfwYyLZIL1KNSYbBGWtPsBh89e8xArdCCGIeNLhpf6HxiKY1ov
 EFOUbueuJxDe5LICmL89fJp7dliVfz4IqkOM0ZDAxQut8KLmAYSDaeh/EOy8hmAjqv5kJIj
 uiFASifQqioungX2KrFgQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bJPEe4L2Q5A=:s4pRhCV8TjuiB4jQ5yEW1X
 eyENHdN3LzPOMV+OL/UF2bzVHKvIIIFpbDsb2KoCptDRcjcmgtk2CtyB4wE7hYjC5aOzlLbYE
 LbziWYLh6iEdKoXb3GFSqhkCnyR8FK1EgHnMASPwa+uOCZ4McLCmNgbt0+htfKH8o09egGTMA
 xzny9F5mfaAF7ifljXj0Q2dtTkpyKCn1qq0lDk92r1Y22s0mX2ecL2PEqE+Br+2WuKBUh8uaC
 3Ww4cyd3bkNpWZ6dmcSTtslwT623ejZSmjQRpED8HHQxSXvYKK5oENS2PAMhic1K2rX+3+Eg1
 Y3O0qGK4gbVR17IRTOCkxWhet1BODXXKXAsbfEvF4f9M5MSUvoxUIsApijuPtVWhoEmVoB0WF
 MR5NsI02LW1pV3rHvPsNk7k3jd2Ofwq1CFk34BGLGWgMPmpEBHeqGFp2xPWyY3m4a3OvedgQC
 3WBxBnOKGmYqJSd5w7CWblETQma4aPnBN2u+3vsDAi0Kc+/R5IQFbHqV8QN7lgcsMt86eq3hv
 NArqTXrRoWT6IObaS+a+OP1FkgB9CmCWCSSPiPTd7hUqxcnYSM6PsoN+LPfQEmADlKmdoyiyt
 OPKSNJYc6/08AY46oyeVxSj4cxd/o2zPxJgtzBhZ1R2WK8LcKaLqTD74QL1dlCWEqs6TOr/90
 U8iFIWoUkXA7nngFLSWtXm7j3oESPsIoSSSuUO4bZahhigAweKyilKTvryf1ypBq5GK/iUDiE
 19b9ZDlTLn4xYYww4qy2NTmu+jrEPR6fF6G1SZ2RWaqeW3L8UmQ2PdAX4Gv5Oxguicm2bK2XS
 GE2dSYS0c8XE6BSQtmT1QhgR/qkrZFbEI+WXtB5y7MrFd9arLMTB+uxSLNs1zu/t11UZufiyh
 6EyBJY0jLGEAKDQyfRU0N2emiMiZf4BzXLe/JlNi8c+YSSjLQjWoiW8fQGWPBYsa5npBP5bY+
 ijt0EVXuW7bJYBWL0iMstJpLhM+u2bSHdV7BNL3qoskrmSgLRXzyf
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> +- e1 =3D devm_ioremap_resource(arg4, id);
>>> ++ e1 =3D devm_platform_ioremap_resource(arg1, arg3);
>>
>> Can the following specification variant matter for the shown SmPL
>> change approach?
>>
>> + e1 =3D
>> +-     devm_ioremap_resource(arg4, id
>> ++     devm_platform_ioremap_resource(arg1, arg3
>> +                           );
>
> In the latter case, the original formatting of e1 will be preserved.

I would like to point the possibility out to express only required changes
also by SmPL specifications.


> But there is not usually any interesting formatting on the left side of =
an
> assignment (ie typically no newlines or comments).

Is there any need to trigger additional source code reformatting?


> I can see no purpose to factorizing the right parenthesis.

These characters at the end of such a function call should be kept unchang=
ed.


I got another software development concern according to the discussed
software update =E2=80=9Cdrivers: provide devm_platform_ioremap_resource()=
=E2=80=9D
(from 2019-02-21).
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/=
drivers/base/platform.c?id=3D7945f929f1a77a1c8887a97ca07f87626858ff42

The flag =E2=80=9CIORESOURCE_MEM=E2=80=9D is passed as the second paramete=
r for the call
of the function =E2=80=9Cplatform_get_resource=E2=80=9D in this refactorin=
g.
Should this detail be specified also in the proposed script for the
semantic patch language instead of using the metavariable =E2=80=9Carg2=E2=
=80=9D
in SmPL disjunctions?

How do you think about to delete error detection and corresponding
exception handling code for the previous function call?


Is the SmPL code specification =E2=80=9Cwhen !=3D id=E2=80=9D really suffi=
cient for
the exclusion of variable reassignments here?

Regards,
Markus
