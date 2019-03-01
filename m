Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CDDEC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 17:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56D3420848
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 17:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389328AbfCAREU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 12:04:20 -0500
Received: from foss.arm.com ([217.140.101.70]:39250 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728507AbfCAREU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 12:04:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 032F080D;
        Fri,  1 Mar 2019 09:04:20 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 374913F575;
        Fri,  1 Mar 2019 09:04:18 -0800 (PST)
Date:   Fri, 1 Mar 2019 17:04:15 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] MAINTAINERS: Update files for PSCI
Message-ID: <20190301170415.GP15517@lakrids.cambridge.arm.com>
References: <20190228135919.3747-1-ulf.hansson@linaro.org>
 <20190228135919.3747-3-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228135919.3747-3-ulf.hansson@linaro.org>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 02:59:14PM +0100, Ulf Hansson wrote:
> The files for the PSCI firmware driver were moved to a sub-directory, let's
> update MAINTAINERS to reflect that.
> 
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 32b76cb95f57..ff998605b773 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12182,7 +12182,7 @@ M:	Mark Rutland <mark.rutland@arm.com>
>  M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>  L:	linux-arm-kernel@lists.infradead.org
>  S:	Maintained
> -F:	drivers/firmware/psci*.c
> +F:	drivers/firmware/psci/
>  F:	include/linux/psci.h
>  F:	include/uapi/linux/psci.h
>  
> -- 
> 2.17.1
> 
