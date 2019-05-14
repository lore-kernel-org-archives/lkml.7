Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDDF4C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 07:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B23B02086A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 07:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="gNYzRL5U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbfENHuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 03:50:03 -0400
Received: from mout.web.de ([212.227.17.12]:38971 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbfENHuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 03:50:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1557820180;
        bh=DhKr8PCpkLVojq4ATlnb839KJ85huWNrdkiYuBYjhY8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=gNYzRL5UfK34aC03wgd3GKngIqT/JEEJYz1fW12SUAMeuO63XSbctX9K8q08EuSq1
         hAwECMbyVmtmCBFAtm8odwxC6rLONY3lHFrHyG5AeyEm0ClB3K0/b1gJc9nmGNy/MX
         VuQAkunVJyAqHet5nMx7Iz4YpBT49ABR0tT1wEqc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.131.122.180]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MA5qv-1hXIlB350j-00BNtS; Tue, 14
 May 2019 09:49:40 +0200
Subject: Re: [4/5] Coccinelle: put_device: Extend when constraints for two
 SmPL ellipses
To:     Julia Lawall <julia.lawall@lip6.fr>,
        Wen Yang <wen.yang99@zte.com.cn>
Cc:     Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org, Yi Wang <wang.yi59@zte.com.cn>
References: <1553321671-27749-1-git-send-email-wen.yang99@zte.com.cn>
 <e34d47fe-3aac-5b01-055d-61d97cf50fe7@web.de>
 <6f08d4d7-5ffc-11c0-8200-cade7d294de6@web.de>
 <alpine.DEB.2.20.1905131130530.3616@hadrien>
 <4116e083-9e21-62d7-10b7-5cb26594144c@web.de>
 <alpine.DEB.2.21.1905140849570.2567@hadrien>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <2881b53d-66ba-1327-0081-42f7c853b79e@web.de>
Date:   Tue, 14 May 2019 09:49:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1905140849570.2567@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fQtCuDuJZS2GWGBaZZZKl5KHBMaJgMG//cPpPvUlkUJUh6/GoCu
 B/J8lDaXeNGuecqpXHPwHUH0z68iRNj0ceUprzxRQjRpikF90R+iSTN1kuY3d5sCofEn9yf
 ahU+AS32zp9l9nFyvkTiPBw2KOEMoieEi55uRXwhmIh0V0hjvryk4Z2Mg8NKv2TbnEFH5ax
 9eLit9IrTj3QCNbBTQm3A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CehVx0LkPo4=:BDVX+x2+lUqUCBI/n9D4BJ
 5RDZtMLE3yL8Lhr0cxMgQYu97Og/N6C9Dq2JaH+PHo/UmX3wkwHRMomrd9u67Nr0ysvclYMsF
 IZgJM6cs84mUy8vlzyTuP8TAY6rGSb1ZTUaK1ezQe8gEiUwNSMNbmt2LVH1f72FLLL96a0Wrm
 5FmheUo52hM7PWifm282S2z/85hViOyEC6QIaZ7Cv8dATlxLvVrTBNqFC0b+ea2HLWiTmabsE
 KJsR1mpBbikLVu5gzi5EyBH4UQg3NgKOWigecyMuehq8OlvkmFWtf6iRK0qNe+FLB8L0A/ghi
 3DuCrxdj+FdJtQnVeeY0zH59pIDcSL/dxTy8/0oFwYkNWwvRvAwsvTPj0UcC0uhMkD5YMb2vW
 yx1fc1Gb3x4YR+hjmZ3ITsG4yOcOcFvVlAasEnpOE9DrnKjNkaxHptIbY7jpSqq6t6IzaaONT
 WEi2gTHkXvvguWqAVb0JaAUTJe97EKwLxbc8l2JNes6yWguHwCd2dAx0xDLTCyfBF78XUaEYG
 vq5YMjnkoFnY/MyxfsW0Mef23GbrVHg8EnKozcHiBQTwe8JcykK/JjRa4Y0c+09VjO1u3YGvZ
 nx8Ernk79IumiiKt+aJSeTb7Wd83/xnuO8nqNyjZvvHfbj7gRzBBW3eA082bXcN5ZKiUv3Elt
 sSq7JGX8lUHizryrEFh+0+laLxJeYb4kBqanh7A+y05fiRpl+8WLwfTcG0AIVKcAkRk6sEi4s
 EtxbxlTuHAQdA594JorVvSYC5uPIeQfjbuWKP+2rhbpaEdHbTuFw20shWTbU2B2q+2g+HvtUj
 sHWBlAeqXT2ccxDS/n0iCLnxuFlvFsjSXg78//jybRoJ5w/A6XwwNStElB+jRlxrVOUCtEULk
 zPXt0LW/8pLCGuMhYHTxvhPTNC+/vIbJfUgnx+NXYcgqt9DGi/Mi88ethP5pSlYRYF5d/jW17
 nNFZLxHmJMQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Can you agree to any information which I presented in the commit messag=
e?

Do you find this description inappropriate?


>>> You don't need so many type metavariables.
>>
>> It seems that the Coccinelle software can cope also with my SmPL code a=
ddition.
>> You might feel uncomfortable with the suggested changes for a while.
>
> It's ugly.  Much more ugly than msg =3D

The clarification of this change reluctance might become more interesting.
I got convinced that there is a need for further software updates.


>> * Can it become required to identify involved source code placeholders
>>   by extra metavariables?
>
> I don't understand the question.

Wen Yang was planning a corresponding modification since 2019-02-19.
https://lore.kernel.org/cocci/201902191014156680299@zte.com.cn/
https://systeme.lip6.fr/pipermail/cocci/2019-February/005620.html

I got into the development mood to contribute another concrete update sugg=
estion
for an open issue in affected scripts for the semantic patch language.
Do you recognise the need for the extension of exclusion specifications he=
re?


>> * Would you like to clarify the probability any more how often the show=
n
>>   type casts will be identical?
>
> No idea about this one either.

I am curious if helpful ideas will be added also by other contributors.


> Basically, if you have T && T, the two T's have to be the same,

Such an expectation might be logical.


> and T is not pure.

This information triggers various communication difficulties.


> If you have T on two separate ...s then you are in the && case.

I agree to this view also according the application of two ellipses
in the SmPL rule =E2=80=9Csearch=E2=80=9D.


> If you have T in two branches of a disjunction or in two whens on the sa=
me
> ... you are in the || case.

It is clear that disjunctions will check code alternatives here.
The clarification of consequences around the interpretation of =E2=80=9Cty=
pe purity=E2=80=9D
might distract from the final solution.


How many (optional) type casts would we like to handle by the discussed
source code search approach?

Regards,
Markus
