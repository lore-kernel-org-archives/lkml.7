Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA22C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 15:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB9A122CBB
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 15:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389019AbfGYPRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 11:17:48 -0400
Received: from verein.lst.de ([213.95.11.211]:36175 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388457AbfGYPRr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 11:17:47 -0400
Received: by verein.lst.de (Postfix, from userid 2005)
        id 532AC68B02; Thu, 25 Jul 2019 17:17:42 +0200 (CEST)
Date:   Thu, 25 Jul 2019 17:17:42 +0200
From:   Torsten Duwe <duwe@lst.de>
To:     Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Sean Paul <seanpaul@chromium.org>,
        Harald Geyer <harald@ccbib.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 6/7] dt-bindings: Add ANX6345 DP/eDP transmitter
 binding
Message-ID: <20190725151742.GA4820@lst.de>
References: <20190722151202.5506768B20@verein.lst.de> <CA+E=qVdu3Hf7ufst-t_CiWkquximGFX8B2RcoQ1x0m++cc8n8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+E=qVdu3Hf7ufst-t_CiWkquximGFX8B2RcoQ1x0m++cc8n8Q@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 11:51:36AM -0700, Vasily Khoruzhick wrote:
> On Mon, Jul 22, 2019 at 8:12 AM Torsten Duwe <duwe@lst.de> wrote:
> >
> > The anx6345 is an ultra-low power DisplayPort/eDP transmitter designed
> > for portable devices.
> >
> > Add a binding document for it.
> 
> I believe you'll have to convert it to yaml format.

Right. Thanks for the reminder.

	Torsten

