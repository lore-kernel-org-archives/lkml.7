Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5667DC32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 12:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 253E3217D4
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 12:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731009AbfHBMDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 08:03:54 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:47819 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbfHBMDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 08:03:54 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1htWHk-0006HX-Oz; Fri, 02 Aug 2019 14:03:48 +0200
Message-ID: <1564747425.3090.1.camel@pengutronix.de>
Subject: Re: [PATCH] drm/imx: Drop unused imx-ipuv3-crtc.o build
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Fabio Estevam <festevam@gmail.com>,
        Guido =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Fri, 02 Aug 2019 14:03:45 +0200
In-Reply-To: <CAOMZO5BipmSPR1jz3ov8ESSJPsHMViMw42di-WKOdqhyONLK6Q@mail.gmail.com>
References: <e5484fa33bffec220fd0590b502a962da17c9c72.1564743270.git.agx@sigxcpu.org>
         <CAOMZO5BipmSPR1jz3ov8ESSJPsHMViMw42di-WKOdqhyONLK6Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guido, Fabio,

On Fri, 2019-08-02 at 08:03 -0300, Fabio Estevam wrote:
> Hi Guido,
> 
> Good catch!
> 
> On Fri, Aug 2, 2019 at 7:55 AM Guido Günther <agx@sigxcpu.org> wrote:
> > 
> > Since
> > 
> > commit 3d1df96ad468 ("drm/imx: merge imx-drm-core and ipuv3-crtc in one module")
> > 
> > imx-ipuv3-crtc.o is built via imxdrm-objs. So there's no need to keep an
> 
> Actually, it is ipuv3-crtc.o that is built via imxdrm-objs, not
> imx-ipuv3-crtc.o.
> 
> Apart from that:
> 
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

Thank you, applied to imx-drm/next with Fabio's R-b, and added Fixes:
tag, and the commit message changed as follows:

    drm/imx: Drop unused imx-ipuv3-crtc.o build
    
    Since
    
    commit 3d1df96ad468 ("drm/imx: merge imx-drm-core and ipuv3-crtc in one module")
    
    the former contents of imx-ipuv3-crtc.o are built via imxdrm-objs. So
    there's no need to keep an extra entry with a non existing config value
    (CONFIG_DRM_IMX_IPUV3).
    
    Fixes: 3d1df96ad468 ("drm/imx: merge imx-drm-core and ipuv3-crtc in one module")
    Signed-off-by: Guido Günther <agx@sigxcpu.org>
    Reviewed-by: Fabio Estevam <festevam@gmail.com>
    Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

no action necessary if you agree, otherwise just send a v2 and I'll
replace it.

regards
Philipp
