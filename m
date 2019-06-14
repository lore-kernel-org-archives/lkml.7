Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C3A0C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 19:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4911E2173C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 19:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbfFNT6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 15:58:53 -0400
Received: from mga07.intel.com ([134.134.136.100]:63227 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbfFNT6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 15:58:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2019 12:58:52 -0700
Received: from tzanussi-mobl.amr.corp.intel.com (HELO [10.254.101.2]) ([10.254.101.2])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/AES256-SHA; 14 Jun 2019 12:58:51 -0700
Subject: Re: [PATCH -next] tracing: Make two symbols static
To:     YueHaibing <yuehaibing@huawei.com>, rostedt@goodmis.org,
        mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org
References: <20190614153210.24424-1-yuehaibing@huawei.com>
From:   "Zanussi, Tom" <tom.zanussi@linux.intel.com>
Message-ID: <8c64a9e1-03c5-8716-9151-23fc5f5f645c@linux.intel.com>
Date:   Fri, 14 Jun 2019 14:58:50 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190614153210.24424-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi YueHaibing,

On 6/14/2019 10:32 AM, YueHaibing wrote:
> Fix sparse warnings:
>
> kernel/trace/trace.c:6927:24: warning:
>   symbol 'get_tracing_log_err' was not declared. Should it be static?
> kernel/trace/trace.c:8196:15: warning:
>   symbol 'trace_instance_dir' was not declared. Should it be static?
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

These look fine to me.

Acked-by: Tom Zanussi <tom.zanussi@linux.intel.com>

Thanks,

Tom


> ---
>   kernel/trace/trace.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index a092e40..650b141 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -6924,7 +6924,7 @@ struct tracing_log_err {
>   
>   static DEFINE_MUTEX(tracing_err_log_lock);
>   
> -struct tracing_log_err *get_tracing_log_err(struct trace_array *tr)
> +static struct tracing_log_err *get_tracing_log_err(struct trace_array *tr)
>   {
>   	struct tracing_log_err *err;
>   
> @@ -8193,7 +8193,7 @@ static const struct file_operations buffer_percent_fops = {
>   	.llseek		= default_llseek,
>   };
>   
> -struct dentry *trace_instance_dir;
> +static struct dentry *trace_instance_dir;
>   
>   static void
>   init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer);
