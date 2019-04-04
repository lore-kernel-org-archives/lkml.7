Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 040FCC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C702520855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Pez4en/s";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="V7Eyi6Yy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbfDDIrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:47:01 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42358 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbfDDIrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:47:01 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7DF9861195; Thu,  4 Apr 2019 08:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554367620;
        bh=kYneu8WQ2E83mQMJ8ku6mqxcFcUw+FWj+eEidn+OXc8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Pez4en/sT4AXoJ96QDID8Hq1nqN8lYIqOeZHfGpzHZGw048Q86E8ZDIqP7GEoggP8
         KAGWHtu8BIdW6xZZ0ZoyflUNOHcBMUIfgV4refUFZmsvlqKxfD1QOKmy/h/RH59ekl
         pkFGzqw1+pERqQuFqgbf1o5nW2qrC+b0OMxfHrqU=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2FA2260E40;
        Thu,  4 Apr 2019 08:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554367618;
        bh=kYneu8WQ2E83mQMJ8ku6mqxcFcUw+FWj+eEidn+OXc8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=V7Eyi6YyrD/BX+gu+MklnXJfXXj84IReSWcKha5negEkktCydRuG8aRl/n61w6cve
         aJpw7lEciUeOHcVv+DlHPwCxOet2pd7VeB0nqdiHvBDAZyOn+qUVctnKE7zY8cDoH2
         8pawuMjlLaY6gIRlQToPYNdg+md8cVE+qxmPURxs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2FA2260E40
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] perf script: fix spelling mistake "multipe" -> "multiple"
To:     Colin King <colin.king@canonical.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190404082341.16335-1-colin.king@canonical.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <88ac84e6-e179-4fa6-c53f-b0df4fa0df7b@codeaurora.org>
Date:   Thu, 4 Apr 2019 14:16:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190404082341.16335-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/4/2019 1:53 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in the Documentation. Fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh
> ---
>   tools/perf/Documentation/perf-script.txt | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
> index 9b0d04dd2a61..e84aba03fc25 100644
> --- a/tools/perf/Documentation/perf-script.txt
> +++ b/tools/perf/Documentation/perf-script.txt
> @@ -360,7 +360,7 @@ include::itrace.txt[]
>   	stop time is not given (i.e, time string is 'x.y,') then analysis goes
>   	to end of file.
>   
> -	Also support time percent with multipe time range. Time string is
> +	Also support time percent with multiple time range. Time string is
>   	'a%/n,b%/m,...' or 'a%-b%,c%-%d,...'.
>   
>   	For example:
