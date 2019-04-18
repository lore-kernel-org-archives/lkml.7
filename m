Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693E2C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33966217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555597945;
	bh=7ZnyJ+RvVn3rwxpMf7xuiPzJ974WarE73HnwEWe3FNo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=iB36oJ4YujvIJ6HohkMRAn+ZDiqa5Ic2rJEpkQpjBncIRolIIHnyRm5zLRlp2axHY
	 iT58vtlsemMZz9HDaBxNsUERq0W+S+VGSYeV3UhIQtyLnzMFfKPgzGPiXz93oRypTk
	 f+xHpgZnpnFbzdDLBzic9G4PEDvR8enZoLtCNPrI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389367AbfDROcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 10:32:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:35080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388097AbfDROcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 10:32:23 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D87A2217FA
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 14:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555597943;
        bh=7ZnyJ+RvVn3rwxpMf7xuiPzJ974WarE73HnwEWe3FNo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Q3pHpBTbYJsr5CyUkF8egGBAT5I6sDBV6HunRe32BRpSb3bv7JZxUwaGom1lAhpdW
         4fTLBwk1E2yOAwW9gDOQVGITQ9ZeebSz/K7yxRJGMUoMbbGC7Mv3AGY3FTq5jYUMIL
         jKFq7L07wfiEjBoJ2npjIlMq/JyLVAqnG+d9N/PY=
Received: by mail-qt1-f182.google.com with SMTP id d13so2376919qth.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 07:32:22 -0700 (PDT)
X-Gm-Message-State: APjAAAUmsh9xWHy0efcvTa6ZUQ8go4EKpeNW7XZZpSFUORU6zRlNiNyh
        p9pHfWgy0QvaY3ZDmk+P50vm9Mlznlz/WYZkJQ==
X-Google-Smtp-Source: APXvYqzLEgUKvPTxTFZj6RDRnoIpuKPaES5XIbuLEFe11LT+WSCQufJFT4dYyHr+eooJQxZP9WVJSnzxt87gF8RdD0w=
X-Received: by 2002:a0c:d4d5:: with SMTP id y21mr938607qvh.106.1555597942154;
 Thu, 18 Apr 2019 07:32:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190416150051.34092-1-yuehaibing@huawei.com>
In-Reply-To: <20190416150051.34092-1-yuehaibing@huawei.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 18 Apr 2019 09:32:10 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+nXQXKKLPEwXppPwkQwx4o+83nV2dJO9MQO2ARkkosUA@mail.gmail.com>
Message-ID: <CAL_Jsq+nXQXKKLPEwXppPwkQwx4o+83nV2dJO9MQO2ARkkosUA@mail.gmail.com>
Subject: Re: [PATCH -next] drm/panfrost: Make panfrost_gem_free_object() static
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 10:01 AM Yue Haibing <yuehaibing@huawei.com> wrote:
>
> From: YueHaibing <yuehaibing@huawei.com>
>
> Fix sparse warning:
>
> drivers/gpu/drm/panfrost/panfrost_gem.c:17:6:
>  warning: symbol 'panfrost_gem_free_object' was not declared. Should it be static?
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_gem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.
