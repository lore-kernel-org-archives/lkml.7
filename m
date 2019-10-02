Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C24C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 15:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F23621848
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 15:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570031330;
	bh=qgj+Htm8Ty5XDGtj2mvSIl2LJNQo9b0XVs1LQEEIQ24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iGj7uNiYNLdPs6DrRHw0xdZ35tgwKN8ZhpPBvqD2zGTIsR8MBabByhtD99mdrrWo6
	 /Eb/kNb0a6OrYrOPR1iIjgi3sQvSYzd98l7HZP2kNka6wUOInY1ownlrw2XUSHbjFm
	 cfTh/dLC5nFegjiTRFsM8dmWwcB7gbgTen9F/ASc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbfJBPst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 11:48:49 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51661 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbfJBPss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 11:48:48 -0400
Received: by mail-wm1-f68.google.com with SMTP id 7so7770115wme.1;
        Wed, 02 Oct 2019 08:48:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L+hxNaDSGun9WXAKThcVXAhiXWk+/gt73mQz7EUTjWo=;
        b=BqaLRTTncpF84Gsoz/HZErrAv5pXFEmj9k5QwkKYcLmnV3EsaaP05XRx5yD1rGh12e
         fcKKrdwpwqjGRKI7yr9/ef7BRmo6dIdh8gEJpYLSLDqV4cCyK7S84M9QuK++8/2hlkfr
         JWpze7jLEOdilE7ZO1KCzbUdjOfDE7cOewqzj0/2U/S2eV6Pw2w5ycbm2AMG+1VWNSeu
         IUGgcdocJR7U2xvhrkCqYk/+9CvUZJQR+OGm+tsrI6L6Cxp7WG1OVLriA8zNYRqqDD89
         zwuK/t1qNe8FOqZuXCA77xd/4/qQvOm5i8lFE7hN83rJdrkXhkcI5SI5geYNdGRT2vad
         O2fA==
X-Gm-Message-State: APjAAAVDaKmNlbEXct84nZYNSjPODn/6FddVpspfx1qd2YcauSdM2vla
        3EO7yeMrwDCXd7xFxzV8LcXkkuav
X-Google-Smtp-Source: APXvYqzw/rAoksd2h8xVjx1/aL0+itOfDm4AXqGRq+B96m/2GvsWHUhTmg85JDurWQYKSx+2fLR1AQ==
X-Received: by 2002:a7b:cf1a:: with SMTP id l26mr3644534wmg.38.1570031326159;
        Wed, 02 Oct 2019 08:48:46 -0700 (PDT)
Received: from kozik-lap ([194.230.155.145])
        by smtp.googlemail.com with ESMTPSA id q15sm42255773wrg.65.2019.10.02.08.48.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Oct 2019 08:48:45 -0700 (PDT)
Date:   Wed, 2 Oct 2019 17:48:43 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Maciej Falkowski <m.falkowski@samsung.com>,
        mark.rutland@arm.com, robh@kernel.org, a.hajda@samsung.com
Subject: Re: [PATCH v2 resend] ARM: dts: exynos: remove obsolete IRQ lines
Message-ID: <20191002154843.GB4072@kozik-lap>
References: <CAJKOXPcs5K46U9mF8evCpbEap_j0Sd5kUk-xiWjwyihAL7te=Q@mail.gmail.com>
 <CGME20190919134622eucas1p1947abc201f86d414bd0b0635f2d91cfe@eucas1p1.samsung.com>
 <20190919134547.11671-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190919134547.11671-1-m.szyprowski@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2019 at 03:45:47PM +0200, Marek Szyprowski wrote:
> From: Maciej Falkowski <m.falkowski@samsung.com>
> 
> In commit 7222e8db2d50 ("iommu/exynos: Fix build errors") Exynos3250
> iommu driver stopped supporting two IRQ lines. The second IRQ line in DTS
> is ignored and is not needed.
> 
> Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  arch/arm/boot/dts/exynos3250.dtsi | 9 +++------

Thanks, applied.

Best regards,
Krzysztof

