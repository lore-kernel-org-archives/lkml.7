Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C2CC432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 06:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74755222C5
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 06:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="aL7r3QzP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392697AbfIZGEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 02:04:33 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54393 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387550AbfIZGEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 02:04:12 -0400
Received: from [IPv6:2601:646:8600:3281:4da0:b184:256:e0c2] ([IPv6:2601:646:8600:3281:4da0:b184:256:e0c2])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x8Q63n1Z3585601
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Wed, 25 Sep 2019 23:03:51 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com x8Q63n1Z3585601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019091901; t=1569477831;
        bh=WmyJwmANGw5Ag0RkHdGwa7GGgV/A2jhJ22eHat+o3wA=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=aL7r3QzPml5eV/hTWvLbqKrRUGLElsBDuMP03qv9IG2kmS3s2BnSanr7SwUa03L3A
         PKBfLu9GQVu9pAoZtLp7w4Nvyqoe2yd3RVgOP5nj9gmPfUIstUDA1uZovz5of/OXhS
         ROEwIjJB4iY5rO/fNgABpwN7Leg1h2ecRFQub7D39HjQpzu5S5oeJtuucokGq4HHOJ
         Ee+rVvPbtST1sl4KCZOpIDqk8+WQzVLt62Qcatuil3lc4AnlwHk05A7bOc4PzLjP3P
         afLGihU8PlcHdT01JN4rC6ODh+BnVc2uiKaRDlyd/cUH4+ki2CnXxM6S8Ik4q6nsHl
         giumcmASmy+tg==
Date:   Wed, 25 Sep 2019 23:03:41 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <20190926060139.GA100481@gmail.com>
References: <20190926042116.17929-1-caoj.fnst@cn.fujitsu.com> <20190926060139.GA100481@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH] x86/doc/boot_protocol: Correct the description of "reloc"
To:     Ingo Molnar <mingo@kernel.org>, Cao jin <caoj.fnst@cn.fujitsu.com>
CC:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, corbet@lwn.net
From:   hpa@zytor.com
Message-ID: <2964C8CC-D6BD-4601-AA3D-5BE7AE8FB769@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On September 25, 2019 11:01:39 PM PDT, Ingo Molnar <mingo@kernel=2Eorg> wro=
te:
>* Cao jin <caoj=2Efnst@cn=2Efujitsu=2Ecom> wrote:
>
>> The fields marked with (reloc) actually are not dedicated for
>writing,
>> but communicating info for relocatable kernel with boot loaders=2E For
>> example:
>>=20
>>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>>     Field name:     pref_address
>>     Type:           read (reloc)
>>     Offset/size:    0x258/8
>>     Protocol:       2=2E10+
>>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>>=20
>>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>     Field name:     code32_start
>>     Type:           modify (optional, reloc)
>>     Offset/size:    0x214/4
>>     Protocol:       2=2E00+
>>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>=20
>> Signed-off-by: Cao jin <caoj=2Efnst@cn=2Efujitsu=2Ecom>
>> ---
>> Unless I have incorrect non-native understanding for "fill in", I
>think
>> this is inaccurate=2E
>>=20
>>  Documentation/x86/boot=2Erst | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/Documentation/x86/boot=2Erst b/Documentation/x86/boot=2Ers=
t
>> index 08a2f100c0e6=2E=2Ea611bf04492d 100644
>> --- a/Documentation/x86/boot=2Erst
>> +++ b/Documentation/x86/boot=2Erst
>> @@ -243,7 +243,7 @@ bootloader ("modify")=2E
>> =20
>>  All general purpose boot loaders should write the fields marked
>>  (obligatory)=2E  Boot loaders who want to load the kernel at a
>> -nonstandard address should fill in the fields marked (reloc); other
>> +nonstandard address should consult with the fields marked (reloc);
>other
>>  boot loaders can ignore those fields=2E
>> =20
>>  The byte order of all fields is littleendian (this is x86, after
>all=2E)
>
>Well, this documentation is written from the point of view of a=20
>*bootloader*, not the kernel=2E So the 'fill in' says that the bootloader
>
>should write those fields - which is correct, right?
>
>Thanks,
>
>	Ingo

This is correct=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
