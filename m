Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F045C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A9ED206DD
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Gu8M6hPT";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CAbeycJ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730742AbfDDJu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:50:56 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56752 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729824AbfDDIzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:55:23 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 39D8760FE9; Thu,  4 Apr 2019 08:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554368122;
        bh=9CKOUexVP8JdJ3BWo9jnDoS2CjHIOPL7ssYstpqon8k=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Gu8M6hPTEcIfs63D3zMsgPlEbKuPfKp1XKs42SyWegZJaI4Nmo8wxlUTsqOvReCb6
         mMUI29pJcaKJtwqyqtBeuyXXsIlqUWSzPKscPtC2bi8xZ/4vxgfDbabUibnaSjaZQZ
         zVNNMZu2UVTHEd0gd7PZvxkwtfz5tN/t1Rn6ALmU=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D652760C72;
        Thu,  4 Apr 2019 08:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554368118;
        bh=9CKOUexVP8JdJ3BWo9jnDoS2CjHIOPL7ssYstpqon8k=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=CAbeycJ3vQuB8qg+xQWRYAbnCBN+IfqsHV9njzOy9bm1IlfXBj+BF+kd6Cd9Ky+w9
         PhaZW34p6kbtXbU+j4YuV2kGDwfJHlyHbM83S8FXiZwjapgb42O+vWU1csiS2zIYDC
         0kYJtyuq5DvBKCsuG9z48/NjuRaPY8NlBb7GZzTI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D652760C72
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH][next] HID: intel-ish-hid: fix spelling mistake "multipe"
 -> "multiple"
To:     Colin King <colin.king@canonical.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org
References: <20190404075857.12411-1-colin.king@canonical.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <9cdd8454-6e01-257d-d618-75456f2a8b2d@codeaurora.org>
Date:   Thu, 4 Apr 2019 14:25:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190404075857.12411-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/4/2019 1:28 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in a dev_err message, fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh
> ---
>   drivers/hid/intel-ish-hid/ishtp-fw-loader.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hid/intel-ish-hid/ishtp-fw-loader.c b/drivers/hid/intel-ish-hid/ishtp-fw-loader.c
> index e770e220bd73..22ba21457035 100644
> --- a/drivers/hid/intel-ish-hid/ishtp-fw-loader.c
> +++ b/drivers/hid/intel-ish-hid/ishtp-fw-loader.c
> @@ -525,7 +525,7 @@ static int ish_query_loader_prop(struct ishtp_cl_data *client_data,
>   	if ((fw_info->ldr_capability.xfer_mode & LOADER_XFER_MODE_DIRECT_DMA) &&
>   	    (fw_info->ldr_capability.max_dma_buf_size % L1_CACHE_BYTES)) {
>   		dev_err(cl_data_to_dev(client_data),
> -			"Shim firmware loader buffer size %d should be multipe of cacheline\n",
> +			"Shim firmware loader buffer size %d should be multiple of cacheline\n",
>   			fw_info->ldr_capability.max_dma_buf_size);
>   		return -EINVAL;
>   	}
