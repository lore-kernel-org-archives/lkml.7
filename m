Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E20C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 16:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BC222081B
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 16:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="L8+mj//p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfCIQV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 11:21:28 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:57088 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfCIQV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 11:21:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1552148483; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0ObnIZZXjIdjz4h/6SKpSit2+zp5DF8vYj96LBwtyng=;
        b=L8+mj//p8gOV1oD614qXuwwt1Vzi4Qb0aXB51fmd1zF4nnupf9lPpJPwtLAf+7R85teBhX
        EhM1c1Fu0MESwAfaczi7pIDfc0V1v1kWAuXsJFODWDWiNuUTN0eRBBTFqycjSw81js/u+v
        RtBa8QLhGfocUuXbDlKGKoSRQeBWKj4=
Date:   Sat, 09 Mar 2019 13:33:54 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 1/3] dt-bindings: Add doc for the ingenic-drm driver
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-mips@vger.kernel.org,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        linux-kernel@vger.kernel.org
Message-Id: <1552134834.2040.0@crapouillou.net>
In-Reply-To: <CACRpkdbtnuHC6Ob-soewxKbH_AR+ijg-zkc_w2ZTBg8qBPkoZw@mail.gmail.com>
References: <20190228220756.20262-1-paul@crapouillou.net>
        <20190228220756.20262-2-paul@crapouillou.net>
        <20190301201624.GA22317@ravnborg.org> <1551480042.1526.0@crapouillou.net>
        <CACRpkdbtnuHC6Ob-soewxKbH_AR+ijg-zkc_w2ZTBg8qBPkoZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Fri, Mar 8, 2019 at 11:23 PM, Linus Walleij=20
<linus.walleij@linaro.org> wrote:
> On Fri, Mar 1, 2019 at 11:41 PM Paul Cercueil <paul@crapouillou.net=20
> <mailto:paul@crapouillou.net>> wrote:
>=20
>>  I also have a board with a "smart" panel (ili9331)
>>  that needs a special configuration in the IP. There is nothing in
>>  the drm_panel interface that tells me what mode I should use for=20
>> what
>>  panel...
>=20
> Is the ILI9331 anything similar to ILI9322 that I have a driver
> for in drivers/gpu/drm/panel/panel-ilitek-ili9322.c?
> I was hoping they would be similar and we =E1=BA=83ould be able
> to just reuse that driver for more of them but I might be
> mistaken.

That's a bit hard to tell right now, but from a quick look at the
datasheet, it looks quite different :(

-Paul

=

