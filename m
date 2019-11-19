Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7594C43215
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A46D0222A0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="E1BdrwRD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbfKSO7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 09:59:46 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:60720 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbfKSO7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 09:59:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1574175580; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5gzc6iuBgaTr89P05jPP8SxsIn5uFVdeznkj0sQ2nnQ=;
        b=E1BdrwRDpKN+MwsEYzwHF0kRuB4SbnvU3CXGFguJ+1BmQSQee9EBejmp7LbqV4t2mbyzoW
        ZMpYQyVzaQxp84UZ05pr8oIDi/B1lKC8nt8WTITMMbW0xfyQ0lFaSZwXqDpj7AzO9wYrXp
        EdL/hCNERFMtfSSoU072p5vdNb/shlk=
Date:   Tue, 19 Nov 2019 15:59:31 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] clk: ingenic: Allow drivers to be built with COMPILE_TEST
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Message-Id: <1574175571.3.0@crapouillou.net>
In-Reply-To: <20191114001925.159276-1-sboyd@kernel.org>
References: <20191114001925.159276-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,


Le mer., nov. 13, 2019 at 16:19, Stephen Boyd <sboyd@kernel.org> a=20
=E9crit :
> We don't need the MIPS architecture or even a MIPS compiler to compile
> test these drivers. Let's add a COMPILE_TEST possibility on the
> menuconfig here so that we can build these drivers on more
> configurations.
>=20
> Cc: Paul Cercueil <paul@crapouillou.net>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>

Reviewed-by: Paul Cercueil <paul@crapouillou.net>

> ---
>  drivers/clk/ingenic/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/clk/ingenic/Kconfig b/drivers/clk/ingenic/Kconfig
> index fb7b39961703..b4555b465ea6 100644
> --- a/drivers/clk/ingenic/Kconfig
> +++ b/drivers/clk/ingenic/Kconfig
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  menu "Ingenic SoCs drivers"
> -	depends on MIPS
> +	depends on MIPS || COMPILE_TEST
>=20
>  config INGENIC_CGU_COMMON
>  	bool
> --
> Sent by a computer through tubes
>=20

=

