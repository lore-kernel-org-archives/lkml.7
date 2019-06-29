Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA136C5B577
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 19:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A77C8215EA
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 19:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="SlBhBx4P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfF2Tbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 15:31:32 -0400
Received: from mout.web.de ([212.227.17.11]:50351 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726891AbfF2Tbb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 15:31:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1561836657;
        bh=vo09pSRaTUToqgbIQsisTZIbBb/GsNi3fYXSBbYUNvY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=SlBhBx4PZ1yW3qEEC5K6EoaoEyQsHjshkOJsJNIGMqJoOMe5dyyPxctqsm6x4iuz9
         Ozk1Oq2Fq/qt3D9GABGCZ0dVjK4w1Z/hYKBPOijpJGQ4mI9vBumgaaRIK+aMYtAOkE
         eluvE3A+RTJi6PM8xkgDXDzeYbpi3ods5MpzpQ64=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.176.71]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LmLc6-1iForj1cWo-00a1Ge; Sat, 29
 Jun 2019 21:30:57 +0200
Subject: Re: [v2] Coccinelle: Testing SmPL constraints
To:     Julia Lawall <julia.lawall@lip6.fr>, cocci@systeme.lip6.fr
Cc:     Wen Yang <wen.yang99@zte.com.cn>, Yi Wang <wang.yi59@zte.com.cn>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
References: <1561690732-20694-1-git-send-email-wen.yang99@zte.com.cn>
 <904b9362-cd01-ffc9-600b-0c48848617a0@web.de>
 <76641efc-2e3e-8664-03b2-4eb82f01c275@web.de>
 <alpine.DEB.2.21.1906290947470.2579@hadrien>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <03cc4df5-ce7f-ba91-36b5-687fec8c7297@web.de>
Date:   Sat, 29 Jun 2019 21:30:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1906290947470.2579@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bAbEiUkVH6AWjmazL1j3eSonWoKkra6CEa1YhyXXbqr62Cs/VVf
 /c84YC2KO82h8Mor5ct/2pH/nVPQGXMlGePgGAyGc2qjl5D+M+RODUZB/XBHVcd5kNXUFJB
 2+mbMOmOF3qclxlDZKz1zSdH97cW+nitmKuX99ZgN8Ik2LnqpTuaC3BUyANjDr1gS5NrL00
 J3VWsx0znC9SEpsfBbmGg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BJdMmP+hHys=:vCYf21pdbTcmwUfH7Bz0Bk
 JKZNdxNTV9i3vbl+iunnUCpR0afcOwE/xMry/XLgiCBR7G6HWC47heNYuyGcE0YE6ZJuzz1uk
 K0FN2NxnG25YW1WwOl7G9WBoBmRU3yPt0360bn511yGM1UBgjZtZ3TKr1EStxn2YMtNq+XeRj
 C5LslQ6KD3QRkD/B+S959B/2jPWgZHVuZfh1opg9bdc//j2V0wuJzjBi+GDFsjoo07YcdDJOS
 g39qy82LnLjIJ12Eo44uYn8qpJEv68C9DvYExHBZj5pXGUNp8vyaI0GyhbZ9sFLS7QJfsR2zh
 /CKu7myqz5r56k8JFOhDtlhkv5IfaynNhrmhJok0/rj9xgnVWnIjKdHuqsaAY8Y0+17Au0mLD
 qL5G+hHOfPlkPseIBiDjAOqwgwkSuEXVAsSMBJCjQlbkYZQPJfLcjkQqw5uENfkZsRYj275lb
 DLAPrK/Hr6jCYKbs77qaVzO75djvTAJbn7gI0vVoBdxHL2aj90vgL+llwyWC/E8WdfB0AeiGG
 klNqRtFAjZQ3QD2gdWXpFWnFLnWzFNGxXqF0GJlUy933Aqc8tstaAlijpVxIV2opXl7okjX7E
 RsSREOsGcpds/87+IPj2LkoNgSU9ndCVyk17mLkrUrqGSehWpJRnFOolL5b854K0qOWYmIzW5
 T2EpBa+s2kV1jUEe2/cTc832Y+/AbVS21ncuxviCZRsCK2h12rCL+u2F6Wa2ASGIyaYyF+l1J
 K72BQ9GyMDhZXeA84cU8EqmFvIU6vT/R9RuVFaYCE3pNxkdoopxCmeExpD8CGpN4lVEKVMCbf
 1vYGVbDgG55bIJ3rfBrCiXcyAe8NDKNmuEBHVcnZWsl2RZPETloOTxau8lGdrZLzhik32TJMv
 62qp6+8svNWcyNrTIRIxGfkiw61K+dTXQs+2MGzYbvX72o9ngdigk1Ppz3aqiaKLldH6jhS4J
 Fipv4zVOvPrYgsnVPT/JjXFcezpa6wQAbMKXf6F4SufX+oxKZ7qRwoDDsqNXEzOXHL9QlXY4x
 owbQKRwftZH2HHJEN/JwXP01eyOOXk6IHHJCKW3g87AfXC6irVIsa3cleP6ymbr1rwhVZLrd+
 S0ZdY9Z3Hz2nsbAF5BoTkluqLbCXSTOokii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Please actually try things out before declaring them to be useless.

This feedback provides also another opportunity for collateral evolution
in some directions. I am curious on how involved uncertainty can be fixed =
around
possibly different interpretation for provided software functionality.

The SmPL construct =E2=80=9C... when =E2=80=A6=E2=80=9D is mentioned in an=
 area (of the section
=E2=80=9CBasic transformations=E2=80=9D in the software documentation) whi=
ch is introduced with
the wording =E2=80=9CThe grammar for the minus or plus slice of a transfor=
mation is
as follows:=E2=80=9D.
https://github.com/coccinelle/coccinelle/blob/c6d7554edf7c4654aeae4d33c3f0=
40e300682f23/docs/manual/cocci_syntax.tex#L1033

I got the impression that the corresponding meaning is not explained in th=
is
information source so far.
The published example =E2=80=9CReference counter: the of_xxx API=E2=80=9D =
can be interesting
then to some degree for the explanation of the discussed development effor=
ts.
https://github.com/coccinelle/coccinelle/blob/175de16bc7e535b6a89a62b81a67=
3b0d0cd7075c/docs/manual/examples.tex#L320

If the available application documentation is still too limited (and incom=
plete
because it is also work in progress), it is probably usual that SmPL code
occasionally tries to express expectations which are not covered by an evo=
lving
software implementation.
How would you like to improve the situation further?

* Is it certain that a search is performed only for the source code =E2=80=
=9Cx =3D=3D NULL=E2=80=9D
  (and corresponding isomorphisms) by the SmPL constraint =E2=80=9Cwhen !=
=3D true=E2=80=9D
  (after a successful null pointer check was detected in this use case)?

* Would you like to test any functionality which should work in different =
ways
  than you might see from the original OCaml source code?
  https://github.com/coccinelle/coccinelle/issues/134

Regards,
Markus
