Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2711C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 18:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A66D520B7C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 18:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560363948;
	bh=7/JejZXuw4c82OjHDF4+j/TFP9PqUXciwPyDMKWbltA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sOneQrh5nnoShvc/3yh5mKlG9WU1TCRUdx7UaZIgwIlhJsaCBswmANq6FJdKs1Qof
	 S6EaykLEMGOV76HRajsimYLrWxOzuoaLEbcn034/XBr4Giy2M9G2bHInKuBg0K5Dnj
	 sBaAZJdoyz4IDvTIiNKawwKRhEexs8jNiIJm1lMQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbfFLSZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 14:25:47 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35516 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727843AbfFLSZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 14:25:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7/JejZXuw4c82OjHDF4+j/TFP9PqUXciwPyDMKWbltA=; b=diZSDCcMuyJrjruXy1ZwgBgM6
        U5GLj33sBcQ4EZclDj66fANPwauHu7YcuPai2oGPt2BlizI8WSBbIRMDhgGdE2zavpqxCVIWykapM
        byA1dRAOskAfbv/m648KeoOg5tyt8xc0FNJ8lQuw0ijdPLebMkIY31IxyCPww9X0RoOg4=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hb7w7-0003Ol-Hn; Wed, 12 Jun 2019 18:25:27 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id D22F9440046; Wed, 12 Jun 2019 19:25:26 +0100 (BST)
Date:   Wed, 12 Jun 2019 19:25:26 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Clemens Ladisch <clemens@ladisch.de>,
        Antti Palosaari <crope@iki.fi>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Subject: Re: [PATCH v4 24/28] docs: timers: convert docs to ReST and rename
 to *.rst
Message-ID: <20190612182526.GG5316@sirena.org.uk>
References: <cover.1560361364.git.mchehab+samsung@kernel.org>
 <30e605cd5a295c42c39523d88b4c57298c5a6f1d.1560361364.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="j2AXaZ4YhVcLc+PQ"
Content-Disposition: inline
In-Reply-To: <30e605cd5a295c42c39523d88b4c57298c5a6f1d.1560361364.git.mchehab+samsung@kernel.org>
X-Cookie: Editing is a rewording activity.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--j2AXaZ4YhVcLc+PQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 12, 2019 at 02:53:00PM -0300, Mauro Carvalho Chehab wrote:
> The conversion here is really trivial: just a bunch of title
> markups and very few puntual changes is enough to make it to
> be parsed by Sphinx and generate a nice html.

Acked-by: Mark Brown <broonie@kernel.org>

--j2AXaZ4YhVcLc+PQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0BQ5UACgkQJNaLcl1U
h9CfQwf/T+GuS4qxkPnnrGt5BupQpYiRUjRWLkbqyLs9yZLDqKhwJZcErxl4gHHx
Z5Vb42b0CWQLguzl90HFaG5XtXjcUalh/JZX6OI+4o/wvkAKyEDLs83MFPvm/tCw
Theem/1VwhHFUCD+yEPPIqCpBnAySRhPm75JjAJqN0BvIYxskUyXZ2T907Q6/I6C
2sOs4xk62gUU50gKtb8O6++rTjpNux3HBPMX2//qoLOXgcapDinpcoChu4yA4w7g
/C2tRwrHi/o+Wp+AvLZLAzHWgsGvzbtrgaKVD18h4qlNfxN7eZbpsFGiZ7uCI5Xf
nYLJXuUu1+AcRHTr+oU1OnO8pq7ApA==
=+02E
-----END PGP SIGNATURE-----

--j2AXaZ4YhVcLc+PQ--
