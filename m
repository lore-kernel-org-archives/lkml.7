Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9CEC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 06:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF1C32177E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 06:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="k02HtCVT";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IMnFOBwR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbfC1Gdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 02:33:50 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50608 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbfC1Gdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 02:33:50 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C33F36072E; Thu, 28 Mar 2019 06:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553754829;
        bh=vELmGJZgsdE7uTd30OhE+H9dZ7PHYWfzte6mHgFTMOQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=k02HtCVTeYn7WCRPu6MeDG+4VJCYFpwWE5TWzH3AuGLzRv59hchi9ZPZ+Tp9DaPFR
         9PNmfXI4xxXN0XwowmcoKXN1rmq+CXDzFnzJakl3WLFHU5hSDeisj+gRrkwN54Ekp9
         Mz19jkRneFEUMme30I+K50+ImRl1UPtQ4sVHb36I=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 51AB66072E;
        Thu, 28 Mar 2019 06:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553754827;
        bh=vELmGJZgsdE7uTd30OhE+H9dZ7PHYWfzte6mHgFTMOQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=IMnFOBwR+yLJ7k6Y/zh80FsFxqDbBz8ufWsmWIRwQoIMse5VCvZ7oUI3Wm/oCaocj
         WXbe0f0SMmoWrU+AnVY5SubtJU7gZYoBpR/QVdCHX85iuGn9/6jFLjkuLUOWQfSZhU
         jNoeFqhEwcFhGe+uRJrVUTH40v0Em0ODeMT7UDwE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 51AB66072E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] selftests:powerpc/tm/tm-vmx-unavail.c : Remove duplicate
 header
To:     jagdsh.linux@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
        mpe@ellerman.id.au, shuah@kernel.org, paul.burton@mips.com
Cc:     inuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1553723356-40069-1-git-send-email-jagdsh.linux@gmail.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <682ef220-efac-3c11-0205-35c00fa4b611@codeaurora.org>
Date:   Thu, 28 Mar 2019 12:03:41 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1553723356-40069-1-git-send-email-jagdsh.linux@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/28/2019 3:19 AM, jagdsh.linux@gmail.com wrote:
> From: Jagadeesh Pagadala <jagdsh.linux@gmail.com>
>
> Remove duplicate header which is included twice.
>
> Signed-off-by: Jagadeesh Pagadala <jagdsh.linux@gmail.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

-Mukesh
> ---
>   tools/testing/selftests/powerpc/tm/tm-vmx-unavail.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/tools/testing/selftests/powerpc/tm/tm-vmx-unavail.c b/tools/testing/selftests/powerpc/tm/tm-vmx-unavail.c
> index 137185b..1cb963a 100644
> --- a/tools/testing/selftests/powerpc/tm/tm-vmx-unavail.c
> +++ b/tools/testing/selftests/powerpc/tm/tm-vmx-unavail.c
> @@ -17,7 +17,6 @@
>   #include <pthread.h>
>   #include <sys/mman.h>
>   #include <unistd.h>
> -#include <pthread.h>
>   
>   #include "tm.h"
>   #include "utils.h"
