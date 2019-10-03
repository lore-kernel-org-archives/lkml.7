Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E30C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 13:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D542215EA
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 13:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570108760;
	bh=LZnYEhmvbSaW3Ofpm6bbGneZMRXJOF36LsLe7rVKsiE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CB3HIUCbnoCq3aQCt3rr0eSRqyGS4IdyL2EsGrrGZA6VSJuHDU4kYa45BeAmQOYgk
	 pJ0IyngmeX7MXvrFrIf9NC3AHSDWXPGHT1QuYOiya3zvPuCYclKjsNHYhPCcvHBl8b
	 7UsT6KGqRZ7n+uWjGVEj0Ng6GukXGCWMi2n9T/So=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730380AbfJCNTT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 09:19:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:44258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbfJCNTT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 09:19:19 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9305F20862;
        Thu,  3 Oct 2019 13:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570108759;
        bh=LZnYEhmvbSaW3Ofpm6bbGneZMRXJOF36LsLe7rVKsiE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b4NIq8WYP5JaZDLiCwCQTigNR4O6wgBuNSMj1dwMDtbDVOQj/iC0ui6TY73gL+SiS
         PhJWqYe90ubpY+i3nRet3oc7jB9RCXLLWy8xTzrW+N/EubHZtIg9CAxNkl3mtTMVFc
         lKEUIxFvgExGZqaLKkuZSvOyUEbVr7jMnXC/Pf9M=
Date:   Thu, 3 Oct 2019 15:19:16 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Icenowy Zheng <icenowy@aosc.io>, Chen-Yu Tsai <wens@csie.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [linux-sunxi] [PATCH 1/3] Revert "drm/sun4i: dsi: Change the
 start delay calculation"
Message-ID: <20191003131916.4bm22krapo5tz6oz@gilmour>
References: <20191001080253.6135-1-icenowy@aosc.io>
 <20191001080253.6135-2-icenowy@aosc.io>
 <CAMty3ZCjrM4MajJLyLwt-31mNnfVWghwatogtwVOvCt4gY0LZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gpjy7vewgc4imexw"
Content-Disposition: inline
In-Reply-To: <CAMty3ZCjrM4MajJLyLwt-31mNnfVWghwatogtwVOvCt4gY0LZA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gpjy7vewgc4imexw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 03, 2019 at 12:38:43PM +0530, Jagan Teki wrote:
> On Tue, Oct 1, 2019 at 1:33 PM Icenowy Zheng <icenowy@aosc.io> wrote:
> >
> > This reverts commit da676c6aa6413d59ab0a80c97bbc273025e640b2.
> >
> > The original commit adds a start parameter to the calculation of the
> > start delay according to some old BSP versions from Allwinner. However,
> > there're two ways to add this delay -- add it in DSI controller or add
> > it in the TCON. Add it in both controllers won't work.
> >
> > The code before this commit is picked from new versions of BSP kernel,
> > which has a comment for the 1 that says "put start_delay to tcon". By
> > checking the sun4i_tcon0_mode_set_cpu() in sun4i_tcon driver, it has
> > already added this delay, so we shouldn't repeat to add the delay in DSI
> > controller, otherwise the timing won't match.
>
> Thanks for this change. look like this is proper reason for adding +
> 1. also adding bsp code links here might help for future reference.
>
> Otherwise,
>
> Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>

The commit log was better in this one. I ended up merging this one,
with your R-b.

Maxime

--gpjy7vewgc4imexw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXZX1VAAKCRDj7w1vZxhR
xUuoAP4y5oTqiRELKb7+eBaUuQzrM0UnEaEFGgPGo3tNepr5MAD+JZ+yULsZi7ib
qWa9lYn9gfhY+hQfA+wQQBdXJWRJxgk=
=K3FM
-----END PGP SIGNATURE-----

--gpjy7vewgc4imexw--
