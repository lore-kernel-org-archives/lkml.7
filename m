Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71C2C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 13:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE45C21874
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 13:21:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="ye6vJt0o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389798AbfHHNVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 09:21:04 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:47492 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389742AbfHHNVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 09:21:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1565270462; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a4sMGU+58l4ZjZqvNldoxEEYUKfU3TR21IuO9AwoB2Y=;
        b=ye6vJt0oK2mT0Ejg6Tx2Yx5nkq22FHycdUxTYubKuXe9fD0jTEdCkRjq84Eaid2bB+w/wY
        KL31pZU+z8TdijVJ8Ae6zAYE+fM+8w7BfEwj8+pEAlvNpiaLLA0xX1OXNQXi38eYfW/UOZ
        VGblV7VNyKaawUwzSoO2SbOvIsw0xA4=
Date:   Thu, 08 Aug 2019 15:20:58 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] clk: ingenic: Use CLK_OF_DECLARE_DRIVER macro
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>, od@zcrc.me,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <1565270458.15950.1@crapouillou.net>
In-Reply-To: <20190808042354.5168A21743@mail.kernel.org>
References: <20190716170800.23668-1-paul@crapouillou.net>
        <20190808042354.5168A21743@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le jeu. 8 ao=FBt 2019 =E0 6:23, Stephen Boyd <sboyd@kernel.org> a =E9crit :
> Quoting Paul Cercueil (2019-07-16 10:08:00)
>>  By using CLK_OF_DECLARE_DRIVER instead of the CLK_OF_DECLARE macro,=20
>> we
>>  allow the driver to probe also as a platform driver.
>>=20
>>  While this driver does not have code to probe as a platform driver,=20
>> this
>>  is still useful for probing children devices in the case where the
>>  device node is compatible with "simple-mfd".
>>=20
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>=20
> What's the baseline for this? It doesn't apply cleanly to v5.3-rc1

You're right. I'll send a V2.

-Paul

=

