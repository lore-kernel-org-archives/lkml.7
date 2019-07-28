Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E86C7618B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 13:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B77DD216B7
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 13:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="i8d3l0/h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbfG1NB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 09:01:56 -0400
Received: from ozlabs.org ([203.11.71.1]:60175 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbfG1NB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 09:01:56 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45xNJ0462kz9sBF;
        Sun, 28 Jul 2019 23:01:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1564318914;
        bh=IZuJJ7fKnyUCxE7A1p610rDrVwilIx54gJHVTLiI3yY=;
        h=Date:From:To:Cc:Subject:From;
        b=i8d3l0/hojRZUuw0qhpE2jUJV435W1zvliBvmAGhicknqZl8Ay95irpr1J015ymn5
         p2OwpvQALOZlng7QUOp4zejr2jMkahlmhQAhVl7exI50mugMgebdLnWW53edDgiuKj
         6NpaA0fZaKmPddaXwlSBug+pjxWhnasOclpeZbojU1pINMruq80q1/714/kItRPS33
         N1mAubvETDxw4ViSraUKnzclKgPu6N8OeBFP39qG/QQ117hqGoHkBcbJZE4y1hy41I
         dTkNi4Ux9/8ViQNGF+tcCSB8uXICDYBDKsGByIae9rhuLHkZYx9cnHV06H8PvpMGjD
         kiZNy+ytza98g==
Date:   Sun, 28 Jul 2019 23:01:47 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Artur Rojek <contact@artur-rojek.eu>
Subject: linux-next: Fixes tag needs some work in the staging.current tree
Message-ID: <20190728230147.1925870f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/6zBZ8DY2qUD61PdaGLKLEHa";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/6zBZ8DY2qUD61PdaGLKLEHa
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  5a304e1a4ea0 ("IIO: Ingenic JZ47xx: Set clock divider on probe")

Fixes tag

  Fixes: 1a78daea107d ("iio: adc: probe should set clock divider")

has these problem(s):

  - Subject does not match target commit subject
    Just use
	git log -1 --format=3D'Fixes: %h ("%s")'

Did you mean

Fixes: 1a78daea107d ("IIO: add Ingenic JZ47xx ADC driver.")

--=20
Cheers,
Stephen Rothwell

--Sig_/6zBZ8DY2qUD61PdaGLKLEHa
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl09nLsACgkQAVBC80lX
0GwWwwf/UN3amlMc4gAqWMWgtr2Vcgsq/zw9kHau28C8DdT0s83bE7NXkWs69HCf
8VznUaSD+8/2c5kGyYiPMWqJnd1azi0jJISrraa24Nmaj7cQupJFqKvP0lFyq2or
aPfPjN7+HZRDBzXqyLb1KHA2J7eOhKqqkygl+PKI6wCe1V/X4JsrJLDEiYe15IJJ
fP3IcRi0WaxIy70fEQs0B4G82Pin7GGLsxdWgGOHeFj3JZef9xzWlg+TyOsbnuas
q43/28vboduF6WsrD9a3t2NdFxNqYOmztj2gAmf0AWvJvFHg3waJjPCFLJQdUFJQ
B0VlGfMIYRc6lzXprebQ+Ks1mZwoKQ==
=zb0L
-----END PGP SIGNATURE-----

--Sig_/6zBZ8DY2qUD61PdaGLKLEHa--
