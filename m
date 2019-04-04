Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B16C10F0C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 05:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9025620651
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 05:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554355846;
	bh=AMAbd68xJyGXHK5y0Fs7Iu39qAvQ4SaWNERhPnW6MCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JO0n3dH5s83nnuzZwBUtxnHzUxFzA3xTUxU2pgx485WQ23OK3aYRH+DW+esp957DM
	 yHo8ETUqg3TeiMQSei5OdGi4OKuhzO4cG2tP8chAmKFvHW7sMA8GeTVA33dkP4Z2lU
	 cQbzPjtg41aC4nHNlvjNNK8/MZONAYkO1g+DtFY8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfDDFap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 01:30:45 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53918 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfDDFap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 01:30:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=R3YnONeW4GuNowGK8+rUVUUC1ZebQJvRknzgmI/FUB4=; b=uxYRLqLOo5nNAHCm50Q16OTGr
        nLTQxwMm9kreOLWRTUOWprJuK9oIIhN6k4xBWKYMUR3gHLzKAs1kUKKn2IVJ3Qc5q0rpb3fY255bC
        e24EwTPEf3qW9N5v8WzOFZRLl0gCSzgM1TC857g/ryEbt7OsY7yiIg/VZ4kHQQkMgqUSY=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hBuxV-00044T-Nn; Thu, 04 Apr 2019 05:30:42 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 6A1B4441D3C; Thu,  4 Apr 2019 12:30:37 +0700 (+07)
Date:   Thu, 4 Apr 2019 12:30:37 +0700
From:   Mark Brown <broonie@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Axel Lin <axel.lin@ingics.com>
Subject: Re: [PATCH AUTOSEL 5.0 209/262] regulator: mcp16502: Include
 linux/gpio/consumer.h to fix build error
Message-ID: <20190404053037.GK5748@sirena.org.uk>
References: <20190327180158.10245-1-sashal@kernel.org>
 <20190327180158.10245-209-sashal@kernel.org>
 <20190327193211.GC11404@sirena.org.uk>
 <20190404004608.GG16241@sasha-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cEobB2knsyc5ebfU"
Content-Disposition: inline
In-Reply-To: <20190404004608.GG16241@sasha-vm>
X-Cookie: Replace with same type.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cEobB2knsyc5ebfU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 03, 2019 at 08:46:08PM -0400, Sasha Levin wrote:
> On Wed, Mar 27, 2019 at 07:32:11PM +0000, Mark Brown wrote:

> > > Fix below build error:
> > > drivers/regulator/mcp16502.c: In function =E2=80=98mcp16502_gpio_set_=
mode=E2=80=99:
> > > drivers/regulator/mcp16502.c:135:3: error: implicit declaration of fu=
nction =E2=80=98gpiod_set_value=E2=80=99; did you mean =E2=80=98gpio_set_va=
lue=E2=80=99? [-Werror=3Dimplicit-function-declaration]
> > >    gpiod_set_value(mcp->lpm, 0);

> > Does this error actually manifest in v5.0?

> I couldn't reproduce the error on f3c6a1a194317f^ so I assumed it
> requires a specialized config.

I suspect you will find this is a fix for a change that was only merged
in v5.1.

--cEobB2knsyc5ebfU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyllnoACgkQJNaLcl1U
h9B+Ogf9HjUb/rIFl+hWvDW8mQGrXYPsVLeJ4ixhnUW4/JzJGy1l0HeZGn2sPgax
V6aQd9EOcc2zK8HxWU88QR3mtpyfjQwXRvKkiaCnmnW9EcogA9tKUJHwBhuibE74
47ZvfWs4BocMbXfb+DbglUHXK76zgmqrwdNaD02N80K2cPHbqUrvrzIaGi142ulY
QclkaOuOG7gfXvC4JHMmV2A90bQWMovrV+2JpZmY/1ESFjp0muGRD3lEmiOtnV7s
gcKMqtIwxkbST+99Ee7BxMc8QRkT7nOA6cfJOraabjnofS3L8/Q8DFut8DNQsuj+
9id9cke4JJ4QWCk42Z/zCbGDZM9xbw==
=Gykn
-----END PGP SIGNATURE-----

--cEobB2knsyc5ebfU--
