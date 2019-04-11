Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D764C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 06:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8ACE2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 06:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfDKGjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 02:39:02 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:47677 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbfDKGjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 02:39:02 -0400
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <mkl@pengutronix.de>)
        id 1hETMO-0002hY-Vg; Thu, 11 Apr 2019 08:38:57 +0200
Received: from [IPv6:2a03:f580:87bc:d400:61a6:cf3c:f77c:6bd5] (unknown [IPv6:2a03:f580:87bc:d400:61a6:cf3c:f77c:6bd5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 1479A3F9BE4;
        Thu, 11 Apr 2019 06:38:54 +0000 (UTC)
To:     Joakim Zhang <qiangqing.zhang@nxp.com>,
        "wg@grandegger.com" <wg@grandegger.com>,
        "davem@davemloft.net" <davem@davemloft.net>
Cc:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190410062533.31535-1-qiangqing.zhang@nxp.com>
 <39d8ef33-50c3-9b7a-88e1-8ef3a7fbac70@pengutronix.de>
 <DB7PR04MB4618D14BE595F3BDE46CBE17E62E0@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <ad4c0921-3275-b466-95b4-a63944d5b71f@pengutronix.de>
 <DB7PR04MB4618D30C746B397F8C5308BAE62F0@DB7PR04MB4618.eurprd04.prod.outlook.com>
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Openpgp: preference=signencrypt
Autocrypt: addr=mkl@pengutronix.de; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [EXT] Re: [PATCH] can: dev: clean up CAN ctrlmode when close CAN
 device
Message-ID: <35c15351-5ae1-0826-1b05-95fe53272244@pengutronix.de>
Date:   Thu, 11 Apr 2019 08:38:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <DB7PR04MB4618D30C746B397F8C5308BAE62F0@DB7PR04MB4618.eurprd04.prod.outlook.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Mw8JsGkOUkVm7EENA0gbDYPdtFyBtXOT4"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Mw8JsGkOUkVm7EENA0gbDYPdtFyBtXOT4
Content-Type: multipart/mixed; boundary="PblQydVdEdfzsawluoFlTtk65ZIlGeMdZ";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Joakim Zhang <qiangqing.zhang@nxp.com>,
 "wg@grandegger.com" <wg@grandegger.com>,
 "davem@davemloft.net" <davem@davemloft.net>
Cc: dl-linux-imx <linux-imx@nxp.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <35c15351-5ae1-0826-1b05-95fe53272244@pengutronix.de>
Subject: Re: [EXT] Re: [PATCH] can: dev: clean up CAN ctrlmode when close CAN
 device
References: <20190410062533.31535-1-qiangqing.zhang@nxp.com>
 <39d8ef33-50c3-9b7a-88e1-8ef3a7fbac70@pengutronix.de>
 <DB7PR04MB4618D14BE595F3BDE46CBE17E62E0@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <ad4c0921-3275-b466-95b4-a63944d5b71f@pengutronix.de>
 <DB7PR04MB4618D30C746B397F8C5308BAE62F0@DB7PR04MB4618.eurprd04.prod.outlook.com>
In-Reply-To: <DB7PR04MB4618D30C746B397F8C5308BAE62F0@DB7PR04MB4618.eurprd04.prod.outlook.com>

--PblQydVdEdfzsawluoFlTtk65ZIlGeMdZ
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 4/11/19 3:16 AM, Joakim Zhang wrote:
>> Whatever mode you enable via user space use user space to disable them=

>> again.
>=20
> Thank you for your detailed explanation. But in flexcan driver, it
> just set register bit when mode on and do not clear register bit when
> mode off, e.g. loopback, listennoly, 3 samples....

Let's see:

> 	reg =3D priv->read(&regs->ctrl);

The ctrl reg is read

> 	reg &=3D ~(FLEXCAN_CTRL_PRESDIV(0xff) |
> 		 FLEXCAN_CTRL_RJW(0x3) |
> 		 FLEXCAN_CTRL_PSEG1(0x7) |
> 		 FLEXCAN_CTRL_PSEG2(0x7) |
> 		 FLEXCAN_CTRL_PROPSEG(0x7) |
> 		 FLEXCAN_CTRL_LPB |
> 		 FLEXCAN_CTRL_SMP |
> 		 FLEXCAN_CTRL_LOM);

=2E...the loopback mode, 3 sample mode and listen only mode bits are
masked out....

> 	reg |=3D FLEXCAN_CTRL_PRESDIV(bt->brp - 1) |
> 		FLEXCAN_CTRL_PSEG1(bt->phase_seg1 - 1) |
> 		FLEXCAN_CTRL_PSEG2(bt->phase_seg2 - 1) |
> 		FLEXCAN_CTRL_RJW(bt->sjw - 1) |
> 		FLEXCAN_CTRL_PROPSEG(bt->prop_seg - 1);
>=20
> 	if (priv->can.ctrlmode & CAN_CTRLMODE_LOOPBACK)
> 		reg |=3D FLEXCAN_CTRL_LPB;
> 	if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
> 		reg |=3D FLEXCAN_CTRL_LOM;
> 	if (priv->can.ctrlmode & CAN_CTRLMODE_3_SAMPLES)
> 		reg |=3D FLEXCAN_CTRL_SMP;

=2E..and the bits are set, if enabled by user space...

> 	netdev_dbg(dev, "writing ctrl=3D0x%08x\n", reg);
> 	priv->write(reg, &regs->ctrl);

=2E..and written to the register.

So all three bits will be unset, if unset by user space, right?

> When we configure mode off after configured mode on in the user
> space, corresponding bit will not change. Is this should be improved
> in flexcan driver?

That should work. If it doesn't work, we need a fix.

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--PblQydVdEdfzsawluoFlTtk65ZIlGeMdZ--

--Mw8JsGkOUkVm7EENA0gbDYPdtFyBtXOT4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAlyu4PUACgkQWsYho5Hk
nSAM/wf/VLZ2Jptfd/XQecKar70GhTJJOm1fXo1LU35G1IKeOiTOlbWZYOxXiro8
V79OzEcXezHtGJ6uoPyKfWf4uksZ3EQ+6W21TFecZFID9vAU/rsH7mKhc2I8Zd0N
gI0k7GyzErFFFdGFDBju2RtIodeUp8Ql3O6vsSwmHko5Hh7fy8Tr8dpN8sLCWtUN
8nOPmwu6++HAvQWOVBg170Js6FcQzHZGlQBFZu+xVWqRaEgRfEtG8fjqHQueI0Ka
/eQJltcp6wE8HVQbMxBKj0GTTP24Vwzaxm4Ol1K3BO5toyjaD2opRtgRB1OBXrHS
b2SyoEIzcBPk7RmbOs8qWRbKg96ikA==
=gOIv
-----END PGP SIGNATURE-----

--Mw8JsGkOUkVm7EENA0gbDYPdtFyBtXOT4--
