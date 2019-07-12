Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A13CC742AE
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 09:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2523D2166E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 09:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfGLJVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 05:21:45 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:40075 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbfGLJVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 05:21:45 -0400
Received: from aptenodytes (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 43BF5100002;
        Fri, 12 Jul 2019 09:21:21 +0000 (UTC)
Date:   Fri, 12 Jul 2019 11:21:21 +0200
From:   "paul.kocialkowski@bootlin.com" <paul.kocialkowski@bootlin.com>
To:     Mirela Rabulea <mirela.rabulea@nxp.com>
Cc:     dl-linux-imx <linux-imx@nxp.com>,
        "s.nawrocki@samsung.com" <s.nawrocki@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vivek.kasireddy@intel.com" <vivek.kasireddy@intel.com>,
        "boris.brezillon@collabora.com" <boris.brezillon@collabora.com>,
        Robert Chiras <robert.chiras@nxp.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "niklas.soderlund+renesas@ragnatech.se" 
        <niklas.soderlund+renesas@ragnatech.se>,
        "sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "ezequiel@collabora.com" <ezequiel@collabora.com>
Subject: Re: Re: [PATCH] media: v4l: Add packed YUV444 24bpp pixel format
Message-ID: <20190712092121.GF15882@aptenodytes>
References: <1562166911-27454-1-git-send-email-mirela.rabulea@nxp.com>
 <20190711081808.GA15389@aptenodytes>
 <1562853469.9511.6.camel@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1562853469.9511.6.camel@nxp.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu 11 Jul 19, 13:57, Mirela Rabulea wrote:
> On Jo, 2019-07-11 at 10:18 +0200, Paul Kocialkowski wrote:
> > Caution: EXT Email
> > 
> > Hi,
> > 
> > On Wed 03 Jul 19, 18:15, Mirela Rabulea wrote:
> > > 
> > > The added format is V4L2_PIX_FMT_YUV24, this is a packed
> > > YUV 4:4:4 format, with 8 bits for each component, 24 bits
> > > per sample.
> > > 
> > > This format is used by the i.MX 8QuadMax and i.MX
> > > 8DualXPlus/8QuadXPlus
> > > JPEG encoder/decoder.
> > So this format is not aligned to 32-bit words at all and we can
> > expect
> > to see cases where a single 32-bit word contains data for two pixels?
> > 
> > Nothing wrong with that, just checking whether I understood this
> > right :)
> > 
> 
> Hi Paul,
> yes, your understanding is correct.

Out of curiosity, is the JPEG block assmiliated to (one of) the Hantro VPUs
or is it a totally different and unrelated hardware block?

Anyway the change looks good to me:
Reviewed-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Cheers,

Paul

-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
