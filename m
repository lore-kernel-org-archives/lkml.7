Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4215BC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB1832184E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="LonURHS2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbfDKNXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 09:23:50 -0400
Received: from smtp.domeneshop.no ([194.63.252.55]:42880 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbfDKNXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 09:23:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=d9pLWNp3A8ZyO9s2f6rybI7okNpr+dxUcKSw182F0yU=;
        b=LonURHS2Zteww05FUfTJ81a+U2ppFnENs/rUBLDyI4do3gy+lKRiqP8136HPdZ50PFq4OmeL9Fig6Ej4k0I26Vj5wOpi2f5t2QIY5JztFveOrZCCVqR/559gVxXOMQUXi59Y3FdRGTqNzeLGUzYjyhtAd5nfsjTa/upi+EHSxFYvQf3FQp//VHdHjy7k0Xi6ggKde1tQJb9DSXcIdmi2L4em9AAAMm9YMYpYZQHn06Oo5RHDL3k42qRhlhZ7m8mtNNLvdbaiofqbMccs50DXqZAMI/+aOzmBKeDWQMZChRw6E5dxPlTyMavanZChvrJApD4nuSOv9JKZSvHdzz8Ykg==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:56342 helo=[192.168.10.179])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1hEZgB-0000qq-Nv; Thu, 11 Apr 2019 15:23:47 +0200
Subject: Re: [PATCH] drm: fix drm_fb_xrgb8888_to_rgb888_dstclip()
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        open list <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>, Sean Paul <sean@poorly.run>
References: <20190411044932.13247-1-kraxel@redhat.com>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <c7501f57-64cc-3806-53a1-b6d852675e3f@tronnes.org>
Date:   Thu, 11 Apr 2019 15:23:44 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411044932.13247-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 11.04.2019 06.49, skrev Gerd Hoffmann:
> Oops, the __iomem annotation was added to the header file only.
> Add it to the implementation (and documentation) too.
> 
> Fixes: 5c5373b51bec ("drm: switch drm_fb_xrgb8888_to_rgb888_dstclip to accept __iomem dst")
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---

Reviewed-by: Noralf Trønnes <noralf@tronnes.org>
