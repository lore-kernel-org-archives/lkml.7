Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745E4C04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 17:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 430B62146F
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 17:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557680768;
	bh=87o37kpwvI1kfqMgeqZL71zdz58KB5+15cYxzz+oq/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=g3wsHYQdzbYerYi27Lb0ABFlvr5ao9D+TNZnUh/+bSrVnVabODQixMctZAbIuVtbO
	 fDyuMkrqQebqCPI+57k1S+XjOfrEviqDFNhvvDVK18I+oEJqOPLyW7FPq+iUEanjta
	 8NBN1PGVZW8Bfm3pJnDOwfI0tRq5SCk3uJP9kyvU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbfELRFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 13:05:52 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49572 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbfELRFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 13:05:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nbByTlVdvhd4cJtvH/Oei0P8BYeWA+j4hmBdzYBpl7U=; b=pgfyvM8VHeCIw0PFOvMa1wVNz
        pACtyWMg0cyUO/qu4Flq2BvrCcyy8t/EE5J6W4F15cNzxWTmZcqYXjvApYtuc+LyyvihQzUkgglJO
        NupuSyvoRjZKqJW/H5M3+J05bEwM3TkEB1r723hp+dbWCjw8u37MqR89rQy79X/WRtIao=;
Received: from [81.145.206.43] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hPruu-00044f-8V; Sun, 12 May 2019 17:05:40 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 939C8440034; Sun, 12 May 2019 08:45:38 +0100 (BST)
Date:   Sun, 12 May 2019 16:45:38 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-rockchip@lists.infradead.org, drinkcat@chromium.org,
        Guenter Roeck <groeck@chromium.org>, briannorris@chromium.org,
        mka@chromium.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] Revert "platform/chrome: cros_ec_spi: Transfer
 messages at high priority"
Message-ID: <20190512074538.GE21483@sirena.org.uk>
References: <20190510223437.84368-1-dianders@chromium.org>
 <20190510223437.84368-5-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ns7jmDPpOpCD+GE/"
Content-Disposition: inline
In-Reply-To: <20190510223437.84368-5-dianders@chromium.org>
X-Cookie: HOST SYSTEM RESPONDING, PROBABLY UP...
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Ns7jmDPpOpCD+GE/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2019 at 03:34:37PM -0700, Douglas Anderson wrote:
> This reverts commit 37a186225a0c020516bafad2727fdcdfc039a1e4.
>=20
> We have a better solution in the patch ("platform/chrome: cros_ec_spi:
> Set ourselves as timing sensitive").  Let's revert the uglier and less
> reliable solution.

It isn't clear to me that it's a bad thing to have this even with the
SPI thread at realime priority.

--Ns7jmDPpOpCD+GE/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzXzyEACgkQJNaLcl1U
h9CZ8Af/Zx78PRk1JAMVQgIM9tFEJxhIQNOf2mVis4Ku5Pv89nRp1solLrhwReKo
osAxMTDdLUOKuZxBJxBdshhCdHB04UXpwDnaPeX8jXeN43azdvv0jz8/UuUmhl69
9KqCSjyH2hQ+zSCMcsZK2iN+44J4Q+Sv4Gr2R95Cpvo1kRqxz/LOfhOa3xoStb7X
eFgjYaSmEA7yS5vt2sLunTzeH7YH1o9j9tG/L0QRpeHeJIqtwcUWUctr1PUjrNdE
AXYJpaV8wrQnzFkcmf+wQt4I477pALXbx9OlmFj1tP6YgklHvFc65Z/eNNUlYePs
D0koY+RVt8j06SujCyTf+c9I/89Wng==
=4tri
-----END PGP SIGNATURE-----

--Ns7jmDPpOpCD+GE/--
