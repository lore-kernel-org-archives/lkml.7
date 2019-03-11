Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A50C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 00:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0971A20652
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 00:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbfCKADL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 20:03:11 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51854 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbfCKADL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 20:03:11 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 1AD07260CB2
Message-ID: <fce3f17981cda6a263abcce6b2902591e7984fa4.camel@collabora.com>
Subject: Re: [5.2][PATCH 0/3] Ingenic JZ47xx KMS driver
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Paul Cercueil <paul@crapouillou.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>
Cc:     devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Sun, 10 Mar 2019 21:02:57 -0300
In-Reply-To: <20190228220756.20262-1-paul@crapouillou.net>
References: <20190228220756.20262-1-paul@crapouillou.net>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-02-28 at 19:07 -0300, Paul Cercueil wrote:
> Hi,
> 
> This is a first attempt at a KMS driver for the JZ47xx MIPS SoCs by
> Ingenic. It is aimed to replace the aging jz4740-fb driver.
> 
> The driver will later be updated with new features (overlays, TV-out
> etc.), that's why I didn't go with the simple/tiny DRM driver.
> 
> The driver has been tested on the Ben Nanonote (JZ4740) and the
> RetroMini RS-90 (JZ4725B) handheld gaming console.
> 

Does this support JZ4780? Or otherwise,
is there any similarity with JZ4780 display controller?

Thanks,
Eze

