Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F59C432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 19:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BADB7206F4
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 19:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbfKQTCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 14:02:49 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:18203
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726069AbfKQTCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 14:02:49 -0500
X-IronPort-AV: E=Sophos;i="5.68,317,1569276000"; 
   d="scan'208";a="327024931"
Received: from abo-228-123-68.mrs.modulonet.fr (HELO hadrien) ([85.68.123.228])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Nov 2019 20:02:46 +0100
Date:   Sun, 17 Nov 2019 20:02:46 +0100 (CET)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Travis Davies <tdavies@darkphysics.net>
cc:     akpm@linux-foundation.org, davem@davemloft.net,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] /linux/netdevice.h: Fix checkpatch.pl comment warning
In-Reply-To: <20191117185722.GA4637@Cheese>
Message-ID: <alpine.DEB.2.21.1911172002050.2553@hadrien>
References: <20191117185722.GA4637@Cheese>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Te subject line does not look correct.  See what other people have done
for this file.

On Sun, 17 Nov 2019, Travis Davies wrote:

> Fix checkpatch Warning:
> '...netdevice.h:100: WARNING: Block comments use a trailing */ on a separate line'

Say what you do and why, and not just Fix X.

julia

> Signed-off-by: Travis Davies <tdavies@darkphysics.net>
>
> ---
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
