Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97721C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 11:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D40320657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 11:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="foLciLyd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbfCKLpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 07:45:14 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:47934 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfCKLpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 07:45:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1552304711; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RDXysKZy1wgubaKUTlF2WlKOp2ZGS29f4zVysvSmpRE=;
        b=foLciLydrGPey7jEpvx6Gj0tIc7K92s23kurdTsxSuUSK8e426gz09joLonamKecyImBFf
        i4o/ycjB6nufxfeaxBVDhKXFm8C/uSKjNScazOJCMjYCpsfEvTmOnhGoFPeFOS3+QjAgUg
        nmyBntvLUZ9DJxNFYekMUR8wZFKy1/E=
Date:   Mon, 11 Mar 2019 12:45:05 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [5.2][PATCH 0/3] Ingenic JZ47xx KMS driver
To:     Ezequiel Garcia <ezequiel@collabora.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Message-Id: <1552304705.1929.0@crapouillou.net>
In-Reply-To: <fce3f17981cda6a263abcce6b2902591e7984fa4.camel@collabora.com>
References: <20190228220756.20262-1-paul@crapouillou.net>
        <fce3f17981cda6a263abcce6b2902591e7984fa4.camel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ezequiel,

On Mon, Mar 11, 2019 at 1:02 AM, Ezequiel Garcia 
<ezequiel@collabora.com> wrote:
> On Thu, 2019-02-28 at 19:07 -0300, Paul Cercueil wrote:
>>  Hi,
>> 
>>  This is a first attempt at a KMS driver for the JZ47xx MIPS SoCs by
>>  Ingenic. It is aimed to replace the aging jz4740-fb driver.
>> 
>>  The driver will later be updated with new features (overlays, TV-out
>>  etc.), that's why I didn't go with the simple/tiny DRM driver.
>> 
>>  The driver has been tested on the Ben Nanonote (JZ4740) and the
>>  RetroMini RS-90 (JZ4725B) handheld gaming console.
>> 
> 
> Does this support JZ4780? Or otherwise,
> is there any similarity with JZ4780 display controller?
> 
> Thanks,
> Eze

The JZ4780 LCD controller would in theory work with this driver, but
to test on the CI20 you'd need to add support for HDMI first.

-Paul


