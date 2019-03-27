Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2783FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 10:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFA3520700
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 10:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733134AbfC0KQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 06:16:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:35310 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725827AbfC0KQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 06:16:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 63D00AD2F;
        Wed, 27 Mar 2019 10:16:15 +0000 (UTC)
Message-ID: <3ea28268d51c6d9befecf273e1295ba11f8d3b06.camel@suse.de>
Subject: Re: [PATCH v3] HID: core: move Usage Page concatenation to Main item
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Oliver Neukum <oneukum@suse.com>, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Terry.Junge@plantronics.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 27 Mar 2019 11:16:13 +0100
In-Reply-To: <1553679302.14990.0.camel@suse.com>
References: <20190326200331.25934-1-nsaenzjulienne@suse.de>
         <1553679302.14990.0.camel@suse.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-mUp3K+XZ82nz6aO0pkje"
User-Agent: Evolution 3.30.5 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-mUp3K+XZ82nz6aO0pkje
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Oliver, thanks for the review!

On Wed, 2019-03-27 at 10:35 +0100, Oliver Neukum wrote:
> On Di, 2019-03-26 at 21:03 +0100, Nicolas Saenz Julienne wrote:
> > --- a/drivers/hid/hid-core.c
> > +++ b/drivers/hid/hid-core.c
> > @@ -218,13 +218,14 @@ static unsigned hid_lookup_collection(struct
> > hid_parser *parser, unsigned type)
> >   * Add a usage to the temporary parser table.
> >   */
> > =20
> > -static int hid_add_usage(struct hid_parser *parser, unsigned usage)
> > +static int hid_add_usage(struct hid_parser *parser, unsigned usage, __=
u8
> > size)
>=20
> No need to use the __u8 style inside the kernel. u8 will do.

Noted, fixed for v4.

>=20
> 	Regards
> 		Oliver
>=20


--=-mUp3K+XZ82nz6aO0pkje
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAlybTW0ACgkQlfZmHno8
x/7DXggAqpMi5OD/MzO3QKe+MsiQAQJlI70NyUiUtDaJOkB1zVUM1dub8hvpeH9c
2gBJCMcUOqBuCpQ6OVfB2Gtp8l+J4/6Ng19veubKHm1LFTA3XYbf+8l/iQ8IMuzO
ft/OTsHv6b/r6HkuLj0682lROuBmeJCerADbw63a2t84vHHbBCU6iaRzOuizFOTK
Nis3n+Hipw7JSnwyNt6XvBoHIbhAVXr/IzsRVntV0nM13YxlQBDOywyt0q0bSMZV
XGR4NWebReYaTurH3G1n97aOM3NTVwsaiwt26epb1Nzs5VVmAeUUGBtk97lRMogb
x8P9D2Lc4j6yyUHgtoQNvsnnMoZu/A==
=ULv/
-----END PGP SIGNATURE-----

--=-mUp3K+XZ82nz6aO0pkje--

