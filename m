Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B5BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5516218D4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbfCUWKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 18:10:02 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:60495 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbfCUWKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 18:10:02 -0400
Received: from 79.184.255.210.ipv4.supernova.orange.pl (79.184.255.210) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 0736c43650bd594a; Thu, 21 Mar 2019 23:09:59 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add mailing list for the interconnect API
Date:   Thu, 21 Mar 2019 23:08:06 +0100
Message-ID: <4114564.UGys5yUu8D@aspire.rjw.lan>
In-Reply-To: <20190321155050.25847-1-georgi.djakov@linaro.org>
References: <20190321155050.25847-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, March 21, 2019 4:50:50 PM CET Georgi Djakov wrote:
> Add a mailing list for patch reviews and discussions related to tuning
> the on-chip interconnects. For now i am not expecting a lot of traffic,
> so let's use the linux-pm@ list.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
> 
> Hi Rafael,
> Please ack the patch if you don't mind this.
> Thanks!
> 
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e17ebf70b548..186439e7f846 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8046,6 +8046,7 @@ F:	drivers/gpio/gpio-intel-mid.c
>  
>  INTERCONNECT API
>  M:	Georgi Djakov <georgi.djakov@linaro.org>
> +L:	linux-pm@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/interconnect/
>  F:	Documentation/devicetree/bindings/interconnect/
> 


