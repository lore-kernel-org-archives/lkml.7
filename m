Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA32EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 12:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 993B2214AE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 12:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="ldehnXed"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbfCMM75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 08:59:57 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:37816 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfCMM74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 08:59:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1552481993; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CQfhMEahN/XrocGBGIFWacACkKiBhn1UP0sVp4+5o4E=;
        b=ldehnXedF7XsNQEdYt+WNCD79TY93OlbKMUJxZq0I6kYpNvO31/WlkBPmRn+Tzo2Ub4qie
        +bwnqvZib1oimQr89EzzXngJ2o/Mgo+Ep31PTI9Q3cqyOXT4/Q2V1zouIwL5jBtMFUXpoh
        pIEPyyG3vR7MMBBAcESULnsRND56Zug=
Date:   Wed, 13 Mar 2019 09:59:48 -0300
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v4 2/9] dt-bindings: mtd: ingenic: Change 'BCH' to 'ECC'
 in documentation
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <1552481988.2412.2@crapouillou.net>
In-Reply-To: <20190304195852.45c056f6@xps13>
References: <20190209192305.4434-1-paul@crapouillou.net>
        <20190209192305.4434-2-paul@crapouillou.net> <20190304105014.0cceea0a@xps13>
        <1551723830.4932.3@crapouillou.net> <20190304195852.45c056f6@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le lun. 4 mars 2019 =E0 15:58, Miquel Raynal <miquel.raynal@bootlin.com>=20
a =E9crit :
> Hi Paul,
>=20
> Paul Cercueil <paul@crapouillou.net> wrote on Mon, 04 Mar 2019=20
> 19:23:50
> +0100:
>=20
>>  On Mon, Mar 4, 2019 at 10:50 AM, Miquel Raynal=20
>> <miquel.raynal@bootlin.com> wrote:
>>  > Hi Paul,
>>  >
>>  > Paul Cercueil <paul@crapouillou.net=20
>> <mailto:paul@crapouillou.net>> > wrote on Sat,  9 Feb 2019 16:22:58
>>  > -0300:
>>  >
>>  >>  The JZ4740 ECC hardware is not BCH but Reed-Solomon, so it=20
>> makes >> more
>>  >>  sense to use the more generic ECC term.
>>  >> >>  Signed-off-by: Paul Cercueil <paul@crapouillou.net >>=20
>> <mailto:paul@crapouillou.net>>
>>  >>  ---
>>  >> >>  Changes:
>>  >> >>  v3: New patch
>>  >> >>  v4: No change
>>  >> >>   .../devicetree/bindings/mtd/ingenic,jz4780-nand.txt    | 18=20
>> >> +++++++++---------
>>  >>   1 file changed, 9 insertions(+), 9 deletions(-)
>>  >> >>  diff --git >>=20
>> a/Documentation/devicetree/bindings/mtd/ingenic,jz4780-nand.txt >>=20
>> b/Documentation/devicetree/bindings/mtd/ingenic,jz4780-nand.txt
>>  >>  index a5b940f18bf6..5a45cc54f46d 100644
>>  >>  ---=20
>> a/Documentation/devicetree/bindings/mtd/ingenic,jz4780-nand.txt
>>  >>  +++=20
>> b/Documentation/devicetree/bindings/mtd/ingenic,jz4780-nand.txt
>>  >>  @@ -1,4 +1,4 @@
>>  >>  -* Ingenic JZ4780 NAND/BCH
>>  >>  +* Ingenic JZ4780 NAND/ECC
>>  >> >>   This file documents the device tree bindings for NAND flash=20
>> >> devices on the
>>  >>   JZ4780. NAND devices are connected to the NEMC controller >>=20
>> (described in
>>  >>  @@ -14,10 +14,10 @@ Required NAND controller device properties:
>>  >>     an offset of 0 and a size of 0x1000000 (i.e. the whole NEMC=20
>> >> bank).
>>  >> >>   Optional NAND controller device properties:
>>  >>  -- ingenic,bch-controller: To make use of the hardware BCH >>=20
>> controller, this
>>  >>  -  property must contain a phandle for the BCH controller node.=20
>> The >> required
>>  >>  +- ingenic,bch-controller: To make use of the hardware ECC >>=20
>> controller, this
>>  >>  +  property must contain a phandle for the ECC controller node.=20
>> The >> required
>>  >
>>  > I think there is already a 'ecc-engine' property used by MTK and=20
>> Atmel
>>  > NAND controllers to point to the ECC engine block. Please use this
>>  > property instead of the ingenic specific one.
>>=20
>>  ingenic,bch-controller is already in the devicetree ABI. I can't=20
>> change it now...
>=20
> Oh, right...
>=20
> Well, same thing as before, maybe you can change it and keep the=20
> driver
> backward compatible? I don't want new DT to use this property because
> it is not generic and we must have a way from the core to find the ECC
> engine handle when the controller does not embed one itself (thus, the
> ecc-engine property which is around for quite some time already).

I can do that. Will the new ECC framework work with the "ecc-engine"=20
property?

-Paul
=

