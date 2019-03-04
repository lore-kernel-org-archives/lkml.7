Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF5EC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89B7620663
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="Ool6FC75"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbfCDSX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 13:23:59 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:44706 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbfCDSX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 13:23:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1551723837; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2VdIgxbkW7jJs7e+lCM6DVrb4aw/Z8hcXtudCrVXd2w=;
        b=Ool6FC75VgDObHgCIH6EXieLyfxAguSo0HGYl1AaLaNhyNMs2ZV2//vfO72jai2DsJosKw
        fl3j7j6uam1DHpJONdndwgwToymWGpRugw7XlhqCDakoh5NIgi9T/i/3h2UtUnD25n/6gp
        Cd0Dg2yPnUId9jQdf8Trgun6gAYaDTU=
Date:   Mon, 04 Mar 2019 19:23:50 +0100
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
Message-Id: <1551723830.4932.3@crapouillou.net>
In-Reply-To: <20190304105014.0cceea0a@xps13>
References: <20190209192305.4434-1-paul@crapouillou.net>
        <20190209192305.4434-2-paul@crapouillou.net> <20190304105014.0cceea0a@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, Mar 4, 2019 at 10:50 AM, Miquel Raynal=20
<miquel.raynal@bootlin.com> wrote:
> Hi Paul,
>=20
> Paul Cercueil <paul@crapouillou.net <mailto:paul@crapouillou.net>>=20
> wrote on Sat,  9 Feb 2019 16:22:58
> -0300:
>=20
>>  The JZ4740 ECC hardware is not BCH but Reed-Solomon, so it makes=20
>> more
>>  sense to use the more generic ECC term.
>>=20
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net=20
>> <mailto:paul@crapouillou.net>>
>>  ---
>>=20
>>  Changes:
>>=20
>>  v3: New patch
>>=20
>>  v4: No change
>>=20
>>   .../devicetree/bindings/mtd/ingenic,jz4780-nand.txt    | 18=20
>> +++++++++---------
>>   1 file changed, 9 insertions(+), 9 deletions(-)
>>=20
>>  diff --git=20
>> a/Documentation/devicetree/bindings/mtd/ingenic,jz4780-nand.txt=20
>> b/Documentation/devicetree/bindings/mtd/ingenic,jz4780-nand.txt
>>  index a5b940f18bf6..5a45cc54f46d 100644
>>  --- a/Documentation/devicetree/bindings/mtd/ingenic,jz4780-nand.txt
>>  +++ b/Documentation/devicetree/bindings/mtd/ingenic,jz4780-nand.txt
>>  @@ -1,4 +1,4 @@
>>  -* Ingenic JZ4780 NAND/BCH
>>  +* Ingenic JZ4780 NAND/ECC
>>=20
>>   This file documents the device tree bindings for NAND flash=20
>> devices on the
>>   JZ4780. NAND devices are connected to the NEMC controller=20
>> (described in
>>  @@ -14,10 +14,10 @@ Required NAND controller device properties:
>>     an offset of 0 and a size of 0x1000000 (i.e. the whole NEMC=20
>> bank).
>>=20
>>   Optional NAND controller device properties:
>>  -- ingenic,bch-controller: To make use of the hardware BCH=20
>> controller, this
>>  -  property must contain a phandle for the BCH controller node. The=20
>> required
>>  +- ingenic,bch-controller: To make use of the hardware ECC=20
>> controller, this
>>  +  property must contain a phandle for the ECC controller node. The=20
>> required
>=20
> I think there is already a 'ecc-engine' property used by MTK and Atmel
> NAND controllers to point to the ECC engine block. Please use this
> property instead of the ingenic specific one.

ingenic,bch-controller is already in the devicetree ABI. I can't change=20
it now...

>>     properties for this node are described below. If this is not=20
>> specified,
>>  -  software BCH will be used instead.
>>  +  software ECC will be used instead.
>>=20
>>   Optional children nodes:
>>   - Individual NAND chips are children of the NAND controller node.
>>  @@ -70,17 +70,17 @@ nemc: nemc@13410000 {
>>   	};
>>   };
>>=20
>>  -The BCH controller is a separate SoC component used for error=20
>> correction on
>>  +The ECC controller is a separate SoC component used for error=20
>> correction on
>>   NAND devices. The following is a description of the device=20
>> properties for a
>>  -BCH controller.
>>  +ECC controller.
>>=20
>>  -Required BCH properties:
>>  +Required ECC properties:
>>   - compatible: Should be one of:
>>     * ingenic,jz4740-ecc
>>     * ingenic,jz4725b-bch
>>     * ingenic,jz4780-bch
>>  -- reg: Should specify the BCH controller registers location and=20
>> length.
>>  -- clocks: Clock for the BCH controller.
>>  +- reg: Should specify the ECC controller registers location and=20
>> length.
>>  +- clocks: Clock for the ECC controller.
>>=20
>>   Example:
>>=20
>=20
> Thanks,
> Miqu=E8l

=

