Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A4BC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2430321773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556148079;
	bh=DSmHkoIkwZsm1Mx8ltfExaA4b8nehNkyJDu8NKgo8pI=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=zwyxbwxpGg9nvQDKqKLgmwZBXLzMUz+dAtoy/githtvt/gs6HtSX82+lLczkD6zpW
	 2pw8Frj6qKNiMj8yjpWjwprmG8zQVviuehBP3CsUMKk3W8yRUnLMpWuW/cEXdl1CXn
	 uG+09UhCyPMCOvma/+lzwA2qpUKR8eG6Jg4wJLZA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbfDXXVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 19:21:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:40748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727358AbfDXXVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 19:21:17 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6CF62175B;
        Wed, 24 Apr 2019 23:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556148076;
        bh=DSmHkoIkwZsm1Mx8ltfExaA4b8nehNkyJDu8NKgo8pI=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=gjGboqiJ3iboaJ9xE1Ny624NdCprS5t9kYpU06qxsjIaN3AkYjEhmk8nojpeteq0Z
         VfblfykldCXCugpYlUmGSY6cU1g4yfipoTPT5520A4cJGF5bjlYGxNGwS8Pf9Krn3t
         2GgwXjdP4ga0wkZyHufMV2o5cJ84lRiepHweIoOc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1556117426-26878-1-git-send-email-vabhav.sharma@nxp.com>
References: <1556117426-26878-1-git-send-email-vabhav.sharma@nxp.com>
Cc:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        Vabhav Sharma <vabhav.sharma@nxp.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] arm64: drivers: clk: qoriq: increase array size of cmux_to_group
To:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vabhav Sharma <vabhav.sharma@nxp.com>
Message-ID: <155614807592.15276.17299738374776352204@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Wed, 24 Apr 2019 16:21:15 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Your subject should be "clk: qoriq: Increase array size of cmux_to_group"

Quoting Vabhav Sharma (2019-04-24 07:50:13)
> From: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
>=20
> Increase size of cmux_to_group array, to accomdate entry of
> -1 termination.
>=20
> Added -1, terminated, entry for 4080_cmux_grpX.
>=20
> Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> Acked-by: Scott Wood <oss@buserror.net>
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  drivers/clk/clk-qoriq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
> index 1212a9b..f6606cf 100644
> --- a/drivers/clk/clk-qoriq.c
> +++ b/drivers/clk/clk-qoriq.c
> @@ -79,7 +79,7 @@ struct clockgen_chipinfo {
>         const struct clockgen_muxinfo *cmux_groups[2];
>         const struct clockgen_muxinfo *hwaccel[NUM_HWACCEL];
>         void (*init_periph)(struct clockgen *cg);
> -       int cmux_to_group[NUM_CMUX]; /* -1 terminates if fewer than NUM_C=
MUX */
> +       int cmux_to_group[NUM_CMUX+1]; /* array should be -1 terminated */

Please put space around that +.

>         u32 pll_mask;   /* 1 << n bit set if PLL n is valid */
>         u32 flags;      /* CG_xxx */
>  };
> @@ -601,7 +601,7 @@ static const struct clockgen_chipinfo chipinfo[] =3D {
>                         &p4080_cmux_grp1, &p4080_cmux_grp2
>                 },
>                 .cmux_to_group =3D {
> -                       0, 0, 0, 0, 1, 1, 1, 1
> +                       0, 0, 0, 0, 1, 1, 1, 1, -1
>                 },
>                 .pll_mask =3D 0x1f,
>         },

Did you want this patch to go through clk tree? I seem to have acked it,
which I don't remember. Usually when I ack something I assume it's going
through some other tree.

