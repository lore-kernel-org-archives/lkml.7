Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC126C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 00:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CEED2084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 00:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbfDBAd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 20:33:28 -0400
Received: from rosenzweig.io ([107.170.207.86]:41664 "EHLO rosenzweig.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbfDBAd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 20:33:27 -0400
Received: by rosenzweig.io (Postfix, from userid 1000)
        id DC61E60923; Mon,  1 Apr 2019 17:33:26 -0700 (PDT)
Date:   Mon, 1 Apr 2019 17:33:26 -0700
From:   Alyssa Rosenzweig <alyssa@rosenzweig.io>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Rob Herring <robh@kernel.org>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Lyude Paul <lyude@redhat.com>,
        Eric Anholt <eric@anholt.net>,
        Neil Armstrong <narmstrong@baylibre.com>,
        "Marty E . Plummer" <hanetzer@startmail.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: Re: [PATCH v2 3/3] drm/panfrost: Add initial panfrost driver
Message-ID: <20190402003326.GB12934@rosenzweig.io>
References: <20190401074730.12241-1-robh@kernel.org>
 <20190401074730.12241-4-robh@kernel.org>
 <6ce32759-ea83-ee79-33d3-237737f7b866@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ce32759-ea83-ee79-33d3-237737f7b866@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> the userspace definitely doesn't support T624

This is true, yes. Shouldn't be too hard to backport; if there's still
interest in Midgard 1st/2nd gen, I suppose I can grab hardware and sort
it out...

> You probably want a dma_set_mask_and_coherent() call for your 'real' output
> address size somewhere - the default 32-bit mask works out OK for RK3399,
> but on systems with RAM above 4GB io-pgtable will get very unhappy about DMA
> bounce-buffering.

Out of curiosity, are there Mali systems with >4GB RAM? That sounds
awesome :)

> Any chance of resurrecting the generic "arm,mali-midgard" compatible? :P

...Would that require editing everybody's DT file?

-----

Thank you for the review!
