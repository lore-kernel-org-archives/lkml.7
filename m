Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA62CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 00:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F06120650
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 00:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="H/UDoxo7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbfJ1ADC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 20:03:02 -0400
Received: from ozlabs.org ([203.11.71.1]:59269 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726909AbfJ1ADC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 20:03:02 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 471Zfp4Wykz9sP4;
        Mon, 28 Oct 2019 11:02:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1572220979;
        bh=az2zydEzQ1rf9pqzia427KFZ7Y/igSD/dWXuoPvZSEk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=H/UDoxo73yXK4v7F0hcgaERxxh1rF/3iKa9cKb3y5shsLqJpAcxn9S6Pc1l05Imwa
         nkQJe/1f4MkoWj8VKnQ8RbiTTsxp9QvQp7dBb8dnMZhRWYevnXbJNVP0zHF2Swne2n
         oG9RdH4WTDXwq6fPHDNR8aAhxI19lLhKi9bVjBg0PPIxpN9UwRSUV0uvts0jGbshsb
         WV6eqYGCZleliuHEWCwSX18ImZyHSpFe/z3Mmn4n1AnQLDrxp97XpkdYA8oXosq5km
         +CSHCJJkoG2EwjQ2U5KKpiGKlNMKZ8DiQ4AX9hGURM54rKc+rmdYpa0rONN9OcY6gC
         XHiMIWA6MUerw==
Date:   Mon, 28 Oct 2019 11:02:57 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: linux-next: build warning after merge of the bpf-next tree
Message-ID: <20191028110257.6d6dba6e@canb.auug.org.au>
In-Reply-To: <20191018105657.4584ec67@canb.auug.org.au>
References: <20191018105657.4584ec67@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ZXSJx2c+WO+1Z=QY9pD2xO_";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ZXSJx2c+WO+1Z=QY9pD2xO_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 18 Oct 2019 10:56:57 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Hi all,
>=20
> After merging the bpf-next tree, today's linux-next build (powerpc
> ppc64_defconfig) produced this warning:
>=20
> WARNING: 2 bad relocations
> c000000001998a48 R_PPC64_ADDR64    _binary__btf_vmlinux_bin_start
> c000000001998a50 R_PPC64_ADDR64    _binary__btf_vmlinux_bin_end
>=20
> Introduced by commit
>=20
>   8580ac9404f6 ("bpf: Process in-kernel BTF")

This warning now appears in the net-next tree build.

--=20
Cheers,
Stephen Rothwell

--Sig_/ZXSJx2c+WO+1Z=QY9pD2xO_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl22MDEACgkQAVBC80lX
0GzzfQf/Q0QnAHV72bYNUdkgcSH9LOJ9t/6p+aRr+4vw5frSUMgwlpL/dqzwXlPi
ubGCbcVoaDWDXBCcAXj6IZx8Ki0jwZmkGHhvMCktOg3IpMDRZJqdtrqJzSGnYYlx
k4R3yiW2Eag+I2/3sBkTfStBFU8sd04Ae5YqnTb3RtFMwEVR3BQg8wvQ2uRKF4DY
JPR6f55s0av6kVF8pQ/ySnAMguJim+J/tyAcC4kxRlBOaxXiwVmaHH1pRs8gWQ/e
enkPaJcIdJW36+UKNVqbLNSWuTV0InP4B3OBknRt+1ea/TrfM3ejYuGcjRRcwAvu
D23+98uAKiuQpg7EyUd34X+rRy9ZkA==
=CUKK
-----END PGP SIGNATURE-----

--Sig_/ZXSJx2c+WO+1Z=QY9pD2xO_--
