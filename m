Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24D7C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 15:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E9402082C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 15:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553526351;
	bh=ifoAmYYoFEF7J41kD0wFEywG135ueWAC4bFhmM7PlvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YLJzDsfvGclnrcSt1Pz9gMP58bUcmWpx/If/YlqLNqzNwrg6ugQh8gRP5TohcRAW+
	 7YDr1Kt8RfZ5LNWL5wx1Dad34QUA37/QO8/ovva7TkQRWmRIsi6WTxwYinNMAFRZTw
	 AQwTntppqKYKrd/InTZHgXyFGUP9Qg2tNPnHe7Io=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbfCYPFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 11:05:50 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56460 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbfCYPFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 11:05:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ifoAmYYoFEF7J41kD0wFEywG135ueWAC4bFhmM7PlvQ=; b=JjqVUv4LfGvAqn31EVPtfV+E3
        mAF6p7fjL7QmENkLEgooS41vo7QV32zkGrlejrkJz2T0WUbFYTG1+IzQ4qG/vqlxITTdixwV0hU8S
        IbFqrvyyrGcFcRYMPyOf504dWSelc36kYcIiHZ84yZ/XaeZRNBZAVtXSHz3fqfKGjQKm4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h8RAM-0002Uz-By; Mon, 25 Mar 2019 15:05:34 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id B496011288F1; Mon, 25 Mar 2019 15:05:33 +0000 (GMT)
Date:   Mon, 25 Mar 2019 15:05:33 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, Jie Yang <yang.jie@linux.intel.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Curtis Malainey <cujomalainey@chromium.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: intel: Fix crash at suspend/resume
 after failed codec registration
Message-ID: <20190325150533.GI7284@sirena.org.uk>
References: <1553294388-25293-1-git-send-email-linux@roeck-us.net>
 <5451ba5b-1a5d-41b0-2b39-772c326de785@linux.intel.com>
 <20190325121232.GF7284@sirena.org.uk>
 <50fafc60-0ee4-ab33-8d24-dfc149215bee@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TKDEsImF70pdVIl+"
Content-Disposition: inline
In-Reply-To: <50fafc60-0ee4-ab33-8d24-dfc149215bee@roeck-us.net>
X-Cookie: Short people get rained on last.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TKDEsImF70pdVIl+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 25, 2019 at 07:21:00AM -0700, Guenter Roeck wrote:

> It is actually a bit more complicated than that. The stored pointer (drv->soc_card)
> isn't released. The problem is that dev_get_drvdata(drv->soc_card->dev) is NULL,
> which causes the crash. I don't think there is a UAF involved - I built the
> test image with KASAN enabled and it did not barf at me.

What is a "UAF"?

> Overall the implementation does seem a bit suspicious to me. I don't really
> understand why the platform driver handles suspend/resume for the cards.
> But that may just be my lack of understanding. However, either case, I think the
> Haswell driver (sst-haswell-pcm.c) has a similar problem. I am also not sure if

It's certainly a bit unusual, usually the platform driver would just
deal with suspending itself and the card driver would handle overall
card suspension together with the core.

--TKDEsImF70pdVIl+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyY7jwACgkQJNaLcl1U
h9BAeQf+PQ+l1znpCsPbzSflIPAJyV3HJ4A9fSRVIOnh2V/z+pJQAWq/aTP+9xmp
Ggb5K1xJVuu+oU5FsvAUmZe8vk2ek9LgJDSBFET5mZPljmGIWPLSNM3UgEQixAih
dEQmqfwKjICSHlMkS+Lk82X6GIhsVHCJSqtKS7AQWojcb+Rm2wqGaavgSGZzPBTs
whHJO6905jQyx9e9lE2FZV7/fq4icSPqtYey9yA+59qmT8R5fjxzRhvKs802ZWyR
UKyJZkzC/YRS4og/kThp4rgGpZwWDRi3AKHq4h/1E3b3kskb4QkeZpw4qrAoGtsv
Gn+E1wbeN2yCs1ok6dVkUQQwEEatQg==
=zn5k
-----END PGP SIGNATURE-----

--TKDEsImF70pdVIl+--
