Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B754DC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 07:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85C7720843
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 07:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="iwGFUo6e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbfEOHsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 03:48:42 -0400
Received: from mout.web.de ([212.227.17.11]:57915 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbfEOHsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 03:48:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1557906487;
        bh=qy8GvydzCG/60aeNk4J1LvKw8jHPAMkwKNvxx/LRvhU=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=iwGFUo6eSuE9df/cohrcCKM+IgVAEQIDOtIjn4hYuz2TvgckbEl99/qVcEui73LY+
         x/LgAi+caisQe09o7AkoC5tmObOjg81yjM3maMrnMrDHdNRedIVwV0V0ApzKoPhZtO
         CwoBQQyrALxLheYzj4trSc05a95Cy4/KqOa+HMdY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([2.244.73.153]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Maayz-1h6gQg2lJ3-00KBsh; Wed, 15
 May 2019 09:48:07 +0200
Subject: Re: [3/3] Coccinelle: pci_free_consistent: Extend when constraints
 for two SmPL ellipses
From:   Markus Elfring <Markus.Elfring@web.de>
To:     Wen Yang <wen.yang99@zte.com.cn>,
        Julia Lawall <julia.lawall@lip6.fr>
Cc:     Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Yi Wang <wang.yi59@zte.com.cn>,
        Cheng Shengyu <cheng.shengyu@zte.com.cn>,
        Ma Jiang <ma.jiang@zte.com.cn>,
        Coccinelle <cocci@systeme.lip6.fr>,
        LKML <linux-kernel@vger.kernel.org>
References: <201905151043340243098@zte.com.cn>
 <39c4150c-b238-a0b4-19b4-6215012bb497@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <647104b8-3ee6-6317-0560-f02443192e65@web.de>
Date:   Wed, 15 May 2019 09:48:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <39c4150c-b238-a0b4-19b4-6215012bb497@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uC5BTOnF1n7WcM3wjtVK8GvakpjuefXpeNNSXrJNdm62kr/nF5J
 2rKtwoFp7j/J8/610zNurfw6TdizVZpQN8vc8UGN1Y12/9AlJfUFgM4O3kvxuVLUnDBI4NP
 NZVCNc9Xl4iJ8uuMB4/JM2F/KnpHqd1Yf0cUhcq9MSnkhqAXeg8+WDx81VXsBi0kZyYe48q
 DyTxjqqPSWuIrdn1+V+zQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tSosc488IMU=:3cWzIKUJRfyDV4VV9yqT9P
 VMPTpW49ulzp7goT8x5mypluLJybBxF5vX5luYLGkv16q0mQtpJWrlzErPhw1Tx7kE4+D6wL/
 iSF23N4gkQSDQD9oXNVMYFjjDpPL87og4CvK3K5/qjdpL7pq7d9fwTReTcP7LyQkwfiqe+U+8
 NTWzZxnhG1LcXTHBIqQCTajxs2W7GTvut0cUrCiYxSaWynI5hBG2UUogq5WWhTPzO5nw0l+t1
 Pw1VhfC9+a/8csk8wiMf3HF2LiWSaar5lV75by7IjmwKvzbMwmp+nhcGT4ZVWf9Ry3PGl1qjt
 tC5j/ZLdwjOo6Ik/HwYl85GiHDGH073ISz3jbcSm2YTf1zVlswAMOGhumcgkP9JdXqYc0us72
 xpy9WtdwHLlMDoszAhNuNY5S9iuu2SCOa6sxD7FayFqznADkZNwWj6hCqkIy8anjaxeBu9H4/
 Yc/2sbBcXMVIuB6hiTfDhPIXy1ujWF5nXx3QRAyzl2QXt5rbf7TnY9YC4VHdRGt8+9ikXTTKG
 d300vP+vW9a8YR1z99c3s61FWhfFC79j6oPKJ0JJrSgC02SpDMhJ6MNmTbKeW5R7uHuUiK17j
 fnsqbiU6F4aqP1KZjjwVq7hgy4Bb5R54U6SzeO1Pq61H9Gde/i5KhExqYlM7EGkYr4FaEL1gH
 3B8mXTkJJEyGeW4t1LGmWfljTnF56uBoCd56Rps0+5kHG9iVuqQehuUXKxBxUzBG6Ne1tQcPq
 0jtvD+r3dtWFuoO+GzKnVm4olBUVvMwaLyUCQ0LI9iZ2Ijk6Yf3ypBkzRmCsYuZZZWRubAKdc
 jihemGv6nVVM3IACTkgjxpaVKJeCL4aKT3GIvm5QDNwKiKGut9rA1DZTsw9r/pAiR1xhVdphB
 hU3pXR56mR2F6zDjXKRGVeyEZ/wpM5vCb9IF5znRLeq06Ce6oUI+EM41MaYGPOTm95XfcKJ6l
 W3+kv6qd8Ug==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> But with your modified SmPL, we can't find the bug.
>
> I do not see a difference here.

I have accidentally overlooked to pass the parameter =E2=80=9C-D report=E2=
=80=9D
to the spatch program.
Now I notice also an unexpected and undesirable difference for your test e=
xample
after the suggested addition of exclusion specifications.


> - I wonder also about this situation then.

How should the software behaviour be improved finally?

Will we need to work with any SmPL script versions in parallel
for selected source code analysis configurations?

Regards,
Markus
