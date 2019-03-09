Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27986C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 10:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED8A72081B
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 10:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfCIKNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 05:13:43 -0500
Received: from sauhun.de ([88.99.104.3]:40232 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbfCIKNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 05:13:43 -0500
Received: from localhost (p5486CD1C.dip0.t-ipconnect.de [84.134.205.28])
        by pokefinder.org (Postfix) with ESMTPSA id 4E4592E3551;
        Sat,  9 Mar 2019 11:13:41 +0100 (CET)
Date:   Sat, 9 Mar 2019 11:13:40 +0100
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
Message-ID: <20190309101340.GH1340@kunai>
References: <1551885125-22295-1-git-send-email-bich.hemon@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dDnEQgWzhgf+8aPe"
Content-Disposition: inline
In-Reply-To: <1551885125-22295-1-git-send-email-bich.hemon@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dDnEQgWzhgf+8aPe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 06, 2019 at 03:12:16PM +0000, Bich HEMON wrote:
> From: Nicolas Le Bayon <nicolas.le.bayon@st.com>
>=20
> It conforms with Reference Manual I2C timing section.
>=20
> Signed-off-by: Nicolas Le Bayon <nicolas.le.bayon@st.com>
> Signed-off-by: Bich Hemon <bich.hemon@st.com>

Applied to for-current, thanks!


--dDnEQgWzhgf+8aPe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyDkdEACgkQFA3kzBSg
KbbSphAAskJuy5T8s8xTMRUdsSM01BnbclYC/krVWBZ6DI/8iTD43g3iycVYzrPZ
GsqMQ8p4u+Iaz2od7b3ktJimjjNYamVn0NZjEj4+12WXijm4hg+uG6b/Z/HQsWWX
gXnrBck0Z1CUMvHRbRXl1B58eDu3RY5tmLAUa+FpDtyKopc+yzK5lZuZaL93ZlgE
MR6NWVyBHzx7tShkgNja5riQKaBMX1hNtE3Av1pFSMtYtsIQT+AaQf+QMI5FTtSw
5HTOQw9zg7VGervtttN4N6FxQCLb9xeWVjxuO0oz7ue9nztUG5HqA1FLYTa5pYCJ
Web44xspncMJF+2tmVki57CnICinQqBdtbiH567wHClDuPeW/U7/r9l5q0v7DPEs
xZzneg4LPE9AoLxlkVNY4jYQZQwnJ1Vv5weiOlfEZpZLwDN6ESaNbH/l2QkeryRG
f2eahSSLJW4T6osEoTA0pA4B5ipcL//7MSnZftsNFSfC9bzLWXfUuY5na+/KW3V8
dk62VmP6LBUqysYxjKASvtu3aNV0ibCwKoI/j5iAVOvbXWAKsQ+EenZMmTWmSK68
/lfbLc7X2TZ3gHHVrzvkiYTWV19ZlN+24NgaIFOraAzf3U/aHJi2G4fppBGs3i0O
74gbgKqHMwwxgPfnfSJJcHs31ekm9aiwS/kVdWl8t8amQRD/vOI=
=ihtV
-----END PGP SIGNATURE-----

--dDnEQgWzhgf+8aPe--
