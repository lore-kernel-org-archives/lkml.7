Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43676C2D0BF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 11:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23A742245C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 11:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729395AbfLELwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 06:52:49 -0500
Received: from mga17.intel.com ([192.55.52.151]:36613 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729074AbfLELws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 06:52:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Dec 2019 03:52:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,281,1571727600"; 
   d="scan'208";a="243223039"
Received: from yuanwan1-mobl.ccr.corp.intel.com ([10.249.174.225])
  by fmsmga002.fm.intel.com with ESMTP; 05 Dec 2019 03:52:46 -0800
Message-ID: <e8531cde046f72407f005bed6bdbc94a0bd9d1d8.camel@intel.com>
Subject: Re: [PATCH] MAINTAINERS: thermal: Eduardo's email is bouncing
From:   Zhang Rui <rui.zhang@intel.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org, eduval@amazon.com
Cc:     linux-pm@vger.kernel.org, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com
Date:   Thu, 05 Dec 2019 19:52:45 +0800
In-Reply-To: <20191123154303.2202-1-f.fainelli@gmail.com>
References: <20191123154303.2202-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-11-23 at 07:43 -0800, Florian Fainelli wrote:
> The last two emails to Eduardo were returned with:
> 
> 452 4.2.2 The email account that you tried to reach is over quota.
> Please direct the recipient to
> https://support.google.com/mail/?p=OverQuotaTemp j17sor626162wrq.49 -
> gsmtp
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Zhang Rui <rui.zhang@intel.com>

thanks,
rui

> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e4f170d8bc29..84e8bdae4beb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16085,7 +16085,6 @@ F:	drivers/media/radio/radio-raremono.c
>  
>  THERMAL
>  M:	Zhang Rui <rui.zhang@intel.com>
> -M:	Eduardo Valentin <edubezval@gmail.com>
>  R:	Daniel Lezcano <daniel.lezcano@linaro.org>
>  R:	Amit Kucheria <amit.kucheria@verdurent.com>
>  L:	linux-pm@vger.kernel.org

