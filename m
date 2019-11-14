Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874AFC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 09:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A9CB2071F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 09:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfKNJIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 04:08:50 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:44749 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727389AbfKNJIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 04:08:38 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 47DFyW0zdDz9sSK; Thu, 14 Nov 2019 20:08:34 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 11dd34f3eae5a468013bb161a1dcf1fecd2ca321
In-Reply-To: <20190218125644.87448-1-yuehaibing@huawei.com>
To:     YueHaibing <yuehaibing@huawei.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Aravinda Prasad <aravinda@linux.vnet.ibm.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Laurent Dufour <ldufour@linux.vnet.ibm.com>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, kernel-janitors@vger.kernel.org,
        YueHaibing <yuehaibing@huawei.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] powerpc/pseries: Drop pointless static qualifier in vpa_debugfs_init()
Message-Id: <47DFyW0zdDz9sSK@ozlabs.org>
Date:   Thu, 14 Nov 2019 20:08:34 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-02-18 at 12:56:44 UTC, YueHaibing wrote:
> There is no need to have the 'struct dentry *vpa_dir' variable static
> since new value always be assigned before use it.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/11dd34f3eae5a468013bb161a1dcf1fecd2ca321

cheers
