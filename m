Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D962CC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 16:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B58B520692
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 16:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbfKUQoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 11:44:24 -0500
Received: from foss.arm.com ([217.140.110.172]:59154 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726593AbfKUQoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 11:44:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4E21328;
        Thu, 21 Nov 2019 08:44:23 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D1ED3F52E;
        Thu, 21 Nov 2019 08:44:22 -0800 (PST)
Subject: Re: generic DMA bypass flag
To:     Christoph Hellwig <hch@lst.de>,
        Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20191113133731.20870-1-hch@lst.de>
 <d27b7b29-df78-4904-8002-b697da5cb013@arm.com>
 <20191114074105.GC26546@lst.de>
 <9c8f4d7b-43e0-a336-5d93-88aef8aae716@arm.com> <20191116062258.GA8913@lst.de>
 <f2335431-8cd4-e1ab-013d-573d163f4067@arm.com>
 <20191121073450.GC24024@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <fb438be4-edae-8ca3-2eee-ec452f762cd9@arm.com>
Date:   Thu, 21 Nov 2019 16:44:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191121073450.GC24024@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/2019 7:34 am, Christoph Hellwig wrote:
> Robin, does this mean you ACK this series for the powerpc use case?

Yeah, I think we've nailed down sufficient justification now for having 
a generalised flag, so at that point it makes every bit of sense to 
convert PPC's private equivalent.

Robin.

> Alexey and other ppc folks: can you take a look?
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
