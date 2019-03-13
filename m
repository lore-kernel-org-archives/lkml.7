Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DDCCC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 12:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C47D2171F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 12:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="l4ZtSWTO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbfCMMzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 08:55:40 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:32942 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfCMMzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 08:55:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1552481738; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zsSEVUC0BIaGQjpDQt5EuoDLXlWn4F5jnVW8wjVFbpA=;
        b=l4ZtSWTOnmjmPUi+jjyDj/euQBhcc31ykUc0PLkXlKETWxqkmeGyVRlrzKSqsTWkUBf19o
        Q9C4tL9B6L+K57Z4v678X2WQnDn2eBd8TI8xJMtXgvxpqfUlF2mXFcRxKT7e3eDW9yznG5
        EIcK4ajInr1WMT10r8XjXUmTKvd/it0=
Date:   Wed, 13 Mar 2019 09:55:34 -0300
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v4 1/9] dt-bindings: mtd: ingenic: Add compatible strings
 for JZ4740 and JZ4725B
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
Message-Id: <1552481734.2412.1@crapouillou.net>
In-Reply-To: <20190304195149.7cca9c64@xps13>
References: <20190209192305.4434-1-paul@crapouillou.net>
        <20190304104554.09be4cd4@xps13> <1551723742.4932.2@crapouillou.net>
        <20190304195149.7cca9c64@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le lun. 4 mars 2019 =E0 15:51, Miquel Raynal <miquel.raynal@bootlin.com>=20
a =E9crit :
> Hi Paul,
>=20
>>  >>  ---=20
>> a/Documentation/devicetree/bindings/mtd/ingenic,jz4780-nand.txt
>>  >>  +++=20
>> b/Documentation/devicetree/bindings/mtd/ingenic,jz4780-nand.txt
>>  >>  @@ -6,7 +6,10 @@ memory-controllers/ingenic,jz4780-nemc.txt),=20
>> and >> thus NAND device nodes must
>>  >>   be children of the NEMC node.
>>  >> >>   Required NAND controller device properties:
>>  >>  -- compatible: Should be set to "ingenic,jz4780-nand".
>>  >>  +- compatible: Should be one of:
>>  >>  +  * ingenic,jz4740-nand
>>  >>  +  * ingenic,jz4725b-nand
>>  >>  +  * ingenic,jz4780-nand
>>  >
>>  > Wouldn't "-nand-controller" suffix be better? Of course in the=20
>> driver
>>  > you should still check for jz4780-nand.
>>=20
>>  So I would be compatible with:
>>  * ingenic,jz4740-nand-controller
>>  * ingenic,jz4725b-nand-controller
>>  * ingenic,jz4780-nand
>>  ?
>=20
> From a driver POV I would even prefer ingenic,jz4780-nand-controller.=20
> I
> don't know what's best here. Maybe Boris or Rob can help?

The "ingenic,jz4780-nand" compatible string is already out there and=20
used
in devicetree files, so I wouldn't change it just for the sake of it.

-Paul
=

