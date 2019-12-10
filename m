Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124E1C2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 19:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEAC320828
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 19:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576005614;
	bh=2k/H8iAqani1y/YBaVi3wfqUka//EYa/Ou3poqmsegQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=h25PqXD3Jd0wvevSHQIP2/8+DqxO5RLLszGj+eBnaYFUzWPjtdxO+T5L6vAB1TQ3U
	 w8vRPNBDimIJP6xWCi+BuTZnu+3B1FKAHFcKBhv8uzW09QvcSTPSOJEWn3Y11dWJns
	 oDWZO40HKO2W02HSjYQl9Y08rPMrxgwwKu90n8L8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfLJTUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 14:20:13 -0500
Received: from foss.arm.com ([217.140.110.172]:54368 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbfLJTUN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 14:20:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DED39328;
        Tue, 10 Dec 2019 11:20:12 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 59FB83F6CF;
        Tue, 10 Dec 2019 11:20:12 -0800 (PST)
Date:   Tue, 10 Dec 2019 19:20:10 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        kbuild test robot <lkp@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 1/2] spi: fsl: don't map irq during probe
Message-ID: <20191210192010.GK6110@sirena.org.uk>
References: <1cdd0a26d7e1545f32c8bc4dc7458ebecdd6aaed.1575990944.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HcXnUX77nabWBLF4"
Content-Disposition: inline
In-Reply-To: <1cdd0a26d7e1545f32c8bc4dc7458ebecdd6aaed.1575990944.git.christophe.leroy@c-s.fr>
X-Cookie: We have ears, earther...FOUR OF THEM!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HcXnUX77nabWBLF4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 10, 2019 at 03:17:15PM +0000, Christophe Leroy wrote:
> With lastest kernel, the following warning is observed at startup:

Please do not submit new versions of already applied patches, please
submit incremental updates to the existing code.  Modifying existing
commits creates problems for other users building on top of those
commits so it's best practice to only change pubished git commits if
absolutely essential.

--HcXnUX77nabWBLF4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3v7+oACgkQJNaLcl1U
h9COMAf/atE1JYdFEaDVfUE6vUZQPvvELAUglONPvpzbC2FySvV79fZw5WQj1B1d
bJA23l3E1GBhegHF1bWLzSYE8WtQCrgr9Jh+TNamNySK/Ob/k2xBwubsuJEWg6rF
iV4ELtr7vBD+yqCH/a7QJ4O7HQcqYjpUTezWpUDZw/6Yn5nd3CtPyFgrCmaR4Eiu
IB1pYoLnYJTJnJClH8JGLs25ezTXpigIeEZ4pcuAW2Sk4kC3R1GwdWK8BMI4cEur
mCN9zWv7+09q1JLnvkc7lqwJA1vFwdPKgeSXhBGf9P37GpPH2hnqDnY8bdFTgXIO
khEdKooQ1FU1cNpViuHqHNORPRR21g==
=cg4Q
-----END PGP SIGNATURE-----

--HcXnUX77nabWBLF4--
