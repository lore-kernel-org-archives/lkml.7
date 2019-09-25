Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832E7C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 16:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 557C3207E0
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 16:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569430263;
	bh=IUM4E4Q+AUx1n2rhSv+li7DF2XNjVEyCbAIRN5fYMgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uirSB5PKLbHJEzB0oqPHJqRN1svhjFUmfF3LT24M4/52j+H9yF/h/MVTjMehNNW2R
	 w6lIxGETfBMlwbfB/OA6hxaNKbpJyn8yXcoK0WDgzCWQgBv5X+58f3foNrmvNeDJnn
	 7hRMKGEP71NAm0JrNIulW6Wk5n2JnmIm+fsgGmhc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439867AbfIYQvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 12:51:02 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41962 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731087AbfIYQvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 12:51:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=naZYuWITcaswjPtwwbtHxt7UXmfEBcDn8wWuUVMvZ0E=; b=ZFKIHEtEGwRsj+oveJPSkwZ6E
        Bo0OeIxRfEr4ejlG2bw7+jJBq3M+qUDaRP3zNMX7fVEFkrcH7kxPDk7gEOFCYmW2MgQb5H/Zrypxr
        Y52OmdJA0DZiUNYkF0WxF1TWaWZzxWqbBzxnOPfK75gUgxNQ146HbFwvFRp6vyY4dnacM=;
Received: from [12.157.10.118] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1iDAUj-0007w3-V4; Wed, 25 Sep 2019 16:50:26 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id F0CE4D01BD1; Wed, 25 Sep 2019 17:50:23 +0100 (BST)
Date:   Wed, 25 Sep 2019 09:50:23 -0700
From:   Mark Brown <broonie@kernel.org>
To:     Richtek Jeff Chang <richtek.jeff.chang@gmail.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        matthias.bgg@gmail.com, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [MT6660] Mediatek Smart Amplifier Driver
Message-ID: <20190925165023.GJ2036@sirena.org.uk>
References: <1567494501-3427-1-git-send-email-richtek.jeff.chang@gmail.com>
 <20190903163829.GB7916@sirena.co.uk>
 <1a776762-ee65-7344-4bca-c82e16badffa@gmail.com>
 <20190904115630.GA4348@sirena.co.uk>
 <3a9f66b3-bdb7-9bec-a9c4-ac58d3efa543@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FO0yZLwVDWUwTKck"
Content-Disposition: inline
In-Reply-To: <3a9f66b3-bdb7-9bec-a9c4-ac58d3efa543@gmail.com>
X-Cookie: Be careful!  UGLY strikes 9 out of 10!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FO0yZLwVDWUwTKck
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2019 at 06:04:23PM +0800, Richtek Jeff Chang wrote:
> Mark Brown =E6=96=BC 2019/9/4 =E4=B8=8B=E5=8D=887:56 =E5=AF=AB=E9=81=93:
> > On Wed, Sep 04, 2019 at 03:07:06PM +0800, Richtek Jeff Chang wrote:

> > > > It would be good to implement a regmap rather than open coding
> > > > *everything* - it'd give you things like this without needing to op=
en
> > > > code them.  Providing you don't use the cache code it should cope f=
ine
> > > > with variable register sizes.

> > > Due to our hardware design, it is hard to implement regmap for MT6660.
> > You definitely can't use all the functionality due to the variable
> > register sizes but using reg_write() and reg_read() should get you most
> > of it.

> =C2=A0=C2=A0=C2=A0 How can I fill the val_bits for variable register size?

> =C2=A0=C2=A0=C2=A0 I try to use all 32 bits val_bits, but our chip some r=
egisters are
> overlap...

> =C2=A0=C2=A0=C2=A0 Do you have any suggestion for this issue?=C2=A0 Thank=
 you very much!

If you use reg_read() and reg_write() operations you can hide the
register size within them - the rest of the code thinks the
registers are all the 32 bits but when doing I/O it can use the
appropriate size for a given register.

> > > > > +	for (i =3D 0; i < len; i++) {
> > > > > +		ret =3D mt6660_i2c_update_bits(chip, init_table[i].addr,
> > > > > +				init_table[i].mask, init_table[i].data);
> > > > > +		if (ret < 0)
> > > > > +			return ret;

> > > > Why are we not using the chip defaults here?

> > > Because MT6660 needs this initial setting for working well.
> > What are these settings?  Are you sure they are generic settings and
> > not board specific?

> Yes, they are generic setting. It comes from our hardware designers.

You should probably be using the regmap register patch feature,
it's for things like this where the chip should always be used
with a different set of defaults to the silicon.

> Should I send new patch file to you in this mail loop, or I should send n=
ew
> patch via new Email Loop?

A new one please.

--FO0yZLwVDWUwTKck
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2Lms8ACgkQJNaLcl1U
h9DWyAf9GJg6rx9ZA0HyG5Q6KMBXqXHcD5FiF/ew+TDWG91wurQF0lIa3JOuBM6P
5MIzrRqWv0j0DFyUD+E0TLtruxSh5zWNV8De2kE84wswFX1f6QA7FYOKqs9iTQ/I
RdCU8CfdrVviYD7cphFaaaF2Aq/dlSGA/kRINOiWswGyYaHLB78Z/TYLD9L5tPTk
yo5ju5eLjrAL4PPOso49/VhONhU6BOcIjmOBiix3NkL45BzNS1gPVGsggRcFC3Rc
aaBv1Fd3lPfExjOG9p5H6PGzGLjtPh5DwK7AuXs0RaW8cUWdrIsvRARD6R6+OTCr
5g84bg+BvEfqAeb1XolhPuf7EpZ/Ow==
=C2/G
-----END PGP SIGNATURE-----

--FO0yZLwVDWUwTKck--
