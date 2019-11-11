Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCBDC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 19:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5361221655
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 19:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573501812;
	bh=dtnQhrLcA6Dn/As/OrO/10b7sB82SnSNakaXENAloVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=U6qL003v7Trq/Qo/F5C/+kzphOKFbQwsI0rvCtIni/F5Ze0uIJ0gTVW6E9aTSgncv
	 U47H0dr/FB49cK2EgeQFGvsaakVRbQD7rUR4pc/8Mdz/t94wYd3fBZpsOMn/z5aJdP
	 wkDoerCpP6hZeWcG1lgkfRcusZHygtnEDGEb1dLo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbfKKTuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 14:50:11 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52142 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbfKKTuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 14:50:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dtnQhrLcA6Dn/As/OrO/10b7sB82SnSNakaXENAloVA=; b=SyjN+ChHN2juaWY5YQMiuX1aY
        CeTEXEVFxbd3BfGyS2eX3JJHU9fiJeljPYjWVUQJBKVgzRaKSboR06/IsP1GqMOQe31TD/owVChN6
        ESS8tp6sqJOuMosq+s5h3Dk/bEbtYxZzvT27Jgj1OcCFU5cWnEfresi1FQaZDEkVg6whg=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iUFgs-0005OG-J2; Mon, 11 Nov 2019 19:49:34 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id D949927429EB; Mon, 11 Nov 2019 19:49:33 +0000 (GMT)
Date:   Mon, 11 Nov 2019 19:49:33 +0000
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
Message-ID: <20191111194933.GF4264@sirena.co.uk>
References: <20191111185957.217244-1-jacobraz@google.com>
 <20191111194427.GA29859@sirena.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UBnjLfzoMQYIXCvq"
Content-Disposition: inline
In-Reply-To: <20191111194427.GA29859@sirena.co.uk>
X-Cookie: A lie in time saves nine.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UBnjLfzoMQYIXCvq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 11, 2019 at 07:44:27PM +0000, Mark Brown wrote:
> On Mon, Nov 11, 2019 at 11:59:57AM -0700, Jacob Rasmussen wrote:
> > The headphone jack on buddy was broken with the following commit:
> > commit 6b5da66322c5 ("ASoC: rt5645: read jd1_1 status for jd
> > detection").

> This commit has been in mainline for a while but this doesn't apply
> against my fixes branch, I'll apply against -next but it'll need some
> work backporting to make it back as a fix.

Sorry, the issue with applying wasn't due to conflicts - I've applied as
a fix now.

--UBnjLfzoMQYIXCvq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3Ju0wACgkQJNaLcl1U
h9DX3gf/YtrShJZsOudaKwwQ17lvSz66qAmyxXjzitTuvQlr3QLrHHScvgxbiYjt
ho0/Rdk87BVNkBKuBxeLGTmZAQquQbGx6hg+TqnnCbLGp102236hpCifnPgTb6/9
RQP+qeg7Q6/R1uvMBcjm0Ad7P0/CtloH7sfgkXgCZEH+Awb8woNiwJKcqyxG20wy
+bZlT1VTFSnLlN2reOnU1ksrc/DU2b5JKtFY8/yod4gz8CRhYYWEg52ogltOGlX3
sLbpmqiEIo0W6UErhdpkAlH34otteeKR/V0ogDnPJeN7GMGDSHPk1vpI8SWuEnzE
f8RVcTvbcGqBgR/q89Wn5/MeiRxCMQ==
=WROu
-----END PGP SIGNATURE-----

--UBnjLfzoMQYIXCvq--
