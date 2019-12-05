Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A12C2D0BF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 12:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29C472245C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 12:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575548210;
	bh=JrTSdIrzvfGw0n2g1HFxF6EnXJcyW4HKIkiTE+69Lio=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=r1kNrbxtln/GKzQRMEMSmjr059efijTRyc7R4Ctisqn1f3iFsubVQRfnN4o3w1cx5
	 H57lArtXeo3XlRrMXb9sr9G/BA0BU3HRhjArgwLcv9EwjULRwcvftvtOWuW+3zBai5
	 C+Thuon89IfbIDsRBZmCkkvttPcGEc1bMCw9dWFc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729412AbfLEMQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 07:16:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:59932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729074AbfLEMQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 07:16:48 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56DC32245C;
        Thu,  5 Dec 2019 12:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575548208;
        bh=JrTSdIrzvfGw0n2g1HFxF6EnXJcyW4HKIkiTE+69Lio=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0DNjvzgfKR8YvAQoaS5tLzKNeSqYu2EPJoPnNU5bXNfyib9n/qL6tFpj8gt1Up7Ha
         nrIVYWKKlumS8aa5vOUfcR+vtefkAzQDU4isJtu6IEhDxydmmVzTHycQd3Pn9WeM5W
         aRIJCImZ5V6btNyNFOzqtpfo31UjzziyJ1YkqqnE=
Date:   Thu, 5 Dec 2019 21:16:43 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, Micah Morton <mortonm@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        jaswinder.singh@linaro.org
Subject: Re: [BUGFIX PATCH 0/2] selftests: safesetid: Fix build warnings and
 errors
Message-Id: <20191205211643.8253ca3925c336f9a27ee84e@kernel.org>
In-Reply-To: <157553119188.17524.1379079312058580155.stgit@devnote2>
References: <157553119188.17524.1379079312058580155.stgit@devnote2>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  5 Dec 2019 16:33:12 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi,
> 
> Here are the patches to fix build warnings and erorrs on
> kselftest safesetid.

Oops, I found one another bug in safesetid. I'll send v2 including
new fix.

Thank you,

> 
> Thank you,
> 
> ---
> 
> Masami Hiramatsu (2):
>       selftests: safesetid: Move link library to LDLIBS
>       selftests: safesetid: Check the return value of setuid/setgid
> 
> 
>  tools/testing/selftests/safesetid/Makefile         |    3 ++-
>  tools/testing/selftests/safesetid/safesetid-test.c |   15 ++++++++++-----
>  2 files changed, 12 insertions(+), 6 deletions(-)
> 
> --
> Masami Hiramatsu (Linaro) <mhiramat@kernel.org>


-- 
Masami Hiramatsu <mhiramat@kernel.org>
