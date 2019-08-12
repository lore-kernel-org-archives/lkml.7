Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E74CC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D1F92085A
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbfHLKxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 06:53:45 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55822 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727235AbfHLKxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 06:53:45 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 6DF4E28BC11
Message-ID: <d71d504c2c73af04ce7a92c27f2d33f101c0cdf5.camel@collabora.com>
Subject: Re: [PATCH v4 05/11] media: uapi: h264: Get rid of the p0/b0/b1
 ref-lists
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org
Cc:     kernel@collabora.com,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Jonas Karlman <jonas@kwiboo.se>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        fbuergisser@chromium.org, linux-kernel@vger.kernel.org
Date:   Mon, 12 Aug 2019 07:53:32 -0300
In-Reply-To: <62750a74-f856-c927-72a3-17d1a2624550@xs4all.nl>
References: <20190808103432.12062-1-ezequiel@collabora.com>
         <20190808103432.12062-6-ezequiel@collabora.com>
         <62750a74-f856-c927-72a3-17d1a2624550@xs4all.nl>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-08-12 at 12:20 +0200, Hans Verkuil wrote:
> On 8/8/19 12:34 PM, Ezequiel Garcia wrote:
> > From: Boris Brezillon <boris.brezillon@collabora.com>
> > 
> > Those lists can be extracted from the dpb, let's simplify userspace
> > life and build that list kernel-side (generic helpers will be provided
> > for drivers that need this list).
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> > Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> > Reviewed-by: Ezequiel Garcia <ezequiel@collabora.com>
> > Reviewed-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > ---
> > Changes in v4:
> > * Add R-b
> 
> ???
> 
> Nothing was added, left-over from some old version?
> 

Compared to v3, this version adds the Reviewed-by tags,
which is what the Add R-b means.

Sorry if that wasn't clear! :-)

