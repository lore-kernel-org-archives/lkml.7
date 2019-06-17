Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9976C31E44
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 08:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8882C21C38
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 08:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbfFQIOq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 04:14:46 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:48903 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbfFQIOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 04:14:45 -0400
Received: from xps13 (aaubervilliers-681-1-81-150.w90-88.abo.wanadoo.fr [90.88.23.150])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 0372B200003;
        Mon, 17 Jun 2019 08:14:35 +0000 (UTC)
Date:   Mon, 17 Jun 2019 10:14:34 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-mtd@lists.infradead.org,
        David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] jffs2: do not use C++ style comments in uapi header
Message-ID: <20190617101434.3d29808c@xps13>
In-Reply-To: <20190603165027.11831-1-yamada.masahiro@socionext.com>
References: <20190603165027.11831-1-yamada.masahiro@socionext.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

Masahiro Yamada <yamada.masahiro@socionext.com> wrote on Tue,  4 Jun
2019 01:50:27 +0900:

> Linux kernel tolerates C++ style comments these days. Actually, the
> SPDX License Identifier for .c files uses C++ comment style.
> 
> On the other hand, uapi headers are strict, where the C++ comment
> style is banned.
> 
> Looks like these lines are temporarily commented out, so I did not
> use the block comment style.
> 
> Having said that, they have been commented out since the pre-git era.
> (so, at least 14 years). 'Maybe later' may not happen. Alternative fix
> might be to delete these lines entirely.

Richard's POV on the question would be interesting but mine would be to
simple drop these lines.

> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  include/uapi/linux/jffs2.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/uapi/linux/jffs2.h b/include/uapi/linux/jffs2.h
> index a18b719f49d4..5dee6d930d5b 100644
> --- a/include/uapi/linux/jffs2.h
> +++ b/include/uapi/linux/jffs2.h
> @@ -77,10 +77,10 @@
>  
>  #define JFFS2_ACL_VERSION		0x0001
>  
> -// Maybe later...
> -//#define JFFS2_NODETYPE_CHECKPOINT (JFFS2_FEATURE_RWCOMPAT_DELETE | JFFS2_NODE_ACCURATE | 3)
> -//#define JFFS2_NODETYPE_OPTIONS (JFFS2_FEATURE_RWCOMPAT_COPY | JFFS2_NODE_ACCURATE | 4)
> -
> +/* Maybe later...
> +#define JFFS2_NODETYPE_CHECKPOINT (JFFS2_FEATURE_RWCOMPAT_DELETE | JFFS2_NODE_ACCURATE | 3)
> +#define JFFS2_NODETYPE_OPTIONS (JFFS2_FEATURE_RWCOMPAT_COPY | JFFS2_NODE_ACCURATE | 4)
> +*/
>  
>  #define JFFS2_INO_FLAG_PREREAD	  1	/* Do read_inode() for this one at
>  					   mount time, don't wait for it to

Thanks,
Miquèl
