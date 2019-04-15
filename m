Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D05C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 801652075B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbfDOMm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 08:42:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:33380 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727214AbfDOMm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 08:42:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3C638ADCF;
        Mon, 15 Apr 2019 12:42:56 +0000 (UTC)
Date:   Mon, 15 Apr 2019 14:42:55 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     shuah <shuah@kernel.org>, jpoimboe@redhat.com, jikos@kernel.org,
        joe.lawrence@redhat.com, live-patching@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: livepatch use TEST_PROGS for test shell
 scripts
Message-ID: <20190415124255.hcraeeiu5xoziber@pathway.suse.cz>
References: <20190412011823.26884-1-shuah@kernel.org>
 <alpine.LSU.2.21.1904120901490.773@pobox.suse.cz>
 <8967c9aa-7eb1-7e6d-a371-f29a2be24c84@kernel.org>
 <alpine.LSU.2.21.1904121535100.773@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.1904121535100.773@pobox.suse.cz>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2019-04-12 15:37:37, Miroslav Benes wrote:
> From: Miroslav Benes <mbenes@suse.cz>
> Date: Fri, 12 Apr 2019 15:31:42 +0200
> Subject: [PATCH] selftests/livepatch: Add functions.sh to TEST_PROGS_EXTENDED
> 
> Add functions.sh to TEST_PROGS_EXTENDED so that it is installed along
> with the rest of the selftests and they can be run.
> 
> Originally-by: Shuah Khan <shuah@kernel.org>
> Signed-off-by: Miroslav Benes <mbenes@suse.cz>
> ---
>  tools/testing/selftests/livepatch/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/livepatch/Makefile b/tools/testing/selftests/livepatch/Makefile
> index 114f43e2081a..fd405402c3ff 100644
> --- a/tools/testing/selftests/livepatch/Makefile
> +++ b/tools/testing/selftests/livepatch/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
> +TEST_PROGS_EXTENDED := functions.sh
>  TEST_PROGS := \
>  	test-livepatch.sh \
>  	test-callbacks.sh \
> -- 
> 2.21.0

The patch has been committed into the branch for-5.1/upstream-fixes.

Best Regards,
Petr
