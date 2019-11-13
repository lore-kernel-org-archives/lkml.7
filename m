Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F17BAC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 07:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D324A21A49
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 07:41:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfKMHlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 02:41:22 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34349 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfKMHlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 02:41:22 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iUnGz-0007gc-KI; Wed, 13 Nov 2019 08:41:05 +0100
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1iUnGy-0007xK-Ci; Wed, 13 Nov 2019 08:41:04 +0100
Date:   Wed, 13 Nov 2019 08:41:04 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Oliver Graute <oliver.graute@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCHv7 2/3] ARM: dts: Add support for i.MX6 UltraLite DART
 Variscite Customboard
Message-ID: <20191113074104.nbcc6kopsr3ow4kt@pengutronix.de>
References: <1573586526-15007-1-git-send-email-oliver.graute@gmail.com>
 <1573586526-15007-3-git-send-email-oliver.graute@gmail.com>
 <CAOMZO5DX_-zSHJjDigK2c=dVLEMxvfd_dFCu=0fbyjht1gsr=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5DX_-zSHJjDigK2c=dVLEMxvfd_dFCu=0fbyjht1gsr=A@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 08:40:28 up 179 days, 13:58, 119 users,  load average: 0.13, 0.07,
 0.01
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-11-12 20:17, Fabio Estevam wrote:
> Hi Oliver,
> 
> On Tue, Nov 12, 2019 at 4:22 PM Oliver Graute <oliver.graute@gmail.com> wrote:
> 
> > +&lcdif {
> > +       pinctrl-names = "default";
> > +       pinctrl-0 = <&pinctrl_lcdif>;
> > +       display = <&display0>;
> > +       status = "okay";
> > +
> > +       display0: display0 {
> > +               bits-per-pixel = <16>;
> > +               bus-width = <24>;
> > +
> > +               display-timings {
> > +                       native-mode = <&timing0>;
> > +                       timing0: timing0 {
> > +                               clock-frequency =<35000000>;
> > +                               hactive = <800>;
> > +                               vactive = <480>;
> > +                               hfront-porch = <40>;
> > +                               hback-porch = <40>;
> > +                               hsync-len = <48>;
> > +                               vback-porch = <29>;
> > +                               vfront-porch = <13>;
> > +                               vsync-len = <3>;
> > +                               hsync-active = <0>;
> > +                               vsync-active = <0>;
> > +                               de-active = <1>;
> > +                               pixelclk-active = <0>;
> > +                       };
> > +               };
> > +       };
> > +};
> 
> You are using the deprecated bindings.
> 
> Please switch to the DRM bindings as stated at
> Documentation/devicetree/bindings/display/mxsfb.txt
> 
> You should also add your panel to the simple panel driver.

That would be the best solution :)

Regards,
  Marco
