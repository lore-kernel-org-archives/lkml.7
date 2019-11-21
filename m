Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D091CC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 11:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1F8320898
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 11:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574335842;
	bh=Rwju7mil6tW/AfAn9a6uUogaLmvQb/zy3wNtrHb4LSE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=rDr+ycCGopLty6xdDUFTUOM0+RLE8EFKrcYQ1XAHl9a9WFY94Bc4Fv9rxQ5rG4mcW
	 q3tRy9G/EJylOkP2w6sHSIlKikO+O5/Q4MMor6VQAvh3B7zJwVkuQ+Kyd7WJu2xQm6
	 HQo4syGIhKD0o6B27CAuowKRsXuOASvkxOv76320=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfKULal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 06:30:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:54502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbfKULal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 06:30:41 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6435C20714;
        Thu, 21 Nov 2019 11:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574335840;
        bh=Rwju7mil6tW/AfAn9a6uUogaLmvQb/zy3wNtrHb4LSE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=G5RLswA97Zv34MBS5+FVmcBxNGECL/UpHfxcNKADLc3btNtRTO5bZoE7xxZu4hxN8
         EaWGfiTFQMDc+4ILEgRP0n74PDzh7zf0xaRGKJeF0Wbhaju13nf7OMUvEAopZb6zA1
         LArGSNfSacOYnKFZSviCLV2etHMKB7itiCV7gUF0=
Date:   Thu, 21 Nov 2019 20:30:35 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] perf probe: fix spelling mistake "addrees" ->
 "address"
Message-Id: <20191121203035.5eae09a076f376472cd4465b@kernel.org>
In-Reply-To: <20191121092623.374896-1-colin.king@canonical.com>
References: <20191121092623.374896-1-colin.king@canonical.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,

On Thu, 21 Nov 2019 09:26:23 +0000
Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in a pr_warning message. Fix it.

Oops, good catch! (How my finger miss-typed this...)

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!

> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  tools/perf/util/probe-finder.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
> index 38d6cd22779f..c470c49a804f 100644
> --- a/tools/perf/util/probe-finder.c
> +++ b/tools/perf/util/probe-finder.c
> @@ -812,7 +812,7 @@ static int verify_representive_line(struct probe_finder *pf, const char *fname,
>  	if (strcmp(fname, __fname) || lineno == __lineno)
>  		return 0;
>  
> -	pr_warning("This line is sharing the addrees with other lines.\n");
> +	pr_warning("This line is sharing the address with other lines.\n");
>  
>  	if (pf->pev->point.function) {
>  		/* Find best match function name and lines */
> -- 
> 2.24.0
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
