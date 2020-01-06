Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC385C33C9E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 11:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC5F620731
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 11:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgAFLJc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 06:09:32 -0500
Received: from gloria.sntech.de ([185.11.138.130]:50070 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbgAFLJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 06:09:31 -0500
Received: from ip5f5a5f74.dynamic.kabel-deutschland.de ([95.90.95.116] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1ioQG8-0004XS-2c; Mon, 06 Jan 2020 12:09:20 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Sandy Huang <hjc@rock-chips.com>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 00/11] Add PX30 LVDS support
Date:   Mon, 06 Jan 2020 12:09:19 +0100
Message-ID: <2064471.Uj1soXtvLx@diego>
In-Reply-To: <1885398.klecWcqSHf@phil>
References: <20191224143900.23567-1-miquel.raynal@bootlin.com> <1885398.klecWcqSHf@phil>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 5. Januar 2020, 15:05:26 CET schrieb Heiko Stuebner:
> Am Dienstag, 24. Dezember 2019, 15:38:49 CET schrieb Miquel Raynal:
> > Hello,
> > 
> > This series aims at supporting LVDS on PX30.
> > 
> > A first couple of patches update the documentation with the new
> > compatible and the presence of a PHY. Then, the existing Rockchip
> > driver is cleaned and extended to support PX30 specificities. Finally,
> > the PX30 DTSI is updated with CRTC routes, the DSI DPHY and the LVDS
> > IP itself.
> > 
> > Cheers,
> > Miquèl
> > 
> > Changes since v1:
> > * Added Rob's Ack.
> > * Used "must" instead of "should" in the bindings.
> > * Precised that phy-names is an optional property in the case of
> >   PX30.
> > * Renamed the WRITE_EN macro into HIWORD_UPDATE to be aligned with
> >   other files.
> > * Removed extra configuration, not needed for generic panels (see
> >   Sandy Huang answer).
> > * Dropped the display-subsystem routes (useless).
> > * Merged two patches to avoid phandle interdependencies in graphs and
> >   intermediate build errors.
> > 
> > Miquel Raynal (11):
> >   dt-bindings: display: rockchip-lvds: Declare PX30 compatible
> >   dt-bindings: display: rockchip-lvds: Document PX30 PHY
> >   drm/rockchip: lvds: Fix indentation of a #define
> >   drm/rockchip: lvds: Harmonize function names
> >   drm/rockchip: lvds: Change platform data
> >   drm/rockchip: lvds: Create an RK3288 specific probe function
> >   drm/rockchip: lvds: Helpers should return decent values
> >   drm/rockchip: lvds: Pack functions together
> 
> applied patches 1-8 to drm-misc-next
> 
> >   drm/rockchip: lvds: Add PX30 support
> 
> drm-misc-next is currently still at 5.4-rc4, so I'll need to find out how
> to get newer kernel changes in there, as right now we're missing
> the PHY_MODE_LVDS constant.

applied now to drm-misc-next as well, after drm-misc maintainers did the
requested back-merge to get that constant.

Heiko


