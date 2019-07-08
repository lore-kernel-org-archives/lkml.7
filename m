Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79424C606B0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 23:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C36421707
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 23:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="DYIsz984"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfGHXP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 19:15:26 -0400
Received: from ozlabs.org ([203.11.71.1]:53127 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbfGHXP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 19:15:26 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45jLs7063lz9sML;
        Tue,  9 Jul 2019 09:15:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562627723;
        bh=ba8FWgVE23b8w0JrUPK9RJHVOQCWVSjZAuL38KMiQZ0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DYIsz984BFjPVioJPMLCRak6MW8GlW3AIhcu6oYa3DJ9edo/0ttUbM9JUae853zLT
         yugV+dQIPrgJR/RYV3OG2hUIHkYQL49xBeI0PUIQ3sUugOJtlpSWAq7f22iM4lb08e
         w8xm8LCvMTptbJckztH0WHLP44HR24gY4n8iiOxEIO9MK8UrPF06hvyN80u2IRYGov
         FqKppfbhmuOteMSlqkPpJGUv4UCCOam/x4jeIMqTOdjMo2xbLxEOPvnkjLPgd1m0a2
         nY2vFeUmQcfw21bd6SehUDdh9HTEtL4oMOKnROQ4aEASP218nOf4CUlNisao+bdweB
         dHxrZzNnUco5w==
Date:   Tue, 9 Jul 2019 09:15:21 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: Re: linux-next: manual merge of the userns tree with the
 arc-current tree
Message-ID: <20190709091521.0b264257@canb.auug.org.au>
In-Reply-To: <20190530131721.0af603a4@canb.auug.org.au>
References: <20190530131721.0af603a4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/qKsjICntNxKwVqJjy3ZMRsz"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/qKsjICntNxKwVqJjy3ZMRsz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 30 May 2019 13:17:21 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the userns tree got a conflict in:
>=20
>   arch/arc/mm/fault.c
>=20
> between commits:
>=20
>   a8c715b4dd73 ("ARC: mm: SIGSEGV userspace trying to access kernel virtu=
al memory")
>   ea3885229b0f ("ARC: mm: do_page_fault refactor #5: scoot no_context to =
end")
>   acc639eca380 ("ARC: mm: do_page_fault refactor #6: error handlers to us=
e same pattern")
>   0c85612550a4 ("ARC: mm: do_page_fault refactor #7: fold the various err=
or handling")
>   c5d7f7610d88 ("ARC: mm: do_page_fault refactor #8: release mmap_sem soo=
ner")
>=20
> from the arc-current tree and commits:
>=20
>   351b6825b3a9 ("signal: Explicitly call force_sig_fault on current")
>   2e1661d26736 ("signal: Remove the task parameter from force_sig_fault")
>=20
> from the userns tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc arch/arc/mm/fault.c
> index e93ea06c214c,5001f6418e92..000000000000
> --- a/arch/arc/mm/fault.c
> +++ b/arch/arc/mm/fault.c
> @@@ -187,21 -228,14 +187,21 @@@ bad_area
>   		return;
>   	}
>  =20
>  -	goto no_context;
>  +	if (fault & VM_FAULT_SIGBUS) {
>  +		sig =3D SIGBUS;
>  +		si_code =3D BUS_ADRERR;
>  +	}
>  +	else {
>  +		sig =3D SIGSEGV;
>  +	}
>  =20
>  -do_sigbus:
>  -	up_read(&mm->mmap_sem);
>  +	tsk->thread.fault_address =3D address;
> - 	force_sig_fault(sig, si_code, (void __user *)address, tsk);
> ++	force_sig_fault(sig, si_code, (void __user *)address);
>  +	return;
>  =20
>  -	if (!user_mode(regs))
>  -		goto no_context;
>  +no_context:
>  +	if (fixup_exception(regs))
>  +		return;
>  =20
>  -	tsk->thread.fault_address =3D address;
>  -	force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)address);
>  +	die("Oops", regs, address);
>   }

I am still getting this conflict (the commit ids may have changed).
Just a reminder in case you think Linus may need to know.

--=20
Cheers,
Stephen Rothwell

--Sig_/qKsjICntNxKwVqJjy3ZMRsz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0jzooACgkQAVBC80lX
0Gws/wf+KzZstLr2a+CXAaiI0oVlQi0NTSF2GaDUPm1vo2Y6TGboEIXfEPAUfUJf
bRbwBBIU+ThpDyS1rpXKaf7acuoj42J8pGsdsFz82Ul7y/9128LjoSLJ0vlksina
RSD9iXq5/tXMmBKTwCmLc6mLw1+Q+eTeAMYftIfph+CZ8iN+2NyfNTh/21DSd6Uk
dcccvuSvlH0qZCzPbYM8pdRo7VS8iYazoS9tcvbFibYoJlBUMezzl7TzdainN/5/
E+NibMtxkzdj3p27GqXGNiRX9jOOhwkfl3f/Aue0BacBDVfsovn86H+p4jpnVv7K
eHGS0aOLPjw0lUinVEV/EstBZmc7Fw==
=Saob
-----END PGP SIGNATURE-----

--Sig_/qKsjICntNxKwVqJjy3ZMRsz--
