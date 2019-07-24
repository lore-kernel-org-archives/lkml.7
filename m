Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2647AC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 10:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 028092190F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 10:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbfGXKg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 06:36:26 -0400
Received: from foss.arm.com ([217.140.110.172]:38588 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726070AbfGXKg0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 06:36:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B27A7337;
        Wed, 24 Jul 2019 03:36:25 -0700 (PDT)
Received: from dawn-kernel.cambridge.arm.com (unknown [10.1.197.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0961E3F71F;
        Wed, 24 Jul 2019 03:36:24 -0700 (PDT)
Subject: Re: [PATCH] coresight: fix typos
To:     pavel@ucw.cz, mathieu.poirier@linaro.org,
        alexander.shishkin@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190724100335.GA7373@amd>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <7ae7157b-1336-f4a6-59a3-b1ac6307bd8d@arm.com>
Date:   Wed, 24 Jul 2019 11:36:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190724100335.GA7373@amd>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/07/2019 11:03, Pavel Machek wrote:
> 
> Fix typos in comments.
> 
> Signed-off-by: Pavel Machek <pavel@denx.de>
> 
> diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
> index 55db77f641..1d66191 100644
> --- a/drivers/hwtracing/coresight/coresight.c
> +++ b/drivers/hwtracing/coresight/coresight.c
> @@ -1001,7 +1001,7 @@ static int coresight_orphan_match(struct device *dev, void *data)
>   	if (!i_csdev->orphan)
>   		return 0;
>   	/*
> -	 * Circle throuch all the connection of that component.  If we find
> +	 * Circle through all the connections of that component.  If we find
>   	 * an orphan connection whose name matches @csdev, link it.

We have stopped using name to match the csdev and switched to fwnode handles. 
Please could you update the comment to reflect this, while you are at it ?
Otherwise looks fine to me.

Suzuki
