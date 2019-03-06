Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A72CEC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 03:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CDA520675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 03:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbfCFDDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 22:03:25 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:57950 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727730AbfCFDDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 22:03:25 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7FD2D1473DDA6;
        Tue,  5 Mar 2019 19:03:24 -0800 (PST)
Date:   Tue, 05 Mar 2019 19:03:23 -0800 (PST)
Message-Id: <20190305.190323.1175144356168830240.davem@davemloft.net>
To:     saeedm@mellanox.com
Cc:     roid@mellanox.com, leon@kernel.org, netdev@vger.kernel.org,
        gustavo@embeddedor.com, elibr@mellanox.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] net/mlx5e: Remove redundant assignment
From:   David Miller <davem@davemloft.net>
In-Reply-To: <176546c027a13f39c0dd8d5915b2d16b98637782.camel@mellanox.com>
References: <da1f1300-20f4-2929-078b-71ac1772a933@mellanox.com>
        <20190304062645.GZ15253@mtr-leonro.mtl.com>
        <176546c027a13f39c0dd8d5915b2d16b98637782.camel@mellanox.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 05 Mar 2019 19:03:24 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Saeed Mahameed <saeedm@mellanox.com>
Date: Tue, 5 Mar 2019 22:21:39 +0000

> On Mon, 2019-03-04 at 08:26 +0200, Leon Romanovsky wrote:
>> On Sun, Mar 03, 2019 at 03:20:57PM +0000, Roi Dayan wrote:
>> > 
>> > On 02/03/2019 21:39, Gustavo A. R. Silva wrote:
>> > > Remove redundant assignment to tun_entropy->enabled.
>> > > 
>> > > Addesses-Coverity-ID: 1477328 ("Unused value")
>> > > Fixes: 97417f6182f8 ("net/mlx5e: Fix GRE key by controlling port
>> > > tunnel entropy calculation")
>> > 
>> > the commit doesn't fix any real issue but is more of a cleanup.
>> > so I'm not sure if fixes line is relevant or not.
>> > beside that looks ok.
>> 
>> It doesn't matter if it is real issue or not, the code is wrong and
>> should be fixed. This alone is enough to see the Fixes line.
>> 
>> Thanks,
>> Acked-by: Leon Romanovsky <leonro@mellanox.com>
> 
> Acked-by: Saeed Mahameed <saeedm@mellanox.com>
> Dave, Do you think such patch should go to net, or do you want me to
> send it in my next pull request to net-next, once it is open of course
> ?

This feels more like net-next stuff to me, thanks for asking.
