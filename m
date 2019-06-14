Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634E5C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 404F821537
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbfFNOLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 10:11:46 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:40887 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728218AbfFNOLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 10:11:46 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1hbmvh-0001zd-17; Fri, 14 Jun 2019 16:11:45 +0200
Message-ID: <1560521504.18257.2.camel@pengutronix.de>
Subject: Re: [PATCH 3/3] gpu: ipu-v3: image-convert: Fix image downsize
 coefficients
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Steve Longerbeam <slongerbeam@gmail.com>
Cc:     "open list:DRM DRIVERS FOR FREESCALE IMX" 
        <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Fri, 14 Jun 2019 16:11:44 +0200
In-Reply-To: <20190612011657.12119-3-slongerbeam@gmail.com>
References: <20190612011657.12119-1-slongerbeam@gmail.com>
         <20190612011657.12119-3-slongerbeam@gmail.com>
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

On Tue, 2019-06-11 at 18:16 -0700, Steve Longerbeam wrote:
> The output of the IC downsizer unit in both dimensions must be <= 1024
> before being passed to the IC resizer unit. This was causing corrupted
> images when:
> 
> input_dim > 1024, and
> input_dim / 2 < output_dim < input_dim
> 
> Some broken examples were 1920x1080 -> 1024x768 and 1920x1080 ->
> 1280x1080.
> 
> Fixes: 70b9b6b3bcb21 ("gpu: ipu-v3: image-convert: calculate per-tile
> resize coefficients")
> 
> Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>

All applied on the imx-drm/fixes branch.

regards
Philipp
