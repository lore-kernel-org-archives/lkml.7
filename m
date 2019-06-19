Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4540EC31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 05:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EC0620B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 05:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730920AbfFSFjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 01:39:51 -0400
Received: from ale.deltatee.com ([207.54.116.67]:45700 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbfFSFjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 01:39:49 -0400
Received: from s0106602ad0811846.cg.shawcable.net ([68.147.191.165] helo=[192.168.0.12])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hdTJz-00072o-5Y; Tue, 18 Jun 2019 23:39:47 -0600
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Jon Mason <jdmason@kudzu.us>
Cc:     Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
        linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20190619053205.GA10452@mwanda>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <2f4dea74-d78e-8b53-8dec-df8dc032759c@deltatee.com>
Date:   Tue, 18 Jun 2019 23:39:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190619053205.GA10452@mwanda>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 68.147.191.165
X-SA-Exim-Rcpt-To: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, allenbh@gmail.com, dave.jiang@intel.com, jdmason@kudzu.us, dan.carpenter@oracle.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH] NTB: test: remove a duplicate check
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

,,

On 2019-06-18 11:32 p.m., Dan Carpenter wrote:
> We already verified that the "nm->isr_ctx" allocation succeeded so there
> is no need to check again here.
> 
> Fixes: a6bed7a54165 ("NTB: Introduce NTB MSI Test Client")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Hmm, yup, not sure how that slipped through, must have been a bad rebase
or something. Thanks Dan!

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

> ---
> Hey Logan, can pick a patch prefix when you're introducing a new module?
> "[PATCH] NTB/test: Introduce NTB MSI Test Client" or whatever.

I don't quite follow you there. NTB doesn't really have a good standard
for prefixes. NTB/test might have made sense.

Logan
