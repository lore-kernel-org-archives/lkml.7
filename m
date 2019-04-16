Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9668EC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65C1520870
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="eDeFtamR";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WEgle5Q2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729346AbfDPNWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 09:22:32 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38270 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfDPNWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 09:22:31 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 33A6D60850; Tue, 16 Apr 2019 13:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555420950;
        bh=gi2J4a/2Nij7yX8j5xCIPPYNVO9kPoojH67qEMuF4Uo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=eDeFtamRVyEP2mn5Nj9NApLfUMJLugdmn3Vx5ttdh1Q0IQNaaFzsOM8EQKhwoo/uH
         GCPM4nBjzClwoxw70AdcIepizqgXMKzhLEGEPOTnvvLQEJ07CekOjN0rgVDdQa8+4L
         /fhH92tDuHOFbUyrNygsAZnJJ2+ix091Du/es0FA=
Received: from [10.204.79.15] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8FCCF60E5F;
        Tue, 16 Apr 2019 13:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555420948;
        bh=gi2J4a/2Nij7yX8j5xCIPPYNVO9kPoojH67qEMuF4Uo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WEgle5Q2qi3VMM6TMmxm2Xr/YID6QJlMljoUtzxtH88R0Zj89D2/7MVJ8ifU6xtiy
         QhKKs2oyuQ2/UHs3UA8/nASLkg6jP2yunKbFii7Grmts6+njl8vxXmPq1c2g6t1Y08
         Mo70LucO7SXLDoGaJhisOsgehYR5le4as0VJaLno=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8FCCF60E5F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] clk: mvebu: fix spelling mistake "gatable" -> "gateable"
To:     Colin King <colin.king@canonical.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190416115616.31861-1-colin.king@canonical.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <9b9e2152-d99b-4edd-762d-da59134c2ec0@codeaurora.org>
Date:   Tue, 16 Apr 2019 18:52:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416115616.31861-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/16/2019 5:26 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> There are a few spelling mistakes in comments and a pr_err
> error message. Fix these.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>


Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

> ---
>   drivers/clk/mvebu/common.c                  | 2 +-
>   drivers/clk/mvebu/cp110-system-controller.c | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/clk/mvebu/common.c b/drivers/clk/mvebu/common.c
> index 6ab3c2e627c7..785dbede4835 100644
> --- a/drivers/clk/mvebu/common.c
> +++ b/drivers/clk/mvebu/common.c
> @@ -240,7 +240,7 @@ void __init mvebu_clk_gating_setup(struct device_node *np,
>   	int n;
>   
>   	if (ctrl) {
> -		pr_err("mvebu-clk-gating: cannot instantiate more than one gatable clock device\n");
> +		pr_err("mvebu-clk-gating: cannot instantiate more than one gateable clock device\n");
>   		return;
>   	}
>   
> diff --git a/drivers/clk/mvebu/cp110-system-controller.c b/drivers/clk/mvebu/cp110-system-controller.c
> index 9235a331b588..b6de283f45e3 100644
> --- a/drivers/clk/mvebu/cp110-system-controller.c
> +++ b/drivers/clk/mvebu/cp110-system-controller.c
> @@ -21,7 +21,7 @@
>    *    - Equal to SDIO clock
>    *    - 2/5 PLL0
>    *
> - * CP110 has 32 gatable clocks, for the various peripherals in the IP.
> + * CP110 has 32 gateable clocks, for the various peripherals in the IP.
>    */
>   
>   #define pr_fmt(fmt) "cp110-system-controller: " fmt
> @@ -57,7 +57,7 @@ enum {
>   #define CP110_CORE_NAND			4
>   #define CP110_CORE_SDIO			5
>   
> -/* A number of gatable clocks need special handling */
> +/* A number of gateable clocks need special handling */
>   #define CP110_GATE_AUDIO		0
>   #define CP110_GATE_COMM_UNIT		1
>   #define CP110_GATE_NAND			2
