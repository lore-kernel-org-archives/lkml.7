Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72CB9C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 21:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D78A20828
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 21:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfF1VS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 17:18:58 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48175 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfF1VS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 17:18:57 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hgyGk-0006CC-JA; Fri, 28 Jun 2019 21:18:54 +0000
Subject: Re: [PATCH][next] regulator: lp87565: fix missing break in switch
 statement
To:     Mark Brown <broonie@kernel.org>
Cc:     Keerthy <j-keerthy@ti.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190627131639.6394-1-colin.king@canonical.com>
 <20190628143628.GJ5379@sirena.org.uk>
From:   Colin Ian King <colin.king@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=colin.king@canonical.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <4cb0e4ab-66c7-2b3d-27d3-fd5cfde8988f@canonical.com>
Date:   Fri, 28 Jun 2019 22:18:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190628143628.GJ5379@sirena.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="oEKD0TuaAUSDAgkxvBRIrIF2rNVkuo2dS"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oEKD0TuaAUSDAgkxvBRIrIF2rNVkuo2dS
Content-Type: multipart/mixed; boundary="tQHFnbd530JsHQTzVsockgDr2aN6yzYeZ";
 protected-headers="v1"
From: Colin Ian King <colin.king@canonical.com>
To: Mark Brown <broonie@kernel.org>
Cc: Keerthy <j-keerthy@ti.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Lee Jones <lee.jones@linaro.org>, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <4cb0e4ab-66c7-2b3d-27d3-fd5cfde8988f@canonical.com>
Subject: Re: [PATCH][next] regulator: lp87565: fix missing break in switch
 statement
References: <20190627131639.6394-1-colin.king@canonical.com>
 <20190628143628.GJ5379@sirena.org.uk>
In-Reply-To: <20190628143628.GJ5379@sirena.org.uk>

--tQHFnbd530JsHQTzVsockgDr2aN6yzYeZ
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 28/06/2019 15:36, Mark Brown wrote:
> On Thu, Jun 27, 2019 at 02:16:39PM +0100, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> Currently the LP87565_DEVICE_TYPE_LP87561_Q1 case does not have a
>> break statement, causing it to fall through to a dev_err message.
>> Fix this by adding in the missing break statement.
>=20
> This doesn't apply against current code, please check and resend.
>=20
So it applies cleanly against linux-next, I think the original code
landed in mfd/for-mfd-next - c.f. https://lkml.org/lkml/2019/5/28/550

Colin



--tQHFnbd530JsHQTzVsockgDr2aN6yzYeZ--

--oEKD0TuaAUSDAgkxvBRIrIF2rNVkuo2dS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEcGLapPABucZhZwDPaMKH38aoAiYFAl0WhD0ACgkQaMKH38ao
AiYXqhAAgNjTAegXGgSCgEaVLMbaflCz6y02yhmBbwEtjXJsbDREpATHmq4Gbt+j
erzMKu9kEXGF0arOAmBOkAVyvtWatjvF0Za6/vvjgUrFS5hBmukxGvzET0H9bTGz
YNJnIxm1YROmQc8zlJDk/JTChddEsHTdmQaz4oMvhI415EyyMnXXHBnIPKKnt4de
WRLO6cSk0wtE3uU2ueEBR9RTyaaPzvYYCCrB8ln6muXr1cBI1f2823t8Ty0PRBHS
TxCKUjTwg1ZBWPwCkk6jqS39ET2sn8NFkhkTbvWccvhTI+EB8vNy3JeNhv/7m+BD
EX0suKNfuOovcfZISF6ngtnSgZo4YgpuYA+ekfu8hNML2rA7hkLNGa3ykLhGv9L4
PxqlSI8ejX94A/mAZKHzHE29J+b+LAb7lGSFecFBqOpC1sv7G8Jsv2ftdfOs1qZN
LkIXVhFRT2dsTAVZb8HyTuDGY4KoP4nAze9ew0VDHw40QCJHwtcBUZIDlKzN+ayN
FgfXCA3e2RT8VAxNfWU0HRpFoZRbwmfhuvjMMvvUR7ee4VUyNLD0oabI3IoEjFnh
UXRoq6rHqDQ+aN2iz7Ya4qj+m2QKo7fEo+04uchuKWuBgewNe1Nx9vDHZFJlnw9l
kuRZPk8KyoUWmzx2BC3j2dae2miEk9gxfZHF2L/8OwNeXYzp8CQ=
=U/PE
-----END PGP SIGNATURE-----

--oEKD0TuaAUSDAgkxvBRIrIF2rNVkuo2dS--
