Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1041C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 10:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89C1921881
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 10:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568717430;
	bh=CMv27HSqoNlAVEfJg7x7juVBvO72wMCFsjn1ssmBpBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XtqSObVXXsinfeTmPGaPcW4x/vC7Ue6b27qxg2GI/wZcAbrwR1O48pK2v60Trw5I5
	 zw9rDxFaRi+dinliRegkk/yH31ME6NVOZXNksVxZ8kwB4XIYGnO5WDE1A2w7EwY61w
	 XicoWCgeptaM0X59Dpj+kbcYF4N9yXtYg8pYpT7w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfIQKu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 06:50:29 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39472 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbfIQKu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 06:50:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7ysJyJKJEUr4khG20YZEwGPv0cFPLtQKqiinCxXuok0=; b=d3ghXNPhfvvMkLgEW7LycS0Ug
        ymSwgqY8bAJNrorMgwhnxFj9Rohc8yczZHJMmSo5h0BwDLXQUMS2u0vH3+QMRCG7wrkIKww6LF+/k
        ZrAVCENWlfhmlXwchnRGwmgYebaN2RMhblMPHqtVI1WsF/7uoBD2tA4lPdn9iZR+rvCfQ=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iAB3U-0007hu-0J; Tue, 17 Sep 2019 10:49:56 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 3B2E327419E9; Tue, 17 Sep 2019 11:49:55 +0100 (BST)
Date:   Tue, 17 Sep 2019 11:49:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "shifu0704@thundersoft.com" <shifu0704@thundersoft.com>
Cc:     lgirdwood <lgirdwood@gmail.com>, perex <perex@perex.cz>,
        tiwai <tiwai@suse.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        alsa-devel <alsa-devel@alsa-project.org>,
        robh+dt <robh+dt@kernel.org>, Dan?Murphy <dmurphy@ti.com>,
        "Navada Kanyana, Mukund" <navada@ti.com>
Subject: Re: [PATCH v5] tas2770: add tas2770 smart PA kernel driver
Message-ID: <20190917104955.GB3524@sirena.co.uk>
References: <1568705889-6224-1-git-send-email-shifu0704@thundersoft.com>
 <1568705889-6224-2-git-send-email-shifu0704@thundersoft.com>
 <201909171540576235182@thundersoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FkmkrVfFsRoUs1wW"
Content-Disposition: inline
In-Reply-To: <201909171540576235182@thundersoft.com>
X-Cookie: Know Thy User.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FkmkrVfFsRoUs1wW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 17, 2019 at 03:40:59PM +0800, shifu0704@thundersoft.com wrote:

> > +reload:
> > + /* hardware reset and reload */
> > + tas2770_load_config(tas2770);

> Sometimes devices need to be reset to return to normal, and this setting is necessary.

But why do we have systems where the device is being reset?  Like I keep
saying I'd just get a normal driver merged first, then go back and
figure out what's going on with the reset support so it can be reviewed
separately.

> > +end:
> > + return IRQ_HANDLED;
> > +}

> I see that the other drivers, the return values in irq_handler are IRQ_HANDLED.

If they've actually handled an interrupt.  There's some buggy drivers
that do it unconditionally, they aren't a good reason to add more.

--FkmkrVfFsRoUs1wW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2AulIACgkQJNaLcl1U
h9CivAf/TXpClZFNRdOGm/qTXoebLIrHtsAWHL6Bdl4IOjCwRg4e7053muNi9edC
DdQ7xdI1C1uu/G6JoAZ33gCe78eDbqxL/QYXOJS0w75Zyp1/YeTsnbTR8d24P29x
z6Z/Q2f3W62Uc5n/aVp0KLvYI+OklBLH2A7YGOztNLm5FyXLXvKyekr1rwRErYpO
O/0505YBiy1reQSUNpDFpwVDPFwpPT7WSdk6hSi0euR8tUoefU3lV6B5iT1iJktE
nRsUu1j2a7i/8iev1295vbiaFQQ18vCGK7CPzX8uTWhrymZrl20urSyL4Kd+WQLy
BG7HzdYIKjS3LYutXM8425ufkcnzXQ==
=vT2v
-----END PGP SIGNATURE-----

--FkmkrVfFsRoUs1wW--
