Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CFCC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 15:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE73F20645
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 15:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfE0P3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 11:29:40 -0400
Received: from mailoutvs31.siol.net ([185.57.226.222]:38439 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726276AbfE0P3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 11:29:40 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id AB104520C06;
        Mon, 27 May 2019 17:29:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta09.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta09.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id D9ETVfFkE8JX; Mon, 27 May 2019 17:29:36 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 5733A5217BC;
        Mon, 27 May 2019 17:29:36 +0200 (CEST)
Received: from jernej-laptop.localnet (cpe-86-58-52-202.static.triera.net [86.58.52.202])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Postfix) with ESMTPA id 9F19C520C06;
        Mon, 27 May 2019 17:29:33 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, hverkuil@xs4all.nl,
        dri-devel@lists.freedesktop.org, heiko@sntech.de,
        maxime.ripard@bootlin.com, hjc@rock-chips.com,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] drm/bridge: add encoder support to specify bridge input format
Date:   Mon, 27 May 2019 17:29:33 +0200
Message-ID: <2679412.W4MLjRXsPJ@jernej-laptop>
In-Reply-To: <20190520133753.23871-3-narmstrong@baylibre.com>
References: <20190520133753.23871-1-narmstrong@baylibre.com> <20190520133753.23871-3-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Thanks for working on this!

Dne ponedeljek, 20. maj 2019 ob 15:37:50 CEST je Neil Armstrong napisal(a):
> This patch adds a new format_set() callback to the bridge ops permitting
> the encoder to specify the new input format and encoding.
> 
> This allows supporting the very specific HDMI2.0 YUV420 output mode
> when the bridge cannot convert from RGB or YUV444 to YUV420.
> 
> In this case, the encode must downsample before the bridge and must
> specify the bridge the new input bus format differs.
> 
> This will also help supporting the YUV420 mode where the bridge cannot
> downsample, and also support 10bit, 12bit and 16bit output modes
> when the bridge cannot convert between different bit depths.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---

Reviewed-by: Jernej Skrabec <jernej.skrabec@siol.net>

Best regards,
Jernej


