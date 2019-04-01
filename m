Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA83C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 22:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A88AB2086C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 22:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="fKR9oq2w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfDAWwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 18:52:33 -0400
Received: from mout.gmx.net ([212.227.15.19]:54323 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbfDAWwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 18:52:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1554159134;
        bh=netgtGcmPd9+lHBrExXQYrctXRHIscuP/NzGvjieDIQ=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=fKR9oq2w462aZVhe4ARPsG49Toy//J+s8V2+QIFu1mSW/yWZiFtEy1NfrCWKJmXcj
         FkuMMQ40BTZSP4/l2fwUHsLesvDOPbTY8e8eEkFH9P/4QxKWNPA6dw1Gb3dWjJJ8J5
         SMlMVRpuIItpjchj9EarBR/30wjmDyTaBBF2eSXs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MN1C4-1hHgQA0PBA-006hQ6; Tue, 02
 Apr 2019 00:52:14 +0200
Date:   Tue, 2 Apr 2019 00:52:11 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-doc@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: soundwire: Ensure that code is inside the
 code blocks
Message-ID: <20190401225211.GE2095@latitude>
References: <20190331223423.29855-1-j.neuschaefer@gmx.net>
 <20190401154003.7eddc9e9@lwn.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SFyWQ0h3ruR435lw"
Content-Disposition: inline
In-Reply-To: <20190401154003.7eddc9e9@lwn.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:pNnLNK2jlOOxHiOieeEKZ60giMsr0FgWptyO8TCiQlpo9eCrwcu
 dIk/xI0gfe7dNTOwTQGkHUTuADI9SpM8caMN2pZy4qrTyxLzoy6OoU4zNiAJFqfjhGVuZ1L
 bzgZ1E6UXEENAjTpF82uBtD+fBrFHI3Vct0cpnbjCH7N88cyA+HwOLAe1WhWzr731vgxDPD
 qeqXYLQOXrz4JEn90Vq7A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WZCl0in6gjg=:HVz0GTvBpRWe+Gikw9NGKJ
 g58a5q8krasojGHFToqN28SKBmokqB12HBd4Vhn/c/2QymsV3IF+wWFsnjwUiNTak95asnsKk
 SE84ykAda9vGzmXL9Vl8uptfWj9mKLM47FTaD8bEEcJQxlADl1njodWs+B/SSk0GVy9aIkjBM
 PSiuzevaAHs30GN4upVd13cotlWxPaWzd02gvHPanFREhBdJ05zRoH2+jLzStamGAyw61maGq
 OFAbRhMenU3v+szQWGyghMPuM3K+ZRGRbW7t3ew+lcIpJaCAAoCkzug2OVRQ3+Z1/MeCswnhn
 MbaqawCd0e1VfrH09alhMXY5xfoQr/bwL6gkCUo7IgM+cyqivPYnN4O2/gPE31RpIJW97NQ0b
 dAR1KylZgn0fU+R7vbRDRpl4uaQt6v15JRNS3/wNiTBAY/mzy9oSO7m6T3L3Np9EGO2Jjjkr9
 lIsBBNg+H3pr2WFA7BQvYzzzJgui6UNlqi9HDBMZw7TKzLU5Z3cgZuzK7yS2ZEjqtL0f4U6Yp
 Hsa75wB68BVk7N1/NtLSYJCBR0bJjE3VUpNdYL/slXzjNz1DwxIiHSKMvO7I8oVITCTYYV/G7
 TeD8Ay/LzwYYLkycz33tQT5Jg9pmVsR6mEDFGwqu8EjFE1BuGyS7IJjJP97576ZNs+PQXgo3E
 fVXcLZ21pr25/ynOskHatrWP4RftM2KtxdtXX+gnZk7XhlWIvwiC5DWyXiATWr255kHRdlaTF
 wGxOPO/pBBLp+MgFkM1xaz3IWMR+Bhn+99bFHP+NrbPVKDwe9nUQDTGAa3A75dkbHy2XbcbnC
 JkbF7/mcKTna76rUQx2N0Jnsz3UZ0re3+2k3pbAD+j2AReM9JAcquTZ2jG3A8nK116Md3knLH
 7hJFlhNfg2tWIizP0UTwH18y6A0zO92CUqG2c+HiCXmoZznXYS+yxGEDzLVhi0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SFyWQ0h3ruR435lw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 01, 2019 at 03:40:03PM -0600, Jonathan Corbet wrote:
> On Mon,  1 Apr 2019 00:34:22 +0200
> Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net> wrote:
>=20
> > The way the document is written now, Sphinx renders empty code blocks
> > followed by the lines that should be inside them.
> >=20
> > Unindent the code-block directives to fix this.
> >=20
> > Fixes: 502c00d9c315 ("Documentation: soundwire: fix stream.rst markup w=
arnings")
> > Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
>=20
> That definitely makes things better.  Applied, thanks.
>=20
> I'm going to take out the Fixes tag, though, since the named commit did
> not, in fact, introduce that problem.

Ah, true, the wrong indentation didn't come from that commit.

> It's also good to copy authors of patches named in Fixes tags so they
> can defend themselves :)

Good idea, I'll try to remember that.


Jonathan Neusch=C3=A4fer

--SFyWQ0h3ruR435lw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAlyilhIACgkQCDBEmo7z
X9vZ8A//Ubr9LUXRv3XHqbcvLtsVzW1M+qSredcJrMbpgR86ynQnBKQH1tM0Z7UE
CE910vJTtwKogXfB/ohMwb1mOUlumajBuhCPO4MRKj6kO4et6g8kgNU3rUJj2Eh8
9OB1rOyWADqOJLbxZq/W+FPt217NMNry/BrWu9JSXak4Y7pax3cJOuSTt1IHuSzx
+h7AcudAKgiAvnYC3hVh2FZdSScQIpEf/G6oP5uvv2YvF1QOnGXhShGBzBKxZGp7
hjOWwJLZ1hTnMgV6eIGYackJMMqPSnAfjtLLn7YZH90z1T9ehorUOvVFp5fd/6j9
duakvKusP4ED6llf7LiXmanOhbqq1M74qtD5eUVwmexsW1omGYXV48dQzElgrO6B
K0v8LML3g0m7L1wsWrdOYwCXReEWjTdGU5gVgfmi0O7PSRPy0sW1/vTqOctSGSfZ
1o6+n6E6RZ9vnq1IzyPZw7cNojn+vU7zr8bhF4a+jFGiDsuZJB83wXLOgoupajhO
az+Y2QvDXq8E4U5U+4pAuv1K9XEvoDcrG5D2CsJxgA0Z+Xifp3NN5Qwa4XyTUkSj
ia3NXHW+BtNcOBUnNa37kFLiVkokER7wwvxqD2nMB4ujI7QzYlQFZfuSKOIP6TRk
GlE5Gh6AC4USqRXAyPa3ZkqqSEoaCz+6AOrcX+yXYBZ1BuSAHNw=
=0pIl
-----END PGP SIGNATURE-----

--SFyWQ0h3ruR435lw--
