Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF9FFC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C03512184B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554479934;
	bh=/ujAI0kuX6MbKlnCRJSqfOUbAHxk336H5FdchUMBFdk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aVpdnFi9E6fxAygFrMohnqGAyaA+7sq9frsWIAkXrsGpu2tZ/761R9nE2QkmX0rje
	 5vhGCN1LKMwxaaQ8eTaZ3mZns88kHcFVB5kERFrdKktbQpcla41dTpYuFnlWnq9Gio
	 WdHTl+xrya+5YU21q167/wUAx1BxbHwcny3VqApc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731430AbfDEP6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 11:58:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:55356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726135AbfDEP6x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 11:58:53 -0400
Received: from earth.universe (host-091-097-083-087.ewe-ip-backbone.de [91.97.83.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A45712175B;
        Fri,  5 Apr 2019 15:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554479932;
        bh=/ujAI0kuX6MbKlnCRJSqfOUbAHxk336H5FdchUMBFdk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M2ZSOEjEH4eiKEShrjCIw5hwobHM7nWl6K7kHeEwrocG9ZhacjknVyzmAWpOMiEiN
         Ionumne7iliFcloGLC/7DyO3ubOg2RM0r93ykKUI41hI0QoeJNqUa8fFCvVE6yBvox
         CD82Is92aQiCE23qkmunfnVcqbkyRfsQsWFTmcdw=
Received: by earth.universe (Postfix, from userid 1000)
        id A86603C08D5; Fri,  5 Apr 2019 17:58:50 +0200 (CEST)
Date:   Fri, 5 Apr 2019 17:58:50 +0200
From:   sre <sre@kernel.org>
To:     =?utf-8?B?5b2t57qi?= <elicec@foxmail.com>
Cc:     linux-pm <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] power:ds2782:Fix description error
Message-ID: <20190405155850.j3f35qiov7hg5pfo@earth.universe>
References: <tencent_408CB7922C1972D02ACDB8E48E4218092507@qq.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hdhbftm6bszhjotw"
Content-Disposition: inline
In-Reply-To: <tencent_408CB7922C1972D02ACDB8E48E4218092507@qq.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hdhbftm6bszhjotw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 20, 2019 at 04:32:29PM +0800, =E5=BD=AD=E7=BA=A2 wrote:
> After add support for ds2786 battery gas gauge=EF=BC=8Cthe description
> didn't update. fix it.
>=20
> Signed-off-by: HongPeng <elicec@foxmail.com>
> ---

The patch does not apply due to a spelling fix in the description
(Gauage -> Gauge). Also your name in From does not match the name
in the Signed-off-by (SoB) and the one from SoB seems to miss a
space.

-- Sebastian

>  drivers/power/supply/ds2782_battery.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/ds2782_battery.c b/drivers/power/supply=
/ds2782_battery.c
> index a1b7e0592245..924e99d1e69e 100644
> --- a/drivers/power/supply/ds2782_battery.c
> +++ b/drivers/power/supply/ds2782_battery.c
> @@ -471,5 +471,5 @@ static struct i2c_driver ds278x_battery_driver =3D {
>  module_i2c_driver(ds278x_battery_driver);
> =20
>  MODULE_AUTHOR("Ryan Mallon");
> -MODULE_DESCRIPTION("Maxim/Dallas DS2782 Stand-Alone Fuel Gauage IC drive=
r");
> +MODULE_DESCRIPTION("Maxim/Dallas DS2782/DS2786 Stand-Alone Fuel Gauage I=
C driver");
>  MODULE_LICENSE("GPL");
> --=20
> 2.17.1

--hdhbftm6bszhjotw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlynezoACgkQ2O7X88g7
+por0xAAhqSxQkhQqPwnHJq9mNddmBX/H6tS91EL0bhP4jIUTuXnZ9lEzlxdnnbP
IV6GfrDOI89JtwvfxhiWXTMqUrm9XK/A9eTPcin+li98pF05eQ0btM1/kL9b9Soe
KMiwW/ZElYr/oxkwQE+gB+uIdCQA0SpH9x/EPRKLGjSUSntytsyyR4kcnJYy8UW9
Jlg7KGB9e27KZKBnuDBg8XBKttdddVXjcotwupJXP7VnG/Sz1xuvpg03QOtsmB9d
ixL1fbWhbz6FJeg5BZgxLOaLkoz86BH68WjxPVhBqiggZHLvTil0MbIXyaluy/n4
ppDUdb5RKMpq13+EvD7LyxprLWqcanfAklm35Eo6lJ+fL+4M8JMptbMd8IPF2sPG
FIpn4+cGZErsF4j0TO9GQNZG6pnc+/ICbIyNvJLESyX1hOYetM3K81eC3MkAPpMV
AQJRrJMHFPlcJv/d5bXwhOiDlayUpVMlC/BE61TKH6fCfS1yA5i3wYECX7OucM/p
9MIeYO4Gx2UpUi+buCKWfHk6+s1C3UucdThRRZcNah438cp1h40QR1zwEkWcaiby
tRzV27LcCe/yMIUVYQSyIDvdh/R+6MtAAGIJcPyUxs7stZA96T7Q8yO5wQbh+Tsc
XJFhzKR1JZ8hlf+Nz6rViJzm5pCM0KYvlyjDlvVNYRGIC+Euc7w=
=lVby
-----END PGP SIGNATURE-----

--hdhbftm6bszhjotw--
