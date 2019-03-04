Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026BBC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 23:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD14420657
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 23:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfCDX0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 18:26:16 -0500
Received: from anholt.net ([50.246.234.109]:56688 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbfCDX0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 18:26:15 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id A65E810A2A7A;
        Mon,  4 Mar 2019 15:26:14 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 9wedHe-ZO9pd; Mon,  4 Mar 2019 15:26:13 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 7EFBC10A2A62;
        Mon,  4 Mar 2019 15:26:13 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 140BC2FE464E; Mon,  4 Mar 2019 15:26:13 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Helen Koike <helen.koike@collabora.com>
Cc:     devicetree@vger.kernel.org, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, lkundrak@v3.sk,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, kernel@collabora.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: bcm283x: Fix hdmi hpd gpio pull
In-Reply-To: <149506090.292981.1551737405671@email.ionos.de>
References: <20190304214837.9045-1-helen.koike@collabora.com> <149506090.292981.1551737405671@email.ionos.de>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Mon, 04 Mar 2019 15:26:11 -0800
Message-ID: <875zsyql0s.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Stefan Wahren <stefan.wahren@i2se.com> writes:

> Hi,
>
> since this patch change only one board, the subject could be more specifi=
c:
>
> ARM: dts: bcm2835-rpi-b-rev2: Fix hdmi hpd gpio pull
>
>> Helen Koike <helen.koike@collabora.com> hat am 4. M=C3=A4rz 2019 um 22:4=
8 geschrieben:
>>=20
>>=20
>> Raspberry pi board model B revison 2 have the hot plug detector gpio
>> active high (and not low as it was in the dts).
>>=20
>> Signed-off-by: Helen Koike <helen.koike@collabora.com>
>> Reviewed-by: Eric Anholt <eric@anholt.net>
>
> I think we should add a Fixes tag here, so it could be backported.
>
> @Eric: Feel free to take V2

Added a fixes tag, and I'll submit PRs for this and the PM fixes now.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlx9tBMACgkQtdYpNtH8
nugVVQ//VwHm0DM9+gyxUG/5cyDfD1lUYD8nTJmzaaImO94WjHWDvGpirZyLT4KL
JMrYDY7TBG6xnENleuLet096nAhFytK1mu0GeMct287ULaUwGAyAJ0mcjs38dPRZ
BXTZfy4in8Fto7qu/obPKuOyS8ZSswEliO94C0bB7Gg9tMR++Kv7Z9OBzWSQM0Zg
coA2q2vcupFnh77Et26I4ghMHqCkdBqaBVHKDIG6feYfmVkD7dvGJHZmk+2dQALH
rup0C+Q8XCuEQKF89uL/caA3MvrK+8EQFfMzIAyv9s2qYVF2czonWZGnSedz4EFi
usgEHbO8koI0MmlDW5z8wFoj3AqLf9QFa6QrphO7p2y28KL0Jyf2WVkdcMdhDM5d
m3zYkiksJG3dw/HeAYgTHiTdtwLPXRo1ynxGxz5tMOrioPVq4OIN7pgcLqYYUrB4
K2r//Z/s5JlWcyJvF1gXbG1klRsiw06/1ZprUFjLICscNDY+thj/RF3FcKO609ax
jA1tg7rptcpuZkGWKYN4ffOHiaTbK2Eg3Mc2Yva0DjDpxdmhCH7Sxj9+wRPmL4//
fMfTZq+ut1H/gdzj168TKvULD+0lyFBG3xm+i5Ui6JCM8KVBC9bJdHB08P4WoCEU
cmf6GUBmtnuMydBQOBV/aofc6o6n5lpXRs9Z95CQLcRSmpjAX2k=
=SJQz
-----END PGP SIGNATURE-----
--=-=-=--
