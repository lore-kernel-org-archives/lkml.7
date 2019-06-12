Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CEDC31E47
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 038D1206E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="nkRUMm+M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436598AbfFLIuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 04:50:01 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:53834 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfFLIuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 04:50:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1560329398; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qI8IlvgG3xtgR+kPR9NmFwLa8z15R4AFwa5PzuA3tsw=;
        b=nkRUMm+MmQ3Z4Poafx518YANlIeZoQ1q6oucK0Gym45Q4O0ovk2TX8p7NxBFAKT7mFrvVc
        Eiu3/JU9eofLGdOPC7QIqaGuglgk9LXEtddQxc4wmi2AmGeGVh4k/tKMLb+pLu7XJn9Uzl
        FYkCR6nTFUepT40VYhfFNfKM1TIhYRY=
Date:   Wed, 12 Jun 2019 10:49:52 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v5 1/2] dt-bindings: Add doc for the Ingenic JZ47xx LCD
 controller driver
To:     Rob Herring <robh@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, od@zcrc.me,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Artur Rojek <contact@artur-rojek.eu>
Message-Id: <1560329392.1823.1@crapouillou.net>
In-Reply-To: <20190611215554.GA23791@bogus>
References: <20190603152331.23160-1-paul@crapouillou.net>
        <20190611215554.GA23791@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le mar. 11 juin 2019 =E0 23:55, Rob Herring <robh@kernel.org> a =E9crit :
> On Mon,  3 Jun 2019 17:23:30 +0200, Paul Cercueil wrote:
>>  Add documentation for the devicetree bindings of the LCD controller=20
>> present in
>>  the JZ47xx family of SoCs from Ingenic.
>>=20
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  Tested-by: Artur Rojek <contact@artur-rojek.eu>
>>  ---
>>=20
>>  Notes:
>>      v2: Remove ingenic,panel property.
>>=20
>>      v3: - Rename compatible strings from ingenic,jz47XX-drm to=20
>> ingenic,jz47XX-lcd
>>          - The ingenic,lcd-mode property is now read from the panel=20
>> node instead
>>      	  of from the driver node
>>=20
>>      v4: Remove ingenic,lcd-mode property completely.
>>=20
>>      v5: No change
>>=20
>>   .../bindings/display/ingenic,lcd.txt          | 44=20
>> +++++++++++++++++++
>>   1 file changed, 44 insertions(+)
>>   create mode 100644=20
>> Documentation/devicetree/bindings/display/ingenic,lcd.txt
>>=20
>=20
> Please add Acked-by/Reviewed-by tags when posting new versions.=20
> However,
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.
>=20
> If a tag was not added on purpose, please state why and what changed.

Sorry Rob, my mistake. I simply forgot that you ever reviewed that=20
patch.

=

