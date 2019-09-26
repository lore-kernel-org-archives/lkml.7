Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC6F2C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 07:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8159B2146E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 07:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="mqK/7Ul9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbfIZH6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 03:58:52 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36193 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726418AbfIZH6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 03:58:51 -0400
Received: from [IPv6:2601:646:8600:3281:4da0:b184:256:e0c2] ([IPv6:2601:646:8600:3281:4da0:b184:256:e0c2])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x8Q7wRc53612418
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Thu, 26 Sep 2019 00:58:29 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com x8Q7wRc53612418
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019091901; t=1569484710;
        bh=e69WFYWciy+hazfvzCnromNr0NTIvmpRtmxkPKzWlNg=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=mqK/7Ul9t0I1hRojr5+dOkAiHfWYXvTC5VwS4FinrznzAG7z5yALOXMKypT9RQQrg
         rviXKrdo6TrlGRoAbMd+cV8/3VjTMq3Lk7L1Fl/OnrCZIWwz+jk1ks28hWlsCLvbdB
         m2ZeIAjgqJ3kHHH3xIkm14Hh4rEGV9pWy3/+oWpncoB5WfcA7E+ocMcuwPcwRSIZOc
         ac3Y7iRmQn39t7bp7WKuJ0YIj0Enicv37MNP75SbYorFCNgVcCKJlUymg57/PEZk94
         uOqtUCGB33DNgF1mh2QKwlTfDXk3rwJj5d2L7gc5XJbu0vAHK4NWX+1UO0wyANDb7E
         wlws12TZryomg==
Date:   Thu, 26 Sep 2019 00:58:19 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <faabfe47-ba3e-5a92-af65-dc26e8e2ecb9@cn.fujitsu.com>
References: <20190926042116.17929-1-caoj.fnst@cn.fujitsu.com> <20190926060139.GA100481@gmail.com> <faabfe47-ba3e-5a92-af65-dc26e8e2ecb9@cn.fujitsu.com>
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
Message-ID: <3073CD01-65C5-4BEC-B2FC-F76DD0E70D73@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On September 26, 2019 12:55:51 AM PDT, Cao jin <caoj=2Efnst@cn=2Efujitsu=2E=
com> wrote:
>On 9/26/19 2:01 PM, Ingo Molnar wrote:
>> * Cao jin <caoj=2Efnst@cn=2Efujitsu=2Ecom> wrote:
>>=20
>>> The fields marked with (reloc) actually are not dedicated for
>writing,
>>> but communicating info for relocatable kernel with boot loaders=2E For
>>> example:
>>>
>>>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>>>     Field name:     pref_address
>>>     Type:           read (reloc)
>>>     Offset/size:    0x258/8
>>>     Protocol:       2=2E10+
>>>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>>>
>>>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>     Field name:     code32_start
>>>     Type:           modify (optional, reloc)
>>>     Offset/size:    0x214/4
>>>     Protocol:       2=2E00+
>>>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>
>>> Signed-off-by: Cao jin <caoj=2Efnst@cn=2Efujitsu=2Ecom>
>>> ---
>>> Unless I have incorrect non-native understanding for "fill in", I
>think
>>> this is inaccurate=2E
>>>
>>>  Documentation/x86/boot=2Erst | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/x86/boot=2Erst b/Documentation/x86/boot=2Er=
st
>>> index 08a2f100c0e6=2E=2Ea611bf04492d 100644
>>> --- a/Documentation/x86/boot=2Erst
>>> +++ b/Documentation/x86/boot=2Erst
>>> @@ -243,7 +243,7 @@ bootloader ("modify")=2E
>>> =20
>>>  All general purpose boot loaders should write the fields marked
>>>  (obligatory)=2E  Boot loaders who want to load the kernel at a
>>> -nonstandard address should fill in the fields marked (reloc); other
>>> +nonstandard address should consult with the fields marked (reloc);
>other
>>>  boot loaders can ignore those fields=2E
>>> =20
>>>  The byte order of all fields is littleendian (this is x86, after
>all=2E)
>>=20
>> Well, this documentation is written from the point of view of a=20
>> *bootloader*, not the kernel=2E So the 'fill in' says that the
>bootloader=20
>> should write those fields - which is correct, right?
>>=20
>
>Take pref_address or relocatable_kernel for example, they have type:
>read (reloc), does boot loader need to write them? I don't see grub
>does
>this at least=2E

Read means the boot later reads them=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
