Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21EECC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFE5C2184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbfCTUTj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 16:19:39 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:47162 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbfCTUTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 16:19:39 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id C0177609185A;
        Wed, 20 Mar 2019 21:19:36 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 5LPTQF1JokWG; Wed, 20 Mar 2019 21:19:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 4883860ED8A1;
        Wed, 20 Mar 2019 21:19:36 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id S1oWfxpoei8A; Wed, 20 Mar 2019 21:19:36 +0100 (CET)
Received: from blindfold.localnet (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id C11B8609185A;
        Wed, 20 Mar 2019 21:19:35 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Mukesh Ojha <mojha@codeaurora.org>
Cc:     Yue Haibing <yuehaibing@huawei.com>, dedekind1@gmail.com,
        adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH -next] ubifs: remove unused function __ubifs_shash_final
Date:   Wed, 20 Mar 2019 21:18:58 +0100
Message-ID: <2691086.gDEv9kBeKS@blindfold>
In-Reply-To: <97289b81-ed73-002a-504d-2e82fad153e7@codeaurora.org>
References: <20190320140955.11576-1-yuehaibing@huawei.com> <97289b81-ed73-002a-504d-2e82fad153e7@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 20. März 2019, 21:05:37 CET schrieb Mukesh Ojha:
> 
> On 3/20/2019 7:39 PM, Yue Haibing wrote:
> > From: YueHaibing <yuehaibing@huawei.com>
> >
> > There is no callers in tree, and can be removed.
> >
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > ---
> >   fs/ubifs/auth.c | 18 ------------------
> >   1 file changed, 18 deletions(-)
> >
> > diff --git a/fs/ubifs/auth.c b/fs/ubifs/auth.c
> > index 5bf5fd0..2a40ccce 100644
> > --- a/fs/ubifs/auth.c
> > +++ b/fs/ubifs/auth.c
> > @@ -147,24 +147,6 @@ struct shash_desc *__ubifs_hash_get_desc(const struct ubifs_info *c)
> >   }
> >   
> >   /**
> > - * __ubifs_shash_final - finalize shash
> > - * @c: UBIFS file-system description object
> > - * @desc: the descriptor
> > - * @out: the output hash
> > - *
> > - * Simple wrapper around crypto_shash_final(), safe to be called with
> > - * disabled authentication.
> > - */
> > -int __ubifs_shash_final(const struct ubifs_info *c, struct shash_desc *desc,
> > -			u8 *out)
> > -{
> > -	if (ubifs_authenticated(c))
> > -		return crypto_shash_final(desc, out);
> > -
> > -	return 0;
> > -}
> > -
> > -/**
> >    * ubifs_bad_hash - Report hash mismatches
> >    * @c: UBIFS file-system description object
> >    * @node: the node
> 
> 
> 
> Looks fine to be removed.
> 
> Acked-by: Mukesh Ojha <mojha@codeaurora.org>

I guess you mean Reviewed-by?

Thanks,
//richard



