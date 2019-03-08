Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 772E8C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 21:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EE7420851
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 21:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbfCHVIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 16:08:02 -0500
Received: from anholt.net ([50.246.234.109]:54398 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726258AbfCHVIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 16:08:02 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id D36AF10A2E2B;
        Fri,  8 Mar 2019 13:08:01 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id NYB-UFRLxABq; Fri,  8 Mar 2019 13:08:00 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id C19E510A2BEE;
        Fri,  8 Mar 2019 13:08:00 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 690432FE4653; Fri,  8 Mar 2019 13:08:00 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [GIT PULL 2/2] bcm2835-drivers-next-2019-03-04
In-Reply-To: <f07ce14b-53be-623e-deeb-d968745c31b4@gmail.com>
References: <20190305000218.15180-1-eric@anholt.net> <20190305000218.15180-2-eric@anholt.net> <f07ce14b-53be-623e-deeb-d968745c31b4@gmail.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Fri, 08 Mar 2019 13:07:58 -0800
Message-ID: <87ef7h3wi9.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Florian Fainelli <f.fainelli@gmail.com> writes:

> On 3/4/19 4:02 PM, Eric Anholt wrote:
>> The following changes since commit e1dc2b2e1bef7237fd8fc055fe1ec2a6ff001=
f91:
>>=20
>>   ARM: bcm283x: Switch V3D over to using the PM driver instead of firmwa=
re. (2019-02-01 10:34:32 +0100)
>>=20
>> are available in the Git repository at:
>>=20
>>   git://github.com/anholt/linux tags/bcm2835-drivers-next-2019-03-04
>>=20
>> for you to fetch changes up to 4deabfae643d8852c643664d9088a647abfaa5d0:
>>=20
>>   soc: bcm: bcm2835-pm: Fix error paths of initialization. (2019-03-04 1=
5:33:14 -0800)
>>=20
>> ----------------------------------------------------------------
>> This pull request brings in two fixes for the new native bcm2835 power
>> domains driver.
>>=20
>> ----------------------------------------------------------------
>
> Looks like Stefan found an arm64 build configuration that failed linking
> with the driver, do you want to add an additional fix to this pull
> request that addresses that?

Took a look at it now, sent a fix.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlyC2a4ACgkQtdYpNtH8
nuh0bA//YPEs77Ca9YpZuOUKo1A9/kPWaRqzJMBmNqdLvAwCij57YDsnwqEaJjha
2De5P3qeJhnENdKAOQfCRHLD3SBGtgsUqKj9hnRRYryhJuxeVn/kpIQoiezj9fCy
Wl9tPGo/5vjtJdA9Pqm86ZVWk9q7bDR0210Mk+Dvif4smAz+APqMOcN0ojA3W2QJ
9aEjPGQVLAskEpgOvh4oIOU5lUf/hMOrXoR6U0p11hQyAZGWXmwXv6MmqlU+7Qfu
I+NoSbBBqz5cWFFNmNSBI2xrxX/rjGnLFLgWgWXorT9QI5gXFgFhQbFjEDsRvkeX
YyasRtdLUM4ksfbS7vp0brIvjq6COF9X27f7WyY5E9gk/GvJM9he2mJ25DlE/JQP
ZwpfXJtpZqtBpep5Z2yxMXThUMo9sABz9hHSYc3M3n8ba0ncQ0oVjU6eRr5EadOQ
OX7xALKy77nNGfigBKNjwAOdB6RN2vl6WgLeouL3pNAehlBbHSKMx1kbPWzlabVC
Y+MZ7sfa5lyS2DY+eiTgNGWfgIweTxDguDN2pV2ZtLeBBNntkJBQoDARY8XhsSb1
jql+xZ5LpqZVUOJmV/cv+BjhY6W2KlO8YJ85Aa3U2P6hro/Y1EupqtsFAR0qAbBF
NOD5hTmbDUxgEaZJ58+Ha3EcAp1U5OyE6P+sy+ArASO6B7TAv6o=
=Nt2W
-----END PGP SIGNATURE-----
--=-=-=--
