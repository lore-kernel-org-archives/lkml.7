Return-Path: <SRS0=geQ9=WA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1A0C19759
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 12:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70DDC20844
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 12:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564923174;
	bh=CUiOp/mIeBCbY/ngTZBhtLw3Og7NrQM1xMiLk8WCzZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PmycW8fg6gmpZk8M6AkQl7Kcbs2r+DN+mC17jg1yiYgnewfUlYgxhEKllCMpNW1wW
	 TbdzXoFXjFoYqBkTn2VAnbwbCCt/lB++Oq+Dvw7dDQhBN5ITl2LeQaipn4elCZqZLz
	 XChhrP4mxw2DwzFGTPEbKOImCGOP/BdtybvA/T5Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfHDMwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Aug 2019 08:52:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:41546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbfHDMwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Aug 2019 08:52:53 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4E70206C1;
        Sun,  4 Aug 2019 12:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564923172;
        bh=CUiOp/mIeBCbY/ngTZBhtLw3Og7NrQM1xMiLk8WCzZo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rsE8Cs+eR48j5AKhlQbv+yGh7FBBQttX0No0RCfXq9MrsfUU4vb7Tq7xMk5Odoir7
         SUaaEbaqJxjcEklT4piX/1eXsI7Kor7FCcI8iI3Pgb3vtaevBihmLacRZ0riMKMpoF
         6/2VSuqAEtPyJT/sNi12M83G2zTuLUsSlY4MVEpY=
Date:   Sun, 4 Aug 2019 15:52:49 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Saeed Mahameed <saeedm@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Use refcount_t for refcount
Message-ID: <20190804125249.GI4832@mtr-leonro.mtl.com>
References: <20190802172334.8305-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802172334.8305-1-hslester96@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 03, 2019 at 01:23:34AM +0800, Chuhong Yuan wrote:
> Reference counters are preferred to use refcount_t instead of
> atomic_t.
> This is because the implementation of refcount_t can prevent
> overflows and detect possible use-after-free.
>
> First convert the refcount field to refcount_t in mlx5/driver.h.
> Then convert the uses to refcount_() APIs.
>
> Changelog:
>
> v1 -> v2:
>   - Add #include in include/linux/mlx5/driver.h.

The same NAK as for version v0.

Thanks
