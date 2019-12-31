Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D73C2D0DC
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 15:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 578E9206D9
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 15:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbfLaPld convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 10:41:33 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:33745 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfLaPlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 10:41:32 -0500
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 2BBBAC0005;
        Tue, 31 Dec 2019 15:41:27 +0000 (UTC)
Date:   Tue, 31 Dec 2019 16:41:25 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Heiko Stuebner <heiko@sntech.de>
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
Subject: Re: [PATCH v2 10/11] arm64: dts: rockchip: Add PX30 DSI DPHY
Message-ID: <20191231164125.2aaad2e2@xps13>
In-Reply-To: <10740878.zWD4iEhqxt@phil>
References: <20191224143900.23567-1-miquel.raynal@bootlin.com>
        <20191224143900.23567-11-miquel.raynal@bootlin.com>
        <1796464.bE5sXyoQCg@phil>
        <10740878.zWD4iEhqxt@phil>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

Heiko Stuebner <heiko@sntech.de> wrote on Tue, 31 Dec 2019 13:14:02
+0100:

> Am Dienstag, 31. Dezember 2019, 12:56:14 CET schrieb Heiko Stuebner:
> > Am Dienstag, 24. Dezember 2019, 15:38:59 CET schrieb Miquel Raynal:  
> > > Add the PHY which outputs MIPI DSI and LVDS.
> > > 
> > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>  
> > 
> > applied for 5.6 (picked early due to it being shared between lvds and dsi)  
> 
> and I've just added the VO powerdomain to the dsi-dphy node.
> 
> While the TRM is not really forthcoming in telling me if the dphy needs
> the power-domain as well, the vendor kernel does, so we should probably
> just follow their example ;-) .

Agreed!

Miquèl
