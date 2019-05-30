Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69369C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 21:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39BEA261AF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 21:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559250360;
	bh=1jssNiTMn7lNEzbP5Eo+hcP+KrAgvO9UNgar+fFKl1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=A/JSyJfi8fwHgJnrtGuaLwgRD9QFBX1UcrTAeWkY6UUT9p3DiMHLMY4t7tFVvZL4/
	 Uw5pdFTDCo0QRioLNhqhvXKWvlqNzuQS96W6P7XVjCBqV5QdR+6Nu7IgWDB3hPwEwc
	 tp+FqgLx23Au0a/QyC3ouZw8BimcN+7XkD8RQpfs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfE3VF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 17:05:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:40828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbfE3VF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 17:05:59 -0400
Received: from localhost (unknown [207.225.69.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A19A261AF;
        Thu, 30 May 2019 21:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559250358;
        bh=1jssNiTMn7lNEzbP5Eo+hcP+KrAgvO9UNgar+fFKl1w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sPUAftLsz5QMfZ97r9mPjyFUIRceHZm24vJXkWY3otFPwFSJtYqTa0HnANNz3NZGd
         ofykHcjVEyVUCWZlTDd0F1TlhxHOKPfIS9cUf/f6V6SgOlD8MfCqiSeX1bvfqZlYVo
         5YilSbOD+z8OPFQGoKTI8AchyPSV1+PaRE5dcRrg=
Date:   Thu, 30 May 2019 14:05:58 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Simon =?iso-8859-1?Q?Sandstr=F6m?= <simon@nikanor.nu>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] staging: kpc2000: add spaces around operators in
 core.c
Message-ID: <20190530210558.GA21455@kroah.com>
References: <20190524110802.2953-1-simon@nikanor.nu>
 <20190524110802.2953-2-simon@nikanor.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190524110802.2953-2-simon@nikanor.nu>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 01:07:59PM +0200, Simon Sandström wrote:
> Fixes checkpatch.pl check "spaces preferred around that <op>".
> 
> Signed-off-by: Simon Sandström <simon@nikanor.nu>
> ---
>  drivers/staging/kpc2000/kpc2000/core.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/staging/kpc2000/kpc2000/core.c b/drivers/staging/kpc2000/kpc2000/core.c
> index 4110032d0cbb..b464973d12ad 100644
> --- a/drivers/staging/kpc2000/kpc2000/core.c
> +++ b/drivers/staging/kpc2000/kpc2000/core.c
> @@ -276,18 +276,18 @@ static ssize_t kp2000_cdev_read(struct file *filp, char __user *buf,
>  	if (WARN(NULL == buf, "kp2000_cdev_read: buf is a NULL pointer!\n"))
>  		return -EINVAL;
>  
> -	cnt += scnprintf(buff+cnt, BUFF_CNT-cnt, "Card ID                 : 0x%08x\n", pcard->card_id);
> -	cnt += scnprintf(buff+cnt, BUFF_CNT-cnt, "Build Version           : 0x%08x\n", pcard->build_version);
> -	cnt += scnprintf(buff+cnt, BUFF_CNT-cnt, "Build Date              : 0x%08x\n", pcard->build_datestamp);
> -	cnt += scnprintf(buff+cnt, BUFF_CNT-cnt, "Build Time              : 0x%08x\n", pcard->build_timestamp);
> -	cnt += scnprintf(buff+cnt, BUFF_CNT-cnt, "Core Table Offset       : 0x%08x\n", pcard->core_table_offset);
> -	cnt += scnprintf(buff+cnt, BUFF_CNT-cnt, "Core Table Length       : 0x%08x\n", pcard->core_table_length);
> -	cnt += scnprintf(buff+cnt, BUFF_CNT-cnt, "Hardware Revision       : 0x%08x\n", pcard->hardware_revision);
> -	cnt += scnprintf(buff+cnt, BUFF_CNT-cnt, "SSID                    : 0x%016llx\n", pcard->ssid);
> -	cnt += scnprintf(buff+cnt, BUFF_CNT-cnt, "DDNA                    : 0x%016llx\n", pcard->ddna);
> -	cnt += scnprintf(buff+cnt, BUFF_CNT-cnt, "IRQ Mask                : 0x%016llx\n", readq(pcard->sysinfo_regs_base + REG_INTERRUPT_MASK));
> -	cnt += scnprintf(buff+cnt, BUFF_CNT-cnt, "IRQ Active              : 0x%016llx\n", readq(pcard->sysinfo_regs_base + REG_INTERRUPT_ACTIVE));
> -	cnt += scnprintf(buff+cnt, BUFF_CNT-cnt, "CPLD                    : 0x%016llx\n", readq(pcard->sysinfo_regs_base + REG_CPLD_CONFIG));
> +	cnt += scnprintf(buff + cnt, BUFF_CNT - cnt, "Card ID                 : 0x%08x\n", pcard->card_id);
> +	cnt += scnprintf(buff + cnt, BUFF_CNT - cnt, "Build Version           : 0x%08x\n", pcard->build_version);
> +	cnt += scnprintf(buff + cnt, BUFF_CNT - cnt, "Build Date              : 0x%08x\n", pcard->build_datestamp);
> +	cnt += scnprintf(buff + cnt, BUFF_CNT - cnt, "Build Time              : 0x%08x\n", pcard->build_timestamp);
> +	cnt += scnprintf(buff + cnt, BUFF_CNT - cnt, "Core Table Offset       : 0x%08x\n", pcard->core_table_offset);
> +	cnt += scnprintf(buff + cnt, BUFF_CNT - cnt, "Core Table Length       : 0x%08x\n", pcard->core_table_length);
> +	cnt += scnprintf(buff + cnt, BUFF_CNT - cnt, "Hardware Revision       : 0x%08x\n", pcard->hardware_revision);
> +	cnt += scnprintf(buff + cnt, BUFF_CNT - cnt, "SSID                    : 0x%016llx\n", pcard->ssid);
> +	cnt += scnprintf(buff + cnt, BUFF_CNT - cnt, "DDNA                    : 0x%016llx\n", pcard->ddna);
> +	cnt += scnprintf(buff + cnt, BUFF_CNT - cnt, "IRQ Mask                : 0x%016llx\n", readq(pcard->sysinfo_regs_base + REG_INTERRUPT_MASK));
> +	cnt += scnprintf(buff + cnt, BUFF_CNT - cnt, "IRQ Active              : 0x%016llx\n", readq(pcard->sysinfo_regs_base + REG_INTERRUPT_ACTIVE));
> +	cnt += scnprintf(buff + cnt, BUFF_CNT - cnt, "CPLD                    : 0x%016llx\n", readq(pcard->sysinfo_regs_base + REG_CPLD_CONFIG));
>  
>  	if (*f_pos >= cnt)
>  		return 0;

This whole function just needs to be deleted, it's a horrible hack.

thanks,

greg k-h
