Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94540C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 18:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65EE4206DB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 18:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbfL3S6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 13:58:24 -0500
Received: from ms.lwn.net ([45.79.88.28]:60446 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727278AbfL3S6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 13:58:24 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 126AF2B4;
        Mon, 30 Dec 2019 18:58:24 +0000 (UTC)
Date:   Mon, 30 Dec 2019 11:58:23 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Masanari Iida <standby24x7@gmail.com>
Cc:     madhu.cr@ti.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, zbr@ioremap.net
Subject: Re: [PATCH] docs: w1: Fix a typo in omap-hdq.rst
Message-ID: <20191230115823.56bb6c35@lwn.net>
In-Reply-To: <20191225165534.9395-1-standby24x7@gmail.com>
References: <20191225165534.9395-1-standby24x7@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Dec 2019 01:55:34 +0900
Masanari Iida <standby24x7@gmail.com> wrote:

> This patch fix a spelling typo in omap-hdq.rst
> 
> Signed-off-by: Masanari Iida <standby24x7@gmail.com>
> ---
>  Documentation/w1/masters/omap-hdq.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/w1/masters/omap-hdq.rst b/Documentation/w1/masters/omap-hdq.rst
> index 345298a59e50..5347b5d9e90a 100644
> --- a/Documentation/w1/masters/omap-hdq.rst
> +++ b/Documentation/w1/masters/omap-hdq.rst
> @@ -44,7 +44,7 @@ that the ID used should be same for both master and slave driver loading.
>  e.g::
>  
>    insmod omap_hdq.ko W1_ID=2
> -  inamod w1_bq27000.ko F_ID=2
> +  insmod w1_bq27000.ko F_ID=2

Applied, thanks.

jon
