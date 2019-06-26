Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68DB2C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 08:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3855720663
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 08:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbfFZIda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 04:33:30 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:39769 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfFZId3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 04:33:29 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1hg3Ml-0004LD-L5; Wed, 26 Jun 2019 10:33:19 +0200
Message-ID: <1561537996.4870.3.camel@pengutronix.de>
Subject: Re: [PATCH v3 4/4] drm/imx: only send event on crtc disable if kept
 disabled
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Daniel Vetter <daniel@ffwll.ch>,
        Robert Beckett <bob.beckett@collabora.com>
Cc:     dri-devel@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date:   Wed, 26 Jun 2019 10:33:16 +0200
In-Reply-To: <20190625202244.GG12905@phenom.ffwll.local>
References: <cover.1561483965.git.bob.beckett@collabora.com>
         <6599f538740632c5524bab86514b8ba026798537.1561483965.git.bob.beckett@collabora.com>
         <20190625202244.GG12905@phenom.ffwll.local>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-06-25 at 22:22 +0200, Daniel Vetter wrote:
> On Tue, Jun 25, 2019 at 06:59:15PM +0100, Robert Beckett wrote:
> > The event will be sent as part of the vblank enable during the modeset
> > if the crtc is not being kept disabled.
> > 
> > Fixes: 5f2f911578fb ("drm/imx: atomic phase 3 step 1: Use atomic configuration")
> > 
> > Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
> 
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Thank you, patches 2 and 4 applied to imx-drm/fixes.

regards
Philipp
