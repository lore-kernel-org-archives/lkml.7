Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB6CC06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 04:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDA9F216C8
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 04:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562040201;
	bh=jvJL+bPNtg0ZDAv1+LERE9M+MK04DJMUIdOMMXa3QUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Vt1k6wQfYVw48z3jV14+m+x/V076eg2fZNPT/PlHlIutov46kilCj436RkdHmLMIq
	 nVNfJGUgHkSjGEtzZX/Hsa+gkgqPdHnKYywZhYd89ONyCm34NQJFNDFVq7/LoLRnZm
	 UhJOLKXlvHLePs7CiBhrrt/DIJQGiFM2KXOvjUpE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725822AbfGBEDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 00:03:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:58024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725648AbfGBEDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 00:03:20 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22B2121473;
        Tue,  2 Jul 2019 04:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562040199;
        bh=jvJL+bPNtg0ZDAv1+LERE9M+MK04DJMUIdOMMXa3QUk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=coz2ue94BQ89zgRbbgS6yrRw9Ol4mzvkavGih9FWLiI6/eauOL0VuHLEorS5FRvZ0
         0MrXng4sAoHJwCWfiAN3IsJJrOIdOIf7J+jlEDqtSXXP2gWa26fJmOFqCcDCTLm2q5
         +acB2w3TdRU+hHAyt7kKeZHq8LwEJ48b5wzBBvJM=
Date:   Tue, 2 Jul 2019 07:03:05 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eli Britstein <elibr@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Bodong Wang <bodong@mellanox.com>
Subject: Re: linux-next: manual merge of the mlx5-next tree with Linus' tree
Message-ID: <20190702040305.GO4727@mtr-leonro.mtl.com>
References: <20190702131327.65dfdcd9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702131327.65dfdcd9@canb.auug.org.au>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2019 at 01:13:27PM +1000, Stephen Rothwell wrote:
> Hi all,
>
> Today's linux-next merge of the mlx5-next tree got a conflict in:
>
>   drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
>
> between commit:
>
>   955858009708 ("net/mlx5e: Fix number of vports for ingress ACL configuration")
>
> from Linus' tree and commit:
>
>   062f4bf4aab5 ("net/mlx5: E-Switch, Consolidate eswitch function number of VFs")
>
> from the mlx5-next tree.
>
> I fixed it up (I just used the latter version) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

Thanks Stephen,

I expect this conflict will vanish once both rdma and netdev pull
mlx5-next branch, which is based on -rc2.

Thanks

>
> --
> Cheers,
> Stephen Rothwell


