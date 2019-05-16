Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC63C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 392C6206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558005165;
	bh=Z2Z7+MFUvBPBnKh5hkeD2cTajetudgmw37iyLkzYbLw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AJ7zZTxgb1qAYAXOuRtfDZTpW0OoqwlM7AKaOmNzXzH64B/7Wd9yGPk5RxSrNEFMg
	 1zT0IGq8Ng1T2DDu9gsAzxU92MddBxESnYsP8wxc+ZsWlGLY9wINuCvcfHWSFNslOK
	 r6aPulddoB+BOgM1RB0jwjKA3kkZN3pMHOfgjanE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfEPLMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 07:12:44 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33086 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbfEPLMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 07:12:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Z2Z7+MFUvBPBnKh5hkeD2cTajetudgmw37iyLkzYbLw=; b=jv3sGed48h6DuIvtRuzJJnlJB
        KnLKxpPh5Uc/p7dSXShIZizO4MmSQ5Btmpo39FOmGYiyf4A0nTs16I6vzNr3m05bc04XTZQSOWkqc
        qp7N5cOb1rUrwd6deezf6NdJ5TCEpJkRWfKCT6B9uE4gQ2k8Dh44BNu7mdvE09ffEpRyU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hREJM-00066K-Lr; Thu, 16 May 2019 11:12:32 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 21D5A1126D45; Thu, 16 May 2019 12:12:32 +0100 (BST)
Date:   Thu, 16 May 2019 12:12:32 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "S.j. Wang" <shengjiu.wang@nxp.com>
Cc:     "brian.austin@cirrus.com" <brian.austin@cirrus.com>,
        "Paul.Handrigan@cirrus.com" <Paul.Handrigan@cirrus.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] ASoC: cs42xx8: Add reset gpio handling
Message-ID: <20190516111232.GE5598@sirena.org.uk>
References: <VE1PR04MB64790C7A0C1C068503038FDEE30A0@VE1PR04MB6479.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n+lFg1Zro7sl44OB"
Content-Disposition: inline
In-Reply-To: <VE1PR04MB64790C7A0C1C068503038FDEE30A0@VE1PR04MB6479.eurprd04.prod.outlook.com>
X-Cookie: <ahzz_> i figured 17G oughta be enough.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n+lFg1Zro7sl44OB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 16, 2019 at 11:09:27AM +0000, S.j. Wang wrote:

> > You also need a binding document update for this.
> ok, will send v3

Separate patch please, I already applied this and binding docs should be
separate patches anyway.

--n+lFg1Zro7sl44OB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzdRZ8ACgkQJNaLcl1U
h9DryQf/QN1WnlIxisEBv3q8UfSPHhd4YuCYO0Gzp7QK64Ei6KJL1BYr3LpneK9G
yjzhG4Ix4Diugig2rg/i9boPzcT8DskSS0GV28zhE0cvaSbxVRmQd2oQBMgK44AP
MuU7ZFZh6VQtmOYDUf8d9WQj7vcLs2kGwfiU32xA2865EwVarnwY3SRpmW4YYCc4
twMse4gvRuL4k5RoRvuT05whKNVKwigBzOmDXpIHpkHkg+dQA/pA1fUf7T7HM68f
UkBiRis8BbivxIiE6l+c14GaYamniawMmP17C+66uJCxtNfiiJa4nH7SscKOpmwI
6ZnItmz8SMwfphe48YkFJcvciCYghw==
=CqUE
-----END PGP SIGNATURE-----

--n+lFg1Zro7sl44OB--
