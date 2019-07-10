Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE4AC004EF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 09:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33ECA2084B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 09:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562751107;
	bh=vy0Mr4Uol6rxl9Ul5HNef3JkghGVfMZzH2ZYvBEDPNM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=w03/jYCGgJg033gW3WMNeROmweKUul4M7tmCdIwsmTSYXiChzXFluF2jHq5ma1jT1
	 INqJ5n4L9ppME1YU6Ar+P9IjV2MQaxmT32MzCxytmm/okGhVS2F0MefYKkf5hSayPC
	 kJHKrsKRNL+2p+v67ixu1M/CRRmzVjt9XoQKSPoM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbfGJJbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 05:31:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:34308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727064AbfGJJbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 05:31:45 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C01A020838;
        Wed, 10 Jul 2019 09:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562751104;
        bh=vy0Mr4Uol6rxl9Ul5HNef3JkghGVfMZzH2ZYvBEDPNM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v3AUO4eYGlcdf0/mRSZxPbZ2Xs+pJEVLj+7ECL67ahfXbHScUC+ItJ93D0h1evUJv
         X4xwiL//KM6HoaGu1aq2/XwMq3fleodsYyTzpDjOQ25Ie/Vz+b4bt39sAJRumpGlLl
         PWR5BVOMD3BBROb3E3q6OTjafSO/4YRLR5rXa9ME=
Date:   Wed, 10 Jul 2019 12:31:39 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Saeed Mahameed <saeedm@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Boris Pismenny <borisp@mellanox.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH net-next v3] net/mlx5e: Convert single case statement
 switch statements into if statements
Message-ID: <20190710093139.GG7034@mtr-leonro.mtl.com>
References: <20190710044748.3924-1-natechancellor@gmail.com>
 <20190710060614.6155-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710060614.6155-1-natechancellor@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2019 at 11:06:15PM -0700, Nathan Chancellor wrote:
> During the review of commit 1ff2f0fa450e ("net/mlx5e: Return in default
> case statement in tx_post_resync_params"), Leon and Nick pointed out
> that the switch statements can be converted to single if statements
> that return early so that the code is easier to follow.
>
> Suggested-by: Leon Romanovsky <leon@kernel.org>
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---

Thanks again,
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
