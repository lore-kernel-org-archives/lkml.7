Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC15C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 13:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6AFA2054F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 13:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfEFNyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 09:54:07 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:38669 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbfEFNyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 09:54:07 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 44yPNY0bjTz9s7T; Mon,  6 May 2019 23:54:05 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 6be6a8de1b55e719e3f95894910743719065d6a1
X-Patchwork-Hint: ignore
In-Reply-To: <20190504070430.57008-1-weiyongjun1@huawei.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alastair D'Silva <alastair@d-silva.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, kernel-janitors@vger.kernel.org,
        Wei Yongjun <weiyongjun1@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] ocxl: Fix return value check in afu_ioctl()
Message-Id: <44yPNY0bjTz9s7T@ozlabs.org>
Date:   Mon,  6 May 2019 23:54:05 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-05-04 at 07:04:30 UTC, Wei Yongjun wrote:
> In case of error, the function eventfd_ctx_fdget() returns ERR_PTR() and
> never returns NULL. The NULL test in the return value check should be
> replaced with IS_ERR().
> 
> This issue was detected by using the Coccinelle software.
> 
> Fixes: 060146614643 ("ocxl: move event_fd handling to frontend")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> Acked-by: Alastair D'Silva <alastair@d-silva.org>
> Acked-by: Andrew Donnellan <ajd@linux.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/6be6a8de1b55e719e3f9589491074371

cheers
