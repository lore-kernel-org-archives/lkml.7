Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0756FC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 03:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0DC0208E3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 03:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="aCSelvFz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfDHDCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 23:02:21 -0400
Received: from ozlabs.org ([203.11.71.1]:33899 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726349AbfDHDCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 23:02:21 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44cwFM06M7z9sQx;
        Mon,  8 Apr 2019 13:02:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1554692539;
        bh=YOFk+atCKrXbjCML7jZe9KGogxn1YoR//ITrERqtAqU=;
        h=Date:From:To:Cc:Subject:From;
        b=aCSelvFz9iY//hXDTkWTikYlPZ+N2W4B6gl1vZxyiGce0fRqjr5JRW6A60EsWjLOj
         ZLLy/FtOH6bL1A9x3/NBRUuOn3sLv2IGVUFetVtEt53xynPBCkYovstX8Te0Qr/m2e
         9i4lStEEELMZzD3dsj75ycM+utrVMg8mgJa3l/5oi6cdz7Bh6BuI2HoKaSVjyF8Y3i
         uwfeoBHUIchJoXPGb+GEHfU0aY1i/ekzmwynn2l7CFt6juM3bj90mZgMzgQLcaoSjV
         ff3UpLluR9ANd8o8lVVM2/pcDgTYfdVXTD7Ahu7YSEe9Rr9P84Fr4d/5ygZTC+MW0G
         RJCMJraNM7BMg==
Date:   Mon, 8 Apr 2019 13:02:12 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: linux-next: manual merge of the staging tree with the
 staging.current tree
Message-ID: <20190408130212.0a41f2a8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/p70eTziV7_X5O6WDD_8LHup"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/p70eTziV7_X5O6WDD_8LHup
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the staging tree got a conflict in:

  drivers/iio/industrialio-buffer.c

between commit:

  20ea39ef9f2f ("iio: Fix scan mask selection")

from the staging.current tree and commit:

  3862828a903d ("iio: buffer: Switch to bitmap_zalloc()")

from the staging tree.

I fixed it up (I just used the staging tree version) and can carry the
fix as necessary. This is now fixed as far as linux-next is concerned,
but any non trivial conflicts should be mentioned to your upstream
maintainer when your tree is submitted for merging.  You may also want
to consider cooperating with the maintainer of the conflicting tree to
minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/p70eTziV7_X5O6WDD_8LHup
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyqubQACgkQAVBC80lX
0GyEVwf+L3iLA/ah+KrLo74edL+x9cSVgb1NT/g2yBFQYdp+cA1ZMoLw280rsvhN
Iq6qti5DUj/Zi2XxWN+MFVyyMUBHEtU7natiLK7N9uApcodg7uR3/wU34vmUQ6Ci
3W5rxgzSjyX4ZQ4aCT6KDTcDsZwqEgd49LQeg9E3VrDJAxDI0orP9gM4Vh98zA5Y
c2zk58fu3qQYRctdY6UnGVmHUc5/l0WTc27LWxV7wlLP5f11DJq35Rl+0YE2Nxrf
fktymUWXQOEoxOZF0CF/3nHWueXCHudeDh0uCdZkH2GrXHw5I3r7Q2YswENa4Nhp
HW12SJUlC9sQmMewXecNK6mb0yuxFg==
=7ixT
-----END PGP SIGNATURE-----

--Sig_/p70eTziV7_X5O6WDD_8LHup--
