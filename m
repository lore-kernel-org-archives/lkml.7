Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BE6C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 13:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D09E9206D8
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 13:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="er4Y+Dsf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbfLPNkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 08:40:00 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:43970 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727609AbfLPNkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 08:40:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1576503598; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I7vYLgIsS5tJQdkPlZ9agIsnannevGQoUa/+rxeDUjY=;
        b=er4Y+DsflE5wUPtNmfE+vP4acAeAWY2VasEC5ZAK0iwplyEheRxoF8oC8WW16PAZ3sBGK5
        g/L+Xb7D38tLwomnMp060HpmiumzH8/nW1obInbZ7Dj2TwgSzXPHzSm8opYwCwR1WXbYWr
        PqhDYdgDzDakj5IgDit7Slkbr29+23E=
Date:   Mon, 16 Dec 2019 14:39:53 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 1/6] dt-bindings: display/ingenic: Add compatible
 string for JZ4770
To:     Ville =?iso-8859-1?b?U3lyauRs5A==?= 
        <ville.syrjala@linux.intel.com>
Cc:     Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Message-Id: <1576503593.3.2@crapouillou.net>
In-Reply-To: <20191216131529.GN1208@intel.com>
References: <20191210144142.33143-1-paul@crapouillou.net>
        <20191214105418.GA5687@ravnborg.org> <20191216131529.GN1208@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ville,


Le lun., d=E9c. 16, 2019 at 15:15, Ville Syrj=E4l=E4=20
<ville.syrjala@linux.intel.com> a =E9crit :
> On Sat, Dec 14, 2019 at 11:54:18AM +0100, Sam Ravnborg wrote:
>>  Hi Paul.
>>=20
>>  On Tue, Dec 10, 2019 at 03:41:37PM +0100, Paul Cercueil wrote:
>>  > Add a compatible string for the LCD controller found in the=20
>> JZ4770 SoC.
>>  >
>>  > v2: No change
>>  >
>>  > Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  > Acked-by: Rob Herring <robh@kernel.org>
>>=20
>>  Whole series looks good.
>>  Acked-by: Sam Ravnborg <sam@ravnborg.org>
>=20
> Paul, looks like you forgot to git commit --amend after adding the=20
> tags.
> Now the commit messages have and extra "# *** extracted tags ***" in=20
> them.

Sorry, I'm still relatively new to this :(

I thought they were going to be automatically removed since they are=20
comments.

-Paul

=

