Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC89C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 18:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D6CE21670
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 18:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbfIQSO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 14:14:26 -0400
Received: from sauhun.de ([88.99.104.3]:55588 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726604AbfIQSOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 14:14:25 -0400
Received: from localhost (p54B331E4.dip0.t-ipconnect.de [84.179.49.228])
        by pokefinder.org (Postfix) with ESMTPSA id 9D6F52C0489;
        Tue, 17 Sep 2019 20:14:23 +0200 (CEST)
Date:   Tue, 17 Sep 2019 20:14:23 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Saiyam Doshi <saiyamdoshi.in@gmail.com>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 0/3] Fix issues reported by Coccinelle
Message-ID: <20190917181423.GB28182@ninjato>
References: <20190917172758.GA11926@SD>
 <76e99512-8818-cec2-9e77-799e4c8481ab@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tsOsTdHNUZQcU9Ye"
Content-Disposition: inline
In-Reply-To: <76e99512-8818-cec2-9e77-799e4c8481ab@web.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tsOsTdHNUZQcU9Ye
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 17, 2019 at 08:10:45PM +0200, Markus Elfring wrote:
> > Using cocciecheck to ensure there are no semantic issues in
> > i2c-qup driver.
>=20
> * This wording contains a typo.

Doesn't matter to me for a cover letter as long as we can understand it.

> * I would prefer to refer to a desired reduction of a few
>   source code quality concerns.

Not needed. I understand what is going on here.

> > Changes in =E2=80=A6
>=20
> Can such a prefix be omitted?

Why? I think it makes sense?


--tsOsTdHNUZQcU9Ye
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl2BIn4ACgkQFA3kzBSg
KbYSiA/8Ctn+loUGOKb8bL3M+OGopn2EaUhafoln2xcFttrCpjcSHKHLAbgPiDEl
YVWtsZhrp/eJ+ESZidZ8GctwSfW1SajtUagsEFCc/4B8LR0ODYHNE84AAbDmOdAT
SX6s+qjqTyy7UATwt9zk8PcpdvjYf+arPVBI2DZjX5OTBT4kTWTPLEm1Z3abm6xT
rwo10dScXa5TAI2ZGAAzVf2m8qiucTgjkc5MNzGs5xTy5R/PI0icnMidZ0lfok93
kASEUujmjHJsDt9trymNHocGj9wTo23eukZxqrB6aCdG24KLDNuncc+bRW6mFlXp
927BffKNDz1/EgcwnxxtzWeA3T5JQ4i21ylXHQIRrollLU2fGOO7RapNOoWu/bir
yQlpx4gmbpcFA2bnzw8v/ramycR4NmGw9kwYOQxKG/3o9T4HbEZHCgnqy3ZVZpvo
AHaPzNXjW2Y0jAS2UxLCMdmLQyjgNaEoZbX+2f5lbDieDooYCmSqo8BNrh3VJmEE
sr2WDV8n5rc5l41MkdVKpx/ahXhPEJxZTPKNlEzClPH7humapeviR02SQMuPZ6Vp
9bfLJUPBiQ5ilS1kc+tuAP3rrMVK+1VbpsNxu2iVhVjbSGqqrHCyP93WYdSVXCG+
5WP44ByXDziBzqPktnANbr9+pCQ6nndWv1pjDlariaxs1JOcaVA=
=ZF09
-----END PGP SIGNATURE-----

--tsOsTdHNUZQcU9Ye--
