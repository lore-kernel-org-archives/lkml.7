Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB824C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0AF2206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfKMV5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 16:57:10 -0500
Received: from sandeen.net ([63.231.237.45]:43270 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbfKMV5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 16:57:10 -0500
Received: from [10.0.0.4] (liberator [10.0.0.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by sandeen.net (Postfix) with ESMTPSA id 68A4BB69;
        Wed, 13 Nov 2019 15:55:51 -0600 (CST)
Subject: Re: [PATCH 00/13] add the latest exfat driver
To:     =?UTF-8?Q?Valdis_Kl=c4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        hch@lst.de, sj1557.seo@samsung.com, linkinjeon@gmail.com
References: <CGME20191113082216epcas1p2e712c23c9524e04be624ccc822b59bf0@epcas1p2.samsung.com>
 <20191113081800.7672-1-namjae.jeon@samsung.com>
 <69d00c12-7b8a-1d47-0c18-58323f7ca60b@sandeen.net>
 <367298.1573682134@turing-police>
From:   Eric Sandeen <sandeen@sandeen.net>
Autocrypt: addr=sandeen@sandeen.net; prefer-encrypt=mutual; keydata=
 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 pA==
Message-ID: <5965ff2d-6cf5-f0b2-54c6-cba6e0cfc364@sandeen.net>
Date:   Wed, 13 Nov 2019 15:57:07 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <367298.1573682134@turing-police>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="46lXcAEqvtFI8uP82RH2e4VeBkuasW0tZ"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--46lXcAEqvtFI8uP82RH2e4VeBkuasW0tZ
Content-Type: multipart/mixed; boundary="M2tsLRGInU9J5GcrVvvHHWLqsDuhBw7pQ"

--M2tsLRGInU9J5GcrVvvHHWLqsDuhBw7pQ
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 11/13/19 3:55 PM, Valdis Kl=C4=93tnieks wrote:
> On Wed, 13 Nov 2019 15:00:23 -0600, Eric Sandeen said:
>> On 11/13/19 2:17 AM, Namjae Jeon wrote:
>>> This adds the latest Samsung exfat driver to fs/exfat. This is an
>>> implementation of the Microsoft exFAT specification. Previous version=
s
>>> of this shipped with millions of Android phones, an a random previous=

>>> snaphot has been merged in drivers/staging/.
>>>
>>> Compared to the sdfat driver shipped on the phones the following chan=
ges
>>> have been made:
>>>
>>>  - the support for vfat has been removed as that is already supported=

>>>    by fs/fat
>>>  - driver has been renamed to exfat
>>>  - the code has been refactored and clean up to fully integrate into
>>>    the upstream Linux version and follow the Linux coding style
>>>  - metadata operations like create, lookup and readdir have been furt=
her
>>>    optimized
>>>  - various major and minor bugs have been fixed
>>>
>>> We plan to treat this version as the future upstream for the code bas=
e
>>> once merged, and all new features and bug fixes will go upstream firs=
t.
>>
>> Apologies if I should know this already, but where are the userspace t=
ools
>> for exfat located?
>=20
> The upstream for that is https://github.com/relan/exfat
>=20
> On Fedora, they're available in the rpmfusion RPM 'exfat-utils', not su=
re where
> Ubuntu or other distros put it.

Thanks, I wasn't sure if that was the "official" repo at this point.

-Eric


--M2tsLRGInU9J5GcrVvvHHWLqsDuhBw7pQ--

--46lXcAEqvtFI8uP82RH2e4VeBkuasW0tZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEK4GFkZ6NJImBhp3tIK4WkuE93uAFAl3MfDQACgkQIK4WkuE9
3uAfqA//f1D1A01RAsumH0UCo8i7oQBlMJauXKPOz4QwHwX2zYyNLDGE4x8X1cCS
lfGKHaGNkamc3qDVJrbJ3fDRTyn4vtCMT9qn9F9cKoA9hBn2V26/AIKd6xlkjIIb
2WmUyt1GGHqricqFEpsH5V8g87s9UxdftvN+tBeL0sgyBrWa7OLUYicEhe8Huq3S
QE+/AnBNxm3l3lSMZdp8Hr4YoRq6GxHT/tTH05pTzpFqOn0ue8TuC5uUtH92MI05
cJl6izg5iK0u5Mvq1isTwROuKndhhx+eRd+ySyVkcLWgysKfB6vJyz9rHQ/4FneR
Aq8uadVy6AeBbg01rCk5NFd9bQaIF0KRRliEMlJsVkn1e2nPdz2Gx43ODrHWLTyB
WeZAw5AUepuzXplBvPAL0ytPu2WmRofZJp4ELlltZoTWiZEQ2CinQyNUVrswencI
HlTbmGkTeCOqeioyKazJOEQhv2NrAtxN7JpX/erymVewaIg1k1TAxaGDjxzt9Q6R
N93QMZNnrp1MAoNMm6G5YcMGtwR/5JP8H5MWp8U/5f4aK7bSvkJB7AOQ2RQlZKOO
31xG1T2NV7I2oz4Hw88FYcMljXccY6IiPVP+3rcBD5bkFk14Al68jFSSBss363+8
Est2WKFXKedAPOlwmHZa9ySdQgnIqw35EjDXB763pBtsYn0P+Vc=
=FWfD
-----END PGP SIGNATURE-----

--46lXcAEqvtFI8uP82RH2e4VeBkuasW0tZ--
