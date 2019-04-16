Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C60C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 019822077C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="a6BdLbZK";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="a6BdLbZK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbfDPNUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 09:20:31 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37336 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfDPNUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 09:20:31 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A50EA60FEA; Tue, 16 Apr 2019 13:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555420830;
        bh=3THTrHx0y/Gfgul8cgqw6N+ZqlM4o8QMylitz1B12ew=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=a6BdLbZKojFPfR8Fu9I0fdXTClLRsncGXq0czcSt4PTA2Gw7IQUVjVXV47do5M3YG
         3eaoLr945e1pu7b5kjG+B9+GizwcSZ+vp9KVORYIrhFao3IAnQ4o6qe7Q82FMzJUIQ
         GkBAEfobcOtzMFr9Qbi0070ZFzS4Nn1qrV/jELLM=
Received: from [10.204.79.15] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EB5E160E5F;
        Tue, 16 Apr 2019 13:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555420830;
        bh=3THTrHx0y/Gfgul8cgqw6N+ZqlM4o8QMylitz1B12ew=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=a6BdLbZKojFPfR8Fu9I0fdXTClLRsncGXq0czcSt4PTA2Gw7IQUVjVXV47do5M3YG
         3eaoLr945e1pu7b5kjG+B9+GizwcSZ+vp9KVORYIrhFao3IAnQ4o6qe7Q82FMzJUIQ
         GkBAEfobcOtzMFr9Qbi0070ZFzS4Nn1qrV/jELLM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EB5E160E5F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] qed: fix spelling mistake "faspath" -> "fastpath"
To:     Colin King <colin.king@canonical.com>,
        Ariel Elior <aelior@marvell.com>,
        GR-everest-linux-l2@marvell.com,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190416114317.28983-1-colin.king@canonical.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <ec71bfe9-1843-25b0-b639-cf7bd68e2dce@codeaurora.org>
Date:   Tue, 16 Apr 2019 18:50:23 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416114317.28983-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/16/2019 5:13 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in a DP_INFO message, fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh
> ---
>   drivers/net/ethernet/qlogic/qed/qed_sriov.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/qlogic/qed/qed_sriov.c b/drivers/net/ethernet/qlogic/qed/qed_sriov.c
> index 9faaa6df78ed..2f318aaf2b05 100644
> --- a/drivers/net/ethernet/qlogic/qed/qed_sriov.c
> +++ b/drivers/net/ethernet/qlogic/qed/qed_sriov.c
> @@ -1591,7 +1591,7 @@ static void qed_iov_vf_mbx_acquire(struct qed_hwfn *p_hwfn,
>   			p_vfdev->eth_fp_hsi_minor = ETH_HSI_VER_NO_PKT_LEN_TUNN;
>   		} else {
>   			DP_INFO(p_hwfn,
> -				"VF[%d] needs fastpath HSI %02x.%02x, which is incompatible with loaded FW's faspath HSI %02x.%02x\n",
> +				"VF[%d] needs fastpath HSI %02x.%02x, which is incompatible with loaded FW's fastpath HSI %02x.%02x\n",
>   				vf->abs_vf_id,
>   				req->vfdev_info.eth_fp_hsi_major,
>   				req->vfdev_info.eth_fp_hsi_minor,
