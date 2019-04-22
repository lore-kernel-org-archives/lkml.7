Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA93EC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 14:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD84520656
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 14:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbfDVOFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 10:05:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39762 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbfDVOFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 10:05:44 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4EFA059468;
        Mon, 22 Apr 2019 14:05:44 +0000 (UTC)
Received: from haswell-e.nc.xsintricity.com (ovpn-112-9.rdu2.redhat.com [10.10.112.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E4B665D9C8;
        Mon, 22 Apr 2019 14:05:41 +0000 (UTC)
Message-ID: <32310473e6aef679d00c39028adcfcf4c31f47f7.camel@redhat.com>
Subject: Re: [PATCH v2 64/79] docs: ioctl-number.txt: convert it to ReST
 format
From:   Doug Ledford <dledford@redhat.com>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Date:   Mon, 22 Apr 2019 10:05:39 -0400
In-Reply-To: <16911408d1ac64c0df5ef3ecdae9cf1cc2df58e4.1555938376.git.mchehab+samsung@kernel.org>
References: <cover.1555938375.git.mchehab+samsung@kernel.org>
         <16911408d1ac64c0df5ef3ecdae9cf1cc2df58e4.1555938376.git.mchehab+samsung@kernel.org>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-yR/yBqelNUQfoXBNUBEp"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 22 Apr 2019 14:05:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-yR/yBqelNUQfoXBNUBEp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-04-22 at 10:27 -0300, Mauro Carvalho Chehab wrote:
> +0x1b  all                                                            Inf=
iniBand Subsystem
> +                                                                     <ht=
tp://infiniband.sourceforge.net/>

I did not know this link was in there.  That sourceforge site is 15
years old and totally obsolete/irrelevant at this point.  This patch
doesn't have the purpose of fixing this up, but now that it's pointed
out, we'll make a follow up patch to correct this.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-yR/yBqelNUQfoXBNUBEp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAly9yjMACgkQuCajMw5X
L91FGA/+NGY41lyZo6SF1rcLpmmHRrsycikwey+lW/oicFTSL32BSa+1q9AMkUeL
s+ZDCw+3lWHma5OnEzNcwKEDGiYTMqQqbPE27bNc6vddzZGQmwJnzR/xvmUZKXMM
piOgKNM1l52arbE4lRX9L3FOGrv2Im5MR8qVwzFqdy7WadDhHC3+kOArQXdrvbkj
KGPrEBI22epop7v0XBBSrRnouUdV26QO9FAjSFJwGMvmazP0TI3ASj9DjJGJ/8sS
Kn+mSqtCejeEu5EpDaE9dJ9I0H2HkAEwcv5Py1w4wkoreaO4gVs+1F3yReWSbPjE
Ia53GSCainLylOPRPJUD7TFNNEk+P42olzHRLFyfAqBkDPCrWe8lT1JBAUEZWn9r
tZ4hRzKfcn125ouAi8OLdX8KGzykdSFjX2s57ISwiMQeMECc+/38M4zdrtoH6fEL
0DH+Q7nFIulP36NBhhWNfnrzjttAVAg942kKB6YQMDC5/WWoJxKB0JCEI2Oh/Nm7
7iwE7zczzKrwk0f1R5A4jL0C+vqiN3iAYDY7Pd5lA7SbS/6jl+m2bn4uDERB8Hg7
7/SeY/c/MnG1NybWfiYcnwf0nhZnH9nPPtdw+jRfV7BtZLhFXHeIq1K+/cVxMPlP
+BPDd6RXt01e+GY9yFbiofT0Kl2DcOp+NCyza/5dQ+g6it2dntU=
=olyd
-----END PGP SIGNATURE-----

--=-yR/yBqelNUQfoXBNUBEp--

