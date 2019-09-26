Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E766FC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 19:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6D7E222C3
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 19:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="P0R/t7oz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbfIZTSf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 15:18:35 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45247 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727707AbfIZTSe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 15:18:34 -0400
Received: from [IPv6:2601:646:8600:3281:4da0:b184:256:e0c2] ([IPv6:2601:646:8600:3281:4da0:b184:256:e0c2])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x8QJHgn33777378
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Thu, 26 Sep 2019 12:17:46 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com x8QJHgn33777378
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019091901; t=1569525469;
        bh=dFgBGB2t/s3m/j16Yd8URWTzLh2KumFreidqW7BxHNw=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=P0R/t7ozLnHE6wVpBckyAY993oU5lUABEV0lN7/ohmxn1YD2JIMFXaS4j6q3z3Hm0
         omwNxekyYweckRuTrpmvB7gxoeRUTfwxpymoMWXOLZEktce39KnIwdwuLBS7g/Ajhd
         piqwHxUOItfrACG5GHO+g9xOFGHavh3naPj1IWGncZ1XfT+ixR4TvKW0Djtj7WtFwL
         pX169iFAgY2kPfVzKdCMNsU4mXE4i88q+A1s3LLgh+2Ot8TvhHk3QvVkfpAeuuckHc
         yffrqkViQuPck9rCbLr+sKb4vZS3NLRjCQl7DwK41v2hXGcyXlS+UBse8wNN7bnW4b
         5F/YRpHMR5rUQ==
Date:   Thu, 26 Sep 2019 12:17:34 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <f7a1d739-94ae-f6d3-efdb-9748e5e03f82@infradead.org>
References: <20190926042116.17929-1-caoj.fnst@cn.fujitsu.com> <20190926060139.GA100481@gmail.com> <faabfe47-ba3e-5a92-af65-dc26e8e2ecb9@cn.fujitsu.com> <3073CD01-65C5-4BEC-B2FC-F76DD0E70D73@zytor.com> <f7a1d739-94ae-f6d3-efdb-9748e5e03f82@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH] x86/doc/boot_protocol: Correct the description of "reloc"
To:     Randy Dunlap <rdunlap@infradead.org>,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        Ingo Molnar <mingo@kernel.org>
CC:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, corbet@lwn.net
From:   hpa@zytor.com
Message-ID: <4CCDD087-62A6-4524-AD3E-6A6FD2D70FE7@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On September 26, 2019 8:20:28 AM PDT, Randy Dunlap <rdunlap@infradead=2Eorg=
> wrote:
>On 9/26/19 12:58 AM, hpa@zytor=2Ecom wrote:
>> On September 26, 2019 12:55:51 AM PDT, Cao jin
><caoj=2Efnst@cn=2Efujitsu=2Ecom> wrote:
>>> On 9/26/19 2:01 PM, Ingo Molnar wrote:
>>>> * Cao jin <caoj=2Efnst@cn=2Efujitsu=2Ecom> wrote:
>>>>
>>>>> The fields marked with (reloc) actually are not dedicated for
>>> writing,
>>>>> but communicating info for relocatable kernel with boot loaders=2E
>For
>>>>> example:
>>>>>
>>>>>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>>>>>     Field name:     pref_address
>>>>>     Type:           read (reloc)
>>>>>     Offset/size:    0x258/8
>>>>>     Protocol:       2=2E10+
>>>>>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>>>>>
>>>>>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>>     Field name:     code32_start
>>>>>     Type:           modify (optional, reloc)
>>>>>     Offset/size:    0x214/4
>>>>>     Protocol:       2=2E00+
>>>>>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>>
>>>>> Signed-off-by: Cao jin <caoj=2Efnst@cn=2Efujitsu=2Ecom>
>>>>> ---
>>>>> Unless I have incorrect non-native understanding for "fill in", I
>>> think
>>>>> this is inaccurate=2E
>>>>>
>>>>>  Documentation/x86/boot=2Erst | 2 +-
>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/Documentation/x86/boot=2Erst
>b/Documentation/x86/boot=2Erst
>>>>> index 08a2f100c0e6=2E=2Ea611bf04492d 100644
>>>>> --- a/Documentation/x86/boot=2Erst
>>>>> +++ b/Documentation/x86/boot=2Erst
>>>>> @@ -243,7 +243,7 @@ bootloader ("modify")=2E
>>>>> =20
>>>>>  All general purpose boot loaders should write the fields marked
>>>>>  (obligatory)=2E  Boot loaders who want to load the kernel at a
>>>>> -nonstandard address should fill in the fields marked (reloc);
>other
>>>>> +nonstandard address should consult with the fields marked
>(reloc);
>>> other
>>>>>  boot loaders can ignore those fields=2E
>>>>> =20
>>>>>  The byte order of all fields is littleendian (this is x86, after
>>> all=2E)
>>>>
>>>> Well, this documentation is written from the point of view of a=20
>>>> *bootloader*, not the kernel=2E So the 'fill in' says that the
>>> bootloader=20
>>>> should write those fields - which is correct, right?
>>>>
>>>
>>> Take pref_address or relocatable_kernel for example, they have type:
>>> read (reloc), does boot loader need to write them? I don't see grub
>>> does
>>> this at least=2E
>>=20
>> Read means the boot later reads them=2E
>
>is that          boot loader ??

Yes, stupid autocorrect=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
