Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC87C3276C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 00:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BBB52085B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 00:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbgACAbm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 19:31:42 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:55782 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgACAbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 19:31:41 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7121815728C58;
        Thu,  2 Jan 2020 16:31:41 -0800 (PST)
Date:   Thu, 02 Jan 2020 16:31:41 -0800 (PST)
Message-Id: <20200102.163141.1473240611016870659.davem@davemloft.net>
To:     Julia.Lawall@inria.fr
Cc:     madalin.bucur@nxp.com, kernel-janitors@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/10] fsl/fman: use resource_size
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1577900990-8588-5-git-send-email-Julia.Lawall@inria.fr>
References: <1577900990-8588-1-git-send-email-Julia.Lawall@inria.fr>
        <1577900990-8588-5-git-send-email-Julia.Lawall@inria.fr>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 02 Jan 2020 16:31:41 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julia Lawall <Julia.Lawall@inria.fr>
Date: Wed,  1 Jan 2020 18:49:44 +0100

> Use resource_size rather than a verbose computation on
> the end and start fields.
> 
> The semantic patch that makes these changes is as follows:
> (http://coccinelle.lip6.fr/)
> 
> <smpl>
> @@ struct resource ptr; @@
> - (ptr.end + 1 - ptr.start)
> + resource_size(&ptr)
> 
> @@ struct resource *ptr; @@
> - (ptr->end + 1 - ptr->start)
> + resource_size(ptr)
> </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Applied to net-next.

Thanks Julia.
