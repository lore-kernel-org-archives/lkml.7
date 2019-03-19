Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA389C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96D722085A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="KMg2Vr0E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbfCSO2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 10:28:12 -0400
Received: from mout.gmx.net ([212.227.17.22]:60895 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726464AbfCSO2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 10:28:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1553005677;
        bh=GpKhyNZHh9r2oti6hSPlwZoSP0iSE6X9TUFiAHIc0pg=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=KMg2Vr0ErLvsfkN5igRvz0BMXRY25cH5AWmkNx7MBaL39qWjMVEq+/9kNCOoEBBst
         D2k9gePe5duMiEdSosTnzHLfxWIz0KOe5R7gqX+Guf0MCxAl7BkMcgx8wi+EwicfFg
         4Qt5xiegwsPMV5GpkHIQPdZ41RF4j7Dx1BJpOsIo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MOfQw-1h3U2F1d26-006AuI; Tue, 19
 Mar 2019 15:27:57 +0100
Date:   Tue, 19 Mar 2019 15:27:56 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Aisheng Dong <aisheng.dong@nxp.com>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND] clk: imx5: Fix i.MX50 clock registers
Message-ID: <20190319142756.GB2095@latitude>
References: <20190318231737.8459-1-j.neuschaefer@gmx.net>
 <AM0PR04MB4211990282677EEB9D3928F380400@AM0PR04MB4211.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
In-Reply-To: <AM0PR04MB4211990282677EEB9D3928F380400@AM0PR04MB4211.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:Afddk5EVnUg+UEmQLpuJcfmgNL6+s0vwGh4zIVr1PwYfC6w0jsQ
 XwL++yWyYpYe698Fh8uo5vlZU29+OTNA3ikhfZrf3rU2i2uNIC0sBPKlYaKyJMYwTAwliAJ
 XSvqjp9ER867z51tKOsStNpyhB7GgNg89eQXqQMtVxMeesX03lpBvW9uBeKKFpAymUUKvAM
 caldUZxnx3JCluZf81xQg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:u8kzpImXitQ=:RIgBfYE12QG3uSmUZRuhjT
 Ah49NJSQ0bky/TyNcP+wwp3WnsGRQrID00ON2Im1XCYen5btFHPLaI/6uNJ8t4JpQHGwEaGR0
 uSmVcxrznJijdCoW61lJLE8ZDloM+U6DWK+hqFtbIgwNQ8+uaml3PM0p+ghk4sab67xfchAfu
 y+KXh2Z+sqHvkYpx2r3Wd4Ef2P12WgGrseeOQX2LyOPwtRIPM+3CwFVKWlu7+mws09U4Tu8XP
 iiIn+sl//jDSTqIc2JSxFuKaP5XzURSukQQuNpA3aJ6O7+cUwtorSo/C/1EjqKtRmwXwnVg2m
 HttaO+2GKadPnXiY0/AUlv7e5tBh/di+QDwnCRW8HZAWvdZyYxE53V1Z5KBmLCul6NLQF7mg/
 w2HPxVm5ZVcPYr39i8NTVAPyhskTBu7oyXwEpBBXD9ReTHs/qT5UnwFnnJVc9j5A0S4+YJCNh
 I+5ms7iALQqfGrQzXP6gY4tLV/2VbT3XviFOd7ObTXFFyAh4Yyr6IZjDD7NyP3/C5dNlwmdVZ
 k1ON55nAWPGOmoKU8a7vS9+xfzDRvjL7aIB/A2kCgeKB4lTe7X1juXzDLl/bh2P/Zz272j+Xm
 2AXiTJ/M6IuJbONVHydbjO9TfIAGxeFThAjBGGIpJXkAjt7/GX1yNgj0RLOwI+MGYsiNx91Sw
 3tNqNsH1AR4DPMbqQ8hBigwQqk15wb9G9nmx+D8yPvGZtnytMusBqgPpeIuIfejb1XaCCp/IK
 haQ9NlEug8tZeRzvcqwYivv4A3hRXpSKMeUHjHcMXv8r7Sfdy0gT3mu8tsnfIL89fGty+LRst
 YN/nHxyWzBBox6MkJQbsTma3tOBtYtJPtQUXFPCchmKXEbCuOzF9mwZBPggL/x0czub06jLOk
 i9fFgPmJmyA0UP/7nVmLTsHIRuQ/MVuNkhnyP53zNZBLSSDbjiutLmzJN3EP/Z
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2019 at 02:16:51PM +0000, Aisheng Dong wrote:
> > From: Jonathan Neusch=C3=A4fer [mailto:j.neuschaefer@gmx.net]
> >=20
> > There are a few differences between the i.MX50 clock tree and those of
> > i.MX51 and i.MX53 that are not yet handled in clk-imx51-imx53.c.
> > This patch handles the following differences:
> >=20
> > - i.MX50 does not have a periph_apm clock. Instead, the main bus clock
> >   (a.k.a. periph_clk) comes directly from a MUX between pll1_sw,
> >   pll2_sw, pll3_sw, and lp_apm.
> > - The MUX bits for esdhc_{a,c,d}_sel are shifted by one bit within
> >   CSCMR1.
> >=20
>=20
> Can you please split them into two patches?
> Otherwise, the fix seems good to me.

Ok, I'll do that.


Jonathan Neusch=C3=A4fer

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAlyQ/GQACgkQCDBEmo7z
X9uhphAAgBpoUw6ho6BKXRsGJUf7dmdmUVAfxuYnaY9XohdkWqEovb/8VfB57U5x
+OEFkqkXO8FHHmgRqml+zb/+TkqDOATSRLX+beaeiEFmVEWeU2z9+iDk0aS5O0vg
MoiHQgmHuI3ZNglfd9Yr5VX/+AxkY+Y6DEd6lSu5P/sKjdLNwH3OGilCooRqEgTZ
Vfh1MX/MH1atmHsyw7cdqpQ3MKafCHJEimvfv6G3YlGQ7wq5+1ydybvEJL/Tu5gF
QMtQZ3nnLCRq8AG4egqzWpMSVJZZJDjjPyEtUSZ9fw9JFYa9ZmKPGhI+/Ca7aWp3
tUsIGTCXUpBHhtw6gZ8kwrId9gbk/aIzALwJW23Gy1a1BoQ66xWNSZ+LWOEBQgjE
WQOG4cE3SCA5Eifh4YsFUS5SckXJ2MDd1YP6pGOITU3RvLSlysxgLtC6ON666cMD
5nbTX9vrK4xwYA+uGS3ufoOPFtLlEY/r2Wsi5ljILgGqNLl9OT2X2/7d5GCDQPE6
IwPW2uUZ5UKExrtUKN1yhLIuRThcZBw4bRxBShTFBm4bKOW9ykr55HHaTfFX3BRi
T7fbTCGLJer7Z7CGlMaf6zVFNie4UAQXRPcORq8ucp+ceBNh00e/is1OgZXBYnrs
jrpHWEh+Sd/SwWV+pW0omucjPMdX5GSQbP67x4rNA8Ln8OJC4v0=
=UGky
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
