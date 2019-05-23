Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E430AC04AAC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 06:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFBD620879
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 06:50:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbfEWGuj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 02:50:39 -0400
Received: from verein.lst.de ([213.95.11.211]:44318 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725814AbfEWGuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 02:50:39 -0400
Received: by newverein.lst.de (Postfix, from userid 2005)
        id 2719D68B05; Thu, 23 May 2019 08:50:13 +0200 (CEST)
From:   Torsten Duwe <duwe@lst.de>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Sean Paul <seanpaul@chromium.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Harald Geyer <harald@ccbib.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] Add anx6345 DP/eDP bridge for Olimex Teres-I
Message-Id: <20190523065013.2719D68B05@newverein.lst.de>
Date:   Thu, 23 May 2019 08:50:13 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

left over from my previous Teres-I device tree series, here comes
the revised anx6345 node for the Teres-I, along with the driver.
The innolux panel attached to it is already known; pinebooks can be
enabled on top of this series, once their panels are introduced.

Changes from the respective previous versions:

* the reset polarity is corrected in DT and the driver;
  things should be clearer now.

* as requested, add a panel (the known innolux,n116bge) and connect
  the ports.

* renamed dvdd?? to *-supply to match the established scheme

* trivial update to the #include list, to make it compile in 5.2

	Torsten
  
