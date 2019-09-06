Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A10AC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 14:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CF402081B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 14:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392142AbfIFO5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 10:57:30 -0400
Received: from ms.lwn.net ([45.79.88.28]:36716 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726019AbfIFO5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 10:57:30 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 8ED4E9AC;
        Fri,  6 Sep 2019 14:57:29 +0000 (UTC)
Date:   Fri, 6 Sep 2019 08:57:28 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Sasha Levin <sashal@kernel.org>
Cc:     tglx@linutronix.de, gregkh@linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.wilk@oracle.com, jkosina@suse.cz, tyhicks@canonical.com,
        linux-kernel@microsoft.com,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH] Documentation/process/embargoed-hardware-issues:
 Microsoft ambassador
Message-ID: <20190906085728.15af96c3@lwn.net>
In-Reply-To: <20190906095852.23568-1-sashal@kernel.org>
References: <20190906095852.23568-1-sashal@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  6 Sep 2019 05:58:52 -0400
Sasha Levin <sashal@kernel.org> wrote:

> Add Sasha Levin as Microsoft's process ambassador.
> 
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  Documentation/process/embargoed-hardware-issues.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/process/embargoed-hardware-issues.rst b/Documentation/process/embargoed-hardware-issues.rst
> index d37cbc502936d..9a92ccdbce74e 100644
> --- a/Documentation/process/embargoed-hardware-issues.rst
> +++ b/Documentation/process/embargoed-hardware-issues.rst
> @@ -219,7 +219,7 @@ an involved disclosed party. The current ambassadors list:
>    Intel
>    Qualcomm
>  
> -  Microsoft
> +  Microsoft	Sasha Levin <sashal@kernel.org>
>    VMware
>    XEN

This document went upstream via Greg's tree, so updates are awkward for
me to apply without having to explain a late backmerge to Linus.  I can
hold them until after the merge window, unless you (Greg) would like to
take them sooner?

Thanks,

jon
