Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90CA0C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 21:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5948F2070B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 21:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730672AbfH0VgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 17:36:05 -0400
Received: from antares.kleine-koenig.org ([94.130.110.236]:48518 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfH0VgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 17:36:04 -0400
Received: from localhost (localhost [127.0.0.1])
        by antares.kleine-koenig.org (Postfix) with ESMTP id 4D42C7860E7;
        Tue, 27 Aug 2019 23:36:00 +0200 (CEST)
Received: from antares.kleine-koenig.org ([127.0.0.1])
        by localhost (antares.kleine-koenig.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ogGPutiTK-Yk; Tue, 27 Aug 2019 23:35:59 +0200 (CEST)
Received: from [IPv6:2a02:8071:b5c2:53f8:3192:99d7:1d59:986] (unknown [IPv6:2a02:8071:b5c2:53f8:3192:99d7:1d59:986])
        by antares.kleine-koenig.org (Postfix) with ESMTPSA;
        Tue, 27 Aug 2019 23:35:59 +0200 (CEST)
Subject: Re: [PATCH v2] vsprintf: introduce %dE for error constants
To:     Joe Perches <joe@perches.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190827211244.7210-1-uwe@kleine-koenig.org>
 <04b021b263465c62628964ac402e15fd4cdc13a0.camel@perches.com>
From:   =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
Openpgp: preference=signencrypt
Autocrypt: addr=uwe@kleine-koenig.org; prefer-encrypt=mutual; keydata=
 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
 kC8vBDJg
Message-ID: <59bfcf90-f7f8-4d55-b5bf-211f6ca67917@kleine-koenig.org>
Date:   Tue, 27 Aug 2019 23:35:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <04b021b263465c62628964ac402e15fd4cdc13a0.camel@perches.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="JlbZvlgxaHVKm5ZzU4aQKmhbuU32i0jym"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JlbZvlgxaHVKm5ZzU4aQKmhbuU32i0jym
Content-Type: multipart/mixed; boundary="OibJTfYqSb8ZYpRBIfcgkpdEmi3BwmzKy";
 protected-headers="v1"
From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
To: Joe Perches <joe@perches.com>,
 Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
 Jani Nikula <jani.nikula@linux.intel.com>, Petr Mladek <pmladek@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <59bfcf90-f7f8-4d55-b5bf-211f6ca67917@kleine-koenig.org>
Subject: Re: [PATCH v2] vsprintf: introduce %dE for error constants
References: <20190827211244.7210-1-uwe@kleine-koenig.org>
 <04b021b263465c62628964ac402e15fd4cdc13a0.camel@perches.com>
In-Reply-To: <04b021b263465c62628964ac402e15fd4cdc13a0.camel@perches.com>

--OibJTfYqSb8ZYpRBIfcgkpdEmi3BwmzKy
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hello Joe,

On 8/27/19 11:22 PM, Joe Perches wrote:
> On Tue, 2019-08-27 at 23:12 +0200, Uwe Kleine-K=C3=B6nig wrote:
>> The new format specifier %dE introduced with this patch pretty-prints
>> the typical negative error values. So
>>
>> 	pr_info("probing failed (%dE)\n", ret);
>>
>> yields
>>
>> 	probing failed (EIO)
>>
>> if ret holds -EIO. This is easier to understand than the for now commo=
n
>>
>> 	probing failed (-5)
>=20
> I suggest using both outputs like '-5 -EIO'
> rather than a single string

I like it the way it is implemented as it is more flexible. If you want
to see both, you can still do

	pr_info("probing failed (%d %dE)\n", ret, ret);

and people (like me) who think that giving only EIO can still do just tha=
t.

Best regards
Uwe


--OibJTfYqSb8ZYpRBIfcgkpdEmi3BwmzKy--

--JlbZvlgxaHVKm5ZzU4aQKmhbuU32i0jym
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl1lojsACgkQwfwUeK3K
7An5Rwf/cDKkW9zVOCTTnyhlRHfVJNZRfCsCPtmZyRRcvtgoC6kTCVolTwThZx5X
aZRpgCXOjwbqPTzK5w9xk5ved15f8eGQmcq02KQqkNkk/bds72l4y/QJcQIXvdXJ
o40Oi6m9PplDh7GudbHeJEhKIFL9GlIJde2Y8M6zYNOP5FJQbr9oBRbhrnVubMX9
fgu2pyy8VNNYvf0nBW1RKptHv0rXHMfKLNEFDaQY+Qi//wQx0FE6HjfMu1hDlTM4
bFYgdUnYsIDiT9z+tCFGj368P8G/almHOqFtxKqzaFjiRHkSmmsvz+uvLHy7275Y
mEhXyCNyq88FXrPhtBSLcZj6+R3dYQ==
=TW0X
-----END PGP SIGNATURE-----

--JlbZvlgxaHVKm5ZzU4aQKmhbuU32i0jym--
