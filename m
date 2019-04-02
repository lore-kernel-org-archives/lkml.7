Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF119C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A164F2082C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="RXuO6aqo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730323AbfDBTNZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 15:13:25 -0400
Received: from mout.gmx.net ([212.227.17.21]:34869 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbfDBTNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 15:13:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1554232399;
        bh=qWoR88u3UXyVY3Dan0Jg67N4efQgr/usDeKN+ubd73A=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=RXuO6aqobTDN62iT1ajDdjEBDXymsEm+Rv08q33xm82vuGt45QFCS/FhJwV+N1QDe
         PocrjwxDA/KMcFh/N094PetSUI69lU3G6zMwe2utj4ZklYP1IoFzbwYoCwmCVkE5vE
         0hBiLuxHlIzB3+70187aFEnOMHUb5OYQ1k8/8pGo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LmNHK-1gbW850KoM-00Zu3J; Tue, 02
 Apr 2019 21:13:19 +0200
Date:   Tue, 2 Apr 2019 21:13:17 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-doc@vger.kernel.org, Martin Kepplinger <martink@posteo.de>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: kernel-docs: Move vfs.txt under "Docs at
 the Linux Kernel tree"
Message-ID: <20190402191317.GG2095@latitude>
References: <20190331221439.22892-1-j.neuschaefer@gmx.net>
 <20190402094358.38c15809@lwn.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FoLtEtfbNGMjfgrs"
Content-Disposition: inline
In-Reply-To: <20190402094358.38c15809@lwn.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:75a/cp3rvVbazYZqV14AZHIHlRl+FRB0qBGUQyXyC7aPqcRrY6s
 QmgyFtkCwZn7LjyrG5Da0LX+Q0C75/kKOcx++/DuaOLk5Lsn6wmFIDwLpt3sUkVQGb7d5Wj
 Yb1bqhlV2I/zB6LSkvyeOsWNK9kkk3Co8aAiu/jJYqsW8DKt2F2t30J1NzFUL4Camo6nwnC
 BZHLC/zwvc6oV4hgtAZWQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hnw4kuHEjb0=:q5WL0JeI2YFpcAoGzJRZhZ
 Pfcf+SV3D17w0XIOAHBGEC0r3MRAdpbOaSxi0i2VBluccLOIxX6d+beddlZyEqx4CDo0b/fp4
 GhrwxucLaGvfDjgK62S1XLW6YrE/PBcWYrQp4NzLsc3kNDJmIObis/Wi5wZic/xeIjLtvfu91
 20r4Hme6zaPZkd/ICGzJrTxkDZPAAyZro9JFVe3fYLZljklM+O27WHaqG/v+1Bwhvq9LFN/dn
 5hqI/Goj9e0j5dDURDPEixHKU9Kb+x0piCBpbk2vShgmmZXqtgW4LMPopF+SJiCF5IzZkBJai
 6iSrQV6MFUvswGJHD3p0L8DAWeSj+ePk9fNI5gt3BEJDQTxI5DIQ8aBwmuZqgFrBollFIiQx0
 QKVhn7apmrJedO7IS7W+vZuera/XE5TG6/HGTt7j7RSfL/+QjQGGlytypt3VC++6QTB6v+hjw
 H6q8gUeFfaLopjR8WzQLwZFAPB+NR4uLRsclEbKDDdjckqw5SoOF1nKBfwOLl4fx38z7SuuF7
 az+wMemOOMsMhEOo3VLs1m2h4nUZE+isb+a8kPxFtxlQjMrBHopu9eYUvxHqrl4r9AdorF7kq
 rvKIWzQrSw5wE0jA67XK3PIKYy/buFZhSj8Y7C91y9dzn00em/qzPr5naaP2Kj4uLOJkOFYEw
 F0WjYHKb9q93ckax3Xp7Buqv9bNSp91L3tCPfzPTtebIpqZp+hhr5AvI5MuXWopcFPIK33bzU
 oxdsV6VzCQnPIWXzzI4DqgkfoYts54yotX+vZNScfr46W0tbL8r9jf5zbCKILSEPpCYGbDrOS
 e6Qhsx2Ww0bhgMnZup/et6um7NknCtC8VWIF4nT/0nhmiDQgZLMih+fv2Rt6KxgcmvdxqTtF7
 7XrBFiUainAjgrSXz91aHz63p2o8DDh9g1BAABnABu4auOJ9y8tlzsDYj1rJX2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FoLtEtfbNGMjfgrs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 02, 2019 at 09:43:58AM -0600, Jonathan Corbet wrote:
> On Mon,  1 Apr 2019 00:14:37 +0200
> Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net> wrote:
>=20
> > It's unnecessary to point to an external mirror of the Documentation
> > directory. Also, drop the date field, because in-kernel documentation is
> > continually updated.
>=20
> So I had to ponder on this one a bit...saying "continually updated" is
> pretty amusing for a document that leads off with:
>=20
> 		  Last updated on June 24, 2007.

Ok, I should have been more explicit with what I meant and written "(in
principle) continually update"; compared to journal articles or sections
of a specific edition of a book, that's what files in Git are.

However, looking at the Git history for vfs.txt, it has indeed been
updated multiple times per year, and not just with typo fixes, so I
think this line should simply be removed to avoid further confusion.

>=20
> > Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> > ---
> >=20
> > Alternatively, we might drop this entry of the list entirely, because
> > Documentation/ is already covered.
>=20
> In the end, I think this alternative option is the better one.  We don't
> want to turn kernel-docs.rst into yet another out-of-date index for the
> rest of Documentation/, and the removal of the external URL takes away the
> only bit of additional information that this entry offers.

Good points, I'll do that for v2.


Jonathan Neusch=C3=A4fer

--FoLtEtfbNGMjfgrs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAlyjtEUACgkQCDBEmo7z
X9tuDxAAhI7/Ps7vFq8GC175FVfxPhfZxKqwVIIz3QGw1eGhSrA1EdDS1W/SWElf
WzM6T71NkvscGCAOyvvwW4hj+bGlvwpUt84wWyjl8MNFqZq+v/4wKwATMvk3O+mA
KRpLnCy2E67hNsLMZKFIdrYnboUxkA/w/oWrKpx6fNPZrAEK0mvL2Ttl5fa6Tled
qgjmGFS41e1KUOViXMdiW37+FGZ8w+ugIj6rcD1vkRnhkrF7Lcbijbv2rODhpm8A
XT29Kz3Pb4r+7hpFem+J1tmICERgECcz7GKyYuq0m5SoqZthAcBzwlNJAOGzW/iH
qqyYVL1NQvkyUecgJt/XVKu5zDAxEF691tF/oVlKAiCIFMmy4F5WuBr4fczkmR1D
iBwNM9onP2M7lzaRFCwV+5jOMn01HDaalUstG96t8v0wfqrDzcdA+h8cQiiJMCIx
j7OUpGxnBb+01ZH5HTImrHt/YqtQlLB7VkNT3gWx4cr3kjvi7L8ZHzKuA7JlzNGb
XdpxForWCTFty9bUkSWiJYSXCISFB0SGeZAN0MV7jVd0oN7CkFG8ZOX1lfmGP/5X
Ln13VCw42IEgISfwUChnPKiv3PTzPH1lE2CKAsOfbOdRYsl5+7dAOq0+mFBJxM8A
7qb3aAT+W28DTMBqvzPts3oe7XLHTKtpxnmRHpknOkuzPUnPGv0=
=TAgE
-----END PGP SIGNATURE-----

--FoLtEtfbNGMjfgrs--
