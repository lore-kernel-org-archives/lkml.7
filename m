Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7376AC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40FF821850
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="oCGKaEjT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731287AbfDEOAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 10:00:02 -0400
Received: from smtp.domeneshop.no ([194.63.252.55]:39427 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731207AbfDEOAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 10:00:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=7THoWOP3GavN7ggGruhDtYjlkkUJeQmROClOrGsiDSI=;
        b=oCGKaEjTfaog/CTnIbnQkfWfS2LkYNwgLKhQ76R6I3+F2755eZeO6vtbw4L6UU052BcEJQGL+Jw++LaKnHEWrr2qxlGGRYSYFRFoaFk6vKKlDxWnBgLNuzH8C8Y9PidZNiV/FGnPb1sIvS2pU3S2pvLGtw+8m0J75O1gmVK996UQQxFMGkNJ/w4TZmVPvRPVmf+l+Q0xkNfHmcU6i2hfQoA2T6ROJJh7SCRsrtc3y5ZkxjQMwKbI/PEHWy9Q0/2TgI3cvlf/Im/DYXWkpvu/yIh6mTcP4e3HCxmIWoePr6YBQQmy4bkfNTcG8osi1vDUYaQyy3BWEeIHi0QVUQJ0pQ==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:59997 helo=[192.168.10.179])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1hCPNu-0003zC-OR; Fri, 05 Apr 2019 15:59:58 +0200
Subject: Re: [PATCH v3 4/5] drm: add drm_fb_xrgb8888_to_rgb888_dstclip()
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     sam@ravnborg.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
References: <20190405095219.9231-1-kraxel@redhat.com>
 <20190405095219.9231-5-kraxel@redhat.com>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <2b977d97-5c66-fe1f-a829-78fe4e33dc11@tronnes.org>
Date:   Fri, 5 Apr 2019 15:59:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190405095219.9231-5-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 05.04.2019 11.52, skrev Gerd Hoffmann:
> Simliar to drm_fb_xrgb8888_to_rgb565_dstclip() but converts to rgb888

Simliar -> Similar

> instead of rgb565.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---

Reviewed-by: Noralf Trønnes <noralf@tronnes.org>

