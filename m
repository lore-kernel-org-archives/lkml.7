Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752B0C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 11:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4915820842
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 11:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565608043;
	bh=DXHfdczzz0Ngw+McQkfe+Do33h0S24f/hNtYp5Nr2Ho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fUrzLUHQIilrU9NwejBrrRm+HvKd6USESTz/gRTiDhsykBkckOMnJHl+fz5S2eNMd
	 SlVDxOganqfFVugAcWyWuX6BrG0AGX/rWUPZ88UD+Lp7k/q5DmwbnZCFt2hjsgirau
	 qSk1RlUlHxPJ9mLjLyTmxZM73wH1Y21zngIPv1A8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbfHLLHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 07:07:22 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59360 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728054AbfHLLHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 07:07:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DXHfdczzz0Ngw+McQkfe+Do33h0S24f/hNtYp5Nr2Ho=; b=Nv/NKn/6zoFeAuQr5jGDYm312
        L3o64lDHq5rXTY9MV7JA5VtpYsL8fr05Wfrn9h7MmUF6suls3UKo6FDBD8e+1PQjx+2gel/b08krO
        kh1l8qJWFLludx1SAcIG5KPn7JBt0amMVaydDs8uAcJZrT5/KvkWN2i3XOxdi39eSg0Dw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hx8Aa-000123-8B; Mon, 12 Aug 2019 11:07:20 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 594B927430B7; Mon, 12 Aug 2019 12:07:19 +0100 (BST)
Date:   Mon, 12 Aug 2019 12:07:19 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] regulator: core: Add devres versions of
 regulator_enable/disable
Message-ID: <20190812110719.GE4592@sirena.co.uk>
References: <20190809030352.8387-1-hslester96@gmail.com>
 <20190809151114.GD3963@sirena.co.uk>
 <CANhBUQ09+q9_=7nMs63w4KRLGOhW1=z-AnuwOzAnUrWRY6uC6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sfyO1m2EN8ZOtJL6"
Content-Disposition: inline
In-Reply-To: <CANhBUQ09+q9_=7nMs63w4KRLGOhW1=z-AnuwOzAnUrWRY6uC6A@mail.gmail.com>
X-Cookie: Decaffeinated coffee?  Just Say No.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sfyO1m2EN8ZOtJL6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 10, 2019 at 09:44:45AM +0800, Chuhong Yuan wrote:
> On Fri, Aug 9, 2019 at 11:11 PM Mark Brown <broonie@kernel.org> wrote:

> > I'm not super keen on managed versions of these functions since they're
> > very likely to cause reference counting issues between the probe/remove
> > path and the suspend/resume path which aren't obvious from the code, I'm
> > especially worried about double frees on release.

> I find that 29 of 31 cases I found call regulator_disable() only when encounter
> probe failure or in .remove.
> So I think the devm versions of regulator_enable/disable() will not cause big
> problems.

There's way more drivers using regulators than that...

> I even found a driver to forget to disable regulator when encounter
> probe failure,
> which is drivers/iio/adc/ti-adc128s052.c.
> And a devm version of regulator_enable() can prevent such mistakes.

Yes, it's useful for that.

--sfyO1m2EN8ZOtJL6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1RSGYACgkQJNaLcl1U
h9BI5Qf+MjbM11UyOu1uRb8i9kBtXAhB3Nf++MDh5wUhKYEmZa3Jd9HPcfiSl1BI
bG2CUtD8eHAktpenvf2YudwZ18GYuTA09RaauWbEu07aB3uUAzRykh9Af6yPj8wH
tt3tn97PeEaYb5DaiJYQtbMyUALv2k0cWxrnXWIJvG9tClfuy4VWTKeEOfw0t09N
pzsFWUE980VeemegI4ceyMYVQ7/aUxmsdvSFnQF0v5+qzeMH0Io1M9IU2YBUhvqz
WuCdRXW81YoO+rhwbBguczlriy6cCN27ilwM+tpX9eilBYdhfFkUHIjptjYW1P01
Jh1z5hndyvZrMvpMpM8iJam8nXgBEQ==
=SvNi
-----END PGP SIGNATURE-----

--sfyO1m2EN8ZOtJL6--
