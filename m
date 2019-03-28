Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06982C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 06:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B83F22173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 06:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="R9mxngTg";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="R9mxngTg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbfC1GZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 02:25:18 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46490 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfC1GZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 02:25:18 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9E6B66079C; Thu, 28 Mar 2019 06:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553754317;
        bh=1nKHCdyrBaheWVNUUzwoRZ/gwImoOwrMluvrj4rhXfo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=R9mxngTg+pGljH81BPH/r2Gpn3bWfk2LMVC9MJjVmaLHWcl8xpvO4J30ycamQmCF0
         0x9myzea0sD6jfu4ykCsvrLwupvh/A+8yPQFHg+DFZUplHr9954ISbKnFuWhBfh0eo
         zN3xllw/MEtHVE5nF3ru1DRPcD2hsp23+b/GLnbc=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C853B60364;
        Thu, 28 Mar 2019 06:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553754317;
        bh=1nKHCdyrBaheWVNUUzwoRZ/gwImoOwrMluvrj4rhXfo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=R9mxngTg+pGljH81BPH/r2Gpn3bWfk2LMVC9MJjVmaLHWcl8xpvO4J30ycamQmCF0
         0x9myzea0sD6jfu4ykCsvrLwupvh/A+8yPQFHg+DFZUplHr9954ISbKnFuWhBfh0eo
         zN3xllw/MEtHVE5nF3ru1DRPcD2hsp23+b/GLnbc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C853B60364
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] kernel/trace/trace.h: Remove duplicate header
To:     jagdsh.linux@gmail.com, rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org
References: <1553725186-41442-1-git-send-email-jagdsh.linux@gmail.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <dbff5bee-f34f-4757-5691-bedd8a8f1389@codeaurora.org>
Date:   Thu, 28 Mar 2019 11:55:02 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1553725186-41442-1-git-send-email-jagdsh.linux@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/28/2019 3:49 AM, jagdsh.linux@gmail.com wrote:
> From: Jagadeesh Pagadala <jagdsh.linux@gmail.com>
>
> Remove duplicate header which is included twice.
>
> Signed-off-by: Jagadeesh Pagadala <jagdsh.linux@gmail.com>


Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

-Mukesh

> ---
>   kernel/trace/trace.h | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index d80cee4..e1e16f9 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -15,7 +15,6 @@
>   #include <linux/trace_seq.h>
>   #include <linux/trace_events.h>
>   #include <linux/compiler.h>
> -#include <linux/trace_seq.h>
>   #include <linux/glob.h>
>   
>   #ifdef CONFIG_FTRACE_SYSCALLS
