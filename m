Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B79CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 16:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71A9C205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 16:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571762286;
	bh=9/fvYnIL7LfXM+M3n0vReAsqZf3TBvnkJHO/5fj3JO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gjcY7fh9gs0lReTXPJ2eGwEPI+vlVFCeXbszJtzMzNX+7v2R0VdWd0zxvQxrZlMnt
	 eFC83YIx0vTdK8XNqWbtB+iXif720ZgTS+g0oLYZNj2gOi1yD0sibZVsVANKh4Z0T3
	 FUhfsTaa9GUqESq72uXwkB5dJpq5U5O4bOgMciso=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732734AbfJVQiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 12:38:05 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33372 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731727AbfJVQiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 12:38:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9/fvYnIL7LfXM+M3n0vReAsqZf3TBvnkJHO/5fj3JO0=; b=CoarkaARHMkWh9bAgIzemxZsR
        ZvzmzF5YtXG46kMDc4mq8Elq4v2Ls1Ksi/5d0fJ6wJKXvnPpN8U2VLyNJkUidbNWi4BxmYBYFdmOF
        n65S189GFbYRke3uf//1BK3EiXaZQdS65jWEunJuTsODPGypUvSDx8gwF1rjAgkf9WshY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iMxAY-00073e-Kl; Tue, 22 Oct 2019 16:38:02 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 20D842743259; Tue, 22 Oct 2019 17:38:02 +0100 (BST)
Date:   Tue, 22 Oct 2019 17:38:02 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 21/46] ARM: pxa: spitz: use gpio descriptors for audio
Message-ID: <20191022163802.GR5554@sirena.co.uk>
References: <20191018154052.1276506-1-arnd@arndb.de>
 <20191018154201.1276638-21-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jTlsQtO0VwrbBARu"
Content-Disposition: inline
In-Reply-To: <20191018154201.1276638-21-arnd@arndb.de>
X-Cookie: Whip it, whip it good!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jTlsQtO0VwrbBARu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 18, 2019 at 05:41:36PM +0200, Arnd Bergmann wrote:
> The audio driver should not use a hardwired gpio number
> from the header. Change it to use a lookup table.

Acked-by: Mark Brown <broonie@kernel.org>

--jTlsQtO0VwrbBARu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2vMGkACgkQJNaLcl1U
h9BZoAf/byNOVvP8AyVc+q40jXPdmEx1BeW+W+mdkphAUOlrJ8L7ofKVxME7W4jz
lCcZv3svPKXE4Tuv1b8Ua+cFGKl37CIRLQJnpXajrmm5699mqaovyUu6BZXJS9mn
jZvyjEMHS3N2WrMeIZ79cdLjPYLX4ruUhzC0F/gsKPIgHVl9Rt1eJYBGzkTuImWm
yG4Uda6MUVs46UNkpIcT2WWBf72YHWoo2uzy81R+2NX+Hsc4vx1ocJS2VJoDJWPe
yLvJBZlDtnrq1S2F1HMJaK8H86GAT1vNK6FjyrOtDQfpvdqNFCm0oTcyqpn7DvLV
CuSqfIOGxomBEe6WRIVMGaPQ9mKR+w==
=QbX5
-----END PGP SIGNATURE-----

--jTlsQtO0VwrbBARu--
