Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B09C8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B57F204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SDt8PQRx";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RKf6DICL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729657AbfC0NrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:47:16 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49332 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728434AbfC0NrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 09:47:16 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D7F5861155; Wed, 27 Mar 2019 13:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553694435;
        bh=5xV2jFS6Inl3xkwHq713MvJQUT6nrtALP97QCqzxH00=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=SDt8PQRxh9/Qa4WAons7v8fv5evQ/QRtdbhJXf9nW4QYhe5UQ6gxHW7JpF6BLUes5
         MJTDbr/vIATl/ZMmD0bQJHjNEeDEpsNjXoop6/P+BEzcmH+0Y6/dR688UHzHtJ2OKn
         DUsKjAUT+KOmELCtTFQGtSOCjjOqNfJdRBxnK0JA=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 88EA960E41;
        Wed, 27 Mar 2019 13:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553694432;
        bh=5xV2jFS6Inl3xkwHq713MvJQUT6nrtALP97QCqzxH00=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=RKf6DICLUiXQI6qPe0wY1+wILsuVlTVYcIqLHU1192FpojSIKQ08Q0OSKZ7Q9ro9D
         z9VhCQBrCnR4CLsnvQCoVdwDTLO74OQzENY71PFiqPcSs/xBPAAxu4TxpSoZYHdc9o
         NSpv15G8G2xHo3uE68s12dVu9L+NyLdfqKzbhG1s=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 88EA960E41
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] MAINTAINER: Fix Qualcomm ETHQOS ethernet DT file
To:     Vinod Koul <vkoul@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        niklas.cassel@linaro.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>
References: <20190326052139.11784-1-vkoul@kernel.org>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <15bcc67c-28a0-572c-dfd4-dc814d0346a8@codeaurora.org>
Date:   Wed, 27 Mar 2019 19:17:05 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190326052139.11784-1-vkoul@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/26/2019 10:51 AM, Vinod Koul wrote:
> Commit 83c177aea4c3: ("MAINTAINER: Add entry for Qualcomm ETHQOS
> ethernet driver") added incorrect filename for DT binding, fix the same.
>
> Fixes: 83c177aea4c3 ("MAINTAINER: Add entry for Qualcomm ETHQOS ethernet driver")
> Reported-By: Joe Perches <joe@perches.com>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>


Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

-Mukesh

> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e17ebf70b548..74c654d89a43 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12849,7 +12849,7 @@ M:	Niklas Cassel <niklas.cassel@linaro.org>
>   L:	netdev@vger.kernel.org
>   S:	Maintained
>   F:	drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> -F:	Documentation/devicetree/bindings/net/qcom,dwmac.txt
> +F:	Documentation/devicetree/bindings/net/qcom,ethqos.txt
>   
>   QUALCOMM GENERIC INTERFACE I2C DRIVER
>   M:	Alok Chauhan <alokc@codeaurora.org>
