Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC061C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 13:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B5CC2186A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 13:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="Nm3FvYwp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731066AbfDEN5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 09:57:35 -0400
Received: from smtp.domeneshop.no ([194.63.252.55]:45541 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfDEN5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 09:57:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=s64KeOzk9N1LkuglRhd6sC6MhVn2qkZP6XEZrxum3vY=;
        b=Nm3FvYwpyP060k3SY7o1351fj0xKCxIq/jk9nZJYcTBKMn9DWnF6V9zv4IsqM0xd1SlSuFp2y0yTXL18azPCSMg12t/NQWZVC7ysCCqqnxZAjBvQeI0rw3l4jNw65vXHtp1Bh+qJVgibL07793en7dMX9Gjsn2JzS6DSmGIDNhWMhP6OseOEMLfsEN5LocAgpnMVJlzIeJGOXzz7vRyP3ohc4ZrzPylVwUAMGOR4BfMK0ZteNb/R4/FZ03bEKIOTD6NknvI1Y63q4Vkyvt3Zv7tXe69vZhHjiA34dz4eaVyKmm1HTa0Nh16DNk2wl6DAgOcehPhEeai5UbJFoKBjsQ==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:59985 helo=[192.168.10.179])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1hCPLY-0003LM-Dl; Fri, 05 Apr 2019 15:57:32 +0200
Subject: Re: [PATCH v3 3/5] drm: add drm_fb_xrgb8888_to_rgb565_dstclip()
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     sam@ravnborg.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
References: <20190405095219.9231-1-kraxel@redhat.com>
 <20190405095219.9231-4-kraxel@redhat.com>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <1970d3d9-8426-9b1a-8c1c-994a6d3a4806@tronnes.org>
Date:   Fri, 5 Apr 2019 15:57:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190405095219.9231-4-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 05.04.2019 11.52, skrev Gerd Hoffmann:
> It is a drm_fb_xrgb8888_to_rgb565() variant which checks the clip
> rectangle for the destination too.
> 
> Common code between drm_fb_xrgb8888_to_rgb565() and
> drm_fb_xrgb8888_to_rgb565_dstclip() was factored out into the
> drm_fb_xrgb8888_to_rgb565_lines() helper function.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---

Reviewed-by: Noralf Trønnes <noralf@tronnes.org>
