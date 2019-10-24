Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB322CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 17:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9029520659
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 17:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439988AbfJXRSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 13:18:31 -0400
Received: from ale.deltatee.com ([207.54.116.67]:39994 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436828AbfJXRSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 13:18:31 -0400
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1iNgkh-0005m1-1a; Thu, 24 Oct 2019 11:18:25 -0600
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
References: <20191023163545.4193-1-logang@deltatee.com>
 <20191023163545.4193-4-logang@deltatee.com> <20191024011743.GC5190@lst.de>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <382906f0-ce0b-282a-9665-8317b50fe374@deltatee.com>
Date:   Thu, 24 Oct 2019 11:18:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191024011743.GC5190@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: sbates@raithlin.com, maxg@mellanox.com, Chaitanya.Kulkarni@wdc.com, sagi@grimberg.me, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 3/7] nvmet: Introduce common execute function for
 get_log_page and identify
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019-10-23 7:17 p.m., Christoph Hellwig wrote:
> On Wed, Oct 23, 2019 at 10:35:41AM -0600, Logan Gunthorpe wrote:
>> Instead of picking the sub-command handler to execute in a nested
>> switch statement introduce a landing functions that calls out
>> to the appropriate sub-command handler.
>>
>> This will allow us to have a common place in the handler to check
>> the transfer length in a future patch.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> [logang@deltatee.com: separated out of a larger draft patch from hch]
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> 
> First signoff needs to be the From line picked up by git.  I don't really
> care if you keep my attribution or not, but if you do it needs From
> line for me as the first theing in the mail body, and if not it
> should drop by signoff and just say based on a patch from me.
> 
> Otherwise the series looks fine.

Ok, understood. Do you want me to fix this up in a v2? Or can you fix it
up when you pick up the patches?

Thanks,

Logan
