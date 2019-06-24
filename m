Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB68DC48BD3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 22:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9D9220663
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 22:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="rGR20+Go"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbfFXWIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 18:08:12 -0400
Received: from ozlabs.org ([203.11.71.1]:47833 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbfFXWIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 18:08:12 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45Xk203WCzz9s4Y;
        Tue, 25 Jun 2019 08:08:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561414089;
        bh=fTgDXJ1bVWmrdYcKduTJMKlqock7C6EN7aDxhgdiJtM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rGR20+GokEJgEMz37nIknsr3e37vbBkml8Bi1WSV5/j1924gawO+jQ+amlBWmidUG
         vvapVlK2ypwJWWCO+Xp4aXL58k14XLUimB+5/2nnrpUNaqOv7f8+mTNHKZuKyXc+LV
         WzU1+RFZOEAr4V+z7MG81Fy2wKIcJcfQwU1GWDVbqJHf7iRNUv1KhYQ6x68YNNP9to
         lXJGcv7H9E6r+zHTM3cP9YlW7DhzkycCyXaxYvDHnv4odJgx8VVjHx+w2Kr0ywn4Wv
         VpEeX640Uufkla/A9QQD6vEyskigEU59Q9OIuUYpbyqKCYZ5AeXmdwp83s4Wiv30fx
         bOhq87BsDNhRQ==
Date:   Tue, 25 Jun 2019 08:08:06 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Cornelia Huck <cohuck@redhat.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Aaron Lewis <aaronlewis@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Huth <thuth@redhat.com>,
        Janosch Frank <frankja@linux.ibm.com>
Subject: Re: linux-next: manual merge of the kvms390 tree with Linus' tree
Message-ID: <20190625080806.11e99e71@canb.auug.org.au>
In-Reply-To: <bf7a7b6d-649d-66d1-f9b7-6c0cf279b043@de.ibm.com>
References: <20190621154315.0a4d5f54@canb.auug.org.au>
        <bf7a7b6d-649d-66d1-f9b7-6c0cf279b043@de.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/y4N59u/QqNSLzmSjUaS3NVg"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/y4N59u/QqNSLzmSjUaS3NVg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Christian,

On Mon, 24 Jun 2019 19:52:09 +0200 Christian Borntraeger <borntraeger@de.ib=
m.com> wrote:
>
> can you replace Conny with
>=20
> Janosch Frank <frankja@linux.ibm.com>
> as contact fot kvms390-next?

Done.
--=20
Cheers,
Stephen Rothwell

--Sig_/y4N59u/QqNSLzmSjUaS3NVg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0RScYACgkQAVBC80lX
0Gz08wf8Cd/3Bd9YLGQTUGsGC3PJIsLaA7t0x8MeYDyyzYzJYr8spoqqUIqiNjow
L6UJHzVLyRVOlZcoSoacLkhhoxDr7WPWJjmFEDXvEQkG5HEJSNT6mrlsKmyp5CzJ
JMZTsck76t9o2WK1bUo+g5KWsvHUNCNZdZBAA33eENRMtZP6RZxzr2uod0o5A0UN
AtU4yMJhRrAvXejQxj3d1aFIc7Mbr8w6RO8AlqR+Eh8Q067UzyDXmu2I284Qs0TP
XYbs1tH2K6kml8bis/9OHrx8CuiiqO+l1pvPfynMygJ+1+KS7bk9NOrMjYJu3zrv
5mJlUmnVNFjnuA3Zih8Oloj6KFBTWQ==
=xjGW
-----END PGP SIGNATURE-----

--Sig_/y4N59u/QqNSLzmSjUaS3NVg--
