Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3F6C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 05:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C841216C8
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 05:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="H6KogFeO";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UEzbIyle"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731974AbfHBFY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 01:24:57 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49226 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbfHBFY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 01:24:57 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8F2C360863; Fri,  2 Aug 2019 05:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564723495;
        bh=GmtpdBoo6eVMwIaIkrqBsggdRCm4FRqn1B21zm7FHhk=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=H6KogFeOFD+WxPdDxqKBaLP4LPiBAi5Su86umjwRcTK2yF/hjSTjM0kwpwIsmwWk5
         B0w8I7qB46YMmVQ+r91dt2l8urFaWxS+rlHz8vPI9zgyHJyJqrcugIqQ8R8bOF9B5M
         3ipP3T8ZzmqMU1waSH73rrkGrte5SYcSm6iVsaOg=
Received: from [10.79.168.112] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9424C601D4;
        Fri,  2 Aug 2019 05:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564723494;
        bh=GmtpdBoo6eVMwIaIkrqBsggdRCm4FRqn1B21zm7FHhk=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=UEzbIyleUppNe0OYQUhAacWLr03GWhq5WuZqOE4mJ5tHuvf+pfNaBUziBkCMv/Da0
         l2vXpseaj/ZvL8D/kSZQfLqfwZZM26BU2B08K4Hfou+9fic579ee9Zr5zHQPnN3DJu
         ppjT9vn+2CVsTM1LgpDgJGeM3NgbPvrNdZGX+thA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9424C601D4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] perf tools: Fix a typo in Makefile
To:     Masanari Iida <standby24x7@gmail.com>,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org
References: <20190801032812.25018-1-standby24x7@gmail.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <b9d6455f-4d9c-35b5-5a4a-863ba6a1d0f4@codeaurora.org>
Date:   Fri, 2 Aug 2019 10:54:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190801032812.25018-1-standby24x7@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/1/2019 8:58 AM, Masanari Iida wrote:
> This patch fix a spelling typo in Makefile.
>
> Signed-off-by: Masanari Iida <standby24x7@gmail.com>

Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

-Mukesh

> ---
>   tools/perf/Documentation/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/Documentation/Makefile b/tools/perf/Documentation/Makefile
> index 6d148a40551c..adc5a7e44b98 100644
> --- a/tools/perf/Documentation/Makefile
> +++ b/tools/perf/Documentation/Makefile
> @@ -242,7 +242,7 @@ $(OUTPUT)doc.dep : $(wildcard *.txt) build-docdep.perl
>   	$(PERL_PATH) ./build-docdep.perl >$@+ $(QUIET_STDERR) && \
>   	mv $@+ $@
>   
> --include $(OUPTUT)doc.dep
> +-include $(OUTPUT)doc.dep
>   
>   _cmds_txt = cmds-ancillaryinterrogators.txt \
>   	cmds-ancillarymanipulators.txt \
