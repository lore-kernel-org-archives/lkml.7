Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCCBC76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 18:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C131218F0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 18:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbfGYSUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 14:20:36 -0400
Received: from ale.deltatee.com ([207.54.116.67]:41050 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbfGYSUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 14:20:36 -0400
Received: from s01061831bf6ec98c.cg.shawcable.net ([68.147.80.180] helo=[192.168.6.132])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hqiLv-0002Vc-S5; Thu, 25 Jul 2019 12:20:32 -0600
To:     Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>
References: <20190718225132.5865-1-logang@deltatee.com>
 <20190718225132.5865-2-logang@deltatee.com>
 <c52f80b1-e154-b11f-a868-e3209e4ccb2d@grimberg.me>
 <6deea9e7-ff3c-e115-b2f2-8914df0b6da7@deltatee.com>
 <dd287560-2cb3-28ab-c22d-fe9f3682c609@grimberg.me>
 <021b5195-9a09-4cc2-064f-940ada9cf764@deltatee.com>
 <b501f53b-48e9-87a3-9023-8597ed1efc6d@grimberg.me>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <25f1903e-2ef1-8dbb-c08b-5dd0d44ba2d2@deltatee.com>
Date:   Thu, 25 Jul 2019 12:20:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b501f53b-48e9-87a3-9023-8597ed1efc6d@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 68.147.80.180
X-SA-Exim-Rcpt-To: hch@lst.de, axboe@fb.com, kbusch@kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, sagi@grimberg.me
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 2/2] nvme-core: Fix deadlock when deleting the ctrl while
 scanning
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019-07-25 12:16 p.m., Sagi Grimberg wrote:
> 
>> Hey,
>>
>> Sorry for the delay.
>>
>> I tested your patch and it does work. Do you want me to send your change
>> as a full patch? Can I add your signed-off-by?
> 
> I have a patch ready with a proper comment in place. I can send it
> out... Can I get your tested-by and reported-by?

Yup. I can retest once you send the patch and I'll send a test-by then.
For now you can add my reported-by:

Reported-by: Logan Gunthorpe <logang@deltatee.com>

Note: I had to modify your original patch a fair bit so it compiled with
multipath disabled.

Logan


