Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22AE7C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 07:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD23C20830
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 07:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551424728;
	bh=6NdYZnKZ+Hn6sARhiLIqtJqfeVE5rK2Zf6/zGg/K4r4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CIzgXUzHIk+UzgJAqIq7bOffWeyiwlai+CxBguDO05AoijrPrQtgo8wagB/HRHxMW
	 geT58NkVyfBwLSNzfYvMAkK8j6X8PaHxOGpqndcp6b+RpugtY0ulwF9gHjrE6Yf1Qt
	 iWRoL8guj02chChg6BS7ssqx0kJYvzOFrVkAL/x4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732403AbfCAHSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 02:18:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:39702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725982AbfCAHSp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 02:18:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC11320830;
        Fri,  1 Mar 2019 07:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551424725;
        bh=6NdYZnKZ+Hn6sARhiLIqtJqfeVE5rK2Zf6/zGg/K4r4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=efUIwKFStMUh6tDMHHNkg7R3AvWzNjQ9M7pG6Xs9p8bA+cwvUfivZ+ugMwIkqJ9K8
         PSQyXKezPu9fkc5hCOffT0yLZDVpR1e1F0DTD2F0Se5D09TaaqbFln6j1KpNTDoFRY
         Gxux5PfZL0JnCyJ5Y05gMC4nQHj5H5yAxLoaFlBk=
Date:   Fri, 1 Mar 2019 08:18:42 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Parav Pandit <parav@mellanox.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        michal.lkml@markovi.net, davem@davemloft.net, jiri@mellanox.com
Subject: Re: [RFC net-next 7/8] net/mlx5: Add devlink subdev life cycle
 command support
Message-ID: <20190301071842.GB8975@kroah.com>
References: <1551418672-12822-1-git-send-email-parav@mellanox.com>
 <1551418672-12822-8-git-send-email-parav@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551418672-12822-8-git-send-email-parav@mellanox.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 11:37:51PM -0600, Parav Pandit wrote:
> --- /dev/null
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/subdev.c
> @@ -0,0 +1,55 @@
> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB

For new stuff, just use GPL-2.0, no need to keep the mistake of the
Linux-OpenIB license around :)

thanks,

greg k-h
