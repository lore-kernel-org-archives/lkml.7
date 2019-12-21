Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CC8C2D0C0
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 09:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0B38206D8
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 09:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="AQruyh3T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbfLUJb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Dec 2019 04:31:28 -0500
Received: from mout.web.de ([212.227.17.12]:37461 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbfLUJb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 04:31:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1576920639;
        bh=FquviSxEiV+GwshRfzWoxnYNf8mIz0ml0zyde3yaKgw=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=AQruyh3TgaNutPR4nC/ESZn7JQVZPndlL08MG2ZUOl1ya6ADIU8J14f0trUuoWCV1
         cMmkSJC8g6HgvGkh7NaOdFhVz1XcvGSK37ffvITC+cAG+r07OioOHpRIqbmmAPdqmk
         jgCvkUwAU8tr58jYte2G68fq1Pl7ZecZ4fFikuz4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.144.160]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M2dTd-1hqDWM0wWT-00sRZP; Sat, 21
 Dec 2019 10:30:39 +0100
Subject: Re: string.h: Mark 34 functions with __must_check
From:   Markus Elfring <Markus.Elfring@web.de>
To:     kernel-janitors@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        David Laight <David.Laight@ACULAB.COM>,
        David Sterba <dsterba@suse.cz>, Joe Perches <joe@perches.com>,
        Kees Cook <keescook@chromium.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <75f70e5e-9ece-d6d1-a2c5-2f3ad79b9ccb@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <95473676-5bb9-0104-38ac-0d196d3ded83@web.de>
Date:   Sat, 21 Dec 2019 10:30:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <75f70e5e-9ece-d6d1-a2c5-2f3ad79b9ccb@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4JAjJpo6HtGKpf3oEbnCOYNmOZu+nrDNIq9CWxvOCI2481zqCZk
 XMSvPYrV5plFX/roEh5pbSflfpjsggr0Z4EAUyOd3vMwGNeR+bkhJZUIdAX0uDEG71tzL7q
 D57yhy2PTTk17fLefmb+YTRm2bhmRvyTZKJVgdNITR+A98r6NtCxCi5P5Ad+CJJ2tPowJP8
 JL5yAkjyEV4nIH6fRf/GA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pHONU6glPTg=:Ziwtw+ecYfzoSCczKCeU/H
 a/H3m4xDzQBGTRJRmC/2JnInIXuBSPvQUHsRduXema3IPcOQRe8EW3SoVY6cC2rOCewoBMqb9
 9gSnErnTJlp5z2saYe8WC/BxgJmVLGq5NGty1mFj+g7wmxlfInUamdY6MLJtxSNG4afNHzSPX
 AVc/yDzbvwBd/D0TXnMJgbAvp7lXp2zCyP83Rpd9MYxGqFaMVI/6AH80Saff94xPIVVHBenZ8
 by/0b5+8FFqFFIh/wNMNskiAFVRWWWBJatXQ6jK7yMBQxl+inpelMq5VbNJhFgMmMiCyAGaAC
 8UUALtr5xprsuxtxBmM4lsI713CO2Fu4ZMGdjXhBnE5410w5ka0URPIovBApueKXYHQAs6c5A
 X8IGfQUfGtet+rZ7D9H4ksnC69FVh6af8FBEJaL44nnQUeEV9sLwA17Y2jL93kgM0RYDVUoS5
 U2fkZbbsoQ6ri72ZTSD932nMrI4bETxupe0F3jBBuavmkdjHhDbqLCdguravA6gPNx0vfLajZ
 8+NeRWqrRlNBggAangMPdZVASWvNM8VDM47YkximSxgcl4o3vFkKtTpsZziXPSOJp6OyZEZdc
 q9kpKgRWg0S4Ms9bMhwbgG6PQvyYRZmYilDHJDbLWMKQ1At+gIPn+cgaPGLNq0h6NaZJsIwwd
 nAfEhY+yPxnNjdtE12j2J/5NUm2keOfCQITrZCYHUe0bBisxvNRZJM+1Xz+8DYlTLTazwQnHd
 JGWUZNGKRSCLDawKUuIM85RKi6w7+PyaUL6+rnRszgwS5uMkskmBl1QR3BskgqS+ACBYZXzlU
 hlPkIOS0hvTrH7o0I4pg5NMLy3WiCSwcEjfGsCuBU1VtF0gV4DlXbg/rsdl5zGxu59wCU1geH
 0MVpferphtMMpCZ05ay0WHpGte8RAGLuQxL0+rMKGbBUlmFWHOn/bb95di4cn9LcTok0hax7T
 VWZUxtBr3eUl1Ira3BZfAdkDNGwHIXeEErzBhehXomGtqdTqMsJQYFpXmVaJ5qppzC0Le7A7a
 nxGFLmPw2z9PriztiLwVq431CZHUVzoI4oNyV+8ZuQ+h3RQHKieWApTDpLCwz8ACYXTG72x82
 7n8saIcB+fU1qm6okmyPpxXNLx5SLnCfRy6/nMuYIcfFxTZA6UUqtJIizsbF3PeVRgxNkJu7m
 yeXRXzLwyVxkfKVAA0lBCSjzP4mUc5wHuVKwZzT9sRBQHyns1mRkdxNQWpnSi1iP9rR4yecg1
 FfRSwtBndK1Z3+6rO+hHSAexojEMuw8M1tew2Fil5ZiGA47rzCM9Tkci9Gfc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Several functions return values with which useful data processing
> should be performed. These values must not be ignored then.
> Thus use the annotation =E2=80=9C__must_check=E2=80=9D in the shown func=
tion declarations.

Will such a software development topic be clarified any further?
Would you like to continue the discussion?

Regards,
Markus
