Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E15F7CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 14:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A63452087E
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 14:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572445463;
	bh=Kz0IT5UaT8gLAAfRWmhaV6j3O6NdS/ROd/IujVWkGVE=;
	h=In-Reply-To:References:From:Subject:To:Cc:Date:List-ID:From;
	b=qrsrjcV6qMrC7vOceqwOKjd79w6ukuo7avU7GtpzZ2hLlBSCsAy5jDxEpvSind7wg
	 fcdtninAe+L3HKj9H5mb7TS4jsPAPH5N8lcgOX0T1jBAUI8tD/UMPMAU2H6ixQKjz7
	 eq+0RSOs7mnydbrkc+DMoNOsOBG3p052m/XKmtA4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfJ3OYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 10:24:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:52094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbfJ3OYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 10:24:22 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7372920656;
        Wed, 30 Oct 2019 14:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572445461;
        bh=Kz0IT5UaT8gLAAfRWmhaV6j3O6NdS/ROd/IujVWkGVE=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=Z13SX6ZjaZruwkFG9gPRQOnp0DYWXrLzo722ret5nAfOi4ywm2QPXrTL8Iqn1b0OQ
         HG9p406cNxZ2wU+lrcTprSrTDE/3zfgdda4AUxlXEZsZ3BjhWchx6zwFsHtAXnjhdC
         upQvfFWx3jgixJub/DrHTlwj+WMPpju63SGMK7Ys=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <97cb0b95-72e9-7aff-28de-637310d66caa@rasmusvillemoes.dk>
References: <20191004094826.8320-1-linux@rasmusvillemoes.dk> <CAMuHMdXSb0mgsqJgNFWqJXywQJLsqvasj7P_bUj4MBvyrAUgVw@mail.gmail.com> <97cb0b95-72e9-7aff-28de-637310d66caa@rasmusvillemoes.dk>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] clk: mark clk_disable_unused() as __init
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
User-Agent: alot/0.8.1
Date:   Wed, 30 Oct 2019 07:24:20 -0700
Message-Id: <20191030142421.7372920656@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rasmus Villemoes (2019-10-29 15:20:22)
> On 07/10/2019 14.02, Geert Uytterhoeven wrote:
> > On Fri, Oct 4, 2019 at 12:30 PM Rasmus Villemoes
> > <linux@rasmusvillemoes.dk> wrote:
> >> clk_disable_unused is only called once, as a late_initcall, so reclaim
> >> a bit of memory by marking it (and the functions and data it is the
> >> sole user of) as __init/__initdata. This moves ~1900 bytes from .text
> >> to .init.text for a imx_v6_v7_defconfig.
> >>
> >> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> >=20
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>=20
> Friendly ping. Will this be picked up?
>=20

Friendly reply. Yes.

