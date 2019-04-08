Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7178EC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F075213F2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="lRuouKTB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfDHKlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 06:41:11 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:44514 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfDHKlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 06:41:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1554720068; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2ASh0gWc+C/zYcVKvauG8xX2qxl8oRxAF1SgYc++Vdw=;
        b=lRuouKTBgUtaXrSg4EwmYGZnlybEisfDR6wIqtE8vYa8bipPeM46cBXICViXHkXjyqSkM+
        XmllXeh4Fx0xJzXPmLA99CChV0fQKjpGdqpiavDKSHv1mzT5fyCtg4tgv9a0s33swzw3TW
        7Au4yJN2N1KHChZtSwT/eX1In/MIAyk=
Date:   Mon, 08 Apr 2019 12:40:34 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 3/5] media: uapi: Add RGB bus formats for the GiantPlus
 GPM940B0 panel
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>, od@zcrc.me,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Message-Id: <1554720034.1893.1@crapouillou.net>
In-Reply-To: <20190403163259.GS5238@ulmo>
References: <20190314122622.7597-1-paul@crapouillou.net>
        <20190314122622.7597-3-paul@crapouillou.net> <20190403163259.GS5238@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry,

Le mer. 3 avril 2019 =E0 18:32, Thierry Reding=20
<thierry.reding@gmail.com> a =E9crit :
> On Thu, Mar 14, 2019 at 01:26:20PM +0100, Paul Cercueil wrote:
>>  The GiantPlus GPM940B0 is a 24-bit TFT panel where the RGB=20
>> components
>>  are transferred sequentially on a 8-bit bus.
>>=20
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>>=20
>>  Notes:
>>      v2: New patch
>>=20
>>   include/uapi/linux/media-bus-format.h | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> Please make sure you Cc the media maintainers on this one when you=20
> send
> the next version. Adding them now.

Oops. Will do.

>>=20
>>  diff --git a/include/uapi/linux/media-bus-format.h=20
>> b/include/uapi/linux/media-bus-format.h
>>  index d6a5a3bfe6c4..f31724d6cd40 100644
>>  --- a/include/uapi/linux/media-bus-format.h
>>  +++ b/include/uapi/linux/media-bus-format.h
>>  @@ -34,7 +34,7 @@
>>=20
>>   #define MEDIA_BUS_FMT_FIXED			0x0001
>>=20
>>  -/* RGB - next is	0x101b */
>>  +/* RGB - next is	0x101d */
>>   #define MEDIA_BUS_FMT_RGB444_1X12		0x1016
>>   #define MEDIA_BUS_FMT_RGB444_2X8_PADHI_BE	0x1001
>>   #define MEDIA_BUS_FMT_RGB444_2X8_PADHI_LE	0x1002
>>  @@ -54,6 +54,8 @@
>>   #define MEDIA_BUS_FMT_RGB888_1X24		0x100a
>>   #define MEDIA_BUS_FMT_RGB888_2X12_BE		0x100b
>>   #define MEDIA_BUS_FMT_RGB888_2X12_LE		0x100c
>>  +#define MEDIA_BUS_FMT_RGB888_3X8_BE		0x101b
>>  +#define MEDIA_BUS_FMT_RGB888_3X8_LE		0x101c
>=20
> The list looks roughly sorted, but these are not. That said, there are
> others that don't seem like they are sorted either.

To me it looks like it's sorted alphabetically, that's why I
put the two new macros there.

> All the more important to get feedback from the media maintainers.
>=20
> Thierry

=

