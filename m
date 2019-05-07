Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19051C04AAB
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 20:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB3A1206A3
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 20:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557260360;
	bh=97vgYIRnn5T9nj27MHPD5xEHZ9M43+wXVgNmi8eAAOE=;
	h=In-Reply-To:References:From:Subject:Cc:To:Date:List-ID:From;
	b=OUBttq5iSeZ8oExSO7xMGveYoWdDoVIqvZiDjdZs1GKMT+QezW5ioLw17IhMaQ75L
	 TKMpV6OCtVnGd87UfRxzhzYsqHeCv096WElfjQnS9+FLvWtfn3FYUk2/V0+vma8UPF
	 4HjnV7/zbmypyCN9F6ljZG3WmbU0pJjPGxG/o+sU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfEGUTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 16:19:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:60918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726371AbfEGUTT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 16:19:19 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB3C420675;
        Tue,  7 May 2019 20:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557260358;
        bh=97vgYIRnn5T9nj27MHPD5xEHZ9M43+wXVgNmi8eAAOE=;
        h=In-Reply-To:References:From:Subject:Cc:To:Date:From;
        b=EXaMRd0/HGaJEBRYUIjtFsqh0HD2dXXBUXEeXVCHnyaaVLw6ZPmwrFANE/hcAylBi
         4EU4v1+7dt4hTurZqp0TlANMOTJEglzDoV9PCtvVGgqRrezIN9Lkyd6PaF1Mt4ZYGf
         YiNVjmmgiCrpsTydYJIq9xZBCVAt9RIdIJer1WV0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190507193421.12260-1-paul@crapouillou.net>
References: <20190507193421.12260-1-paul@crapouillou.net>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 1/5] clk: ingenic: Add missing header in cgu.h
Cc:     od@zcrc.me, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
To:     James Hogan <jhogan@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Paul Burton <paul.burton@mips.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Ralf Baechle <ralf@linux-mips.org>
Message-ID: <155726035790.14659.7321778387595703949@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Tue, 07 May 2019 13:19:17 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paul Cercueil (2019-05-07 12:34:17)
> The cgu.h has structures that contain 'clk_onecell_data' and 'clk_hw'
> structures (no pointers), so the <linux/clk-provider.h> header should be
> included.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/clk/ingenic/cgu.h         | 1 +
>  drivers/clk/ingenic/jz4725b-cgu.c | 1 -
>  drivers/clk/ingenic/jz4740-cgu.c  | 1 -
>  drivers/clk/ingenic/jz4770-cgu.c  | 1 -
>  drivers/clk/ingenic/jz4780-cgu.c  | 1 -
>  5 files changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/drivers/clk/ingenic/cgu.h b/drivers/clk/ingenic/cgu.h
> index e12716d8ce3c..c18198ba2955 100644
> --- a/drivers/clk/ingenic/cgu.h
> +++ b/drivers/clk/ingenic/cgu.h
> @@ -19,6 +19,7 @@
>  #define __DRIVERS_CLK_INGENIC_CGU_H__
> =20
>  #include <linux/bitops.h>
> +#include <linux/clk-provider.h>
>  #include <linux/of.h>
>  #include <linux/spinlock.h>
> =20
> diff --git a/drivers/clk/ingenic/jz4725b-cgu.c b/drivers/clk/ingenic/jz47=
25b-cgu.c
> index 584ff4ff81c7..044bbd271bb6 100644
> --- a/drivers/clk/ingenic/jz4725b-cgu.c
> +++ b/drivers/clk/ingenic/jz4725b-cgu.c
> @@ -6,7 +6,6 @@
>   * Author: Paul Cercueil <paul@crapouillou.net>
>   */
> =20
> -#include <linux/clk-provider.h>

Please leave these here. We want to keep around explicit includes so we
don't get implicit include problems like we just experienced with io.h
not being included in various clk drivers because clk-provider.h did it
for them.

