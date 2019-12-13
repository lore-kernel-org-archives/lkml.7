Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6639FC3436E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A41FD247F8
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbfLMSzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 13:55:03 -0500
Received: from mga02.intel.com ([134.134.136.20]:1981 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728552AbfLMSzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 13:55:03 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Dec 2019 10:55:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,309,1571727600"; 
   d="scan'208";a="216722625"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga003.jf.intel.com with ESMTP; 13 Dec 2019 10:55:02 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id A83E7300860; Fri, 13 Dec 2019 10:55:02 -0800 (PST)
Date:   Fri, 13 Dec 2019 10:55:02 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     emaste@freebsd.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        acme@kernel.org
Subject: Re: [PATCH v2] perf tools: correct license on jsmn json parser
Message-ID: <20191213185502.GB9938@tassilo.jf.intel.com>
References: <20191212151244.26324-1-emaste@freefall.freebsd.org>
 <20191213154625.41064-1-emaste@FreeBSD.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213154625.41064-1-emaste@FreeBSD.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Adding Arnaldo for a perf tools change.

On Fri, Dec 13, 2019 at 03:46:25PM +0000, emaste@FreeBSD.org wrote:
> From: Ed Maste <emaste@freebsd.org>
> 
> This header is part of the jsmn json parser, introduced in 867a979a83.
> Correct the SPDX tag to indicate that it is under the MIT license.
> 
> Signed-off-by: Ed Maste <emaste@freebsd.org>
> Acked-by: Andi Kleen <ak@linux.intel.com>
> ---
>  tools/perf/pmu-events/jsmn.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/pmu-events/jsmn.h b/tools/perf/pmu-events/jsmn.h
> index c7b0f6ea2a31..1bdfd55fff30 100644
> --- a/tools/perf/pmu-events/jsmn.h
> +++ b/tools/perf/pmu-events/jsmn.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> +/* SPDX-License-Identifier: MIT */
>  #ifndef __JSMN_H_
>  #define __JSMN_H_
>  
> -- 
> 2.24.0
> 
