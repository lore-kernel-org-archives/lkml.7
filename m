Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61444C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 01:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1210420896
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 01:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="DAtjSqxY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfDHB1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 21:27:45 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:59133 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbfDHB1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 21:27:45 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 1D59A886BF;
        Mon,  8 Apr 2019 13:27:42 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1554686862;
        bh=b1eLIRdzFEVh5GhB5K6GQ2xz3u9f3LX8WadUU/h0Z2Y=;
        h=From:To:CC:Subject:Date:References;
        b=DAtjSqxYTv/RxKrORMkbyLomdViIpLW5rTey0DGduFosbjtoVvgScj8OislQ60RhX
         lhUhwVkSyRUHQCRrdLzfGKSIh0kZZSS3K5kR/sfB6vPrpxf4MXWvIamBv2dOMFApTA
         qy+Ar45aqdSJz2PKpQpkepehzHeawKpfVZ543DD2+ezWAdT/sdjrkvCl8l1Q0JYvnN
         U4V7HUwZrVB0Jv8A9dDob7aA1eL9ARutUuAMzSh5BB7SepxhIyjhp67tLgT/LxuDJJ
         13Iez0TckaKrKdWfAXQpMRLXqqJS/aUObWAK43wWaM1xDi8Dc2zebkA9nTlHVtJS9Z
         ztPsnzQncHo7Q==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5caaa38d0000>; Mon, 08 Apr 2019 13:27:41 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1156.6; Mon, 8 Apr 2019 13:27:40 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1156.000; Mon, 8 Apr 2019 13:27:40 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Frank Rowand <frowand.list@gmail.com>,
        "pantelis.antoniou@konsulko.com" <pantelis.antoniou@konsulko.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hamish Martin <Hamish.Martin@alliedtelesis.co.nz>
Subject: Re: Using device tree overlays in Linux
Thread-Topic: Using device tree overlays in Linux
Thread-Index: AQHU6ojCpZF8ouBfMkagL4RUBC6Q3g==
Date:   Mon, 8 Apr 2019 01:27:40 +0000
Message-ID: <224942bd629e41eaa23ab327b015134e@svr-chch-ex1.atlnz.lc>
References: <71fb0ff289e84c55bd92ecd96bc9aa76@svr-chch-ex1.atlnz.lc>
 <61185ee9-4bee-eec3-f0d0-6d6760595845@gmail.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [2001:df5:b000:22:3a2c:4aff:fe70:2b02]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,=0A=
=0A=
On 8/04/19 1:05 PM, Frank Rowand wrote:=0A=
> Hi Chris,=0A=
> =0A=
> On 4/3/19 6:50 PM, Chris Packham wrote:=0A=
>> Hi,=0A=
>>=0A=
>> I'm implementing support for some modular Linux based systems using=0A=
>> device tree overlays. The code is working but it seems a little more=0A=
>> fiddly that than it should be so I'm wondering if I'm doing it right.=0A=
> =0A=
> Let me start by saying that I strongly discourage using device tree=0A=
> overlays in the Linux kernel until the support is more baked.  For=0A=
> some info on how unbaked overlays are, see:=0A=
> =0A=
>     https://elinux.org/Frank%27s_Evolving_Overlay_Thoughts=0A=
> =0A=
> You should consider applying overlays in the Linux kernel to be=0A=
> fragile at best.=0A=
> =0A=
> If you can not figure out how to solve your needs without using=0A=
> overlays, then having the boot loader apply the overlay instead=0A=
> of the kernel applying the overlay avoids most of the issues.=0A=
> =0A=
=0A=
Consider us beta-testers :).=0A=
=0A=
We've got a few modular systems that have miscellaneous devices that we =0A=
want to be hot-swapping at run time. For the most part the devices in =0A=
question are i2c based. We want to use overlays as it saves manually =0A=
instantiating devices and avoids needing specific knowledge of the base =0A=
platform.=0A=
=0A=
>> An example of what I'm doing is=0A=
>>=0A=
>>=0A=
>> arch/arm/boot/dts/Makefile:=0A=
>> DTC_FLAGS_myboard +=3D -@=0A=
>>=0A=
>> drivers/foo/Makefile:=0A=
>> obj-y +=3D myplugin.dtb.o=0A=
>> obj-y +=3D mydriver.o=0A=
>>=0A=
>> drivers/foo/myplugin.dts:=0A=
>> /dts-v1/;=0A=
>> /plugin/;=0A=
>> /{=0A=
>> 	fragment@0 {=0A=
>> 		target =3D <&i2c0>;=0A=
>> 		__overlay__ {=0A=
>> 			gpio@74 {=0A=
>> 				compatible =3D "nxp,pca9539";=0A=
>> 				reg =3D <0x74>=0A=
>> 			};=0A=
>> 		};=0A=
>> 	};=0A=
>> };=0A=
> =0A=
> The fragment and __overlay__ nodes are implementation, subject to=0A=
> change, and should not be hand coded.  The dtc compiler has added=0A=
> features to allow a more generic source code.  The above should be:=0A=
> =0A=
> // SPDX-License-Identifier: GPL-2.0=0A=
> /dts-v1/;=0A=
> /plugin/;=0A=
> =0A=
> &i2c0 {=0A=
> 	gpio@74 {=0A=
> 		compatible =3D "nxp,pca9539";=0A=
> 		reg =3D <0x74>;=0A=
> 	};=0A=
> };=0A=
> =0A=
> (Not compiled, not tested.)=0A=
> =0A=
> The rcar overlay sources were merged before dtc was updated to=0A=
> handle this new syntax, so they are not a good example for=0A=
> how to write an overlay.=0A=
=0A=
OK thanks. I suspected as much. I'll update my code based on your example.=
=0A=
=0A=
>> drivers/foo/mydriver.c:=0A=
>> extern uint8_t __dtb_myplugin_begin[];=0A=
>> extern uint8_t __dtb_myplugin_end[];=0A=
>>=0A=
>> int mydriver_probe(struct platform_device *pdev)=0A=
>> {=0A=
>> 	u32 size =3D __dtb_myplugin_end - __dtb_myplugin_begin;=0A=
>> 	int overlay_id;=0A=
>> 	int ret;=0A=
>> 	=0A=
>> 	ret =3D of_overlay_fdt_apply(__dtb_myplugin_begin,=0A=
>> 				   size, &overlay_id);=0A=
>> 	return ret;=0A=
>> }=0A=
> =0A=
> I'm guessing that you have simplified your use case to make it easier to=
=0A=
> describe (thank you for that).  But that also makes it harder to understa=
nd=0A=
> the use case, and whether this is a good solution.  Can you describe your=
=0A=
> use case in some more detail?=0A=
=0A=
As I said above we have a few different modular systems we're trying to =0A=
support. But they all do basically the same thing.=0A=
=0A=
The insertion of a module is detected based on a gpio line being asserted.=
=0A=
=0A=
Then we identify what was just inserted, the details vary a little per =0A=
platform but in one instance we load an overlay that has instantiates an =
=0A=
i2c eeprom identifying the module.=0A=
=0A=
Once we know which specific module has been inserted based on the data =0A=
in the eeprom we load another overlay that instantiates the rest of the =0A=
devices on that module.=0A=
=0A=
>> The first issue is that I need to add -@ to the DTC_FLAGS for my board=
=0A=
>> dtb. I kind of understand that I only need -@ if my overlay targets=0A=
>> something symbolic so I might not need it but I was surprised that there=
=0A=
>> wasn't a Kconfig option that makes this happen automatically.=0A=
>>=0A=
>> externing things in C files makes checkpatch.pl complain. I see the=0A=
>> of/unittests.c and rcar_du_of.c hide this with a macro. I was again=0A=
>> surprised that there wasn't a common macro to declare these.=0A=
> =0A=
> unittests.c should not be used as a model of how to code for devicetree.=
=0A=
> There are some hacks that are needed to be able to test, but should not=
=0A=
> be used by normal drivers.=0A=
> =0A=
> The rcar use of overlays is a temporary hack to provide backward=0A=
> compatibility.  The intent is to drop this code once the backward=0A=
> compatibility window ends.=0A=
=0A=
Yes I suspected as much.=0A=
=0A=
> The long-term intent (once enough of the overlay code is in place) is=0A=
> to provide an overlay loader than can apply an overlay .dtb from a file.=
=0A=
=0A=
Would that be a kernel helper or driven via udev?=0A=
