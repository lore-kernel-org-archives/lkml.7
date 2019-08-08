Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF96C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 18:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E338E217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 18:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="TV/968eA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390179AbfHHSjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 14:39:40 -0400
Received: from mout.gmx.net ([212.227.15.18]:49593 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbfHHSjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 14:39:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565289574;
        bh=dGpkAMtNoDqZDa62BxxMC+N7AToenRiNkGltehKgUbo=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=TV/968eAT82gq65z+zwF7s8khtXqjIa89WdeH9QNm45glqhDomOVjkNxApY1d4JsT
         Rzw5L570mRa//mMcJWkipW75qELkXI5UBxlEfOK+uoiYH+++Pkx5yIUnYt6UtC1Yni
         IKTq9gcAkkoi7UJimVQ75NEpOf87i37zTofpbaTU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([109.90.233.87]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MUoiS-1hnzo13sFQ-00YCm1; Thu, 08
 Aug 2019 20:39:34 +0200
Date:   Thu, 8 Aug 2019 20:39:24 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mfd: rn5t618: Document optional property
 system-power-controller
Message-ID: <20190808183924.GB1966@latitude>
References: <20190129135917.29521-1-j.neuschaefer@gmx.net>
 <20190201092411.GG783@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ftEhullJWpWg/VHq"
Content-Disposition: inline
In-Reply-To: <20190201092411.GG783@dell>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:UjmVhOwYxfTuMNi/1a/JFrncIqEzSeLdJ3cSQi8tXhDD4v/X9z+
 K2kM6jPdFh6Yo+tF3oIjy4adnxjako9At3/c5h4LALZli1pE2kLEPbqrZ4WqXIbCXjDSmG2
 MPeHZrHpLVU3Rv4vEsfcJnATFpq0bLKjJfer35e6moDxjGS+DyWc587eWeSnOvil9VAT2c/
 Baas2YlAaaw+6LYzX5vTg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EiXht/wTFac=:XkMMK69RgaTsYZqvxxjhK/
 Al9pzKUVL3/xdQGP5cUODLK7702G2MSfdsj9iEU8LfKV46xu2uacrvAWs86OBFJK4zmmXz+dy
 je7g8Oosst/sSS87mqPxasUNzE/AQ8WofTOQHObVUGP17bkwYPK1vwcohc/GGqYH/S1xBN3wJ
 AGXRAKkx0j5uowuq2/uHMPh5tEsF9zxWEW9iHD3CcTIQ9wyHvU4q+LA6QbyKq47JkaDWpNbtM
 nho7DOMuyTBLvn3cQUCBze3eb0h4kf7kCfibRlLo1ItadGJGXHLxvtm3CR2nAd+2ZWrb5kvaH
 g1RuMh1qabvbOlLElolK2us6RMdk0CgqRQYCNG4OWLmS+GlLZ8imUWnudqIHDhclYfNSGhSpW
 RwmDoWSd2SWsutw2wraIGbaGokQrRNQEV0Fpc06WwVvewXv9+yyc7V8VlwvFL2vXCx0CU+wkz
 UjvEF7DbeA800tJ/FgNfyjSI37TP9BUglDs7XO5VqVfuDhmugemMyBKEdkyKVr7OghxnLZVcV
 EFOuRQmk2EeN2arp0hHLXHmkVvYLNP3BC0Pm2bSnjqNhvLajJJc3YlA38yT8dp4o4F8ljwRbT
 cFUfme6fVl12WxwSln7YjAbMDiqgtZ7x5MkZZe1ceoStclO5qFtOuwDiayfvhBmndpKY2JHMU
 WFICUu9/9c6dRc4FmALZQD7bCt2l5RVwZ9l1uWNiHhMEhg1DJ0Bn8lrEFrlM+uo1LtqPf2pSa
 +B5oPiEu5ZkaSCeXRf2cU1zgooTEK/y+IlpcYC1OpolaprXToMt4jU1SSY1Z34Ai1Erqshkff
 PGN+JTJZYKH2byPmAAZUon2rvCneaMG2mG2CmqSNrO47MbvhnfmzZShF4LBAhQXorKr4AkAPr
 53onThJU3E/TSPBzvXHpstfd8HwzCsMpSRI4Av92LMn4ITku8T/x+VCUxI5LZZffZ4QtBcqHD
 P2cpip2ZusBfb6Hg70Z809yWJ/uXMsoP0wJZGigA0QrdAK750IsUZSqvHCE3MD92wDnWMDCUD
 58RJEDLQbw23sDmca6X1OMMZh8iyG/hkw8iGUJoy87yuxD1pZOaAnGTi82CuHDPFeqpgSonbs
 K5tM3ZorHz+dMkYXcy5ku3WCyzAAF4oYWZyYxaixv3/fD7mAp8BW1eGOw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ftEhullJWpWg/VHq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 01, 2019 at 09:24:11AM +0000, Lee Jones wrote:
> On Tue, 29 Jan 2019, Jonathan Neusch=C3=A4fer wrote:
>=20
> > The RN5T618 family of PMICs can be used as system management
> > controllers, in which case they handle poweroff and restart. Document
> > this capability by referring to the corresponding generic DT binding.
> >=20
> > Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> > ---
> >  Documentation/devicetree/bindings/mfd/rn5t618.txt | 5 +++++
> >  1 file changed, 5 insertions(+)
>=20
> Applied, thanks.

Hi,

apparently this patch got lost somehow (I can't find it in mainline or
-next). Should I resend it?


Thanks
Jonathan Neusch=C3=A4fer

--ftEhullJWpWg/VHq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAl1MbFMACgkQCDBEmo7z
X9teow/7BstSO97Sl8F6BD6eFHTwI0a/YAhcZlXYyQ11Rvt/a9JFhEE+b9oDaFuc
MaLE3wXSEcx1Ssh8xPhrUzpPsQ8MWV83f1roR6jU0lwUYkjdWm4Far8BSUi5ilmz
BVPeBOlWgRwoyMEjMojIfYLuvhFm2iBvTNbRyU99h7tMF99n4kor07zu/zaQY+fX
8hH1/o4TY19vMgMIK/OQjNAYJHQBoJbX/RrICvBq/QB74nxv/XmgICv2eoI1Tkup
Jf/A6IuTdlhUjGxn1UYwKFfsilMYrLMHYb2l7Zsb6sVYlly3vZjrgBwHsmQWQaYQ
9aKqaK2x3rb1GMfYKhMIHh+4vN2qjJJZeNHn34ut3CHGVhkI08o2lPk5d3DdeHFC
ctl6EoCtb9cGpDBUQKdwZc838tB9Tt5Qdn3ixNknpc17M2rhi/XqxJgjwRmOOC2M
dl2rEh2Ryk4f0mkII5Eo9MoPXimv1fB+rTY5LUFFa91n1rBRYSD6Ko+TvHIpNQDG
Beyx3ol41HSnSqYrfscl2plPZimIQq53bHfKaRQq094Ph/YqIRPtte1jZo/qRnns
6LOF3YBGt7M07VKtSjUKm4zM6mFj2oxD7YE1T/9jq05bxwFSFp5oi+3wmRJ+oENx
f2Ul03iVlXXLBR+W1igbzv09+KAiMeFc8zmkxZ+tKvTLOXNAm5Q=
=nKs6
-----END PGP SIGNATURE-----

--ftEhullJWpWg/VHq--
