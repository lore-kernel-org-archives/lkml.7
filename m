Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C16C31E48
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EC1720896
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437035AbfFLMEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 08:04:42 -0400
Received: from sauhun.de ([88.99.104.3]:59096 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405097AbfFLMEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 08:04:41 -0400
Received: from localhost (p5486CACA.dip0.t-ipconnect.de [84.134.202.202])
        by pokefinder.org (Postfix) with ESMTPSA id E9AA82C54BC;
        Wed, 12 Jun 2019 14:04:39 +0200 (CEST)
Date:   Wed, 12 Jun 2019 14:04:39 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Mauro Carvalho Chehab <mchehab@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ruslan Babayev <ruslan@babayev.com>,
        Andrew de Quincey <adq_dvb@lidskialf.net>
Subject: Re: linux-next: build warning after merge of the i2c tree
Message-ID: <20190612120439.GB2805@kunai>
References: <20190611102528.44ad5783@canb.auug.org.au>
 <20190612081929.GA1687@kunai>
 <20190612080226.45d2115a@coco.lan>
 <20190612110904.qhuoxyljgoo76yjj@ninjato>
 <20190612084824.16671efa@coco.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/WwmFnJnmDyWGHa4"
Content-Disposition: inline
In-Reply-To: <20190612084824.16671efa@coco.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/WwmFnJnmDyWGHa4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > OK, so that means I should send my pull request after yours in the next
> > merge window? To avoid the build breakage?
>=20
> Either that or you can apply my patch on your tree before the
> patch that caused the breakage.=20
>=20
> Just let me know what works best for you.

Hmm, the offending patch is already in -next and I don't rebase my tree.
So, I guess it's the merge window dependency then.


--/WwmFnJnmDyWGHa4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl0A6lcACgkQFA3kzBSg
KbZjSg//Z00AABwaP2AKy0R5ADbslsPS/4ByNTm3ijHSx+dcZ29rhM4HOUfMXDDZ
ksZ+1bvr+pGCR3qKFXv6kCuqWdAKnneKfYNSrib5esjWm++vyLW7lNXwQR7eOYsV
pA1gS/XIG+EHLCvQFupOALutcMHRwKetxSj+y9SBeKVxmOVvvnsvT15wYWouPv/9
5p/BooqZV9o5bNh0AUFwcvGv7kZA4ZDVOwIpiIndpJ/VnFmQQ6mCxuX+j2cal5Wg
q7e6De2CDL+pUfIdcqb67SdE0gJEMHKbMAHw+Ll9cC6A4dytOd4C4Nppo1pAGp+/
AbfASwT7YFfSMPSerXQAGdiSZfVxUKOJ7epaQGQRK5kL99XS3Ccuu8KOheiAG0Vv
bKNpOauz1PNsmQeOBo3KHIfwdGx9H9I440IplefSJdygdMKGvYD2jY80cfU5iR1s
n+c3kiydkIIFSoum+hAH0ObE39sX2WTneOg4OLPa4IokkzbIy1SVwYeqZw7qe/C5
0VpaCD/T4rzTGoGFT0VELYnikOBOD2xH3eaxmu16plpqsoDRr2y7BuwwG3xAOMbF
Nq13QVqR5kU233pVc9FIUbEx4c2LqsQ3F5kvxeMANR8MOIvAw+Rr+WdwsssfpSbu
l7C+JWXxPACxQhu4Joz8XhF/q0JzNMat3F982qQ/0PK//cwIrhM=
=82Kc
-----END PGP SIGNATURE-----

--/WwmFnJnmDyWGHa4--
