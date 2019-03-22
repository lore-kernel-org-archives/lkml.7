Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C7BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 07:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94DF821904
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 07:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfCVHvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 03:51:10 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:44619 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfCVHvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 03:51:09 -0400
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <mkl@pengutronix.de>)
        id 1h7ExH-0000pv-4H; Fri, 22 Mar 2019 08:51:07 +0100
Subject: Re: [PATCH] can: flexcan: bump FLEXCAN_TIMEOUT_US to 250
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Wolfgang Grandegger <wg@grandegger.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Thomas Winding <twi@deif.com>, Fabio Estevam <festevam@gmail.com>,
        Per Christensen <pnc@deif.com>,
        Rasmus Villemoes <Rasmus.Villemoes@prevas.se>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
References: <20190307150024.23628-1-rasmus.villemoes@prevas.dk>
 <a418bbc9-186c-174a-20d8-18cedeaf0089@pengutronix.de>
 <5615c217-8ba6-e452-1aaa-1e3b32eb4cca@prevas.dk>
 <f1fb86fb-1b6b-1860-899d-820d4bc672cf@pengutronix.de>
 <4471c611-1a58-6365-2ab6-1b39c310265a@prevas.dk>
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Openpgp: preference=signencrypt
Autocrypt: addr=mkl@pengutronix.de; prefer-encrypt=mutual; keydata=
 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
Message-ID: <b03e9868-3070-ce35-3477-3119d691baec@pengutronix.de>
Date:   Fri, 22 Mar 2019 08:51:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <4471c611-1a58-6365-2ab6-1b39c310265a@prevas.dk>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="QbbbVd1nuxKJvHpv6YDGgJ6Eaco6CAzRK"
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QbbbVd1nuxKJvHpv6YDGgJ6Eaco6CAzRK
Content-Type: multipart/mixed; boundary="RwniMHbQrYgPxVol7aNT12neuXKAdjjzW";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Wolfgang Grandegger <wg@grandegger.com>,
 "David S. Miller" <davem@davemloft.net>
Cc: Thomas Winding <twi@deif.com>, Fabio Estevam <festevam@gmail.com>,
 Per Christensen <pnc@deif.com>, Rasmus Villemoes
 <Rasmus.Villemoes@prevas.se>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Joakim Zhang <qiangqing.zhang@nxp.com>
Message-ID: <b03e9868-3070-ce35-3477-3119d691baec@pengutronix.de>
Subject: Re: [PATCH] can: flexcan: bump FLEXCAN_TIMEOUT_US to 250
References: <20190307150024.23628-1-rasmus.villemoes@prevas.dk>
 <a418bbc9-186c-174a-20d8-18cedeaf0089@pengutronix.de>
 <5615c217-8ba6-e452-1aaa-1e3b32eb4cca@prevas.dk>
 <f1fb86fb-1b6b-1860-899d-820d4bc672cf@pengutronix.de>
 <4471c611-1a58-6365-2ab6-1b39c310265a@prevas.dk>
In-Reply-To: <4471c611-1a58-6365-2ab6-1b39c310265a@prevas.dk>

--RwniMHbQrYgPxVol7aNT12neuXKAdjjzW
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 3/22/19 8:45 AM, Rasmus Villemoes wrote:
> On 21/03/2019 16.30, Marc Kleine-Budde wrote:
>> On 3/21/19 3:34 PM, Rasmus Villemoes wrote:
>>> On 20/03/2019 14.18, Marc Kleine-Budde wrote:
>>>> On 3/7/19 4:00 PM, Rasmus Villemoes wrote:
>>>>> While trying to add support for the Flexcan modules on the MPC8309,=

>>>>> I'm hitting ETIMEDOUT in flexcan_chip_disable(). With this, probing=

>>>>> succeeds. Checking the leftover value of timeout with a primitive
>>>>>
>>>>>   pr_err("%s: timeout=3D=3D%d\n", __func__, timeout);
>>>>>
>>>>> after the loop in chip_disable() typically shows values around 12-1=
4,
>>>>> i.e. suggesting that it takes about 110-130 us for the LPM_ACK bit =
to
>>>>> appear. So a timeout value of about twice that seems reasonable.
>>>>>
>>>>> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
>>>>
>>>> I've scheduled the patch by Joakim Zhang:
>>>>
>>>>     9daed89ae8a3 can: flexcan: fix timeout when set small bitrate
>>>>
>>>> that doubles the timeout to 100.
>>>
>>> Eh, ok, but that's not sufficient for the MPC8309 (I tried with 100 a=
t
>>> first, but as I write the minimally working timeout value turns out t=
o
>>> be about 140 us). Do you want me to send another patch on top of
>>> 9daed89ae8a3, or how should I interpret the above?
>>
>> Can you propose an updated commit message for Joakim Zhang's patch?
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git/comm=
it/?h=3Dtesting&id=3D9daed89ae8a3fc44ccd2b2bb9c3c4d3e3431904d
>>
>> I'll add it by hand and increase the timeout to 250. Ok?
>=20
> Sounds fine. In order not to change Joakim's commit log too much, how
> about adding something like (with your initials, since you're next in
> the sign-off chain)
>=20
> [mkl: Meanwhile, Rasmus Villemoes reported that even with a timeout of
> 100, flexcan_probe() fails on the MPC8309, which requires a value of at=

> least 140 to work reliably. 250 works for everyone.]
>=20
> ? Feel free to edit as you wish.

Thanks, I've added that to the commit message itself.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--RwniMHbQrYgPxVol7aNT12neuXKAdjjzW--

--QbbbVd1nuxKJvHpv6YDGgJ6Eaco6CAzRK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAlyUk+QACgkQWsYho5Hk
nSAZBwf7BimsXBy5ZlVJP1bOHtZNEER7vpkKWD9FhECKnjeSGPKIv+PkAtScvWLX
w6U5UoJhdYkzrae+l1oP+PL9vbENNbJYaRumN89tq3OiBh+FNE14Wrt0ho79Hb9f
vzJa8OBKvt3sXM/mRzGyB08KzQ3raFRStqqWXiDd8tfh/uJi4VK6zJoTmbPK+30T
aBv6Q6CsDdYFcLzSn/bTMLM4zk+ET51TTHJPuPO5O+LO9WoQTQw1ZZ8qiaRhpt0D
NHTd6TFEZMwrD2Ic3tBaQa/TMGonqp2MvXp39PGjBqptDes4wOvcmGUU51HBSt40
pQ7xC+VV6W9mA8PeV8M/BVDLRSG+IQ==
=iFJD
-----END PGP SIGNATURE-----

--QbbbVd1nuxKJvHpv6YDGgJ6Eaco6CAzRK--
