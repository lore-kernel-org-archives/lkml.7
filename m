Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12083C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFFFF2084D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="GO8efw/t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389178AbfCAQnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 11:43:16 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:39996 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728517AbfCAQnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 11:43:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=e3cqRxxvKi9HlAZWtoJNjQ7NyDmW1rwXBuDYgIjRaH4=; b=GO8efw/tue5jU7+SjKmYRQKdO
        813haTRrud4KS1TCBdtEh1J3hMf5cdaq9JHf7B+fMJVM2RhP2x3db9OJ4cAxnsYdyIh6nQJgdcHqa
        nWfLwTHdelgpn5fcfMiPZPr9z5XJa6RUon+XZHkEHPsu5DmpZk0xlb4DvN2u73NcAmkRY=;
Received: from p5dcc388f.dip0.t-ipconnect.de ([93.204.56.143] helo=aktux)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gzlFV-0000LO-Qy; Fri, 01 Mar 2019 17:43:01 +0100
Date:   Fri, 1 Mar 2019 17:42:49 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: sun8i: h3: bluetooth for Banana Pi M2 Zero board
Message-ID: <20190301174249.59cd960d@aktux>
In-Reply-To: <20190301143632.kzlr4jphq3rceos6@flea>
References: <20190228212840.24964-1-andreas@kemnade.info>
        <20190301143632.kzlr4jphq3rceos6@flea>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/0aemLcy6RyPSQCs9We_xvOu"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/0aemLcy6RyPSQCs9We_xvOu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 1 Mar 2019 15:36:32 +0100
Maxime Ripard <maxime.ripard@bootlin.com> wrote:

> Hi,
>=20
> Thanks for your patch
>=20
> On Thu, Feb 28, 2019 at 10:28:40PM +0100, Andreas Kemnade wrote:
> > The Banana Pi M2 Zero board has an AP6212 BT+Wifi combo chip
> > with broadcom internals attached to UART1 and some gpios.
> > This addition is in line with similar boards
> >=20
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---
> >  .../boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts    | 29 ++++++++++++++=
++++++++
> >  1 file changed, 29 insertions(+)
> >=20
> > diff --git a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts b/arc=
h/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
> > index 1db2541135a7..39e206fac4e3 100644
> > --- a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
> > +++ b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
> > @@ -69,6 +69,8 @@
> >  		compatible =3D "mmc-pwrseq-simple";
> >  		pinctrl-names =3D "default";
> >  		reset-gpios =3D <&r_pio 0 7 GPIO_ACTIVE_LOW>; /* PL7 */
> > +		clocks =3D <&rtc 1>;
> > +		clock-names =3D "ext_clock";
> >  	};
> >  };
> > =20
> > @@ -122,7 +124,34 @@
> >  &uart1 {
> >  	pinctrl-names =3D "default";
> >  	pinctrl-0 =3D <&uart1_pins>, <&uart1_rts_cts_pins>;
> > +	uart-has-rtscts;
> >  	status =3D "okay";
> > +
> > +	bluetooth {
> > +		compatible =3D "brcm,bcm43438-bt";
> > +		pinctrl-names =3D "default";
> > +		pinctrl-0 =3D <&bt_pins_out>, <&bt_pins_in>;
> > +		clocks =3D <&rtc 1>;
> > +		clock-names =3D "lpo";
> > +		vbat-supply =3D <&reg_vcc3v3>;
> > +		vddio-supply =3D <&reg_vcc3v3>;
> > +		device-wakeup-gpios =3D <&pio 6 13 GPIO_ACTIVE_HIGH>; /* PG13 */
> > +		host-wakeup-gpios =3D <&pio 6 11 GPIO_ACTIVE_HIGH>; /* PG11 */
> > +		shutdown-gpios =3D <&pio 6 12 GPIO_ACTIVE_HIGH>; /* PG12 */
> > +	};
> > +
> > +};
> > +
> > +&pio {
> > +	bt_pins_out: bt_out {
> > +		pins =3D "PG12", "PG13";
> > +		function =3D "gpio_out";
> > +	};
> > +
> > +	bt_pins_in: bt_in {
> > +		pins =3D "PG11";
> > +		function =3D "gpio_in";
> > +	}; =20
>=20
> You don't need any of those pinctrl nodes, GPIOs work fine without.
>=20
ok, that makes things easier. I will resend a v2 without them.

Regards,
Andreas

--Sig_/0aemLcy6RyPSQCs9We_xvOu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAlx5YQkACgkQfb1qx03i
kyRfcxAAocObObjJgz3viX72ozjLYYWEsJ61fw6JUaBdH87Lh/gelf1uj+oVDKgH
LMD7njYsISPqfDmfNwtkwIYu0/NTXqgEOd0WJSEIS4RvTSfTichIx3LpsuVxBdEU
jw8xDa1f8SfgxMHoFcMxkzBXzcrxIqGELHy66n+NCj+e68vp1YZghFUbwmWbB0Qs
Z0KWywIP0rTKRSwzPFS5py2f+EHuXiajwiAdirBnwaz4VDqSRtX/ysqPif7LQtyP
43INhJqI56FpbO2Jrj0ZvgMyopYIbyFD5V8iEGs+u3T9vwwtIYi0MAbIG8bCn8sz
rTLjE8mb4IYqSZTCUIFiDH+fc5xcGz7kGPg2i3r/UC2TJ/rGkgH/WGk1VOH13GxT
DJlRL3dxS/xo/p+HcOGSdP9QL/GftSzq+s8ik1jlv35KDcNkryQgxjPBsjlwPH6D
YBpVnCgn8oYdHBJlzxZ/XgnlViJ8Q8cS+NJbAjtmR7GbLShYz7WicfTtc1HpPOr8
d9zBCadzvlrlHTuaZIonIw0agfeUa1+D16WzbXZ0drC/Xb29z3w03SfCwk/EhkRN
LeJyNAsmbKMSDj5oC+ORA2Kd+tCMX8k75Xh7yLpXjeR32VwyhUYWQNuOkk0lVU9M
2+BVRs6eq9e8x/JP+1vVB4iGcGWYXppdH171yd3XR5cUpva48vE=
=jpDM
-----END PGP SIGNATURE-----

--Sig_/0aemLcy6RyPSQCs9We_xvOu--
