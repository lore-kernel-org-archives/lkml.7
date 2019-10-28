Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFFCCA9EC1
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 16:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83AE521479
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 16:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572279650;
	bh=kR8ZRzVktZsrVSrs2I+9RAcAnHJT9+FqtAQh0LUTVHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=g0PhHFs6SbzG4nCsqYshUt+OsCa5PkGFTIvjz/3CAP8a3nbPeiP7SMpGDXn+7jBOn
	 fpZgJRPj2Alb0bDNoRcbfSHa4Rt9boJylaZaR46/ZOWM4xMlET9kF922KipYVVYJc7
	 BQHpkZyScTkc4eqIow82I5cU49ZBa3ZmX6ZgEofs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390882AbfJ1QUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 12:20:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:41634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728780AbfJ1QUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 12:20:49 -0400
Received: from localhost (unknown [91.217.168.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D870620873;
        Mon, 28 Oct 2019 16:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572279648;
        bh=kR8ZRzVktZsrVSrs2I+9RAcAnHJT9+FqtAQh0LUTVHQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h+CcdotX99a+WwOjrTnnkEHvtlomQufJsJ0DhoVWalWzZ9EgmZph8UOPmGTXNDvYK
         ZSmgR821TnE6kwIqS7aWWVKf9YIkAO5MgmLdK3xPhMnlBcgHyHQZfSkjW0VBnpg7Xy
         LAgAA83grRD/5N/R4Pb+gKRQ1ia+IxtJvNlqDymw=
Date:   Mon, 28 Oct 2019 12:20:45 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lan Tianyu <Tianyu.Lan@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        linux-hyperv@vger.kernel.org, Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] drivers: iommu: hyperv: Make HYPERV_IOMMU only available
 on x86
Message-ID: <20191028162045.GG1554@sasha-vm>
References: <20191017005711.2013647-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191017005711.2013647-1-boqun.feng@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 08:57:03AM +0800, Boqun Feng wrote:
>Currently hyperv-iommu is implemented in a x86 specific way, for
>example, apic is used. So make the HYPERV_IOMMU Kconfig depend on X86
>as a preparation for enabling HyperV on architecture other than x86.
>
>Cc: Lan Tianyu <Tianyu.Lan@microsoft.com>
>Cc: Michael Kelley <mikelley@microsoft.com>
>Cc: linux-hyperv@vger.kernel.org
>Signed-off-by: Boqun Feng (Microsoft) <boqun.feng@gmail.com>

Queued up for hyperv-fixes, thanks!

-- 
Thanks,
Sasha
