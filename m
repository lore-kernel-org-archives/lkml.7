Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB70C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 19:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7398D222C7
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 19:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="tIJN8Af3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbfIZTS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 15:18:57 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46741 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727707AbfIZTS4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 15:18:56 -0400
Received: from [IPv6:2601:646:8600:3281:4da0:b184:256:e0c2] ([IPv6:2601:646:8600:3281:4da0:b184:256:e0c2])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x8QJIhF53777727
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Thu, 26 Sep 2019 12:18:45 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com x8QJIhF53777727
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019091901; t=1569525526;
        bh=AwASjrnLXi/qw8uPC6jnY4kcGOnTDEtI99vpaGYBJw4=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=tIJN8Af3E7QnjmLUz+OlO1AsKIFu0i9tVD2GgpHai0TmMJqQ1UYZNR/Pg5Ua+wr5e
         0FX6M9Z+sycCegQPJI9JIalzTHVuM64ww2e0D0MQotYvPmb2tKfnirDkeqe7IuDyyw
         aG019c0Dl8W1DbbX6przkcHqgfw4xql5bzE3qwMHe8Rmd7WTZoQgxSsp6xnvKEKDiH
         k9Nm1ugztJWHYlblgjpBjKg80aSZ2eS9V3pSS2IwON49SvT/m0zE5p9b+yVcvJ7xyx
         8Ezf0dDq5t7IbvcS3SngMwBwRYtShidPldENAEtLD859/rBFv/DROtFzU3Pf5mPDLt
         E0nnMeLbd+oKA==
Date:   Thu, 26 Sep 2019 12:18:36 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <dff52431-ce54-7c64-b223-36f4491c53b0@cn.fujitsu.com>
References: <20190926042116.17929-1-caoj.fnst@cn.fujitsu.com> <20190926060139.GA100481@gmail.com> <faabfe47-ba3e-5a92-af65-dc26e8e2ecb9@cn.fujitsu.com> <3073CD01-65C5-4BEC-B2FC-F76DD0E70D73@zytor.com> <dff52431-ce54-7c64-b223-36f4491c53b0@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH] x86/doc/boot_protocol: Correct the description of "reloc"
To:     Cao jin <caoj.fnst@cn.fujitsu.com>, Ingo Molnar <mingo@kernel.org>
CC:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, corbet@lwn.net
From:   hpa@zytor.com
Message-ID: <A44CE024-DEB0-476C-B71B-883307952F10@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On September 26, 2019 1:20:02 AM PDT, Cao jin <caoj=2Efnst@cn=2Efujitsu=2Ec=
om> wrote:
>On 9/26/19 3:58 PM, hpa@zytor=2Ecom wrote:
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
>>=20
>
>Sorry I don't know what is going wrong in my mind=2E For me, if
>pref_address has "read (reloc)", base on the current document, it means
>boot loader will read it and also write it, which is conflicting=2E And
>the purpose of pref_address should just inform boot loader that kernel
>whats itself to be loaded at certain address, it don't want to be
>written=2E

read (reloc) means it is information for the boot loader to read, but that=
 it can ignore it completely if it does not want to relocate the kernel=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
