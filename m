Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2135C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 20:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4E85206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 20:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbfCLUHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 16:07:24 -0400
Received: from anholt.net ([50.246.234.109]:45266 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbfCLUHY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 16:07:24 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 4123510A2E65;
        Tue, 12 Mar 2019 13:07:23 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id GBW_jvr6nhOq; Tue, 12 Mar 2019 13:07:22 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 0DCE410A0640;
        Tue, 12 Mar 2019 13:07:22 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id A05612FE4653; Tue, 12 Mar 2019 13:07:21 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: bcm2835: Add missing dependency on MFD_CORE.
In-Reply-To: <387603168.348361.1552128458820@email.ionos.de>
References: <20190308210738.10666-1-eric@anholt.net> <387603168.348361.1552128458820@email.ionos.de>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Tue, 12 Mar 2019 13:07:21 -0700
Message-ID: <87mulzyhza.fsf@anholt.net>
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

>> Eric Anholt <eric@anholt.net> hat am 8. M=C3=A4rz 2019 um 22:07 geschrie=
ben:
>>=20
>>=20
>> When adding the MFD dependency for power domains and WDT in bcm2835, I
>> added it only on the arm32 side and missed it for arm64.
>>=20
>> Fixes: 5e6acc3e678e ("bcm2835-pm: Move bcm2835-watchdog's DT probe to an=
 MFD.")
>> Signed-off-by: Eric Anholt <eric@anholt.net>
>> Reported-by: Stefan Wahren <stefan.wahren@i2se.com>
>
> Acked-by: Stefan Wahren <stefan.wahren@i2se.com>

Merged to bcm2835-driver-next and sent an updated PR.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlyIEXkACgkQtdYpNtH8
nujn2A//f4NaiH8kmDEeZ6C02InazkqwcPrQAHDXzQhD4R4Vjj/NSsqbwlXeGd+0
3RwnSXUS17dck+w9i/jcfahPv/mQRiQFNjYV5/HdxUYLScIPNrbzSEvPFaIbvC20
z23M3bIJeTvAk4CJeg1kbyEZuQ5flWUAOo/xp0J2YbdbZlTaNXL6T0FmhydmL6Ly
40eOScRwDuDzwGIYNogZ0hKEVLxlcawDBL0zz+WjdqvkVHtdDxl2Sz/6WfOx1CGT
mo1u2S5XZFpeOPmjlxdv80Gu+nPYbKHJKhM2ktl+emdk9+5AwSpplfkm/f7ljvSp
hEKdkbop5iu/RlRgB9uNguBExv2in7I/JNtaX73+OudEmBnp4apddK3M7W95Bhc8
cUeDhO2Jm0NeK4FRaDI17cNbKnRNBvan/Gp1mtoMZ8PPMksxEjidKJi80r4T0g3s
QkZaBh0bMBA8LOhMaDxSAfT+uUhjTT+kN7WTB05ZXfAy2uPa4qFtTP+TGmp5y5UF
ruPucEyiUqYrLFM1hapYZDcvcxcN0WLKbI7PQ46UdW3/KOnXiPvuGJTo0rveJeBc
iQmX6LMhpKM+Jth8+aHOpMI1kbzQjjhoTp55w6nb4WXF/pwbogiG5Jnz2m6O7H9/
00rCFjTvScuTfhAmbUjlNsxxixjJX0eHoQ8srLD/JElfT7byApA=
=/mMI
-----END PGP SIGNATURE-----
--=-=-=--
