Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82185C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 09:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FD7420833
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 09:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbfEQJrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 05:47:31 -0400
Received: from verein.lst.de ([213.95.11.211]:36563 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727537AbfEQJrb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 05:47:31 -0400
Received: by newverein.lst.de (Postfix, from userid 2005)
        id D876F68B02; Fri, 17 May 2019 11:47:08 +0200 (CEST)
Date:   Fri, 17 May 2019 11:47:08 +0200
From:   Torsten Duwe <duwe@lst.de>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Sean Paul <seanpaul@chromium.org>,
        Harald Geyer <harald@ccbib.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] arm64: DTS: allwinner: a64: enable ANX6345 bridge
 on Teres-I
Message-ID: <20190517094708.GA16858@lst.de>
References: <20190514160241.9EAC768C7B@newverein.lst.de> <CA+E=qVfuKBzWK7dpM_eabjU8mLdzOw3zCnYk6Tc1oXdavH7CNA@mail.gmail.com> <20190515093141.41016b11@blackhole.lan> <CA+E=qVf6K_0T0x2Hsfp6EDqM-ok6xiAzeZPvp6SRg0yt010pKA@mail.gmail.com> <20190516154820.GA10431@lst.de> <CA+E=qVe5NkAvHXPvVc7iTbZn5sKeoRm0166zPW_s83c2gk7B+g@mail.gmail.com> <20190516164859.GB10431@lst.de> <20190517072738.deohh5fly4jxms7k@flea> <20190517101353.3e86d696@blackhole.lan> <20190517090845.oujs33nplbaxcyun@flea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517090845.oujs33nplbaxcyun@flea>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2019 at 11:08:45AM +0200, Maxime Ripard wrote:
> >
> > So for all current practical purposes, we can assume the Teres-I panel
> > to be powered properly and providing valid EDID; nothing to worry about
> > in software.
> 
> You're creating a generic binding for all the users of that bridge,
> while considering only the specific case of the Teres-I.

All I'm saying is that _this_ usage is also valid. Nothing keeps other
users from defining the output panel; on the contrary: the driver at hand
already considers an _optional_ panel and handles it, conditionally. So
driver and binding spec are 100% in sync here.

This is much more straightforward than requiring an output and making up
some dummy code and params because it cannot reasonably be handled.
(Remember, if there is an output, the driver will make calls to the
"attached device" driver.)

	Torsten

