Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F76FC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 12:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57A3D2075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 12:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729533AbfDDMaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 08:30:13 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34159 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727562AbfDDMaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 08:30:13 -0400
Received: by mail-qt1-f196.google.com with SMTP id k2so2966661qtm.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 05:30:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r+h3Jw+gMuYso9qOxdBkdjq4Y05r1HqeGz7COWMIS/0=;
        b=m0eN34tXTExd58IJ4GrIyLlcFzz4Wosn289ZQX24/9vfLyTvoGc8LX7WiasE2VbeiM
         6YjClw42+syg86mOtdkzS6cGSXIvjFXVh+i3n/pS+SC7nNOLu0YuSKhacuXz2uSS5LFr
         +qtLBjZn0KthwWlcXkY7ft8st+jZSSLCxaOCNRAd7EpbPmBArP98bWvXdwEWuJoIBgYH
         Cii1s34zW4s9yGhG8t1qIfqU/lzTndbNDHtbLJqJcBmF9E3MmGdn2Nd95qvMmm3BzPjk
         7wuN9Ynv47j4VfxFq0S3rY/KeDkFiRGZfj/e+rtZucitmMU8f0tpMkjuvaGkbuj8ryuE
         XQ0A==
X-Gm-Message-State: APjAAAWolZOS1cZerYL1FJmbEc9gjX4Pm775tg16dSp1vkA0WmM2y+Kq
        dQM5JPr3cOt55sb8P8xckek0ZwPIg/MHrEFVYkNPDw==
X-Google-Smtp-Source: APXvYqzpuLocEpC6QeD/NK2K3YhYn32QmUxBfKznI0fBZR/gxUfhvIxTeGxcoWBIcYO3rtgMgM3kJaQOBqFmAmx0UQs=
X-Received: by 2002:a0c:d266:: with SMTP id o35mr4320788qvh.111.1554381012691;
 Thu, 04 Apr 2019 05:30:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190404075857.12411-1-colin.king@canonical.com>
In-Reply-To: <20190404075857.12411-1-colin.king@canonical.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 4 Apr 2019 14:30:01 +0200
Message-ID: <CAO-hwJ+BbsyWyar_Uz8Gig0fPgM_piqFEYZdFrBu=rfG-P3_CQ@mail.gmail.com>
Subject: Re: [PATCH][next] HID: intel-ish-hid: fix spelling mistake "multipe"
 -> "multiple"
To:     Colin King <colin.king@canonical.com>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 4, 2019 at 9:59 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in a dev_err message, fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---

Applied to for-5.2/ish

Cheers,
Benjamin

>  drivers/hid/intel-ish-hid/ishtp-fw-loader.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hid/intel-ish-hid/ishtp-fw-loader.c b/drivers/hid/intel-ish-hid/ishtp-fw-loader.c
> index e770e220bd73..22ba21457035 100644
> --- a/drivers/hid/intel-ish-hid/ishtp-fw-loader.c
> +++ b/drivers/hid/intel-ish-hid/ishtp-fw-loader.c
> @@ -525,7 +525,7 @@ static int ish_query_loader_prop(struct ishtp_cl_data *client_data,
>         if ((fw_info->ldr_capability.xfer_mode & LOADER_XFER_MODE_DIRECT_DMA) &&
>             (fw_info->ldr_capability.max_dma_buf_size % L1_CACHE_BYTES)) {
>                 dev_err(cl_data_to_dev(client_data),
> -                       "Shim firmware loader buffer size %d should be multipe of cacheline\n",
> +                       "Shim firmware loader buffer size %d should be multiple of cacheline\n",
>                         fw_info->ldr_capability.max_dma_buf_size);
>                 return -EINVAL;
>         }
> --
> 2.20.1
>
