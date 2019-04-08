Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E96DC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 06:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5003D2084F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 06:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554705503;
	bh=C0/6+lDLmYAW0rt09hC81mt2DFo/g7/dfz3LprGxL2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tjz2EWmwOnfAaSNts9IQAk4PpzeigF7kfOOxMPMC2k3DjLFRuOvwDCrW37Rcik3tn
	 U8qxpMiMUh1x/9H/fYnIYoqrgocNaN9EeNgml+oOT9MmeV/yTLdMM6kHXrUVrKhLuD
	 8Z1VlX5S8HTRBA+X//634vKxyL85ZAyBFhm+DA60=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfDHGiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 02:38:22 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37710 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbfDHGiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 02:38:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ASqNtm4D4TMrvGMMFjrtQ6XtrPx/KdPQoo5OH0K5/Hs=; b=FLnnOeMtUjWpHL7xwP0v/yWjh
        Smp/wOCwgvi6O0TMxixGsbcyvdeZobMMePi202eNrQU5gvxFTcO8ZzrXb0G0X8+8jmasbM1V32dsc
        m1+3uS1IN/VhvMPDiw8cd/1SpW9IuwM2lJZHtqfxQvPOOyiuEriA1NpZmdy7LRWIJH6uo=;
Received: from [8.46.76.46] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hDNuq-0003eh-0B; Mon, 08 Apr 2019 06:38:01 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 2620C441D3B; Mon,  8 Apr 2019 13:10:14 +0700 (+07)
Date:   Mon, 8 Apr 2019 13:10:14 +0700
From:   Mark Brown <broonie@kernel.org>
To:     Fletcher Woodruff <fletcherw@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Ben Zhang <benzh@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Takashi Iwai <tiwai@suse.com>,
        Curtis Malainey <cujomalainey@chromium.org>,
        Ross Zwisler <zwisler@google.com>, alsa-devel@alsa-project.org
Subject: Re: [PATCH v2 1/3] ASoC: rt5677: allow multiple interrupt sources
Message-ID: <20190408061014.GG2803@sirena.org.uk>
References: <20190401205519.34023-2-fletcherw@chromium.org>
 <20190405204257.87095-1-fletcherw@chromium.org>
 <20190405204257.87095-2-fletcherw@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+sHJum3is6Tsg7/J"
Content-Disposition: inline
In-Reply-To: <20190405204257.87095-2-fletcherw@chromium.org>
X-Cookie: Shah, shah!  Ayatollah you so!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+sHJum3is6Tsg7/J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 05, 2019 at 02:42:55PM -0600, Fletcher Woodruff wrote:

> This patch allows headphone plug detect and mic present
> detect to be enabled at the same time. This patch implements
> an irq_chip with irq_domain directly instead of using
> regmap_irq, so that interrupt source line polarities can
> be flipped to support irq sharing.

This changelog still doesn't explain why there is a need to open code
this rather than having the irq_chip and irq_domain provided by
regmap-irq support whatever is missing here.  You said it "needs its own
irq regardless for hotword detection" but provided no information on why
this is.

--+sHJum3is6Tsg7/J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyq5cMACgkQJNaLcl1U
h9Di0wf+NBjf+bFwqw4oq6RJZ5iGyPABszKGZis/h9oAn8BEh3w5HkteApE6b7vj
2/6OXo6qqVxeRfdC8heAQyGILTpvYuo+HaUKy+JqDqh98fCKBQ53LeE/9i63UewU
DlTI6RY0/cF2dvg6H5hsmp7AGnf4khVtpBh1UoiCKb90i/jZX7BDKmIIBbgVC9iN
pyT5MZvTIVENmidN49e8GnvoVqOvPPEfRDOKiDsEJ+oFHLG39V7K7vbFW/aU9x76
LuXfwIYk6vsBDsPaMl6P6YLBYCuYaONgYI3/XUSFAh5nI6NMeBmgTZQwiq7b3r2v
EFZRpLqZ6TJ7ajDLwJ7mHQWufl0AaA==
=Svc4
-----END PGP SIGNATURE-----

--+sHJum3is6Tsg7/J--
