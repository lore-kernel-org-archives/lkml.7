Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11976C7618B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 17:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA43821721
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 17:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387907AbfG0RP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 13:15:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55306 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387823AbfG0RP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 13:15:59 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1E02E883BA;
        Sat, 27 Jul 2019 17:15:59 +0000 (UTC)
Received: from krava (ovpn-204-40.brq.redhat.com [10.40.204.40])
        by smtp.corp.redhat.com (Postfix) with SMTP id 29C03600C0;
        Sat, 27 Jul 2019 17:15:55 +0000 (UTC)
Date:   Sat, 27 Jul 2019 19:15:54 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Vince Weaver <vincent.weaver@maine.edu>
Cc:     linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [patch] perf.data documentation has wrong units for memory size
Message-ID: <20190727171554.GB31276@krava>
References: <alpine.DEB.2.21.1907251155500.22624@macbook-air>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1907251155500.22624@macbook-air>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Sat, 27 Jul 2019 17:15:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 11:57:43AM -0400, Vince Weaver wrote:
> 
> The perf.data-file-format documentation incorrectly says the 
> HEADER_TOTAL_MEM results are in bytes.  The results are in kilobytes
> (perf reads the value from /proc/meminfo)
> 
> Signed-off-by: Vince Weaver <vincent.weaver@maine.edu>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> 
> diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
> index 5f54feb19977..d030c87ed9f5 100644
> --- a/tools/perf/Documentation/perf.data-file-format.txt
> +++ b/tools/perf/Documentation/perf.data-file-format.txt
> @@ -126,7 +126,7 @@ vendor,family,model,stepping. For example: GenuineIntel,6,69,1
>  
>  	HEADER_TOTAL_MEM = 10,
>  
> -An uint64_t with the total memory in bytes.
> +An uint64_t with the total memory in kilobytes.
>  
>  	HEADER_CMDLINE = 11,
>  
