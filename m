Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF9B9C73C74
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 06:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C776020838
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 06:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="AojIX4zX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbfGJGAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 02:00:55 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:49155 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725791AbfGJGAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 02:00:55 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45k7pX18Ndz9s3Z;
        Wed, 10 Jul 2019 16:00:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562738452;
        bh=QS1TYk+jPpzFLZYgrElcWfPd8Iy8zqMpGdy+TeAxg2A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AojIX4zX6lK74pdPSLgR2nbDRUS7WMgbWDbOFlcDKE3uer56SlVS5h+TNxhNO3rgr
         RMDVHpnrzdZtNpUr5dwCvSgDUbct8v/BEcW3sLlsIe5ZsONrEdjOR5UK+kDREwst+5
         IhqMysx1wi91BlAx7QtN3Inh/9xr5/N46SmkDwkXueqZ5GOqSyEbaM0/DUSG8BLiqg
         dkZYo1XkBoAUgzLtfJTLhXTHg3ZYyDZlXaEHjdqHySqeuFsZ0Ases84dVCqAWumvKf
         SvQRMZLUbkIDdp28krazNTAzL1ZvooOIwpjXTN+u3pUpWPxCc/rUBVtxOXDa0cT+yw
         1IjbGRNMomhRg==
Date:   Wed, 10 Jul 2019 16:00:51 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Winkler, Tomas" <tomas.winkler@intel.com>
Cc:     Greg KH <greg@kroah.com>, "Arnd Bergmann" <arnd@arndb.de>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Lubart, Vitaly" <vitaly.lubart@intel.com>
Subject: Re: linux-next: manual merge of the char-misc tree with the
 driver-core tree
Message-ID: <20190710160051.5b192606@canb.auug.org.au>
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B9DC6C94D@hasmsx108.ger.corp.intel.com>
References: <20190620153552.1392079c@canb.auug.org.au>
        <20190709095109.3b75679b@canb.auug.org.au>
        <5B8DA87D05A7694D9FA63FD143655C1B9DC6C94D@hasmsx108.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/1JauvoM9pHm9Os9uhPJxkTc"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/1JauvoM9pHm9Os9uhPJxkTc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Tomas,

On Tue, 9 Jul 2019 07:12:34 +0000 "Winkler, Tomas" <tomas.winkler@intel.com=
> wrote:
>
> Actually I've asked Greg this git expertise question: how the
> **exact** conflict resolution is carried between git trees (before it
> is finally resolved in upstream for all.). For next time If anyone
> has the answer, please let me know.

When I see a conflict, I fix it up and report it, then "git rerere"
will remember the resolution for me so that the next day it is fixed up
automatically.  When Linus merges the same trees he will do the same
(or a similar) merge resolution.  I depend on the maintainers to inform
Linus if the conflict is any anyway difficult to resolve.

--=20
Cheers,
Stephen Rothwell

--Sig_/1JauvoM9pHm9Os9uhPJxkTc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0lfxMACgkQAVBC80lX
0GylYAgAiDaCEKvhJeM7K6qo7sJNDK/yUzqM9NC8FBwsIRVAwUjZH1XarjFi8334
EVJbXZ1WxPW1I04QgqejLjwMG8P/i6qDtrLjBaIYrU0bIFk2GgBlmTdkRHt2szsp
BrUn7ByJuGOvK0/l0HQhOO+RH876fj64WmP15bcpVrDmJ9FKBONt2sulA7NI8KmO
lkUrtOb4oqIsuDE7RbOSUMODnc0BOPPyByBMbaDU4mexXb46cKT3Wxr0pjE8QE3R
tajIAZF0z3boxBgmy95HEjglMUh5sWP822pWfV6Tor6+yzEh4z3JXyDIV4G+s0AR
8a21p3I6LsuSo1m7ExM7BjpKEGm/UQ==
=QlJ5
-----END PGP SIGNATURE-----

--Sig_/1JauvoM9pHm9Os9uhPJxkTc--
