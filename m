Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05202C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 23:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD4012177E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 23:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730851AbfDDXJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 19:09:20 -0400
Received: from sauhun.de ([88.99.104.3]:33492 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730615AbfDDXJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 19:09:20 -0400
Received: from localhost (p5486CF5E.dip0.t-ipconnect.de [84.134.207.94])
        by pokefinder.org (Postfix) with ESMTPSA id E19512C0114;
        Fri,  5 Apr 2019 01:09:16 +0200 (CEST)
Date:   Fri, 5 Apr 2019 01:09:16 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Qii Wang <qii.wang@mediatek.com>
Cc:     linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        leilk.liu@mediatek.com, xinping.qian@mediatek.com,
        liguo.zhang@mediatek.com, robh@kernel.org
Subject: Re: [PATCH RESEND v6 0/6] add i2c support for mt8183
Message-ID: <20190404230916.GA964@kunai>
References: <1554208560-14817-1-git-send-email-qii.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
In-Reply-To: <1554208560-14817-1-git-send-email-qii.wang@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 02, 2019 at 08:35:54PM +0800, Qii Wang wrote:
> This series are based on 5.1-rc1 and the patch
> https://patchwork.kernel.org/patch/10856987/(for dts)
> We provide six patches to support mt8183 IC.
>=20
> Main changes compared to v5:
> --add i2c controller nodes in mt8183.dtsi
> --add a note that old i2c controllers also have I2C_ARB_LOST bit
> --add a flag(ltiming_adjust) to avoid unnecessary settings
> --add Reviewed-by from Rob Herring, Nicolas and Matthias

Well, it seems you missed Rob's Rev-by. No need to resend, I can add it.
I just wonder if Matthias wants to have another look at this?


--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlymjpgACgkQFA3kzBSg
KbY0tA/+MJxfAKLYnkDVA9r9dddlyeI37eVD1M5GLY8LjOg1UGxOmbTv2jFvfwqO
gFuEQiFmtsIPRTPiA/1xLkeM8QxrRPOKacsBcrXLhrobjDiTG8xm/7cSrp1RdDMJ
8yjLIr/4YihJ7HLGEGygrRqSfFnY5VuTfoXyCjAwWWvgkkx+4h8uN/eKesGWTHZO
1P2jTTTldpDZoYY6QTZ++x00oSJ+9VxJCs7a1ZtVEHBKDQAUtE1OTnbZy6TOWjm9
FifVc+YCHcmQo8eEKsHudqOqFg9bUeCAr4eM01rP7EU5eJrF2nsl8JYgmqDhiDvd
6K1rlRdtmF34oi5WnlWt6q0GtdnNUfaZgXRw3ct7U+USc9O47zyjQpVj2cLYTECv
/49D37usj+bx7VajndEyaSMAXxInwFk5Rn0BJYQIOkvvdj/MMDI2z3bHZkHJXUjl
3JpR4GYR/3j01Smoa+iL/exOjWO1QCf8ew/P49LE1K5+AoXxWQmk/jO175Z3sC7k
DqXKn2oKohT+ZwxzO4RdjQxtcItlMx38qswxzUlLiVwM8qZIx5SkSD//VFDc+FO5
RE1hSAVGQ9kWNdX/HQ9HtEryMsMzX2iZNBUh77BHJ3lJIi3L8qy9yQ93I/wehaym
jIxklKE1d/6823idNwK2rFOLbRRjjE/r6JsOmPANHbYZBFNyPO0=
=jqBi
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
