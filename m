Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F72C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 06:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D74C20882
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 06:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568960284;
	bh=e2hNmqSZJCH/Q0fAgiT3xYgideDTi8tg3iV8O1/wANk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qTqtpFEH7tRJDYJFXSevtQTrsInUEjEVZvoIHPEyO03YUQPL6wZdqj8JJOkEQeDl1
	 XUhXanPAmTRx7THi82jzSQ7CHclWJO8YTvOQGiBcUUEw6n2VzHeOC5DgQbqf5z2a0K
	 xun0Fg5VWRVbYmmU08hCl/EIMJeKFNAWyCogtEXc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394807AbfITGSD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 02:18:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:53442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394795AbfITGSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 02:18:03 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F6FA207FC;
        Fri, 20 Sep 2019 06:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568960282;
        bh=e2hNmqSZJCH/Q0fAgiT3xYgideDTi8tg3iV8O1/wANk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mWmVWP9+tSHhxq49vGb0S8n+iG4TpXtGHwiklAduxT4Sm1No1kl2dPhKxyjp33P5a
         Ph9Uqzcjs6AYhiyDi0tOpqjmqHglk1Tm29f0dFmnwFSIHZdmyZoG3MqdUNSR9DpXEs
         +Eoszmv5t8BYa+ROzg4dkarxkQKi9BzCgRxSjn4s=
Date:   Fri, 20 Sep 2019 08:18:00 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Roman Stratiienko <roman.stratiienko@globallogic.com>
Cc:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/sun4i: Use vi plane as primary
Message-ID: <20190920061800.65sm6jth2afatsvl@gilmour>
References: <20190919123703.8545-1-roman.stratiienko@globallogic.com>
 <20190919171754.x6lq73cctnqsjr4v@gilmour>
 <104595190.vWb6g8xIPX@jernej-laptop>
 <CAODwZ7sPG+_YvnLBU11uYaNpDFthLOkcYXsd=ZQtM+88+cPi9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="p55jde6mff27vfkr"
Content-Disposition: inline
In-Reply-To: <CAODwZ7sPG+_YvnLBU11uYaNpDFthLOkcYXsd=ZQtM+88+cPi9A@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--p55jde6mff27vfkr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Thu, Sep 19, 2019 at 11:03:26PM +0300, Roman Stratiienko wrote:
> Actually, I beleive this is True solution, and current one is wrong.  Let
> me explain why.
>
> De2. 0 was designed to match Android hwcomposer hal requirements IMO.
> You can easily agree with this conclusion by comparing Composer HAL and
> De2. 0 hardware manuals.
>
> I faced at least 4 issues when try to run Android using the mainline kernel
> sun8i mixer implementation. Current one, missing pixel formats (my previous
> patch), missing plane alpha and rotation properties. I plan to fix it and
> also send appropriate solution to the upstream.
>
> To achieve optimal UI performance Android requires at least 4 ui layers to
> make screen composition. Current patch enables 4th plane usable.

Note that you can also get 4 UI planes by enabling more than one UI
layer per channel. You wouldn't be able to use alpha between each
plane of a given channel, but we can use a similar trick than what we
did for the pipes in the sun4i backend.

Maxime

--p55jde6mff27vfkr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXYRvGAAKCRDj7w1vZxhR
xVsqAQCxwRn470B2REaVhb6qgjk9gRnJgE2i6CEATPRGAMcSHQD/d3HgVsQHduOw
gSks8IiI1O6jB8IS0OoGeSFJiwoMqAY=
=JHY0
-----END PGP SIGNATURE-----

--p55jde6mff27vfkr--
