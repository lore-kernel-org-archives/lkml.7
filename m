Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435CBC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EB772070B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="py7oqiOq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfCDSgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 13:36:32 -0500
Received: from mail.efficios.com ([167.114.142.138]:49506 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfCDSgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 13:36:31 -0500
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 6B9601AB5ED;
        Mon,  4 Mar 2019 13:36:30 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id SMZ9WAbVVQDN; Mon,  4 Mar 2019 13:36:29 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id D7E581AB5E5;
        Mon,  4 Mar 2019 13:36:29 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com D7E581AB5E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1551724589;
        bh=07xPkmhs7FwOJcDdV0UQ2gMK692iJKnG5ApGHq0Fjsg=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=py7oqiOqVRiUriw5100/zGtJdRswWZvlZJ/LApepYku5XtuodYxjTVaF4JOrZNCl0
         ktUOK1E2i+NCvmvHqv9mojYUsF5GY0m+L/zutX/y/umNB0ZGAgDHAIIzTyg4MK1xG5
         X5qpGfsSbnGqK8eAQJ8e2uvXe9x3DaClv5YRREssUWODDOsn76ntyfuJPDnEy5ej2+
         447oW0p4UZ4I0EjoBUrUwY3+sLyvfLUvt+rR4XjeH92He30/w337xMlF6JRW4RSL6R
         EyomWiUnJjq32qvlXV4FvVOvK0kVLqukMUEX/SAQO0NyKgJKCm3cxHdgA1Y21RTnyl
         bdOXW5HLppS7A==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id bh_6oVWNCsnJ; Mon,  4 Mar 2019 13:36:29 -0500 (EST)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id B6A351AB5CE;
        Mon,  4 Mar 2019 13:36:29 -0500 (EST)
Date:   Mon, 4 Mar 2019 13:36:29 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Souptick Joarder <jrdr.linux@gmail.com>, shuah <shuah@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>
Message-ID: <2071300362.1006.1551724589542.JavaMail.zimbra@efficios.com>
In-Reply-To: <20190304183827.GA6809@jordon-HP-15-Notebook-PC>
References: <20190304183827.GA6809@jordon-HP-15-Notebook-PC>
Subject: Re: [PATCH] selftest/rseq: Remove duplicate header
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.10_GA_3758 (ZimbraWebClient - FF65 (Linux)/8.8.10_GA_3745)
Thread-Topic: selftest/rseq: Remove duplicate header
Thread-Index: qwtIGZJvmEpGiWUK15wda0VRYEgzSA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Mar 4, 2019, at 1:38 PM, Souptick Joarder jrdr.linux@gmail.com wrote:

> Remove duplicate header which is included twice
> 
> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>


> ---
> tools/testing/selftests/rseq/rseq.h | 1 -
> 1 file changed, 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/rseq/rseq.h
> b/tools/testing/selftests/rseq/rseq.h
> index c72eb70..6c1126e7 100644
> --- a/tools/testing/selftests/rseq/rseq.h
> +++ b/tools/testing/selftests/rseq/rseq.h
> @@ -16,7 +16,6 @@
> #include <errno.h>
> #include <stdio.h>
> #include <stdlib.h>
> -#include <sched.h>
> #include <linux/rseq.h>
> 
> /*
> --
> 1.9.1

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
