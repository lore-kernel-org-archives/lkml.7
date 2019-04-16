Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1D1C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB84D2077C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KSa1ycOT";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Oj8TFHp5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729381AbfDPNQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 09:16:22 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35840 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbfDPNQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 09:16:22 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2392761793; Tue, 16 Apr 2019 13:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555420581;
        bh=puPOvqKG86EZGkB3USXhG3YQAlWsKfr9niUcGFBFPb8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KSa1ycOT6LkxFtaRvn0dptgX6gnTNLKJBWpq6CmfEWxMluThhlgJTgnUFrYwIcoKM
         64BNgQyZuMzIU1aJQCD0Ieyam2yPRG6kf0ScXaPiivvETX28JbvEP0W9tNxbsA0IWS
         aMfYPAYDIQf99Yh/kqCIZqSgD4NWXbUxc06Rx1mc=
Received: from [10.204.79.15] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DD2736179C;
        Tue, 16 Apr 2019 13:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555420580;
        bh=puPOvqKG86EZGkB3USXhG3YQAlWsKfr9niUcGFBFPb8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Oj8TFHp5k5xMB4siXdA23CIE6/KjZO0RgMU/6Zc4LHn0JFd9BzabyoEUKuMz/A9qz
         jdJKkZ2D8RqE7LM85oEFmflNOO1FxNxU9qwJrzxZohzGpiFz/bs4C76W97S3B+6Mia
         C2J2A3LuybuajuhksudpzrPILSEOFBSYOEQfhpGA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DD2736179C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] scripts/dtc: fix spelling mistake "endpont" -> "endpoint"
To:     Colin King <colin.king@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190416111214.22107-1-colin.king@canonical.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <a3535cd0-dc5f-7f76-b808-b170c312214a@codeaurora.org>
Date:   Tue, 16 Apr 2019 18:46:06 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416111214.22107-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/16/2019 4:42 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in a FAIL message, fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh
> ---
>   scripts/dtc/checks.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/dtc/checks.c b/scripts/dtc/checks.c
> index 4834e44b37b2..faddf6a57236 100644
> --- a/scripts/dtc/checks.c
> +++ b/scripts/dtc/checks.c
> @@ -1714,7 +1714,7 @@ static void check_graph_endpoint(struct check *c, struct dt_info *dti,
>   		return;
>   
>   	if (!strprefixeq(node->name, node->basenamelen, "endpoint"))
> -		FAIL(c, dti, node, "graph endpont node name should be 'endpoint'");
> +		FAIL(c, dti, node, "graph endpoint node name should be 'endpoint'");
>   
>   	check_graph_reg(c, dti, node);
>   
