Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD51C468BD
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 10:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99D772146E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 10:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="UrQTUSTM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfFHKOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 06:14:14 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:44366 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfFHKOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 06:14:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1559988851; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DE+IF33LpkgmZHSCRWxR0rRV5we/9i/ZbnSKu4FvJFo=;
        b=UrQTUSTML8m9DMJ/+2IJJL4LBBAG65lP13V+eyHDF1vSmjfahqxsAcD9HNjoO/iWKEqqWY
        9RadF8M7CWhgrp0lhWXJ/QjYHthYIwAfP3/P/VXk9UCqXCKNONQdogpnxpbwzdt5vChd3X
        2JOHRhcPfjNSwxLZhblwQDwArv3jLcQ=
Date:   Sat, 08 Jun 2019 12:14:06 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] MIPS: lb60: Fix pin mappings
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, od@zcrc.me,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable <stable@vger.kernel.org>
Message-Id: <1559988846.1815.1@crapouillou.net>
In-Reply-To: <CACRpkdbKg22OyViYhXS=Vyps=2zQ_dmm23Xr8+dBp+uwwjheuQ@mail.gmail.com>
References: <20190604163311.19059-1-paul@crapouillou.net>
        <CACRpkdbKg22OyViYhXS=Vyps=2zQ_dmm23Xr8+dBp+uwwjheuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le sam. 8 juin 2019 =E0 0:10, Linus Walleij <linus.walleij@linaro.org> a=20
=E9crit :
> On Tue, Jun 4, 2019 at 6:34 PM Paul Cercueil <paul@crapouillou.net>=20
> wrote:
>=20
>>  The pin mappings introduced in commit 636f8ba67fb6
>>  ("MIPS: JZ4740: Qi LB60: Add pinctrl configuration for several=20
>> drivers")
>>  are completely wrong. The pinctrl driver name is incorrect, and the
>>  function and group fields are swapped.
>>=20
>>  Fixes: 636f8ba67fb6 ("MIPS: JZ4740: Qi LB60: Add pinctrl=20
>> configuration for several drivers")
>>  Cc: <stable@vger.kernel.org>
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>=20
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>=20
> Such things happen. Are you planning to phase all the board files over
> to use devicetree eventually?

Yes, that's definitely what's planned; right now the blockers are
patchsets [1] and [2]. [1] is ignored by everybody because there's no
maintainer for drivers/memory/. [2] is a year-long effort that still
doesn't show me the light at the end of the tunnel.

[1] https://lkml.org/lkml/2019/6/4/743
[2] https://lkml.org/lkml/2019/5/21/679

Cheers
-Paul

=

