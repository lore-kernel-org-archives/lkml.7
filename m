Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2751C2D0D0
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 02:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A12B720663
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 02:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbfLYCZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 21:25:45 -0500
Received: from ale.deltatee.com ([207.54.116.67]:60070 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726258AbfLYCZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 21:25:45 -0500
Received: from s0106602ad0811846.cg.shawcable.net ([68.147.191.165] helo=[192.168.0.12])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1ijwMn-0002rd-Gt; Tue, 24 Dec 2019 19:25:42 -0700
To:     Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, Kit Chow <kchow@gigaio.com>
References: <20191216190120.21374-1-logang@deltatee.com>
 <20191224045004.GI2536@vkoul-mobl>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <aba86729-b9e7-dc7e-0860-05c95439a673@deltatee.com>
Date:   Tue, 24 Dec 2019 19:25:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191224045004.GI2536@vkoul-mobl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 68.147.191.165
X-SA-Exim-Rcpt-To: kchow@gigaio.com, dave.jiang@intel.com, dan.j.williams@intel.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, vkoul@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 0/5] Support hot-unbind in IOAT
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019-12-23 9:50 p.m., Vinod Koul wrote:
> On 16-12-19, 12:01, Logan Gunthorpe wrote:
>> Hey,
>>
>> This patchset creates some common infrastructure which I will use in the
>> next version of the PLX driver. It adds a reference count to the
>> dma_device struct which is taken and released every time a channel
>> is allocated or freed. A call back is used to allow the driver to
>> free the underlying memory and do any final cleanup.
>>
>> For a use-case, I've adjusted the ioat driver to properly support
>> hot-unbind. The driver was already pretty close as it already had
>> a shutdown state; so it mostly only required freeing the memory
>> correctly and calling ioat_shutdown at the correct time.
> 
> I didnt find anything else (apart from one change i pointed), so I have
> applied this and will fix the comment. No point in delaying this

Great, thanks!

Logan
