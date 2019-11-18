Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEABC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 20:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FA9C2230C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 20:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfKRUzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 15:55:22 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:39242
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726475AbfKRUzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 15:55:21 -0500
X-IronPort-AV: E=Sophos;i="5.68,321,1569276000"; 
   d="scan'208";a="327162018"
Received: from abo-228-123-68.mrs.modulonet.fr (HELO hadrien) ([85.68.123.228])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Nov 2019 21:55:03 +0100
Date:   Mon, 18 Nov 2019 21:55:02 +0100 (CET)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Travis Davies <tdavies@darkphysics.net>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] net: Fix comment block per style guide
In-Reply-To: <20191118185724.GA32637@Cheese>
Message-ID: <alpine.DEB.2.21.1911182154160.3116@hadrien>
References: <20191118185724.GA32637@Cheese>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 18 Nov 2019, Travis Davies wrote:

> Signed-off-by: Travis Davies <tdavies@darkphysics.net>
>
> ---
>
> This patch places /* and */ on separate lines for a
> multiline block comment, in order to keep code style
> consistant with majority of blocks throughout the file.
>
> This will prevent a checkpatch.pl warning:
> 'Block comments use a trailing */ on a separate line'

The comments and the signed off by both go above the ---.  Comments first.
Look at lkml to see what others do.

julia

>
>  include/linux/netdevice.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index c20f190b4c18..a2605e043fa2 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -95,9 +95,11 @@ void netdev_set_default_ethtool_ops(struct net_device *dev,
>  #define NET_XMIT_CN		0x02	/* congestion notification	*/
>  #define NET_XMIT_MASK		0x0f	/* qdisc flags in net/sch_generic.h */
>
> -/* NET_XMIT_CN is special. It does not guarantee that this packet is lost. It
> +/*
> + * NET_XMIT_CN is special. It does not guarantee that this packet is lost. It
>   * indicates that the device will soon be dropping packets, or already drops
> - * some packets of the same priority; prompting us to send less aggressively. */
> + * some packets of the same priority; prompting us to send less aggressively.
> + */
>  #define net_xmit_eval(e)	((e) == NET_XMIT_CN ? 0 : (e))
>  #define net_xmit_errno(e)	((e) != NET_XMIT_CN ? -ENOBUFS : 0)
>
> --
> 2.21.0
>
>
