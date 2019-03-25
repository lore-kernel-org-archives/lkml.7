Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED939C10F03
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB53F2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553515958;
	bh=Cq7JL8EE9L3QOxsLoqVtWqfpCEn6OemM/9uz505z2gU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=p596nqXRU4wDtdcgXvACZJMnslBrHBAzPYIC6QsMBS2L6cqEJjikfdR2PkafR25yC
	 vtlZrARjTgeQZAyx5eMhDvEQqw94EVfBlUwkbi9UnSxVd1Hf27IaJuJgyPnUNpLqtA
	 BwFy0k1bR+RN2AH2wYfebatg7/iHzvPGUwBlIGqc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731158AbfCYMMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 08:12:37 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48094 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730789AbfCYMMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 08:12:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mUjnyHN4reLGLLj3kMsXoLYctaPjd+OJ4M++TfL3vpM=; b=ivnE98mRfo3bOpbjIgRKgROiC
        wXGt72ErBs/V4KjR7qHAPrjv7jv8ILMLtHnLXJvPnoB5qHkt/R1F+uvYSbv7f2Rz+fl1/uJMCYtMy
        juObg3XcEeWrUcjHq39/1YAayzbcEtaPzDEA64vrpO7p3re7hQ35sTFOKmvjdRUuP7pIs=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h8OSv-00021j-Bw; Mon, 25 Mar 2019 12:12:33 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 58B7C11288F1; Mon, 25 Mar 2019 12:12:32 +0000 (GMT)
Date:   Mon, 25 Mar 2019 12:12:32 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, alsa-devel@alsa-project.org,
        Jie Yang <yang.jie@linux.intel.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Curtis Malainey <cujomalainey@chromium.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: intel: Fix crash at suspend/resume
 after failed codec registration
Message-ID: <20190325121232.GF7284@sirena.org.uk>
References: <1553294388-25293-1-git-send-email-linux@roeck-us.net>
 <5451ba5b-1a5d-41b0-2b39-772c326de785@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mrJd9p1Ce66CJMxE"
Content-Disposition: inline
In-Reply-To: <5451ba5b-1a5d-41b0-2b39-772c326de785@linux.intel.com>
X-Cookie: Short people get rained on last.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mrJd9p1Ce66CJMxE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 23, 2019 at 09:55:46AM -0400, Pierre-Louis Bossart wrote:

> I'd like to highlight that there is a fundamental flaw in the way the
> machine drivers are handled. Since we don't have a hook for the machine
> driver in the BIOS, the DSP driver creates a platform_device which will
> instantiate the machine driver. When errors happen in the machine driver
> probe, they are suppressed due to a 'feature' of the device model, so you
> can end-up with a broken configuration that is still reported as a
> successful strobe.

These are driver specific issues not device model issues as far as I can
see?  The issue fixed by this as is that you're storing a pointer in the
ASoC level (not device model level) probe that you don't free when the
component is unbound, causing you to dereference it later during
suspend.  There is absolutely no problem with the machine driver not
being guaranteed to bind at the time it's initially registered, that's
perfectly normal and should cause no problems.

--mrJd9p1Ce66CJMxE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyYxa8ACgkQJNaLcl1U
h9BQNQf/ZXvr/GtRQbc1tulU2dg2cV0Ubh1sW9F6qTbJgiJDD2cHA1EG8aoZaYEe
vbrYbhpioejXYybsY1Y7J5fHvW1zCPCZ7A0qtP/RtBWt9Wagcq3glxuSlrPTx8tN
Tdt+NcZnHN7D5ybaGmEaOcsNY431mEgJOfNZf08Zr/gHLWAe6QHNBYrlBEGhn7Up
3vgh+G3W7JBpE3EytIIoaqfMqnTOkwN7lPl/3l3yEqk11rYYS8X2vJHzx2w2Dsdc
Osq9rBM3qvwuSJjR1P5+kZJHm4JKzhUUhmXlvK43iHANba0IZthB617xMI9dK2B/
ACLzGeDepi9dTaoEByAV6uPwIZ7LXA==
=wwVO
-----END PGP SIGNATURE-----

--mrJd9p1Ce66CJMxE--
