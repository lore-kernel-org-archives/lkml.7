Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115E1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC0AD21873
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:09:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbfCUIJc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 04:09:32 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:57944 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbfCUIJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 04:09:31 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id F1F7A609185A;
        Thu, 21 Mar 2019 09:09:29 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id wdwSuQEe9G0W; Thu, 21 Mar 2019 09:09:29 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id ABBB3609187E;
        Thu, 21 Mar 2019 09:09:29 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id WWftNVS9VFek; Thu, 21 Mar 2019 09:09:29 +0100 (CET)
Received: from blindfold.localnet (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 4B114609185A;
        Thu, 21 Mar 2019 09:09:29 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Mukesh Ojha <mojha@codeaurora.org>
Cc:     Yue Haibing <yuehaibing@huawei.com>, dedekind1@gmail.com,
        adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH -next] ubifs: remove unused function __ubifs_shash_final
Date:   Thu, 21 Mar 2019 09:09:28 +0100
Message-ID: <24657306.kQxLvZqZK3@blindfold>
In-Reply-To: <289f9994-0980-081e-f913-5729b16d16f4@codeaurora.org>
References: <20190320140955.11576-1-yuehaibing@huawei.com> <2691086.gDEv9kBeKS@blindfold> <289f9994-0980-081e-f913-5729b16d16f4@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 21. März 2019, 08:54:55 CET schrieb Mukesh Ojha:
> >> Acked-by: Mukesh Ojha <mojha@codeaurora.org>
> > I guess you mean Reviewed-by?
> 
> As i am unsure about future scope of this func. i.e why Acked.

Acked-by is usually something I expect from the code author
or the person that owns the code.

Thanks,
//richard


