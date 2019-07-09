Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18072C606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 03:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7B79216C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 03:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="FAKYRBQO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbfGIDSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 23:18:37 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:48852 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfGIDSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 23:18:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1562642313; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pzy3NwVjkusfZHFaTz046qoprbVpGHFFowMHni2vKtY=;
        b=FAKYRBQOCMleXkDI4SHI3KoMWnQ0xln8qD1jRqi8ki6Grz/6w0gtIXbzMqQs75W46LVFid
        f/YIylx7EA97zTZvDMndKAP0Audad4Ic7N2eOK87xraEVSBW5jIzlI46JyRis7eLd/emjV
        YqXSYYUHp7i8WAhgzPFpOuk5RqfpX8g=
Date:   Mon, 08 Jul 2019 23:18:19 -0400
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 1/6] dt-bindings: Remove unused compatible strings
To:     Rob Herring <robh@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>, od@zcrc.me,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <1562642299.1834.0@crapouillou.net>
In-Reply-To: <20190709020425.GA7984@bogus>
References: <20190607154410.10633-1-paul@crapouillou.net>
        <20190607154410.10633-2-paul@crapouillou.net> <20190709020425.GA7984@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le lun. 8 juil. 2019 =E0 22:04, Rob Herring <robh@kernel.org> a =E9crit :
> On Fri, Jun 07, 2019 at 05:44:05PM +0200, Paul Cercueil wrote:
>>  Right now none of the Ingenic-based boards probe this driver from
>>  devicetree. This driver defined three compatible strings for the=20
>> exact
>>  same behaviour. Before these strings are used, we can remove two of
>>  them.
>>=20
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>>=20
>>  Notes:
>>      v2: Rebase on v5.2-rc3
>>=20
>>   Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt | 5=20
>> +----
>>   1 file changed, 1 insertion(+), 4 deletions(-)
>>=20
>>  diff --git=20
>> a/Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt=20
>> b/Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt
>>  index 7d9d3f90641b..493bec80d59b 100644
>>  --- a/Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt
>>  +++ b/Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt
>>  @@ -2,10 +2,7 @@ Ingenic JZ47xx PWM Controller
>>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>>=20
>>   Required properties:
>>  -- compatible: One of:
>>  -  * "ingenic,jz4740-pwm"
>>  -  * "ingenic,jz4770-pwm"
>>  -  * "ingenic,jz4780-pwm"
>>  +- compatible: Should be "ingenic,jz4740-pwm"
>=20
> Are you sure all 3 chips are exactly the same features and bugs?

The hardware on these chips have tiny differences, but the current
driver code works on all the SoCs.


> The correct thing to do here generally is the 4770 and 4780 would also
> have ingenic,jz4740-pwm as a fallback compatible. Then the driver can
> match on that until you find some difference and can use the more
> specific compatible.

Why not just update the devicetree with the new compatible string when
a difference is found?


>>   - #pwm-cells: Should be 3. See pwm.txt in this directory for a=20
>> description
>>     of the cells format.
>>   - clocks : phandle to the external clock.
>>  --
>>  2.21.0.593.g511ec345e18
>>=20

=

