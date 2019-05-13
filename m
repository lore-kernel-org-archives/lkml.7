Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ACB2C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 14:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C1EB208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 14:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729448AbfEMO3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 10:29:25 -0400
Received: from foss.arm.com ([217.140.101.70]:57490 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbfEMO3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 10:29:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 75B0080D;
        Mon, 13 May 2019 07:29:24 -0700 (PDT)
Received: from [10.1.196.129] (ostrya.cambridge.arm.com [10.1.196.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6442F3F71E;
        Mon, 13 May 2019 07:29:23 -0700 (PDT)
Subject: Re: linux-next: manual merge of the vhost tree with the iommu tree
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lan Tianyu <Tianyu.Lan@microsoft.com>
References: <20190227152506.4696a59f@canb.auug.org.au>
 <2370af99-9dc1-b694-9f1c-1951d1e70435@arm.com>
 <20190227085546-mutt-send-email-mst@kernel.org>
 <20190228100442.GB1594@8bytes.org>
 <20190512131410-mutt-send-email-mst@kernel.org>
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <7b10be49-f379-c586-d8fd-d67bb932fabd@arm.com>
Date:   Mon, 13 May 2019 15:29:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190512131410-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2019 18:16, Michael S. Tsirkin wrote:
> On Thu, Feb 28, 2019 at 11:04:42AM +0100, Joerg Roedel wrote:
>> On Wed, Feb 27, 2019 at 08:58:36AM -0500, Michael S. Tsirkin wrote:
>>> Even though it's not going into 5.1 I feel it's helpful to keep it in
>>> the vhost tree until the next cycle, it helps make sure unrelated
>>> changes don't break it.
>>
>> It is not going to 5.1, so it shouldn't be in linux-next, no? And when
>> it is going upstream, it should do so through the iommu tree. If you
>> keep it separatly in the vhost tree for testing purposes, please make
>> sure it is not included into your linux-next branch.
>>
>> Regards,
>>
>> 	Joerg
> 
> Joerg, what are we doing with these patches?
> It was tested in next with no bad effects.
> I sent an ack - do you want to pick it up?
> Or have me include it in my pull?

I'll resend the driver for v5.3 with some changes. They should be minor
but one of the changes (domain bits -> domain range) touches UAPI and
isn't backward compatible, so it would be better not to merge it this
time around.

Thanks,
Jean
