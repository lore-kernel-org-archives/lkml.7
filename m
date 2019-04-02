Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43D3C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64BC1206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="PszZZJg/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbfDBPzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 11:55:22 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:40654 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfDBPzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 11:55:22 -0400
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 026782F9;
        Tue,  2 Apr 2019 17:55:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1554220519;
        bh=AqxZQiKDtQ65G/urRT/g8CJJ5XGWlTTEs9zePjluNnc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PszZZJg/mXFWFus9q4HLoHLyU1dPryC/tU3K0iUBB2Lu7/KlQ5BeQjtxVbUfRt8Ov
         gc+vhZRzjDKiQJpjnC78ELNpbWPaJJATOjILvZJWMbjm2YxyVGJ4hUFWc1IbYWDCR1
         tjdu5HWSOeQ+spcR8Cv+FKRDWaFjc616TejLi0s4=
Date:   Tue, 2 Apr 2019 18:55:08 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sebastian Reichel <sre@kernel.org>,
        Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv5 0/6] omapdrm: DSI command mode panel support
Message-ID: <20190402155508.GJ4805@pendragon.ideasonboard.com>
References: <20181121160916.22017-1-sebastian.reichel@collabora.com>
 <3fed7238-776e-9ee7-9c54-b7c44a5e3a2e@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3fed7238-776e-9ee7-9c54-b7c44a5e3a2e@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 06:36:21PM +0300, Tomi Valkeinen wrote:
> On 21/11/2018 18:09, Sebastian Reichel wrote:
> > Hi,
> > 
> > Here is another round of the DSI command mode panel patchset
> > integrating the feedback from PATCHv4. The patches are based
> > on 4.20-rc1 + fixes from Laurent and Tony. I dropped the patches
> > for OMAP3 support (it needs a workaround for a hardware bug) and
> > for automatic display rotation. They should get their own series,
> > once this patchset has landed.
> 
> The big omapdrm bridge/panel series from Laurent has been merged to
> drm-next. I think this series can now be rebased and merged.
> 
> However, all this needs to be changed to DRM bridge/panel model sooner
> or later (sooner, please!), but perhaps it's best to first go with the
> legacy way.

I would be OK with that, but I'd like to understand what we still need
to do to convert DSI support to DRM bridge and panel. Sebastian, if
you've looked into it, could you provide some insight ?

-- 
Regards,

Laurent Pinchart
