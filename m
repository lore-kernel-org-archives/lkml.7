Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C6D1C4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 22:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 621CD21479
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 22:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Duz0PvB2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfJFWjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 18:39:44 -0400
Received: from mout.gmx.net ([212.227.17.20]:59337 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbfJFWjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 18:39:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570401534;
        bh=HQioVg0fLiB703pC94Q5CJrHeDjz8YSULyFi62pu9m0=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Duz0PvB2qX4L8giiwuDvx5SsbWVQkb8MNecGicQqT5uyuTsSprcb4szvkk+FyF308
         T8DlnhoKCH/OKa212mngd7IOBBUBNriW+dQD/sJLRXWBvhuZc1HMtk5iSxIdv46jut
         AsHL66iTBj3HOm50gcjLz6rKv8wQRSbpJ9aIRN2E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([109.90.233.87]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTAFb-1ig9bd1brD-00Uabf; Mon, 07
 Oct 2019 00:38:54 +0200
Date:   Mon, 7 Oct 2019 00:38:48 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, manivannan.sadhasivam@linaro.org,
        andrew.smirnov@gmail.com, marex@denx.de, angus@akkea.ca,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, j.neuschaefer@gmx.net,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: Re: [PATCH v2 2/3] ARM: dts: add Netronix E60K02 board common file
Message-ID: <20191006223848.GE19803@latitude>
References: <20190930194332.12246-1-andreas@kemnade.info>
 <20190930194332.12246-3-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BZaMRJmqxGScZ8Mx"
Content-Disposition: inline
In-Reply-To: <20190930194332.12246-3-andreas@kemnade.info>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:J4irto3tAosr7xHmcWxuJ3ndP76ZbpNdsbSVgPvdRBbyvC87GJw
 aihi+iczLukRIoJQMVNUx900ERyIMFo4pEOlHqGD9/GlFKFWHdmSMQMKFuEFr7ab1pSvKaB
 PCTNYdwLfqAYjoUal33EWnA8HpQaRIF9NQk/HqOjZ9Bg8I6iw5rRkIGWpJ0NN0XKfsgS5bT
 jH6ius3PpesaQmI65q7yQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pNfCcJIi9Yg=:jVzGatRezPDUqXoRMuTiCK
 WikGS7YNtIWvBa/qyr/BVMfmnZjb9pRnm60iEVgst2Q0b5BzmrnXuyUb1FvlAF/uWqZYmg1+q
 CFSzTGbf2pYkYlT1qlrqNx7DD9mouXUZ8pzket/2gn2UDWtBNqBvOi7kVvhxFeJRhjGCZzahu
 M5qs7+I2OBeCuhhzkNNVLlJ5TNzhgmGjylo6WKoNC1UaRUTOOxm/+o6lkw5GoaYP6/irlMnqe
 bQK4OzU56aIAiSsIhkQPYSbJEjIupxPhldWu0LS8OKw2TfrXfzJsh6tL2+Tp/gKEfgk+KBvdr
 AsvXWv2AvUioCIfVMqjIzTUJpVoOf47CbJzwomtd6uieXgJIzPM2QXNaSb9vAh/UYpPvX+iHU
 ZBVIE6t1LFOpY/10M8Rl5ImuKyacdAAiXXbArWFyTxkRxndcoXo80p2tCai3HhXcPnIozoTSC
 UzRfgdcAPlVB9B+V4OQFRcXk4/2VVNifgvfYAaq+8u7+C71lxEUnODJ65Bu1p1ZXMdf5/beA3
 iY+MYzm9yM4xBlVpPdpz4Vp3q0ZPfk2ju73GIoKyewH0lH2W60sfAokDffg/UkSabsSnOq64j
 Kg8NLayxxqQAYNMOcyye0jaXw+GoeDkU7lxxxm7TDkKToZviztmG2gDbiL5iLreSroXfH0cZZ
 4vZrHoJZJ8Sj61SpRYdDZJ4MknKH28XRQW5ISijP5O9ZeiOspgabrgEqkML1E9ARcZXo159JY
 G5TlSvYgb33saya+tVqZ9UoRiwsAaIy9q+sZMpGNPLXfgkKYbApfDsGSCO6tz8n72KyXdr+ed
 ozjFUkYXZL6Bk6v03PFNVpYsxf4d5ZBiujCtJJ2MGqibQB3u5s624pxfQQNA1fiA5NKHBUswC
 0JwbFANOUgZhYZdg1w4hKdKtjN1A6KSEiFXKotRwJddHOiiiR/rm4wHqy9Xv8CoRyv7IQWOzw
 LD62IibRULWlTF2hOIjgHabvUAeaCbMAd3d08Fq0q/5fKkP0idx9oEflKmK6QMybjh7k0tF4E
 NNS4FpuHZBTPeZu6amVeiEOxnR5Ww3gsFKkllSVxRMRLTD2MaBHoBH7JIvT/QMKw+1JZAQ73O
 Z7nj7OK8dRans0lONpWYYru7/zGHG58Ws8NFy81e0OAzIOnpI8/izMHzjilLtlB5erIv/W07e
 rvSp08//+XL4Qq8XtRAtSipEneG03z4fF3cMc0DoT+x0Jrq/rwUb45LPXRoWTJXaaWeW0+CgV
 g54ivdND9+lGWgCLeBLfsp/MlwQFrI5mn+yICXlXuWqfDdUlpr3jkeJH/EnI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BZaMRJmqxGScZ8Mx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thanks for CCing me on this patchset. Nice to see more e-book reader
related work!

A few comments and questions below.

On Mon, Sep 30, 2019 at 09:43:31PM +0200, Andreas Kemnade wrote:
> The Netronix board E60K02 can be found some several Ebook-Readers,
> at least the Kobo Clara HD and the Tolino Shine 3. The board
> is equipped with different SoCs requiring different pinmuxes.

Do I understand it correctly that i.MX6SL and i.MX6SLL are pin-
compatible so we can use the same pin numbers and GPIO handles in the
DT?

> +	leds {
> +		compatible =3D "gpio-leds";
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&pinctrl_led>;
> +
> +		GLED {

What does "GLED" mean? It's not obvious to me.
What user-visible purpose does this LED have, or where is it on the
board?

> +			gpios =3D <&gpio5 7 GPIO_ACTIVE_LOW>;
> +			linux,default-trigger =3D "timer";
> +		};
> +	};
> +
> +	memory {
> +		reg =3D <0x80000000 0x80000000>;

2 GiB of memory?

> +			/* Core3_3V3 */

What are these labels (Core3_3V3, Core4_1V2, etc.)?

> +			dcdc2_reg: DCDC2 {
> +				regulator-name =3D "DCDC2";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-max-microvolt =3D <3300000>;
> +					regulator-suspend-min-microvolt =3D <3300000>;
> +				};
> +			};


Thanks,
Jonathan Neusch=C3=A4fer

--BZaMRJmqxGScZ8Mx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAl2abPEACgkQCDBEmo7z
X9uKtxAAzzgCu+n9jH9hNCttJ3lG5alFog0lO+dd69DN/EG3wH4NCQNnkfL0eTUQ
ePZWqAlCuXMrFgJUrL0RDEw926fYD558I9RBtJGI1yPlKq4Qhs0ENpkNI9bOSZyG
s4UI1iLsalte+sGFZwPcTfWv5mgD5FSoLPIQleDaaHvCoRh9+PP7Nn3svxyToGcY
OE7WtpBAwA+gawwKGWZJUxXLMGQKwyg3f8TcFkugLh5VefyiNgTpRcWnilUbZ3mI
uU1hZc4cC/dcoCs0blZZwO24MAIDN/686fwViySRjzKE411dp1XZDz9LqQdr9OLW
NKMyFCSsjhn5TFMPoo6rux88KLBujHPRiu7e+EXSVgYZH4nRsxUqPTxnGzimotrx
1IoN+Dkg+hx5hxVntHrKktH5kvwuN7mKcgGqHNtkQgyhS4dWa+83R0C0E+uEi/ZM
mH+ht5CK/J6BbCXyUans1T+tIs1xL5xYHsw/ZKZtiYIwGrVVMiIbLf/OW+9llrc4
wt0KQkqUudaQj8i6PCihRudCi371QWQbcGholaDqkn4HFEGYRC8pzsCHr7sU6Gdf
J/5fw3n4lQv5H2RBLgzQBqNWB9CkRdJOTTR3Zj95Gaz1HizSWwyk22aoVKdD/f9R
jQ8CI9hIEMXx1iGEmBAltMHzwtfAzlwp9esITOahR7Sd3ZK0Hyc=
=YsCq
-----END PGP SIGNATURE-----

--BZaMRJmqxGScZ8Mx--
