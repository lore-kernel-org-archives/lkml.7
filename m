Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A313DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70A782184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="ZAXSvq0R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfCTJRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 05:17:30 -0400
Received: from onstation.org ([52.200.56.107]:50346 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726692AbfCTJR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 05:17:29 -0400
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 43239450F9;
        Wed, 20 Mar 2019 09:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1553073448;
        bh=hOay8bTvUV8BiOGXOSp9hvPqiNcZjWQC2j9Zg27/lPo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZAXSvq0RmC+CxgOTHw/nIAqaqjnZthxu2ObOrb4BwP4bHWt3yZ5pJm/pxYLMTA+t3
         IB0KllWuVqccUYID3VVczVvIs3cdvXr1fJ4K9CnI9VIY+IyIl+1CLY04xLD5H74JR0
         93b1UsSkum24IY2jk10miDp4qEPScCZH/01UIp60=
Date:   Wed, 20 Mar 2019 05:17:27 -0400
From:   Brian Masney <masneyb@onstation.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Dave Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Jonathan Marek <jonathan@marek.ca>
Subject: Re: [PATCH 1/2] dt-bindings: drm/panel: simple: add lg,acx467akm-7
 panel
Message-ID: <20190320091727.GA13882@basecamp>
References: <20181124200628.24393-1-masneyb@onstation.org>
 <CACRpkdYqxUJKZGHGX0qPVaSVW4vzHYBMp-FARA2uP85W9AX5wA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdYqxUJKZGHGX0qPVaSVW4vzHYBMp-FARA2uP85W9AX5wA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Tue, Mar 05, 2019 at 11:42:15PM +0100, Linus Walleij wrote:
> On Sat, Nov 24, 2018 at 9:06 PM Brian Masney <masneyb@onstation.org> wrote:
> 
> > Add binding for the LG ACX467AKM-7 4.95" 1080×1920 LCD panel that is
> > found on the LG Nexus 5 (hammerhead) phone. This appears to be a JDI
> > panel based on some Internet searches, however a specific model number
> > could not be found. I disassembled an old Nexus 5 with a broken
> > screen and the LG part number is the only model number present on the
> > back of the panel, so I think that is probably the best ID to use.
> >
> > Signed-off-by: Brian Masney <masneyb@onstation.org>
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Tell me if you need me to merge this to the DRM misc tree.

It would be great if you could take this patch, plus the corresponding
change to panel-simple.c [1]

[1] https://lore.kernel.org/lkml/20181124200628.24393-2-masneyb@onstation.org/

Thanks,

Brian
