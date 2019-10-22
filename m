Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80A0CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 16:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A851D2084B
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 16:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571763232;
	bh=64xwg4EjzWsi963A1nN1trF2oAScSFfc7b7KW8YCN/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nwRa0xfmaEHi1yCg2dwhWxbaQza+EK1pTlWMujU0ysWGIqnBsU7BZAbfCrJzvztxY
	 uDpi+6NLNx1z0WLFmzKgNT92B/NmnIGgawc1bfPD1kofTw6R9woY7aSUFiFqzvuZZM
	 q6bjff8jb1z7mCy6nRyeg7w39yxWsIZ1e2orV/5k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732908AbfJVQxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 12:53:51 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59958 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727885AbfJVQxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 12:53:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nacQBfY/UGUQ+xuZeFazojMy/19k8SRVGm7rI7SQOqc=; b=HAB7IrAm1LQ+xMpuQEu5HYsr+
        vIj2WroRAhofVTFi/J4crk6vTWm4FDHfJ6F8YcdKeEzKXMNnjkknbCdscW9xYXq7D5eF0zOHNTW6O
        4d5nR4PUaQOa9501MToOpkKSiBSyBSNCG0pAHDpU8Xc1a3S1+153FVKYP3Ia39UVWcauo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iMxPe-00075s-2Q; Tue, 22 Oct 2019 16:53:38 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 2890F2743259; Tue, 22 Oct 2019 17:53:37 +0100 (BST)
Date:   Tue, 22 Oct 2019 17:53:37 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Eugeniu Rosca <erosca@de.adit-jv.com>
Cc:     kuninori.morimoto.gx@renesas.com, patch@alsa-project.org,
        twischer@de.adit-jv.com, perex@perex.cz, tiwai@suse.com,
        Jiada Wang <jiada_wang@mentor.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: rsnd: dma: fix SSI9 4/5/6/7 busif dma
 address
Message-ID: <20191022165337.GX5554@sirena.co.uk>
References: <1550823803-32446-1-git-send-email-twischer@de.adit-jv.com>
 <20191022154904.GA17721@vmlxhi-102.adit-jv.com>
 <20191022163501.GK5554@sirena.co.uk>
 <20191022164607.GA20665@vmlxhi-102.adit-jv.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rPH0Y77Oimr1cvNq"
Content-Disposition: inline
In-Reply-To: <20191022164607.GA20665@vmlxhi-102.adit-jv.com>
X-Cookie: Whip it, whip it good!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rPH0Y77Oimr1cvNq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 22, 2019 at 06:46:07PM +0200, Eugeniu Rosca wrote:
> On Tue, Oct 22, 2019 at 05:35:01PM +0100, Mark Brown wrote:
> > On Tue, Oct 22, 2019 at 05:49:04PM +0200, Eugeniu Rosca wrote:

> > > It still applies cleanly to v5.4-rc4-18-g3b7c59a1950c.
> > > Any chance to see it in vanilla?

> > Someone would need to resend it.  No idea what the issues are but I
> > don't have it any more.

> How about downloading it from [1] by pressing on the "mbox" button and
> applying it with "git am"? This will also include any
> "*-by: Name <E-mail>" signatures found in the thread.

> If this doesn't match your workflow, I can resend it.

This doesn't match either my workflow or the kernel's workflow in
general, please resend - that means that not only I but also other
people on the list have the chance to see the patch and review it.

--rPH0Y77Oimr1cvNq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2vNBAACgkQJNaLcl1U
h9DFTwf/YN6aXyO0UZfXUnRzppadDN0/xoHh58aU+6oHsmeayHhYXhEMyJaSx0dl
OEBag6Bb4K9fXX7RBbKFfPrDBmBkwMXFqan9vSfIPo4W9neWCDq+IkIcfzX2/qLa
LgPVi6cWiFibNHRcBvupm0oBdfLIesJ76xJNmA+dZ9aSxZv+tFgX8ocshqbYf60C
UUJtfH8or0Lqr5pCV0y42wCez3vGznkN4peD7tnZrzLVwj8oXLbEYlo/FrKQihXg
kdVTyp/gFwUqJ5ARIMHLGJ9SV+91R1ejA9sSD1+C0pj+7Zbhc43IlmJWvMdFFnm8
bGDya1sGnhk+9ivtxgDHvWpd9TFoMw==
=yjN4
-----END PGP SIGNATURE-----

--rPH0Y77Oimr1cvNq--
