Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A344BC10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6498220645
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PUm7v+V+";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="A6PVDL54"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731840AbfDQLHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 07:07:31 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47450 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfDQLHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 07:07:31 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9E6606055C; Wed, 17 Apr 2019 11:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555499250;
        bh=Qfj20dggX29wkRWIYju9V6EjFoJePYJu8gjPdaDxGpc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=PUm7v+V+Dfc+6ijNOKiG+peYTEm3pU/NoSQKNNsGmx6h2G9gHSyL5MudWeLfczy1/
         LhA5keQrY2FiT5v9RYof+zW/xJTo03UuZcbxwMvFsUfMorrrPfvrGs301Gbffd6LgT
         Ck2pSnwlbuXhVBTIBx5JPgdzOhhhrFwXLPNDaBjs=
Received: from [10.204.79.15] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EDBE86055C;
        Wed, 17 Apr 2019 11:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555499249;
        bh=Qfj20dggX29wkRWIYju9V6EjFoJePYJu8gjPdaDxGpc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=A6PVDL54zcWucbE4lCs97RM2T5VGBPI0XpeM1vIVKIl2AID2HJZzQ77nLCuJHAopa
         8q0ZUn2Ry5y3bHIVwmFwtSXRA0HSwPBCguBTFVPaBeivmqvoEZxA19BOh53G/alFPO
         zTl2DeaUS/ljNxCkvS1k0OZLgVLEFcdSaDjb0sC0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EDBE86055C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] perf test: fix spelling mistake "leadking" -> "leaking"
To:     Colin King <colin.king@canonical.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190417105539.5902-1-colin.king@canonical.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <c9808cb2-7025-2b7a-f311-c69469fc1341@codeaurora.org>
Date:   Wed, 17 Apr 2019 16:37:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190417105539.5902-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/17/2019 4:25 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> There are a couple of spelling mistakes in test assert messages. Fix them.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Well, how are you shooting these mistakes one after the other?

Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

> ---
>   tools/perf/tests/dso-data.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/tests/dso-data.c b/tools/perf/tests/dso-data.c
> index 7f6c52021e41..946ab4b63acd 100644
> --- a/tools/perf/tests/dso-data.c
> +++ b/tools/perf/tests/dso-data.c
> @@ -304,7 +304,7 @@ int test__dso_data_cache(struct test *test __maybe_unused, int subtest __maybe_u
>   	/* Make sure we did not leak any file descriptor. */
>   	nr_end = open_files_cnt();
>   	pr_debug("nr start %ld, nr stop %ld\n", nr, nr_end);
> -	TEST_ASSERT_VAL("failed leadking files", nr == nr_end);
> +	TEST_ASSERT_VAL("failed leaking files", nr == nr_end);
>   	return 0;
>   }
>   
> @@ -380,6 +380,6 @@ int test__dso_data_reopen(struct test *test __maybe_unused, int subtest __maybe_
>   	/* Make sure we did not leak any file descriptor. */
>   	nr_end = open_files_cnt();
>   	pr_debug("nr start %ld, nr stop %ld\n", nr, nr_end);
> -	TEST_ASSERT_VAL("failed leadking files", nr == nr_end);
> +	TEST_ASSERT_VAL("failed leaking files", nr == nr_end);
>   	return 0;
>   }
