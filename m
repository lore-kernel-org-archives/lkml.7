Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B95C4CECF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 17:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD43020820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 17:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502166AbfIWRBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 13:01:11 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:44203 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388187AbfIWRBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 13:01:10 -0400
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=localhost)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1iCRhw-0003at-P2; Mon, 23 Sep 2019 19:01:04 +0200
Message-ID: <45ad0ec1bfd5af4f46efd7d24c627822ac17fdbf.camel@pengutronix.de>
Subject: Re: [PATCH 5/5] arm64: dts: imx8mq: add DCSS node
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Fabio Estevam <festevam@gmail.com>,
        Laurentiu Palcu <laurentiu.palcu@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Guido =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Mon, 23 Sep 2019 19:00:58 +0200
In-Reply-To: <CAOMZO5AOVfBpz2Azh65iT_W3CBZUxf9KnqA=kdow7XWd4j--Qg@mail.gmail.com>
References: <1569248002-2485-1-git-send-email-laurentiu.palcu@nxp.com>
         <1569248002-2485-6-git-send-email-laurentiu.palcu@nxp.com>
         <CAOMZO5AOVfBpz2Azh65iT_W3CBZUxf9KnqA=kdow7XWd4j--Qg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, den 23.09.2019, 13:12 -0300 schrieb Fabio Estevam:
> Hi Laurentiu,
> 
> On Mon, Sep 23, 2019 at 11:14 AM Laurentiu Palcu
> <laurentiu.palcu@nxp.com> wrote:
> 
> > +
> > +                       dcss: dcss@0x32e00000 {
> 
> Node names should be generic, so:
> 
> dcss: display-controller@32e00000
> 
> > +                               #address-cells = <1>;
> > +                               #size-cells = <0>;
> > +                               compatible = "nxp,imx8mq-dcss";
> > +                               reg = <0x32e00000 0x2D000>,
> > <0x32e2f000 0x1000>;
> 
> 0x2d000 for consistency.
> 
> > +                               interrupts = <6>, <8>, <9>;
> 
> The interrupts are passed in the <GIC_SPI xxx IRQ_TYPE_LEVEL_HIGH>
> format.

No, they are not. Those are imx-irqsteer IRQs, this controller has 0
irq cells, so the description in this patch is correct.

Regards,
Lucas

