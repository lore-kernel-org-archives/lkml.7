Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B11C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B67B20850
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfDAKYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 06:24:25 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:34903 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbfDAKYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 06:24:25 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id D4BAAFB05;
        Mon,  1 Apr 2019 12:24:22 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JgDPtYpnb6Jl; Mon,  1 Apr 2019 12:24:21 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 5C85B44B5C; Mon,  1 Apr 2019 12:24:21 +0200 (CEST)
Date:   Mon, 1 Apr 2019 12:24:21 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Thierry Reding <treding@nvidia.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Johan Hovold <johan@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>, Li Jun <jun.li@nxp.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Robert Chiras <robert.chiras@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH RESEND v7 1/3] dt-bindings: Add vendor prefix for Mixel
 Inc
Message-ID: <20190401102421.GB23517@bogon.m.sigxcpu.org>
References: <cover.1553674604.git.agx@sigxcpu.org>
 <e31ffb1d6929e4c961ec90bcdb1ff5e9ecb3380e.1553674604.git.agx@sigxcpu.org>
 <16e92716-17dd-abb5-87dc-601414f22d20@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16e92716-17dd-abb5-87dc-601414f22d20@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,
On Thu, Mar 28, 2019 at 06:04:49PM +0100, Andreas Färber wrote:
> Am 27.03.19 um 09:19 schrieb Guido Günther:
> > Add vendor prefix "mixel" for Mixel Inc. Will be used for a MIPI DSI
> > PHY driver.
> 
> Nit: s/driver/binding/ (to not be Linux specific)
> 
> > 
> > Signed-off-by: Guido Günther <agx@sigxcpu.org>
> > ---
> >  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> > index 413c6f30ce88..97370889039f 100644
> > --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> > +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> > @@ -249,6 +249,7 @@ mikroe		MikroElektronika d.o.o.
> >  minix	MINIX Technology Ltd.
> >  miramems	MiraMEMS Sensing Technology Co., Ltd.
> >  mitsubishi	Mitsubishi Electric Corporation
> > +mixel	Mixel, Inc.
> >  mosaixtech	Mosaix Technologies, Inc.
> >  motorola	Motorola, Inc.
> >  moxa	Moxa Inc.
> 
> Reviewed-by: Andreas Färber <afaerber@suse.de>
> 
> in case you still need it for something else in light of Rob's comment.

You're righgt, using the fsl, prefix this got obsolete but thanks for
having a look!
 -- Guido
