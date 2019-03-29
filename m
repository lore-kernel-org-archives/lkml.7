Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B43C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 02:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B0652173C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 02:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbfC2CFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 22:05:39 -0400
Received: from mail-lf1-f50.google.com ([209.85.167.50]:42533 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727938AbfC2CFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 22:05:38 -0400
Received: by mail-lf1-f50.google.com with SMTP id b7so325955lfg.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 19:05:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K1INk7oRvOXr5sFPk7+79AlS6w2NVYKhSRQDM67ComE=;
        b=CL7cFCChGyNnXkuZ3NNqokjB85Y+EWYLMthH7kJ3C5HiE2jici0V563f9VmgVKpXG2
         PK626YQe/XgdMt6/Jn2ZbXIMWgHZW9zhK8TJHrqVpnrCPkYXWWrGEtBaC+Xc/imn2Rks
         YbjxTELgM0zTHKcYO6hND88sFpn8fIYRyNHZJTlOGpGw2C/vxN347qeURwK4QFiBvPti
         iuZGCAH/Xx4fzaOrhszK7SYv3WkTE1hRa6gPpwGrCRNpCzY3XFwjZZ8uH12azbTytHOO
         agmFXR56MtXeZyH3ll8sSNiXt9XM8in24h7pQ0tuvPyeW3UUiWcZCZn+BI+6NtbkMtnn
         vyYw==
X-Gm-Message-State: APjAAAX5FJyFTqe4Zv4T4RxkF4TSAV3D1ThVkMG5uGdPiosSQmHa0G4N
        8liLTnDWy7YXvs9aQjUp2YwkAZeB64m3tVGZFBwZJg==
X-Google-Smtp-Source: APXvYqxUajXat1biF9JBQ/PiAYqKkyE5JeV73+JuVnc0rtFnk00r1IKF441k1/zJWk8SpWxXf7IpF5rjtV0yVaBE1KM=
X-Received: by 2002:ac2:515b:: with SMTP id q27mr8532928lfd.110.1553825136829;
 Thu, 28 Mar 2019 19:05:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190329014136.20318-1-yuehaibing@huawei.com>
In-Reply-To: <20190329014136.20318-1-yuehaibing@huawei.com>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Fri, 29 Mar 2019 03:05:00 +0100
Message-ID: <CAGnkfhxAtMWk5Go3F2fw3dtnV8-3BSs4YbDrAn6+N1vjMv+u3Q@mail.gmail.com>
Subject: Re: [PATCH -next] drm/omap: Use PTR_ERR_OR_ZERO in hdmi4_core_init()
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sean Paul <seanpaul@chromium.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Benoit Parrot <bparrot@ti.com>,
        dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 2:30 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Use PTR_ERR_OR_ZERO rather than if(IS_ERR(...)) + PTR_ERR
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/gpu/drm/omapdrm/dss/hdmi4_core.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>

Acked-by: Matteo Croce <mcroce@redhat.com>

-- 
Matteo Croce
per aspera ad upstream
