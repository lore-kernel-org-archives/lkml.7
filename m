Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BDAC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 869CB28034
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbfFCMc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 08:32:56 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:46633 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727349AbfFCMcu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 08:32:50 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 45HZFr6FK1z9sNC; Mon,  3 Jun 2019 22:32:48 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 00b0cdbbc87fb4b531a0d75f4004ed3d89999b80
X-Patchwork-Hint: ignore
Content-Type: text/plain; charset="utf-8";
In-Reply-To: <20190504102720.42220-1-yuehaibing@huawei.com>
To:     YueHaibing <yuehaibing@huawei.com>, <fbarrat@linux.ibm.com>,
        <ajd@linux.ibm.com>, <arnd@arndb.de>, <gregkh@linuxfoundation.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     YueHaibing <yuehaibing@huawei.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] misc: ocxl: Make ocxl_remove static
Message-Id: <45HZFr6FK1z9sNC@ozlabs.org>
Date:   Mon,  3 Jun 2019 22:32:48 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-05-04 at 10:27:20 UTC, YueHaibing wrote:
> Fix sparse warning:
> 
> drivers/misc/ocxl/pci.c:44:6: warning:
>  symbol 'ocxl_remove' was not declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> Acked-by: Andrew Donnellan <ajd@linux.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/00b0cdbbc87fb4b531a0d75f4004ed3d

cheers
