Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8022C28EB4
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 18:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E3EB208C0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 18:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559844429;
	bh=PtHQjqPhPn9GtUjORIN5/yJntoVHOyFYm99cfUt3QEQ=;
	h=In-Reply-To:References:To:From:Subject:Cc:Date:List-ID:From;
	b=CA6shzPGDrtCCbCXP1+87boTUDfXwVWtFdCYNqrshneJQyP+p5FDAXuu3WKvqsP2h
	 f6euYIz6jhW0LLMy1+ddDHEabkrncLpZ5Idj/BhUFEVoMj9YGuh7Te/m4YRgkFXO72
	 j9EyVqWk90PFYVBNRd1tvw/Y4Sstgq5asm+NDwYo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730435AbfFFSHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 14:07:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:51216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727559AbfFFSHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 14:07:08 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BD302089E;
        Thu,  6 Jun 2019 18:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559844428;
        bh=PtHQjqPhPn9GtUjORIN5/yJntoVHOyFYm99cfUt3QEQ=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=k6zLDmwuCmwUK53V9J+y+EBIGyWntq9mFBE4r5Elo1vwoTcrD85eMKzbtKG22/gEK
         PBKhCzdjOJY05wYy/dWoJeAopcDZSm+pqcj6iCIPVQxnMR+w4T6tRSnz2zdC37BMv8
         dEflQEjjAuWOT/pPmdB66tGtPxz7O5Z7OcK12gcg=
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
Date:   Thu, 06 Jun 2019 11:07:07 -0700
Message-Id: <20190606180708.0BD302089E@mail.kernel.org>
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

These functions are unused after applying this patch. Can you resend by
test compiling the code?

