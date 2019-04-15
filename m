Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C501C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAD19206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="pvFENEDg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfDOMmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 08:42:38 -0400
Received: from onstation.org ([52.200.56.107]:32904 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbfDOMmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 08:42:38 -0400
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 9F2563E8E1;
        Mon, 15 Apr 2019 12:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1555332157;
        bh=9xs252p0l1mTy8yY/5ZLkynhTWOnrlQ0xCeSJLOlF38=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pvFENEDgAN1TnWfaLKbcght9SpN3T/zJJe+KDkoPbBVJILiOR+IDHucwnwjAbbqd5
         Kmdf1r6MfpYsJWETKyROks+RVps7oFF5oRP6SNd0S2TIoIN4pBIS1Cw4atr57gPsmX
         PxylC68Lst0T6hMpMXegz/yZ6GrwOiF/ykyVn6rY=
Date:   Mon, 15 Apr 2019 08:42:36 -0400
From:   Brian Masney <masneyb@onstation.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com, robh+dt@kernel.org,
        jacek.anaszewski@gmail.com, pavel@ucw.cz, mark.rutland@arm.com,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        jonathan@marek.ca
Subject: Re: [PATCH v3 2/3] dt-bindings: backlight: add lm3630a bindings
Message-ID: <20190415124236.GA1910@basecamp>
References: <20190415072905.2861-1-masneyb@onstation.org>
 <20190415072905.2861-3-masneyb@onstation.org>
 <051b5306-9dab-6249-9e41-b815dce1f2e2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <051b5306-9dab-6249-9e41-b815dce1f2e2@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 07:10:04AM -0500, Dan Murphy wrote:
> I noticed we are missing "label".  It is defined as optional and it is hard coded in the driver
> but wondering if there is a need to add it.

OK, I'll make it optional and have it fall back to the hardcoded values
if it is missing.

Thanks for the quick feedback on this patch and the other one.

Brian
