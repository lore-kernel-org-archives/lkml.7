Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBD2C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 11:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 635CC21848
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 11:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="bBI3tFvy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbfJOLmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 07:42:45 -0400
Received: from ozlabs.org ([203.11.71.1]:36887 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbfJOLmo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 07:42:44 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46stpB2Vf8z9sPF;
        Tue, 15 Oct 2019 22:42:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1571139762;
        bh=GzuSXvwCsW5qF4JT5b2HN3qZva4w3uLIyiYuDHbFckA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bBI3tFvysNsS3jE+Hy7eUTigqI0rcezmGhgObJfPGfzsgJNOD0kdbmfRJTrM7bp/+
         G7A3ZTeo4NApvwBvbc4JHK5FHRjw7dqCKNAnmfRhTKyfDk/38XzeVMrQjJkOU5h0Qj
         jFLkvk1S4nguuFc4v57hMBeMs6oJNTXL+/oJttJEZUyU5qX6eDGLJJPaUpg9ISbnLy
         1jrKLDwiDXTDZ1THQl4nn54tvHeIfK7D9x5Fde5DMYdwp7UVK2k71fE9wDGEw/4/4l
         XW+ubjsewOCMuPRwnR8o8csHaacd5KLYXqwIx2HDiZH0PaqoL7C73WsFGJVzBAdRWO
         XU8S3mjHkZ4hw==
Date:   Tue, 15 Oct 2019 22:42:41 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ayman Bagabas <ayman.bagabas@gmail.com>
Subject: Re: linux-next: build failure after merge of the drivers-x86 tree
Message-ID: <20191015224241.1a485d5d@canb.auug.org.au>
In-Reply-To: <CAHp75Vfv7hzqO=U3AwDs8OuKL_rs9+Sx0DknnAi6WN342iSpHQ@mail.gmail.com>
References: <20191015130006.39f58992@canb.auug.org.au>
        <CAHp75Vfv7hzqO=U3AwDs8OuKL_rs9+Sx0DknnAi6WN342iSpHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/AlH65u3khJPw=1hotxSS7al";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/AlH65u3khJPw=1hotxSS7al
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Tue, 15 Oct 2019 11:04:29 +0300 Andy Shevchenko <andy.shevchenko@gmail.c=
om> wrote:
>
> Oops, thank you for pointing out, should be fixed.

Excellent, thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/AlH65u3khJPw=1hotxSS7al
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl2lsLEACgkQAVBC80lX
0Gy+mgf/TiQL2aTj7YcyG4XIzf8W4bf4hC/qxynHPaK9oMM5StJMxkNv8hU6plta
1utr9QplMT6tRBNeS9lMEp77YO8HX33NcksuggFUagjmiAJm9D3XdkFIZ09OcBla
cWaDadz4LoCJYT8s8nIQJN2bpxVM0JKbKM7qoeK40R8l9lvPA2usrVyFA27a4HJl
Sf0yBs73AIFLw0bSYqCetWUp0u9cfz2Qw+z0fi6fVyBECXckHkancgzujlOrEVt2
lOLPW5qZcCAJYZix8LLurhcR36uDHXsDkYTRcLe8091fcQURAj9WOakYV5bcGz8R
fXktwqSdSyyFcIUxT3qOJ3eHMazYQg==
=dLW5
-----END PGP SIGNATURE-----

--Sig_/AlH65u3khJPw=1hotxSS7al--
