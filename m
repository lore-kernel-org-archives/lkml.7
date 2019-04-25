Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33FEC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 17:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 363082084F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 17:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556214048;
	bh=Ei8GmRgua+7ziQFXrmbSJMqM7GP9Tgiwyulk8VCm4Zo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XrxFW8e2VyaCTfpSYck+S/EugxJr1wwjoVpmaZCUDKQqKGdBkN+UQ3nO6swLrr9Hk
	 /0uJsVu8Im13uuvUDuDoJVh4PpemfAimfgKLy70jKXTvdNaQIUUVNGQAxh3UsgK+Z3
	 euybHM65tG2Ese5bKrgasjQXkWGWZjmNs2tSNogs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729662AbfDYRkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 13:40:46 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43668 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726916AbfDYRko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 13:40:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=c0yQUFasCdP/vo1+83uXGQ2fYZvAvVNdNc3Io6O1FM8=; b=ZwJrlOMhNOYeAVzZsoHvmk/+T
        g68bXgj6h+JSNTZ5ubmyqcWMxl3rcQ17HJ5zzutYTOMuGLCHCvL6WBUKGKna3JLp6X3/FqfsH3ykC
        QBCxi6f7bsY+U/2khPjugUS0yTepPEAvsMyK1n6VUFuBpPvPPHgu5etKVmfjQPykoqxi4=;
Received: from 92.40.248.65.threembb.co.uk ([92.40.248.65] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hJiMP-0003MS-Sx; Thu, 25 Apr 2019 17:40:38 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 9D381441D3B; Thu, 25 Apr 2019 18:40:36 +0100 (BST)
Date:   Thu, 25 Apr 2019 18:40:36 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Subject: Re: [PATCH 00/30] Update cros_ec_commands.h
Message-ID: <20190425174036.GB22575@sirena.org.uk>
References: <20190424232918.243308-1-gwendal@chromium.org>
 <20190425081232.GA14758@dell>
 <aa1c0ab7-6491-69a8-936c-26460b78d6c2@collabora.com>
 <CAPUE2ussoqWAP-1Hpa2mGq-23NuTh=Ai3dssiZYYiqLBDTCJwQ@mail.gmail.com>
 <0fad0c23-7939-606e-86e1-748dd1115b82@collabora.com>
 <CAPUE2uu7npyi0jgHPLCD-3DWkiKuhRidBgyiVK6O1TesHLqkEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p4qYPpj5QlsIQJ0K"
Content-Disposition: inline
In-Reply-To: <CAPUE2uu7npyi0jgHPLCD-3DWkiKuhRidBgyiVK6O1TesHLqkEg@mail.gmail.com>
X-Cookie: Drilling for oil is boring.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2019 at 09:38:09AM -0700, Gwendal Grignou wrote:

> I squashed both patches in [PATCH v2 24/30] mfd: cros_ec: Update I2S API

I think I just deleted that patch unread since it was a single patch
=66rom the middle of a patch series with no context and a subject line
that made it look misdirected...  please ensure that you send at least a
cover letter to people so they have context for individual patches.

--p4qYPpj5QlsIQJ0K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzB8RMACgkQJNaLcl1U
h9Dwpwf/e1ueU0pX2M67i6vB+8g41dJzJUrNnzGeg2qCew30UUEZYbidwJefYVTV
nHd4fYSj7K2sZsEJvsk4sNngfXhGTfdy2x4wK1W/GbFT+tB4JtMwr7AAuhXYS0GZ
L9iqbuegETbeDQwMYJ9Xl+hEt0mD/pL5OCQD4FvZDdlv7PP1R4oFtai3wZseaaIB
+a0eyx42vObhJ35CMKQkJcDk+j+8NFUh7eVjHC20IKdGFLoFsgZWBSp05UIfGG3V
o/OBIp3doJHDREnn3SPQZB8ZlNZhuxzLnS3LpV9lBVoGhP8Txnq6kSzMj+w68RV1
N9CaGPZzpMdgX2Ewn1ckkR8jOVcfpA==
=nqIp
-----END PGP SIGNATURE-----

--p4qYPpj5QlsIQJ0K--
