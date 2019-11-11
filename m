Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD4CC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 19:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0248920659
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 19:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573501519;
	bh=w2Rvj75LepKCR7yvJRU6eUm9bZCoooUrRGcsFZAdp44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=j4yCQvhe1ssASltGc+FE2O8QE5PsPJmiobZUzJaidrIiBPvmqLtl73ocY3SF0rGY5
	 jhnFhWU+ER3i6Dr6+m+/SQ3K80h4PoEpxL9oOWx3Cj1kKjMr1tKBydGeNvcuJuFLbp
	 hctPU4UUda08fVtziazAVwVawCBIFRBbhuxbOK98=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbfKKTpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 14:45:18 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43904 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbfKKTpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 14:45:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=w2Rvj75LepKCR7yvJRU6eUm9bZCoooUrRGcsFZAdp44=; b=r1eXBIHXW8wElBLNHdZkZCM3A
        AzP12bMWZmuFGCNc3Bi6CGesg8gdD53umqic2PQVCUR3UIugiWiPa7ujoBTx3ybggJVIXeVYPR3jf
        ZQXUwKDwu4PuUGdIZ6r3b9Kw/tEzDSaALuVUptZa1o6C4+Ev9GTjtCzihZ9TGxEc7pfpg=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iUFbw-0005Mj-Rw; Mon, 11 Nov 2019 19:44:28 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 1777D27429EB; Mon, 11 Nov 2019 19:44:28 +0000 (GMT)
Date:   Mon, 11 Nov 2019 19:44:28 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jacob Rasmussen <jacobraz@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Jacob Rasmussen <jacobraz@google.com>,
        Bard Liao <bardliao@realtek.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        Ross Zwisler <zwisler@google.com>
Subject: Re: [PATCH] ASoC: rt5645: Fixed buddy jack support.
Message-ID: <20191111194427.GA29859@sirena.co.uk>
References: <20191111185957.217244-1-jacobraz@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
In-Reply-To: <20191111185957.217244-1-jacobraz@google.com>
X-Cookie: Do not flush.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 11, 2019 at 11:59:57AM -0700, Jacob Rasmussen wrote:
> The headphone jack on buddy was broken with the following commit:
> commit 6b5da66322c5 ("ASoC: rt5645: read jd1_1 status for jd
> detection").

This commit has been in mainline for a while but this doesn't apply
against my fixes branch, I'll apply against -next but it'll need some
work backporting to make it back as a fix.

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3JuhsACgkQJNaLcl1U
h9BNCwf/b+3c+eWRNxNuFVB11hWjuEPm4L52Y+EEJtvjLT46mZx+Z8jfIMRSG42T
C6geE4W1VszoICq/jDP7ayx/PrzKtrLMw+7O2lIrHCELt3ZZvBs5JuVg4LUHrgmc
mHiUESFuh37PreCB/b9Hb3YDpDr0Azw1RlMBPXTInl40CAwZUzKxFbMNb4fcuW1n
cPgu+tH9CCzJPeFuB8xNZhtGIRlSeoXEwsM0VyNvrAhrVQSufPvhB0RTVUT+0/pb
rYnW/4r0rT5qZPS018onIyqU7xuSxXnXrZaBfbsGv1rgXz68KZfnPzx/TMTHWxrp
mKfqF7ylJs7SxL+RyWywD+q1i27aMw==
=ue85
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
