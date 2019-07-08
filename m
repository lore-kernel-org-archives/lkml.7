Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E72C606C0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 14:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97AB5216B7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 14:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="DbZguHLO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731734AbfGHOPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 10:15:36 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:48037 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728596AbfGHOPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 10:15:36 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45j6tF3YBlz9sNT;
        Tue,  9 Jul 2019 00:15:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562595333;
        bh=G/FYw91xEfjK7MxW+Phs+NikURuP4TdpN/GlD5cyAyA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DbZguHLO4GM1VeATJsGvkxsJ0cKIxrGyDJntc2IY+4OtoOhjRCCH8ytHfdcaBCs5N
         VufwTbBT5kbuN7kXN9OsItTTEz25IjRYtyL59cHQLzIju9Jp1PWn1K1TPSvmwjI6Wr
         owJrWGevdLkHe+FTSmAoH4yTNaAKsqMMH5NRZRGRujg5DIx5xV6Ibq8TFrxOSGN8Js
         IFjoJ+KrvXvRe9dx+cFyRJQMPULOxruWq7XFxXL5WZDUtdOQD015DOT6eA8ggnZ32F
         BfwES9kuqRS4iyKup3BynL76aDFJS+4aLFl4VjMUoxjvZMHxVyM82E9H9cprCjn+Mi
         5JjJmuB3zoaCQ==
Date:   Tue, 9 Jul 2019 00:15:31 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: linux-next: manual merge of the vfs tree with the nfsd tree
Message-ID: <20190709001531.09b535d3@canb.auug.org.au>
In-Reply-To: <20190708124510.GB7625@fieldses.org>
References: <20190708110633.6e491989@canb.auug.org.au>
        <20190708124510.GB7625@fieldses.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/NsEI5r8dxxnr=g3mDL5PXZZ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/NsEI5r8dxxnr=g3mDL5PXZZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, 8 Jul 2019 08:45:10 -0400 "J. Bruce Fields" <bfields@fieldses.org> =
wrote:
>
> I did a fetch of
>=20
> 	git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>=20
> and looked at the "master" branch and couldn't find that vfs commit.  Am
> I looking in the wrong place?

Maybe you were just a little early, I only finished linux-next today a
few minutes before you sent this email.

> (I'm sure your resolution is fine, I just thought to be careful it might
> be nice to run some tests on the merge.)

Thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/NsEI5r8dxxnr=g3mDL5PXZZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0jUAMACgkQAVBC80lX
0GwPYggAgSK4rk2CNT0ZtNdcGKwG2gIFEdxLNaoH81SrB6Mu51mWjCDUk1tT1lFz
vfL3ESNnH2CBLFGCH0DWuJH69+LFcpJmRVzrJeBjIx+5jAdMYqHhqrVXxWfzFriN
SJMINHl9XEDFp3tGBQ30DnGR5dkoz2MmjXwNgIxO8xK5gvpYD/PWTr8r89KyoX8W
z1EtwCkRQ4yHPJ+V0nlTGprWGLTrFEj2Fb1ley8R3rD8sajwiH5JBH40sFsoBjsS
70ynLAanTVjxePE6Wae1VqCAcb701ZsIMnjib2kUTLNwyj3FSz6hi3eFpAZOUuiX
9AdmZr0oM17BIH2wE5MAUC6dl1nqIw==
=LE06
-----END PGP SIGNATURE-----

--Sig_/NsEI5r8dxxnr=g3mDL5PXZZ--
