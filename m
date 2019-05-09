Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E91C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 13:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66165216C4
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 13:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557407315;
	bh=zrmKkzoMIuE/clhTN2TYlbPBIaRnGtHv2cPtONL0Yo4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=M5Io4nwGbEXr7wGLeZ3t+UAarY7DXwcmWwvqWfygHASynrwIbzAYSLCsGAJzyvra4
	 UQZeOCNaT/SHS7cmpOxQ7se6L5CDp3969KhQ4bjkVEd02kyX8iOALt7Pls59bwqnxa
	 3e4bC9WFE3ol+14e5aeDn7Tv/tneqoASsLzK/M2s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfEINIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 09:08:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:54598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbfEINIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 09:08:34 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E59ED20863;
        Thu,  9 May 2019 13:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557407313;
        bh=zrmKkzoMIuE/clhTN2TYlbPBIaRnGtHv2cPtONL0Yo4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vtQyiYdjvSsEQ+EEewHQihL1fOU3SRptFyfB046JY0CxEzuwvhm8/BGu2n1kZo1Mz
         aZOMES30FSGfE2aFD081bjSCfBVRQRoBernNDWkJYxXxeiJB4Q+XFjwM9ov5t5gQjE
         P1uknazLzujb0XkmKQJPpF4esmCnt4EI9XBud/ro=
Date:   Thu, 9 May 2019 22:08:29 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     <lecopzer.chen@mediatek.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <corbet@lwn.net>, <mhiramat@kernel.org>,
        <srv_heupstream@mediatek.com>, <yj.chiang@mediatek.com>
Subject: Re: [PATCH] Documentation: {u,k}probes: add tracing_on before
 tracing
Message-Id: <20190509220829.42cb21dc0555abe1de98df10@kernel.org>
In-Reply-To: <1557397876-18153-1-git-send-email-lecopzer.chen@mediatek.com>
References: <1557397876-18153-1-git-send-email-lecopzer.chen@mediatek.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 May 2019 18:31:16 +0800
<lecopzer.chen@mediatek.com> wrote:

> From: Lecopzer Chen <lecopzer.chen@mediatek.com>
> 
> After following the document step by step, the `cat trace` can't be
> worked without enabling tracing_on and might mislead newbies about
> the functionality.

OK, but isn't tracing_on enabled by default?
Anyway, it looks good to me (for making sure the trace is enabled).

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

> 
> Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
> ---
>  Documentation/trace/kprobetrace.rst  | 6 ++++++
>  Documentation/trace/uprobetracer.rst | 7 ++++++-
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
> index 235ce2ab131a..baa3c42ba2f4 100644
> --- a/Documentation/trace/kprobetrace.rst
> +++ b/Documentation/trace/kprobetrace.rst
> @@ -189,6 +189,12 @@ events, you need to enable it.
>    echo 1 > /sys/kernel/debug/tracing/events/kprobes/myprobe/enable
>    echo 1 > /sys/kernel/debug/tracing/events/kprobes/myretprobe/enable
>  
> +Use the following command to start tracing in an interval.
> +::
> +    # echo 1 > tracing_on
> +    Open something...
> +    # echo 0 > tracing_on
> +
>  And you can see the traced information via /sys/kernel/debug/tracing/trace.
>  ::
>  
> diff --git a/Documentation/trace/uprobetracer.rst b/Documentation/trace/uprobetracer.rst
> index 4346e23e3ae7..0b21305fabdc 100644
> --- a/Documentation/trace/uprobetracer.rst
> +++ b/Documentation/trace/uprobetracer.rst
> @@ -152,10 +152,15 @@ events, you need to enable it by::
>  
>      # echo 1 > events/uprobes/enable
>  
> -Lets disable the event after sleeping for some time.
> +Lets start tracing, sleep for some time and stop tracing.
>  ::
>  
> +    # echo 1 > tracing_on
>      # sleep 20
> +    # echo 0 > tracing_on
> +
> +Also, you can disable the event by::
> +
>      # echo 0 > events/uprobes/enable
>  
>  And you can see the traced information via /sys/kernel/debug/tracing/trace.
> -- 
> 2.18.0
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
