Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7053C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 16:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6D6A2082C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 16:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440431AbfFLQx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 12:53:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:47296 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2440346AbfFLQxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 12:53:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 31395AE21;
        Wed, 12 Jun 2019 16:53:23 +0000 (UTC)
Message-ID: <a25623922a0b689af8661aa2dbabebdac2c73f3b.camel@suse.de>
Subject: Re: [PATCH v2 1/2] net: ethernet: wiznet: w5X00 add device tree
 support
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     David Miller <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Date:   Wed, 12 Jun 2019 18:53:21 +0200
In-Reply-To: <20190612.095240.868638680123053774.davem@davemloft.net>
References: <20190612122526.14332-1-nsaenzjulienne@suse.de>
         <20190612.095240.868638680123053774.davem@davemloft.net>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-aLpswiBhDbtUeFrpg5XX"
User-Agent: Evolution 3.32.2 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-aLpswiBhDbtUeFrpg5XX
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-06-12 at 09:52 -0700, David Miller wrote:
> From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Date: Wed, 12 Jun 2019 14:25:25 +0200
>=20
> > The w5X00 chip provides an SPI to Ethernet inteface. This patch allows
> > platform devices to be defined through the device tree.
> >=20
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>=20
> Applied to net-next.

Thanks!


--=-aLpswiBhDbtUeFrpg5XX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl0BLgEACgkQlfZmHno8
x/7OuggAq1op+VuvGz5gYY0o+Cqn1mA4pRci1lFmBVud2PezlsU4zvXfjHlfKY8x
xp657FbR9B4gqIaX7RSUx40UWyc8XeL8UbzTw3u97Tk7ZHftrqg1ZK143iSPhld9
T8Osuat5Pl0GtocERj1l5vsEu3HJ8gS9de2hunreJHNrE6rhyP9T+1kAVQMYr1qg
vDxIu/b1ebRyu+K0MsbwmdVQuheDlsQGXMi+KaWds7054cGvP31NuJu9nag6qRSo
eyM/0ByrlgwR3Vg3/Gx+JSdzaweTjtvnH/7Jipj6xOBNFA6CMboiMKdeZ+j3AJcm
OuYHrmjEjm7Fc7d/A66jQ4+mjhH86Q==
=wHL7
-----END PGP SIGNATURE-----

--=-aLpswiBhDbtUeFrpg5XX--

