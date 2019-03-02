Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39C0C4360F
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 20:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7972320836
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 20:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfCBU6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 15:58:10 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:57283 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbfCBU6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 15:58:09 -0500
X-Originating-IP: 82.246.155.60
Received: from localhost (hy283-1-82-246-155-60.fbx.proxad.net [82.246.155.60])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 3DBA9FF802;
        Sat,  2 Mar 2019 20:58:07 +0000 (UTC)
Date:   Sat, 2 Mar 2019 21:58:04 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alexey Roslyakov <alexey.roslyakov@gmail.com>
Cc:     a.zummo@towertech.it, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: pcf85063: remove dead code
Message-ID: <20190302205804.GB3452@piout.net>
References: <20190219083929.24585-1-alexey.roslyakov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219083929.24585-1-alexey.roslyakov@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/02/2019 15:39:29+0700, Alexey Roslyakov wrote:
> Some of defines are not in use since
> 7b5768486a910532885f01b9d2dad4818c8b3be1. Remove it to make the code
> easier to read and understand.
> 
> Signed-off-by: Alexey Roslyakov <alexey.roslyakov@gmail.com>
> ---
>  drivers/rtc/rtc-pcf85063.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
