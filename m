Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB70FCA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 09:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CDC8205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 09:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="VTNuagiS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408756AbfJXJXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 05:23:31 -0400
Received: from mout.web.de ([212.227.17.12]:45921 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390225AbfJXJXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 05:23:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1571908987;
        bh=7gUO4Ode5qDL0gPzRYNre9m20djDeahRlXBA5ywUrYg=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=VTNuagiSAFXsk1RB2b9Y5go91qOkdA5Yu4qeYStjitzLJBYxaE1Q8lS0PXPBo18x0
         pkrUOkm+SjKJU1RtlkpC22Hg34PLokE4mMPcBf85mURGZ5hin0XwBSXdVQa1Gy65da
         kaKqUoriVQtk+jMvAj8XLWIlRKASutIAhsXVoBKM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.110.199]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lc8c5-1hgUk22cfl-00jaMb; Thu, 24
 Oct 2019 11:23:07 +0200
Subject: Re: [v2] coccicheck: support $COCCI being defined as adirectory
To:     Zhong Shiqi <zhong.shiqi@zte.com.cn>, cocci@systeme.lip6.fr
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Cheng Shengyu <cheng.shengyu@zte.com.cn>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Yi Wang <wang.yi59@zte.com.cn>,
        Xue Zhihong <xue.zhihong@zte.com.cn>
References: <201910241603217396927@zte.com.cn>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <9303864d-0feb-5be2-9639-bb4f6f574cb5@web.de>
Date:   Thu, 24 Oct 2019 11:23:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <201910241603217396927@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vcHdXHr2creOBtm4hW2jhZMTZLApTCofX1g+vb306R2kJS/W4kL
 1wDA+qZT7T+IzOtzgjVXBSifwjpU21iwII1sbOmeP1P6fbdilm6NlfP41VIyKuTeB+9wTPh
 BaPj3r31CwNJwJokCY6gF4Ju1ugNXnDqC7Tg1DdIBFkHTsvXtqGV6T+y6lQMj49rAk53dBv
 cP5VLV+Mlmq3V2F8sezhw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HaxlO9WmgHI=:9rx4kTJdw7/ZOxkTYNnyYH
 8ktjyuTxQgg2QROwghJWPE9jM3u9AW7g4ko2iyRO+IECqN2M+mD2JAFUJ+0LAf5TVvPvDf3VH
 j1kBnIbJlS0FQn6sRmYnxySwkGgDohjX6lWfBMlddN15Wa695abAhfSwd6RZRfpc1JbkAL6wP
 ojDi3EcsFeabUntPL3bLnaG7iYQf+YAo0IRPlTkHU/+cj7OpZWc6FkJrDeFkkJihtRQqJzntM
 3H7ORIGLPte+sRPzRf2M9MsFyN7KAVn6RkhTy7rmtUr+r0G/M/uyAQfj+Q76DmpCT5fI5z9sg
 LI0/v4qnFqRfgNUwCxfPMF/rK3+uYBOMPH+YXY5+esJcOecrcXLJLmu0zkYMUoRT2H4VJthoi
 e+dRTx2SOZycdzn4T5pL63bHxGbfbrgHb2fLFT4siyMBLPM2mjR+pJFg+DizOcLr50IsKhXug
 RjwrAe3SmIxCkzvU1zrV7S+6VsP4q6vMzJt4VS23M1xeymot+HC5YoEhBCiR5q1vlrAlyaies
 XaD1qEyo90gazp99Fn6+0gXIhpe8UkDjSZeWwmsHsM8/Nh+bKKF7RyXHfUqzWAUTgnQbtz5mP
 QO/6eKgs5HqP0C9enVASa0Fc+7bVM/mbz5SH78JtA+V+TXPp5hqLOjn/s5sW37TMXLyIheeQi
 mQoXbtRuSBL9lp6gwyxbZZKdakkgh9zG/uArpk8hBgrDcJ45ApG0YCxjAsCYHSA2NlnnBBIz0
 FD9ogz26ptt+okdxcAqI3uDATLNK+3nt/b58GAjyEdHMwF/D6R01RpTUaUVFyrca5Dgx4hc/J
 QBPAeh7pNs4HLpj02K+NyerOP3Km2kY/0eNgqiQgoTbHfWFztUiw3Jb+S2ldKUDRu17acdcSG
 Tp679EnTMc14Q5UQmkFHGGlx993OHm0fd0k6TdRbXVGF51x9f3NkFdfm39sG2T4OgYoSn4sKN
 NYQ+M6P9z1ZoJWkiIypohSGMRafZHnogTJnq/ejJ1vI2veLza6vBRlMidJSQBOMwWtb/ZuQyQ
 v5lJ22neFp0/DyOordl64sN/1w5pX6SS8ULjYxN4Z4eJ8N/WCeavaSvUfxgLDRRJNZINPB5eD
 W3DBbV/I3ooMYQxWTSLlD51rP/i7EQzqvYhD4hzb6OWHYCqHQaeT1ADpwCU9yTcviD8U4OOt5
 zZiGiaajLjk/Q1PhHUbji7qTS7L3a3cEI5l/i6KfLR+CEdjcRcT4uu1A1pelyv26wcGKaYmtN
 86PfSc+495go/cjfCiE5Qod3w5zzIdqPfXeAJx0L61FPxgcV4NY6EvXQ+QXs=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> How do you think about to use the subject =E2=80=9C[PATCH] coccicheck:
>> Support search for SmPL scripts within selected directory hierarchy=E2=
=80=9D?
>
> I would like to use subject as you said.

Thanks for your positive feedback.


> But it seems a little bit long,

I hope that this suggestion is still appropriate.


> does it matter?

Do you know an approach which can express almost the same information
with a shorter wording (besides using an other language) at this place?

Regards,
Markus
