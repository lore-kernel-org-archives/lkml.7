Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31D6C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 13:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F4D1206C0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 13:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="Sq0WZ5cf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730668AbfDENqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 09:46:20 -0400
Received: from smtp.domeneshop.no ([194.63.252.55]:53871 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfDENqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 09:46:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=1Qh69ibX6/4Zqoz+60AJEtxZN1LE1JL6hdBb3lB1jnk=;
        b=Sq0WZ5cfIq9jLs7Ak98Y0w8MPQksQlph5ssYzzXg9U8uHQbMygP2W4gYpdwYRf6gks/NoeACOWeB9wFywX0iN1YPfZGAg2gXQED0fQ9kTTQG/SfO2zriMB3uaMOIny6UJw21h5vAZJzC0jOC1JA+diCuCoYP7MP4g8z4wZDTy1SRMDRuXJZnZmoxfpNdPj21p7NUpbKe6YYkYnKc//xSDHO4RND4I1QbAZwQpAPugJwmJiqpk7X4bUV/91jYl46NAS2EhdIxhlb++EBJ3H/68VJBV1UsguzSqXQ5W5+W9Q+fu/wmn+ygfD4E0MD56/thrvIMkuuPCR5t86qDFgjaTA==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:59923 helo=[192.168.10.179])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1hCPAf-0000E0-Ot; Fri, 05 Apr 2019 15:46:17 +0200
Subject: Re: [PATCH v3 1/5] drm: move tinydrm format conversion helpers to new
 drm_format_helper.c
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     sam@ravnborg.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Lechner <david@lechnology.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20190405095219.9231-1-kraxel@redhat.com>
 <20190405095219.9231-2-kraxel@redhat.com>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <43bfd133-4c69-4a57-000b-3ed5578901fc@tronnes.org>
Date:   Fri, 5 Apr 2019 15:46:12 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190405095219.9231-2-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 05.04.2019 11.52, skrev Gerd Hoffmann:
> Also rename them from tinydrm_* to drm_fb_*
> Pure code motion, no functional change.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---

Thanks for doing this!

Reviewed-by: Noralf Trønnes <noralf@tronnes.org>

