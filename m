Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B569FC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91CB2206C0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729581AbfDDNSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 09:18:25 -0400
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:36902 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727053AbfDDNSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 09:18:24 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hC2FX-0007Xe-Qz; Thu, 04 Apr 2019 15:17:48 +0200
Date:   Thu, 4 Apr 2019 15:17:47 +0200
From:   Florian Westphal <fw@strlen.de>
To:     "Tilmans, Olivier (Nokia - BE/Antwerp)" 
        <olivier.tilmans@nokia-bell-labs.com>
Cc:     "De Schepper, Koen (Nokia - BE/Antwerp)" 
        <koen.de_schepper@nokia-bell-labs.com>,
        Bob Briscoe <research@bobbriscoe.net>,
        Lawrence Brakmo <brakmo@fb.com>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Yuchung Cheng <ycheng@google.com>,
        Neal Cardwell <ncardwell@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Andrew Shewmaker <agshew@gmail.com>,
        Glenn Judd <glenn.judd@morganstanley.com>,
        "David S. Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2] tcp: Ensure DCTCP reacts to losses
Message-ID: <20190404131747.grzhfkzryaltcw7l@breakpoint.cc>
References: <20190404121731.13917-1-olivier.tilmans@nokia-bell-labs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190404121731.13917-1-olivier.tilmans@nokia-bell-labs.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tilmans, Olivier (Nokia - BE/Antwerp) <olivier.tilmans@nokia-bell-labs.com> wrote:
> RFC8257 §3.5 explicitly states that "A DCTCP sender MUST react to
> loss episodes in the same way as conventional TCP".

Thanks, this looks good.

Acked-by: Florian Westphal <fw@strlen.de>
