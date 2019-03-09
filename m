Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA777C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 10:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AFD920851
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 10:50:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfCIKuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 05:50:24 -0500
Received: from sauhun.de ([88.99.104.3]:40432 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbfCIKuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 05:50:23 -0500
Received: from localhost (p5486CD1C.dip0.t-ipconnect.de [84.134.205.28])
        by pokefinder.org (Postfix) with ESMTPSA id A81FF2E3551;
        Sat,  9 Mar 2019 11:50:21 +0100 (CET)
Date:   Sat, 9 Mar 2019 11:50:21 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Bich HEMON <bich.hemon@st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Pierre Yves MORDRET <pierre-yves.mordret@st.com>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i2c: i2c-stm32f7: Fix SDADEL minimum formula
Message-ID: <20190309105021.GI1340@kunai>
References: <1551885125-22295-1-git-send-email-bich.hemon@st.com>
 <20190309101340.GH1340@kunai>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IbA9xpzOQlG26JSn"
Content-Disposition: inline
In-Reply-To: <20190309101340.GH1340@kunai>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IbA9xpzOQlG26JSn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 09, 2019 at 11:13:40AM +0100, Wolfram Sang wrote:
> On Wed, Mar 06, 2019 at 03:12:16PM +0000, Bich HEMON wrote:
> > From: Nicolas Le Bayon <nicolas.le.bayon@st.com>
> >=20
> > It conforms with Reference Manual I2C timing section.
> >=20
> > Signed-off-by: Nicolas Le Bayon <nicolas.le.bayon@st.com>
> > Signed-off-by: Bich Hemon <bich.hemon@st.com>
>=20
> Applied to for-current, thanks!

Do you have a Fixes tag for this?


--IbA9xpzOQlG26JSn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyDmmkACgkQFA3kzBSg
KbZ14A/8DS8m/KjL3vcELMb1q2uDQBQb88nif3mIzMCfNWVu6U5lvTnazqIDISIU
jLlmGHuKPvPChJK6+w+gzPn95RZjbFIgsuXItM9d0KZKrNTb2tW3Nl47mzTpTzj8
+ECctJh7WiQw6Ys79Q9PPXKrtw2PEeuxdrA+T7PvBG8qIUF/02gkHafoLzK8gXH6
u+iIQCY7Wef6nX7ff/1NMIIrm+pcHFbMaBtMEOxdv/lJuFsNRvg9GauWIgFRDebV
YP+EZRfBRt/1KifnrR2Zxpmzz95vKZsoaFkawuuHwR8SCPjJkglsPrc+F6PoqLaY
nwWMc664qBo3dsg1OyKrkbjk4WRrqtJ9LCnLO4lwfNYnovQh0FyOO8MdLOu2ODSL
7bzCYs42QdlUyMRlU7sOGuSA74sYFW2n7gM1sL2LjvlQm/1S0WLnkk4pMIVTlgzd
dq9cv4DkqXoiLe1Avza3GY+4zng/MEm69fSCkUmFJCn97J/0+P62FYPM067RCOaM
/Avz+RTjGujvsGFTgzL9aB7UWdNmM4huUFb9amFhyr6cv0fzNj4kkp3C44sfOCuV
X65Jv+intqvAj/XRJDosdB3lw+5aetMvSCv9bBGpzHDq7Y9SxqG3CfMXRAtGXS7E
VkDP3KJ4QpKV5PuertmA9qNm3HJ5jrOTPeEa5rq3UWQ7/ADBXvc=
=5Ir8
-----END PGP SIGNATURE-----

--IbA9xpzOQlG26JSn--
