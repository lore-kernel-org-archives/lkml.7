Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF34C04AB6
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 00:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BB372183F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 00:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="slXpqHLP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbfE2AAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 20:00:40 -0400
Received: from ozlabs.org ([203.11.71.1]:37685 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726683AbfE2AAj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 20:00:39 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45D9pD4tq5z9sBb;
        Wed, 29 May 2019 10:00:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1559088037;
        bh=GZ0gAzbgJ+60g8ErhosKnQ3VNb9AmTQTKEt9SuzsKzg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=slXpqHLPimqX2oEkSgsk07NdCq3rdyVs/+gs5hqghSeMJs+NocykfGO+an1kDeKZX
         VFB3V1q8RxxDH5WlFKmciegMK+toraXU/a+ELnGUlrfJhotQyd5TV3MK+EXNRUbBDC
         WrSYARv037p+cX9jN9mJSttWg9+OqEBnEiX8AaFA48O/fkYJRIXFNEpd5be2OgUPU+
         kwhTUWlSy4pwuV7lMp7pvL3RiAOg19YDcYLehjggCbPel/adBGoyzu3BpKsbj+LYBW
         3YkidV6Lqdx5Qydz95rZil/oG2b8jZxSJcy5Wo2d1dCBsv4JaQd1fV+IEo2Lgfh0aN
         MYPUMKZ6nKmtA==
Date:   Wed, 29 May 2019 10:00:23 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Zhu Yingjiang <yingjiang.zhu@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Keyon Jie <yang.jie@linux.intel.com>,
        Libin Yang <libin.yang@intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: Re: linux-next: Fixes tags need some work in the sound-asoc tree
Message-ID: <20190529100023.4a7cfacc@canb.auug.org.au>
In-Reply-To: <44bbb3f1-5674-6431-5818-d8b5cca708dd@linux.intel.com>
References: <20190529075614.150b1877@canb.auug.org.au>
        <44bbb3f1-5674-6431-5818-d8b5cca708dd@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/F8gLjB5fcrXmqdy+Qe2tDr8"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/F8gLjB5fcrXmqdy+Qe2tDr8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Pierre-Louis,

On Tue, 28 May 2019 17:22:40 -0500 Pierre-Louis Bossart <pierre-louis.bossa=
rt@linux.intel.com> wrote:
>
> On 5/28/19 4:56 PM, Stephen Rothwell wrote:
> > Hi all,
> >=20
> > In commit
> >=20
> >    be1b577d0178 ("ASoC: SOF: Intel: hda: fix the hda init chip")
> >=20
> > Fixes tag
> >=20
> >    Fixes: 8a300c8fb17 ("ASoC: SOF: Intel: Add HDA controller for Intel =
DSP") =20
>=20
> Sorry about that, not sure how I managed to add an off-by-one in all=20
> these tags. Checkpatch.pl --strict did not report any issues, something=20
> must be broken either in my setup or the script.
> Not sure how I can fix this now?

Its not worth the rebase necessary to fix them.  Just use it as a
learning experience.

--=20
Cheers,
Stephen Rothwell

--Sig_/F8gLjB5fcrXmqdy+Qe2tDr8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzty5cACgkQAVBC80lX
0GyG7Qf+MdPBfzF8R7UaulnuAKN1HfNFWuY3VXVToBvsKdOTLE0EfIQyDfEc2qxa
fq8v+ZOA+rSSgsyxE6LJMy+KhVhm7jzQO7Uoxp+5dxTWVA5+XysKrDsgoe1p/7+i
n0JUeguYaHwVam+YbWHNFRItx9qi/mMLIrnGSe0O+84rtrsQRGGPbVZE7Uv7CbLv
lyeqDw/s7+NXMI2EKX4YolwkjAnonfPOsM8VZ1oBLE+FdtFl5cVWBgKm4YskzAPh
CjCZVquLmrg2zvFbof6Oin4rU7fTpQimvXDaU2beoeW/fXkEmJyZrbpXtV+39R+f
n6jHvA07GMDPyOyx/nVtQTDwgELNmA==
=na2v
-----END PGP SIGNATURE-----

--Sig_/F8gLjB5fcrXmqdy+Qe2tDr8--
