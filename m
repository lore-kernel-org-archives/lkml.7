Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDADC31E54
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 03:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ECC621855
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 03:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560743593;
	bh=2QIQNZai0AZQXkrqFUKN5Sn183NHfvqV8A3b+hNasZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AdwtizaO6AwVfgOvndU13Y40pqhj+Es/+gYlcsPd5EUnzhNGrWz1ZASoZaooJt21p
	 0V7DfcQemt9fKt9l7le+kapFHBjLp0rnRezaUpQklLG/+w6UbZjqcP4VuHHbJzp2o3
	 6FEw4+htlzV23VV+gXarh085yzhC/lRryZdcXHZA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbfFQDxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 23:53:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:46594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727625AbfFQDxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 23:53:11 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30E6A2147A;
        Mon, 17 Jun 2019 03:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560743590;
        bh=2QIQNZai0AZQXkrqFUKN5Sn183NHfvqV8A3b+hNasZM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZPeN51CyF3QDUWHh5nxxEtKa55nkIpUBKb3OZY/yNlv9JaFpiEl7bbjERzHxXv2Cs
         VmsEiYXRrx3d3iFFzM8wx6D0yw9iTLEzvroh4XqBhzRAWLrC+LDcbCJV9sgm2rcxaK
         QTmmsXurSKlmEMxgt/qPUrROs9vq0LXDoD7beRW4=
Date:   Mon, 17 Jun 2019 06:53:06 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Parav Pandit <parav@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>
Subject: Re: linux-next: manual merge of the mlx5-next tree with Linus' tree
Message-ID: <20190617035306.GB4690@mtr-leonro.mtl.com>
References: <20190617121959.55976690@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617121959.55976690@canb.auug.org.au>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 12:19:59PM +1000, Stephen Rothwell wrote:
> Hi Leon,
>
> Today's linux-next merge of the mlx5-next tree got a conflict in:
>
>   include/linux/mlx5/eswitch.h
>
> between commit:
>
>   02f3afd97556 ("net/mlx5: E-Switch, Correct type to u16 for vport_num and int for vport_index")
>
> from Linus' tree and commit:
>
>   82b11f071936 ("net/mlx5: Expose eswitch encap mode")
>
> from the mlx5-next tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>
> --
> Cheers,
> Stephen Rothwell
>

Thanks
