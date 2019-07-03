Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB4AC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 11:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 092BA2189E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 11:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfGCL7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 07:59:24 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:43341 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbfGCL7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 07:59:24 -0400
Received: from 79.184.254.216.ipv4.supernova.orange.pl (79.184.254.216) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 8cb5d68938229b6e; Wed, 3 Jul 2019 13:59:21 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     dvhart@infradead.org, andy@infradead.org,
        andriy.shevchenko@intel.com, corbet@lwn.net, alan@linux.intel.com,
        lenb@kernel.org, prarit@redhat.com, darcari@redhat.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Update for Intel Speed Select Technology
Date:   Wed, 03 Jul 2019 13:59:21 +0200
Message-ID: <1893254.mYh7M8VbD2@kreacher>
In-Reply-To: <20190703015331.5449-1-srinivas.pandruvada@linux.intel.com>
References: <20190703015331.5449-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, July 3, 2019 3:53:31 AM CEST Srinivas Pandruvada wrote:
> Added myself as the maintainer.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5cfbea4ce575..b6ed7958372d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8101,6 +8101,14 @@ S:	Supported
>  F:	drivers/infiniband/hw/i40iw/
>  F:	include/uapi/rdma/i40iw-abi.h
>  
> +INTEL SPEED SELECT TECHNOLOGY
> +M:	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> +L:	platform-driver-x86@vger.kernel.org
> +S:	Maintained
> +F:	drivers/platform/x86/intel_speed_select_if/
> +F:	tools/power/x86/intel-speed-select/
> +F:	include/uapi/linux/isst_if.h
> +
>  INTEL TELEMETRY DRIVER
>  M:	Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
>  M:	"David E. Box" <david.e.box@linux.intel.com>
> 




