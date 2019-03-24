Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 489B0C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 19:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01D392148D
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 19:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="TIvIKQCQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbfCXTYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 15:24:55 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.166]:31678 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfCXTYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 15:24:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1553455490;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=dQpcJP7nbmXkv0hXgpaBl53aoMKq+rqyM784zpn+Aok=;
        b=TIvIKQCQ/0MmxvEUy+THaqoJW7F4GwmaHf6L6x2IK66rbNEFPOKJHN9e4ou2+ibEx5
        fq0dHExvjvLYATE0ijXrsG7cBLi1I1bglQyme9Wv70amy7bYI4csbEjtuzAc23Vg6dC4
        DCFehE7hVaFrDvr75ladQDjAT/taOnK+8wnEn79XNggq42HqDeGrMW6kCLP04gfJ8lY4
        TyNEqBRlaDC5HD+trjCq1Eo7jKJnYGuqd2Ph8M7ZY5IX7/bGBsPSr04BcV1SrTZqYhDL
        X1Zshmnljy2ADRD5y4ZmnNf5y4UDetfPfnMFLEjRpuyXLfQWjDY0/aAAA5k1zaC6LA0v
        FOfg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBp5hRw/qOxWRk4dCz0tZcku5gKwXbfhDpgJ3gm7d6hM8dy3p83sn1i"
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2001:16b8:26a9:3300:bc12:60ce:f8a1:9f77]
        by smtp.strato.de (RZmta 44.16 AUTH)
        with ESMTPSA id h04075v2OJOn2rG
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Sun, 24 Mar 2019 20:24:49 +0100 (CET)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] mtd: rawnand: ams-delta: Drop board specific partition info
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20190324185932.GA24594@darkstar.musicnaut.iki.fi>
Date:   Sun, 24 Mar 2019 20:24:48 +0100
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        linux-mtd@lists.infradead.org,
        linux-omap <linux-omap@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <454BF5C9-478A-4E2A-BF00-D2A2AFE25C45@goldelico.com>
References: <20190319223718.26131-1-jmkrzyszt@gmail.com> <20190320011630.GB7872@darkstar.musicnaut.iki.fi> <2631901.52Nzq63B5o@z50> <20190324185932.GA24594@darkstar.musicnaut.iki.fi>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Am 24.03.2019 um 19:59 schrieb Aaro Koskinen <aaro.koskinen@iki.fi>:
>=20
> Hi,
>=20
> On Sun, Mar 24, 2019 at 05:48:22PM +0100, Janusz Krzysztofik wrote:
>> Hi Aaro,
>>=20
>> Thanks for your review.
>>=20
>> On Wednesday, March 20, 2019 2:16:30 AM CET Aaro Koskinen wrote:
>>> On Tue, Mar 19, 2019 at 11:37:18PM +0100, Janusz Krzysztofik wrote:
>>>> After recent modifications, only a hardcoded partition info makes
>>>> the driver device specific.  Other than that, the driver uses GPIO
>>>> exclusively and can be used on any hardware.
>>>>=20
>>>> Drop the partition info and use MTD partition parser with default
>>>> list of partition types instead.
>>>>=20
>>>> Amstrad Delta users should append the followig partition info to =
their
>>>                                        ^^^^^^^^
>>> Should be "following".
>>>=20
>>>> kernel command line, possibly by embedding it in CONFIG_CMDLINE:
>>>> =
mtdparts=3Dams-delta-nand:3584k(Kernel),256k(u-boot),256k(u-boot_params),\=

>>>> 256k(Amstrad_LDR),27m(File_system),768k(PBL_reserved).  For their
>>>> convenience, select CONFIG_MTD_CMDLINE_PARTS  symbol from that =
board
>>>> Kconfig automatically if this NAND driver is also selected.
>>>>=20
>>>> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
>>>> Cc: Tony Lindgren <tony@atomide.com>
>>>=20
>>> Could we move the fixed partition setup to the board file
>>> instead? Otherwise this kind of change is not really nice for the =
users,
>>> as it will likely break existing setups. The default partition =
layout
>>> should remain the same.
>>=20
>> I'm wondering if it would be acceptable to pass partition info from a =
.dts=20
>> file.  I think that would be a better, more modern approach than =
adding a new=20
>> header under include/linux/platform_data.
>=20
> Hmm, I thought there was some generic way to define partitions without
> adding any new headers. But if that is not possible, then I guess your
> CMDLINE proposal is the preferred one..

I am not sure what you exactly need, but partitions can be defined in
the DTS as children of some NAND drivers. Example:
arch/arm/boot/dts/omap3-beagle.dts
So this design pattern could be copied instead of using CMDLINE.



