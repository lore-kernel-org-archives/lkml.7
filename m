Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC67DCA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 16:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93CDF20B7C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 16:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571762120;
	bh=bnugo1BnfQhQxwRSf7NzxfR70ZZ2Gz6igH9YucBIUBQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=C8rdWZjxpdt8An60KLhZrj9ZHyFeOlXdZeWbqR8KBYAL3GG2IVroB8TxS2VEsbAHY
	 N7Xqg85HkQB8z1oiJpyt/ZtrhObjaxe/4bbdP2ggW9aA2hTa+FTJgDiYTKgr1UBkoO
	 NA9sB3ttQD0lxGy7XhEMhwNO3quDn/EIW59Xvaw8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389495AbfJVQfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 12:35:19 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56850 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389485AbfJVQfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 12:35:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3DAMGtjpRcEj5MxkyBHvgw9I1vtN+eg87OdL/Q7rOxU=; b=nsKzOX/bnhQYhfAQ88mC+POLD
        LqhgI3wA4l4S8A2a4tBz+r3o+TlxcauggO+bP2Ws1IJG7vsbrSD3KmoEHon6rJIILXiL8wZbccXkg
        8vKUkL2HuWf4XfRUBRfJIqG3QNOxPCEUOLmqFgEoJkLdC46I3sbQGbJvPayUDKE5ls+bs=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iMx7d-00071w-MA; Tue, 22 Oct 2019 16:35:01 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 21EC22743259; Tue, 22 Oct 2019 17:35:01 +0100 (BST)
Date:   Tue, 22 Oct 2019 17:35:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Eugeniu Rosca <erosca@de.adit-jv.com>
Cc:     kuninori.morimoto.gx@renesas.com, patch@alsa-project.org,
        twischer@de.adit-jv.com, perex@perex.cz, tiwai@suse.com,
        Jiada Wang <jiada_wang@mentor.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: rsnd: dma: fix SSI9 4/5/6/7 busif dma
 address
Message-ID: <20191022163501.GK5554@sirena.co.uk>
References: <1550823803-32446-1-git-send-email-twischer@de.adit-jv.com>
 <20191022154904.GA17721@vmlxhi-102.adit-jv.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QxIEt88oQPsT6QmF"
Content-Disposition: inline
In-Reply-To: <20191022154904.GA17721@vmlxhi-102.adit-jv.com>
X-Cookie: Whip it, whip it good!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QxIEt88oQPsT6QmF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 22, 2019 at 05:49:04PM +0200, Eugeniu Rosca wrote:

> It still applies cleanly to v5.4-rc4-18-g3b7c59a1950c.
> Any chance to see it in vanilla?

Someone would need to resend it.  No idea what the issues are but I
don't have it any more.

--QxIEt88oQPsT6QmF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2vL7QACgkQJNaLcl1U
h9Atiwf/TC9MLCgCfLcRjT+GAkZHV5/iKnB0WppOTrYDfawY44SqLnFxcFDqs1xw
ZLYAVe3WabLE3vXk5AuUw2RuqHXEeVLLL/bsGQEIbzMmuSIYo0g8Qv1mOyCA2Q2R
gXHENTJHUPBPnYQeo7JfwVo3stcXdFjnN4LMWJU1rLgNGXrjsfo1jbhAzs1nVXbo
KCqkYC0Z7+/s/Y0lPGJ7QjDlHaRN3Mhj43jvxu3WPxyHRGFN/kXC0anJT0c2J7QE
9B8J5in7U2ptKLnsu8IZd+7NHooSk78VOR7Q1EaTwg2eekqVzd6b8M5C4h88Rb4x
fZu8hn34aED77ELINZbd+aCnXJZeZw==
=tQ84
-----END PGP SIGNATURE-----

--QxIEt88oQPsT6QmF--
