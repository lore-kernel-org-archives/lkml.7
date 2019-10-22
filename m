Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD17CA9EB7
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 16:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 252D3205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 16:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571762342;
	bh=Oh88TdIVwomXyqjDgrD03dKXu9TTl8Lvlp/IGQhs5uw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TDTqEodhBswpwYFqBZrsEWHty+nXJJsneLyL+D1xSeHDDJkZxRozUJe8JLzOI3RRo
	 9GYQ+xJ6WvCySMZgYWFGc/uItLccaUXSTX7u260CQQS4WLg4kTxP7cGg4KaM0e7CF+
	 F/BMYybAhL4Xl1Df1FvmmzkcPhpRSICoDdiMgoTs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732772AbfJVQjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 12:39:01 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34988 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732026AbfJVQjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 12:39:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Oh88TdIVwomXyqjDgrD03dKXu9TTl8Lvlp/IGQhs5uw=; b=LSW1HEZCZm9pDFMe606YRrM0S
        +75xL9xLQ0Mdnl4kGlDA95WS5lkCzyihsB3yV/gQYe35SBGkMDrSljMusL38h46axGYQ5fUnwOcUO
        ZgnfRMr5EFmZdO/4zCelANLkSmfRrzn7kJ+bGeKv8OkU18WMWh2IucRUHV2h0RAUbi4Vk=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iMxBR-00074D-IX; Tue, 22 Oct 2019 16:38:57 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id D79D42743259; Tue, 22 Oct 2019 17:38:56 +0100 (BST)
Date:   Tue, 22 Oct 2019 17:38:56 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 24/46] ARM: pxa: magician: use platform driver for audio
Message-ID: <20191022163856.GU5554@sirena.co.uk>
References: <20191018154052.1276506-1-arnd@arndb.de>
 <20191018154201.1276638-24-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TVVcQco/7vcH19KK"
Content-Disposition: inline
In-Reply-To: <20191018154201.1276638-24-arnd@arndb.de>
X-Cookie: Whip it, whip it good!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TVVcQco/7vcH19KK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 18, 2019 at 05:41:39PM +0200, Arnd Bergmann wrote:
> The magician audio driver creates a codec device and gets
> data from a board specific header file, both of which is
> a bit suspicious. Move these into the board file itself,
> using a gpio lookup table.

Acked-by: Mark Brown <broonie@kernel.org>

--TVVcQco/7vcH19KK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2vMKAACgkQJNaLcl1U
h9Cafwf+IMs9u3JG7wwFGnBDA4ojo/c0GOly2J9qruoKDijxJlyOzNvP4v4EoarL
O+4UcvUiFTB4Ju5s+obbJGO3MU0uuMM8lGcgK7qmiZ0hly1jukKegk4whw3z+cyr
xx5ek42aS5EmkfBVd9nErG/x062u145i53UtDLyCeCxJHmv9vy5Z/8GJpk9NyeyS
ZsqGoud0yh0X8Llz0G85Ok4ziRCvtw0HzS8GLGXuxZsnPgIACxHBAy5tYT3KlePN
EpBXQTKHS5WEsQ5kFWG/Kux+GrufCEFe+kAvIcYbZQxqD0R9hFuwiw2RQ/EGwX7v
TFQvoO2AhUmcr/eD/5QT56wssTj1nQ==
=1xnE
-----END PGP SIGNATURE-----

--TVVcQco/7vcH19KK--
