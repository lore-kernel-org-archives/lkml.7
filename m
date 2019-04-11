Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD971C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87F172073F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfDKPBK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 11:01:10 -0400
Received: from mailoutvs14.siol.net ([185.57.226.205]:34469 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726106AbfDKPBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 11:01:09 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id C4F96521E9A;
        Thu, 11 Apr 2019 17:01:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Ry6vwnhum7v9; Thu, 11 Apr 2019 17:01:05 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 6D67F521FF5;
        Thu, 11 Apr 2019 17:01:05 +0200 (CEST)
Received: from jernej-laptop.localnet (cpe-86-58-52-202.static.triera.net [86.58.52.202])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Postfix) with ESMTPA id DAC995225D4;
        Thu, 11 Apr 2019 17:01:03 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     =?ISO-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 0/8] Add Allwinner H6 Mali Midgard GPU
Date:   Thu, 11 Apr 2019 17:01:03 +0200
Message-ID: <2219012.spPdo1bsEq@jernej-laptop>
In-Reply-To: <20190411123223.zyumngnlwhlvk6mf@flea>
References: <20190411105720.32357-1-peron.clem@gmail.com> <20190411123223.zyumngnlwhlvk6mf@flea>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Dne četrtek, 11. april 2019 ob 14:32:23 CEST je Maxime Ripard napisal(a):
> On Thu, Apr 11, 2019 at 12:57:12PM +0200, Clément Péron wrote:
> > Hi,
> > 
> > The Allwinner H6 has a Mali-T720 MP2. The drivers are
> > out-of-tree so this series only introduce the dt-bindings.
> > 
> > The first patch is from Neil Amstrong and has been already
> > merged in linux-amlogic. It is required for this series.
> > 
> > The second patch is from Icenowy Zheng where I changed the
> > order has required by Rob Herring.
> > See: https://patchwork.kernel.org/patch/10699829/
> > 
> > The GPU opp table was taken from Jernej Škrabec's patch
> > on LibreELEC.tv.
> 
> One valuable information here would be which stack did you use,
> panfrost and mesa or the ARM stack? If so, with which driver and which
> blob?

I'm using similar binding (different clock and interrupt names, but otherwise  
same) for quiet some time now on LibreELEC with ARM proprietary userspace and 
kernel space driver (32-bit GBM version) and it works well.

It's true that I'm using OPP table, but most (if not all) of the time GPU is 
set to lowest setting as there is not much to do when rendering GUI.

Best regards,
Jernej


