Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BA5C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 21:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B932E20B7C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 21:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="BXFLwGPC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbfE1V4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 17:56:21 -0400
Received: from ozlabs.org ([203.11.71.1]:45347 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbfE1V4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 17:56:20 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45D72m3p7Vz9s5c;
        Wed, 29 May 2019 07:56:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1559080577;
        bh=LrX/cyFpcdg2iUnZm9VFg2gXW9OqU4FqAiPt8bY6SyQ=;
        h=Date:From:To:Cc:Subject:From;
        b=BXFLwGPCnmVxcvOSSmPm4LvmTFmMwJzOYcPocUJuuL76FCW0i/P2OPW1/auY9yG+S
         EZSbb9PTy9td9qyGXvRzdBPwf0Jllj58O6ln1LOcFO0c/W3Jmr3e5mBqVlgYLcA/FD
         gfUxdF+5B100Zs0B3LYj9DS3xIpp4TRMw9KNxk6bMiB4WhoWWdMrHh6lic1yFGZhqH
         D1nNy9Z//ecS2o6074Vq8gQAUTAlGXMnK0w55fgRwy/jIzAj3AsEFRy2+oTkrboClS
         edBWPX+/Asx10TQ8m8KjY5oHEwFY2vdoDdlTghKDmm09cIvxlsXojKihv7OhaS+A8L
         +fpiVNjSblLyg==
Date:   Wed, 29 May 2019 07:56:14 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Zhu Yingjiang <yingjiang.zhu@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Keyon Jie <yang.jie@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Libin Yang <libin.yang@intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: linux-next: Fixes tags need some work in the sound-asoc tree
Message-ID: <20190529075614.150b1877@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/eDmfDfBWBHbIHswnSV_47HK"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/eDmfDfBWBHbIHswnSV_47HK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  be1b577d0178 ("ASoC: SOF: Intel: hda: fix the hda init chip")

Fixes tag

  Fixes: 8a300c8fb17 ("ASoC: SOF: Intel: Add HDA controller for Intel DSP")

has these problem(s):

  - SHA1 should be at least 12 digits long

In commit

  1183e9a634db ("ASoC: SOF: ipc: fix a race, leading to IPC timeouts")

Fixes tag

  Fixes: 53e0c72d98b ("ASoC: SOF: Add support for IPC IO between DSP and Ho=
st")

has these problem(s):

  - SHA1 should be at least 12 digits long

In commit

  5661ad9490ee ("ASoC: SOF: control: correct the copy size for bytes kcontr=
ol put")

Fixes tag

  Fixes: c3078f53970 ("ASoC: SOF: Add Sound Open Firmware KControl support")

has these problem(s):

  - SHA1 should be at least 12 digits long

In commit

  fab4edf42d2d ("ASoC: SOF: pcm: remove warning - initialize workqueue on o=
pen")

Fixes tag

  Fixes: e2803e610ae ("ASoC: SOF: PCM: add period_elapsed work to fix

has these problem(s):

  - SHA1 should be at least 12 digits long
  - Subject has leading but no trailing parentheses
  - Subject has leading but no trailing quotes
Please do not split Fixes tags over more than one line.

In commit

  04ea642ff62a ("ASoC: SOF: pcm: clear hw_params_upon_resume flag correctly=
")

Fixes tag

  Fixes: 868bd00f495 ("ASoC: SOF: Add PCM operations support")

has these problem(s):

  - SHA1 should be at least 12 digits long

In commit

  0bce512e784d ("ASoC: SOF: core: fix error handling with the probe workque=
ue")

Fixes tag

  Fixes: c16211d6226 ("ASoC: SOF: Add Sound Open Firmware driver core")

has these problem(s):

  - SHA1 should be at least 12 digits long

In commit

  13931ae31b67 ("ASoC: SOF: core: remove snd_soc_unregister_component in ca=
se of error")

Fixes tag

  Fixes: c16211d6226 ("ASoC: SOF: Add Sound Open Firmware driver core")

has these problem(s):

  - SHA1 should be at least 12 digits long

In commit

  b85459aafae6 ("ASoC: SOF: core: remove DSP after unregistering machine dr=
iver")

Fixes tag

  Fixes: c16211d6226 ("ASoC: SOF: Add Sound Open Firmware driver core")

has these problem(s):

  - SHA1 should be at least 12 digits long

Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/eDmfDfBWBHbIHswnSV_47HK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlztrn4ACgkQAVBC80lX
0GxqHgf/Yq/rkW3q0vgeiMRe4oU0VQiOar6RSlvfA2ZXM8x0CrTHxnO2PrBPMmR2
uy0wkIM8cxaVf+C9wvDT1kobn4JNL0TBd8cEIAV0yL1NiCFGU4trhQBd1h7OIF21
HA52u2PmXJ69PCjfHcHHbGMQ/eJZou3n+zXKmhJDSRTJtNvHoYJhfOELrtO50U4l
06eciKHtzLKA30aq082YV8JEkJljh+i6TvgzpXok6+M8PQlj5vMgJZ4u97XneDij
H2kleKZb7j8jB4h1EnskiOLuACvjHe/59lCF0XiYRmjGRWjtrJj2W2So3+BUHTXR
SKdzCRBVDjszafrCE+ZnixVADs97bA==
=tdQC
-----END PGP SIGNATURE-----

--Sig_/eDmfDfBWBHbIHswnSV_47HK--
