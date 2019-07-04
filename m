Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6808C06513
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 07:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EC522133F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 07:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="n5FnUoA6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbfGDHrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 03:47:17 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:55449 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726844AbfGDHrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 03:47:17 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45fVS14Sydz9sBp;
        Thu,  4 Jul 2019 17:47:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562226434;
        bh=s2EKf/ydzCEbA4PkRn/qUXvR5emdDRx7OrbEOwkhBKs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=n5FnUoA6INCwwU6msFsapsE4MDUk6Wke4sKfSaPziG94YN/KHDJQLEAfOuss90dNz
         h05MwbJu1bmOp6yFuosmUfUSA6dWe+BTQOHMBVd/dhXXlmLYrIL+3cSW2My2YDX8/Y
         wIMPiW2TIori9agM5KJHnz0EFxxd1cU+QH+HYGOF+6pAkPVaqoZbXRDi/u8WWOsj8s
         axHsB9kmREN6BrzIFSG/MlNcPCHLZZJtVoLR40DCHi13E/0lp5yW+3pOEtlyg783Db
         gjpvJjHv3beYyhiJq35wvfK32Tw63mzeaIqD0L+K1OwOnQNM1YQ8o08gvQNr5CMMc4
         r7X4LA43F3fWg==
Date:   Thu, 4 Jul 2019 17:47:11 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pawel Laszczak <pawell@cadence.com>
Subject: Re: linux-next: build failure after merge of the usb and usb-gadget
 trees
Message-ID: <20190704174711.0e4a18c5@canb.auug.org.au>
In-Reply-To: <20190704065949.GA32707@kroah.com>
References: <20190704163458.63ed69d2@canb.auug.org.au>
        <20190704065949.GA32707@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/uagndVpPUVtyyYrxZd7H.6V"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/uagndVpPUVtyyYrxZd7H.6V
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Thu, 4 Jul 2019 08:59:49 +0200 Greg KH <greg@kroah.com> wrote:
>=20
> Odd, I thought I pulled the usb-gadget tree into mine.

You did. So after it failed in your tree and I used yesterday's
version of your tree, the build then failed after I merged the
usb-gadget tree (which I do after merging your tree).  The usb-gadget
tree contains commits that were not there yesterday.
--=20
Cheers,
Stephen Rothwell

--Sig_/uagndVpPUVtyyYrxZd7H.6V
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0drv8ACgkQAVBC80lX
0Gxx5Af/cuOxN7YELAoCKOwsN1XvyeSQ6mKWUGPspc48KIQ87O2Vfs7+XiA2Ax3o
pDuaHTyn4xh+LDEIsBvbcBU7olwMlFnMpvX2dlgwIgImZVfFTUsO9bTaNNzHeWSW
10/O+joga0hinUA1EUBmkNflGH6hSqX8IktzLHzGS/mpHpSfcqao6l8RDztd7xe4
GYG0VzZYWeYHNxV5rkW3pmcIw1gsNW2P+ktxbzd1/Jkmj9bB6hjDvMmGsQQsfs4w
kY0ah39/yvwdwDavybpG3k17ezNzHUGbgu1sVx3QwVWkpcbXZeqOWw/Wa/9TPjaN
AgA1sp/rtOcHXPhgPRGVz2yVZbkWIg==
=P+ja
-----END PGP SIGNATURE-----

--Sig_/uagndVpPUVtyyYrxZd7H.6V--
