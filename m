Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9101AC43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 16:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CB382178F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 16:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="g5Nr5ka4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394959AbfIGQUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 12:20:34 -0400
Received: from mout.web.de ([212.227.17.12]:35739 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730957AbfIGQUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 12:20:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1567873207;
        bh=wXNswxiUWDzAYlHRespzTzLruEhvGvoajDxluCATqIU=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=g5Nr5ka48Xto+E61MW4DR/OoTt/PTUJmZjA3kVSZWmrAapH5JeMV/TXevh/zLzG5t
         7XQmzmPt8aXRtce52VYMAStFRfuuNtQwKkEhzhwLqbVzGyQ2HJKlo4EIJot3ga5y3h
         CKMzFwdxC38RE4U+pD0+69qAeyGPs4vm/Xfo6jAQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.16.142]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Le4Tw-1iVoAk41Fs-00puf1; Sat, 07
 Sep 2019 18:20:07 +0200
Subject: =?UTF-8?Q?Re=3a_Adjusting_SmPL_script_=e2=80=9cptr=5fret=2ecocci?=
 =?UTF-8?B?4oCdPw==?=
To:     Julia Lawall <julia.lawall@lip6.fr>,
        Coccinelle <cocci@systeme.lip6.fr>,
        kernel-janitors@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Allison Randal <allison@lohutok.net>,
        Enrico Weigelt <lkml@metux.net>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
References: <c8e0db8a-1f96-dac0-791c-43e2d1e1cf05@web.de>
 <alpine.DEB.2.21.1909071804090.2562@hadrien>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <a50cebe5-4aae-ea93-1920-d5743435cd1d@web.de>
Date:   Sat, 7 Sep 2019 18:20:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1909071804090.2562@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Izz7eOeSOxtdWmotLLiw4IXW4L17VWDDla2x6EDB74umCH3A2li
 fMznnhyL8YD1E80qzbq40u1qMWPLUiLFNxc+6qFDpA7/BE5ol6QieiEZMPrThr0XD8VhCE1
 hifGhKvIBDwNiq3WcKL7XYxn85xuJz6ihhZOK5RcEbTeNmf16z64QA/sDcstGTHgNeyC00L
 BNY3ZE5wipbm1a+efl2mA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cXCUOA0JvIw=:IE1hjIY+B9OjqtP9962mws
 UcoMNfVvN+aESglaXBrhla9oCdYkcM7Xnie57DB5ozvgSPOb63Ne+tBQyUex+ZWGObo2g4fQc
 3aIqXfev7GTT4d0INj18D+66p4P1GrjiOjqwoPx7bf68c58w4KeKTUHSlx22Ac2mx+9qpuKue
 KutlzJ1qhEE29d7GkTyKz8+ca14qTpV8Db8TY24yvIhp5BtfmFgPlScOc8LLndOOPxSuvoF/U
 aR/1OEJop1vsYXdnR9ZpUlt+j+f5H7NDa7WX/63oTEtlkcHaQrhXtlZmhN52K7hgq4XVjp3mm
 W9WXgqfyoLqVFmSd0u9Sc1+9wq0+ped/RdbSHabp+JlrwQJdsqrOz9UtuYf2L0LQD1gTWbnuS
 rQcHjuSziCYwtls2l2UM14Ums/ZzVec/O0nE9Z54KpItuB9BBDns2xTzy1Cljj4OZdGOUYxOa
 02IgA/xFo35QQpntJcbfyqDt7n9SWmwl5o10ECljWpJLCmDb/ciQSLM0FlQznxcCtF0lY7V8J
 4PI3LThfnRoMkFiFELUCmTvigr63Wr4pWAXbe9+PbppcTstWe0SepiRfLuR68DPgTpkm7hTCY
 JNoQfg9Zar3JgPW7qFyz3zDiuPGzt5kmOk4yOu5VgyGz1V3YGDUScpXconTfTzrxFMuQntlAF
 PfuR3h1J2yP/9+9tXWT/QDWWxWYC6bdhpzORANXxinMwZSk6YVO4uA+qSTa+1ssR5GmR3vLM9
 TAYBk9fkDrDvokZ8ZNCo+H3yigyyddGDQ2J7Ly/rMv4MihzOv6xG/U8YifBgt46rg1jValkSE
 DDnJ8w8n+t2yH9DPvR5jLnrTpw/d7EKplMgobST/P12/1LTJbdfGIvg/l1s/UvnrG7gHGztBw
 G1ahzaRj/pn6Z3mozhsvurf70u2FdZhDvFgmqA54oc4a2wq1jM8c00RCkh0+LyLjnlpUYoofs
 HoAQUfsPskLQDCGV7oAFuidFSXO4oYALtCeIRANVDOjWAjkO+r0fZTKFAshewDcYevxr9EaRr
 jixSpXm0Mg13vPV1jijYYoOrVzOGgwgWKzwfwzt3MmjJRJUf2xFA25exhvd0/kzh70z5Qm2KM
 7u37Dv+Z516qrJNzQm5dh+B2OzMDBjs/KemIffrgb+tqoCgWHVWyVcyVbCHPjS/tjwVWZV2Ok
 KePXINcgUm4PCFdM0R/UF6SR3UL85eEkR7qAC/ke/0S4lZzYwEkpa6T0XnOvcTI/gX4UGpkpF
 803cCKvYJJlK8nw+7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> How do you think about to reduce subsequent SmPL rules also according t=
o
>> a possible recombination of affected implementation details?
>
> There is not going to be any change with respect to this issue.

I am curious if the software situation will be reconsidered any further
under other circumstances.


> It's fine when replacing one statement by another, but introduces comple=
xity
> when removing something more complex.

Thanks for such information.


> And there's not point to have something that works in only one special c=
ase.

Will corresponding software development concerns be eventually discussed
a bit more?

Regards,
Markus
