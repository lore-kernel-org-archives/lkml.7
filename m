Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2697ACA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 16:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4372205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 16:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571762200;
	bh=S/esUTBYamlcxz3Whaq0woZLlNP3iaXMA8TIzAQGBtw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nsBiU8iKPkAx4GZiuMwD5R7W4FcuUxZBpULFDGrsjLVZtHjKJoJzNXGCKPKsUP5Wq
	 5ddLb4YQo1vsfkRF12PoKO+6StJdfE+A7YNpGc02PeU0TKtJ9h6AFKqKazkVc+PGO3
	 zKJLKgAzpeMDFbFrwPqUzqMeMbmv7KpxVdeR6RGk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732413AbfJVQgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 12:36:38 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59112 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbfJVQgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 12:36:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=S/esUTBYamlcxz3Whaq0woZLlNP3iaXMA8TIzAQGBtw=; b=ia/5C3N3W+S0YfYt+SiP7qOld
        5+pUuj4E9vXIyBNKazhIMwPcC3hq95hhRUMW24Bhfkbz72K3vEr+XA0KX3Cqgb0zMcjA4u2HptcXH
        Sl8w/veGjSWiO9q3bne+UkNMhv6RAwq6AiEWd6ZNDZgmdLqfV29LnJQTRg0h0NdtQE31E=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iMx95-00072W-LJ; Tue, 22 Oct 2019 16:36:31 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 1CC282743259; Tue, 22 Oct 2019 17:36:31 +0100 (BST)
Date:   Tue, 22 Oct 2019 17:36:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Tomas Cech <sleep_walker@suse.com>,
        Sergey Lapin <slapin@ossfans.org>, alsa-devel@alsa-project.org
Subject: Re: [PATCH 07/46] ARM: pxa: move mach/sound.h to linux/platform_data/
Message-ID: <20191022163631.GM5554@sirena.co.uk>
References: <20191018154052.1276506-1-arnd@arndb.de>
 <20191018154201.1276638-7-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rf72Gf+bfLC8kxKs"
Content-Disposition: inline
In-Reply-To: <20191018154201.1276638-7-arnd@arndb.de>
X-Cookie: Whip it, whip it good!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rf72Gf+bfLC8kxKs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 18, 2019 at 05:41:22PM +0200, Arnd Bergmann wrote:
> This is a basically a platform_data file, so move it out of
> the mach/* header directory.

Acked-by: Mark Brown <broonie@kernel.org>

--rf72Gf+bfLC8kxKs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2vMA4ACgkQJNaLcl1U
h9DD0Qf/XFq0y8LkZDw6GMJf6uYL0f9DnkhueciiDL3lQZLVGGLGG0w3sLQP+jLB
ZGN/SkLyBGD6hh6+tjvQy+TF/NKDP9pOeE1dlhIgxF0QN+W6ibzgedNiEPH6s1iX
oIBME7P/1t0C7nBaWub8M1tyGB230oQjR53ZuffTkLuAOoc/cSwvoRVlMIVSv6eX
NvfDalLQj/XXrxckoMezJpqY8u/xnDIpoEhgv+8fYut+YcUoqu+iotI0w0Q+Z+Q0
iWLWZUSOp/o9GGrv4HXL5GO+ZZtndgGHpdJQiWWmhhmdcevxRJLnKb3qQfA3ANKz
E+OHIQhbeAd6ToUgNYi9U9j7Y1Evww==
=l9b9
-----END PGP SIGNATURE-----

--rf72Gf+bfLC8kxKs--
