Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 853C0C3276C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 00:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D9ED217F4
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 00:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578012881;
	bh=zc6nBxGf7yCpcZzP4TZ1lilk7d1NcsOxhdHwmEx2Gww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2WYVchmiWuH4HbBUh3kA0QvnrLZFTR1EEPBVuxa8JZhKnwlwlmbv6IxL8s6RA+IWO
	 0VgNB+JrIHWhqUc553db6No1ho3ZjLPR0/+6iZ6OUfDpgmK0rKPK/WHk/qdqo1WNnO
	 3SLw/4LdYBQbd4FQdF2fvQ44n4M1OPyE4dUDpSyk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgACAyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 19:54:40 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60858 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgACAyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 19:54:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=w8FcuKIRc1fu8oxZLGHNujTkaW4KdWzXN9N/pQxssUs=; b=aizdm9srKEF+86calgWhejVZI
        lvrluuEvxzSfCattQ54W4Sloxfh/oqSeHcZDzsEvJLGGfvdTWf4j5sPBFu9KdD6IdIUp6kfAtw0D8
        TJBRLFaoVF0GVnS5DuyuOJ61E6LxztQK6IJwIKgBTiuGw6F7vhUgr+GJiSl7ElShB8MVE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1inBEP-0003Ll-DL; Fri, 03 Jan 2020 00:54:25 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 2AF04D057C6; Fri,  3 Jan 2020 00:54:24 +0000 (GMT)
Date:   Fri, 3 Jan 2020 00:54:24 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Bard Liao <bardliao@realtek.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, linux-tegra@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] ASoC: rt5640: Fix NULL dereference on module unload
Message-ID: <20200103005424.GF3897@sirena.org.uk>
References: <20191229150454.2127-1-digetx@gmail.com>
 <20191231001719.GC3897@sirena.org.uk>
 <03ccf221-697e-bc34-f4ba-bf191aecd675@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="V4b9U9vrdWczvw78"
Content-Disposition: inline
In-Reply-To: <03ccf221-697e-bc34-f4ba-bf191aecd675@gmail.com>
X-Cookie: Programming is an unnatural act.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--V4b9U9vrdWczvw78
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 02, 2020 at 06:57:14PM +0300, Dmitry Osipenko wrote:
> 31.12.2019 03:17, Mark Brown =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

> > Please think hard before including complete backtraces in upstream
> > reports, they are very large and contain almost no useful information
> > relative to their size so often obscure the relevant content in your
> > message. If part of the backtrace is usefully illustrative then it's
> > usually better to pull out the relevant sections.

> Yeah, perhaps it's not really useful to have backtrace in the commit's
> description for the case of this patch in particular. But in general it
> is very useful to have backtraces somewhere near the patch such that
> online search engines, like google, could pick it up. I'll move the
> backtrace below --- in v2, thanks.

Right, this is more directed at just pasting in the entire
backtrace (which can be huge with lots of generic bits before the
small number that are relevant) but some edited highlights can
definitely be helpful for search engines and for explaining the
problem.  I'll modify what I'm saying there to clarify this.

--V4b9U9vrdWczvw78
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4OkLwACgkQJNaLcl1U
h9BL0gf/bBWZbW0DvZqYZ84Y2N8XEhFRF5QQ+NS5MBAvcrqzNDvh/KAHA0Vzm9Xq
NBM3uErwYTIgr+uRQSMbu6MQ+YeG5nptjZoPv3c0rWN5jT5ZXjmxIfFlE9EFuAn0
tq3Jhi1U8fGT8oopIMLKQPWvF3FGE242LyYR1C1PLprQk9VMxf6iP0OBRfhG/thu
MzDgxHjbqlsDY6eWnAt2ViTL8MG+1TobCEGkifo6j2kLk8ARy0C1ThkdVGDIc970
xvKX7QouOf94TT3C+2kfdV6TyCEG7BtYfjkirDuMRgOddz0QhAuXC3yi4f7lympq
k7w6IV//x/B7qbVREWl06hP7/HpKBg==
=1GRG
-----END PGP SIGNATURE-----

--V4b9U9vrdWczvw78--
