Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C2CC28EB3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 17:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2732820883
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 17:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559843302;
	bh=qxJXaHSpX6G/vQYp0vNXcqf+c/7Ggd4r9q6++tXx/nE=;
	h=In-Reply-To:References:To:From:Subject:Cc:Date:List-ID:From;
	b=DA2TWAvFEemboKhkRvwdmDiOjR6KFr67oRgu8SZ9UWBiVqzN1rKTBWqHJKLzYXihN
	 eAenTyXdBpFU6IwS/CeFZfw5aQHK9ldkEBAQYcbTFdsz7Tt+WPESm+vGScXv/G59Eo
	 nZ2diQsju5gFJA3b6mjgahhj+emdVkSAhjAqPBy0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730293AbfFFRsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 13:48:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:38654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727961AbfFFRsU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 13:48:20 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9747720868;
        Thu,  6 Jun 2019 17:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559843299;
        bh=qxJXaHSpX6G/vQYp0vNXcqf+c/7Ggd4r9q6++tXx/nE=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=QrEKNot6jJmWjc64RDPVQh7xHmqY9EAhQ9SyYY2yOrdpERHsihoHjxdFWBUtf3sty
         5gL/nNAtgmtq5Y6LeEMYYhwYlNr5wM4gd1xBPyiHkDcBkdAcdflT5oZbbNzk4/ZPux
         4PRlrVRmQLwsevK5BmXx8Q13MSs3mIqAK2Jh0PUs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <VI1PR07MB4432F4F275BC445289FF3D9CFD070@VI1PR07MB4432.eurprd07.prod.outlook.com>
References: <VI1PR07MB4432F4F275BC445289FF3D9CFD070@VI1PR07MB4432.eurprd07.prod.outlook.com>
To:     Philippe Mazenauer <philippe.mazenauer@outlook.de>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] clk: armada-xp: Remove unused variables
Cc:     Philippe Mazenauer <philippe.mazenauer@outlook.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
User-Agent: alot/0.8.1
Date:   Thu, 06 Jun 2019 10:48:18 -0700
Message-Id: <20190606174819.9747720868@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Philippe Mazenauer (2019-05-21 01:58:41)
> Variables 'mv98dx3236_gating_desc' and 'mv98dx3236_coreclks' are
> declared static and initialized, but are not used in the file.
>=20
> ../drivers/clk/mvebu/armada-xp.c:213:41: warning: =E2=80=98mv98dx3236_gat=
ing_desc=E2=80=99 defined but not used [-Wunused-const-variable=3D]
>  static const struct clk_gating_soc_desc mv98dx3236_gating_desc[] __initc=
onst =3D {
>                                          ^~~~~~~~~~~~~~~~~~~~~~
> ../drivers/clk/mvebu/armada-xp.c:171:38: warning: =E2=80=98mv98dx3236_cor=
eclks=E2=80=99 defined but not used [-Wunused-const-variable=3D]
>  static const struct coreclk_soc_desc mv98dx3236_coreclks =3D {
>                                       ^~~~~~~~~~~~~~~~~~~
>=20
> Signed-off-by: Philippe Mazenauer <philippe.mazenauer@outlook.de>
> ---

The patch is base64 encoded.... Sigh outlook!

>  drivers/clk/mvebu/armada-xp.c | 14 --------------
>  1 file changed, 14 deletions(-)
>=20
> diff --git a/drivers/clk/mvebu/armada-xp.c b/drivers/clk/mvebu/armada-xp.c
> index fa1568279c23..2ae24a5debd0 100644
> --- a/drivers/clk/mvebu/armada-xp.c
> +++ b/drivers/clk/mvebu/armada-xp.c
> @@ -168,11 +168,6 @@ static const struct coreclk_soc_desc axp_coreclks =
=3D {
>         .num_ratios =3D ARRAY_SIZE(axp_coreclk_ratios),
>  };
> =20
> -static const struct coreclk_soc_desc mv98dx3236_coreclks =3D {
> -       .get_tclk_freq =3D mv98dx3236_get_tclk_freq,
> -       .get_cpu_freq =3D mv98dx3236_get_cpu_freq,
> -};
> -
>  /*
>   * Clock Gating Control
>   */
> @@ -210,15 +205,6 @@ static const struct clk_gating_soc_desc axp_gating_d=
esc[] __initconst =3D {
>         { }
>  };
> =20
> -static const struct clk_gating_soc_desc mv98dx3236_gating_desc[] __initc=
onst =3D {
> -       { "ge1", NULL, 3, 0 },
> -       { "ge0", NULL, 4, 0 },
> -       { "pex00", NULL, 5, 0 },
> -       { "sdio", NULL, 17, 0 },
> -       { "xor0", NULL, 22, 0 },
> -       { }
> -};
> -
>  static void __init axp_clk_init(struct device_node *np)
>  {
>         struct device_node *cgnp =3D
