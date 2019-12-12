Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C4C3C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 10:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1861F214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 10:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbfLLK5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 05:57:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:33752 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728834AbfLLK5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 05:57:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D787CAFDF;
        Thu, 12 Dec 2019 10:57:34 +0000 (UTC)
Message-ID: <099cb6558e9a10c1fce73e34484c0eaf21293e61.camel@suse.de>
Subject: Re: [PATCH for-5.6 2/4] staging: bcm2835-audio: Use managed buffer
 allocation
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Takashi Iwai <tiwai@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Date:   Thu, 12 Dec 2019 11:57:33 +0100
In-Reply-To: <20191210141356.18074-3-tiwai@suse.de>
References: <20191210141356.18074-1-tiwai@suse.de>
         <20191210141356.18074-3-tiwai@suse.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-KDe450wmkzJFlREF+n28"
User-Agent: Evolution 3.34.2 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-KDe450wmkzJFlREF+n28
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-12-10 at 15:13 +0100, Takashi Iwai wrote:
> Clean up the driver with the new managed buffer allocation API.
> The hw_params and hw_free callbacks became superfluous and dropped.
>=20
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Thanks!


--=-KDe450wmkzJFlREF+n28
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl3yHR0ACgkQlfZmHno8
x/7T1wf9HqdO2587apiYerHZt0Jf/EfpHtnps8r5NNLydl8BXf/nNo9Nnfb7E6vE
tamYcG/rVIzfWZ2aBeIaG1jxrfKwZFrTy8T+djPw4Y94x8HTLf7S+qhJs+ppzFHo
wAF3hzz25fUWCG0z1q2bEQXm4qmc5Irhdy/o9rESwdVF5Z3w+1XGo3J9HIDj4bKw
bKl63amT+yioLN4/cetU9IkEm2TUqKwR3qlH0TZz0EvCiXoOGR2t5kzT92YrROJL
Rxw/PyZ7gqJ4DM6fQ6aWUzo+/p82ASRfrfi0456846zQVShb7zYNAud7fODTsELR
aIt52MtSc3sl2zjH+jbV+U3hRV8Vkw==
=acj8
-----END PGP SIGNATURE-----

--=-KDe450wmkzJFlREF+n28--

