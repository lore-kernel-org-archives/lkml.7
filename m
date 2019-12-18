Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE95C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 15:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71906218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 15:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfLRPHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 10:07:55 -0500
Received: from wbironout2.netvigator.com ([210.87.247.20]:35648 "EHLO
        wbironout2.netvigator.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbfLRPHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 10:07:55 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0CPAQBFP/pd/5YXxstlGgEBAQEBAQEBA?=
 =?us-ascii?q?QMBAQEBEQEBAQICAQEBAYF8giKBQSASKpMMghGPHYRvhyMJAQEBDi0CAQGDLYE?=
 =?us-ascii?q?TAoIZJDgTAhABAQQBAQECAQUEbYRrWIVeAQEBAQMnEz8QCw0BBgEDCRoLDwVJE?=
 =?us-ascii?q?4YZBq0BgXQzGgKKMYE2jBgUBj+BQYQkPogLgiwEl1OIFo8gCoI1lgcnDYI2h3m?=
 =?us-ascii?q?ELgMBi2AtqGssgWkigViBBYMnUBiNV44bNDOBKI14AQE?=
X-IronPort-AV: E=Sophos;i="5.69,329,1571673600"; 
   d="scan'208";a="167853902"
X-MGA-submission: =?us-ascii?q?MDEOhlv2hz4iPFKrijO6XP+V6oJP6RMvFlKCZk?=
 =?us-ascii?q?z08k6tR7oEJvdXcfT2bwT35qTLnJp/ImhWtwkkEE+cbb/uyXCHyxwmb8?=
 =?us-ascii?q?iYpgjySSJFpTkt+tb/AawKH3kvS7Saym0wQ6m2M9w1pHGNWrgIUIQoKV?=
 =?us-ascii?q?NI?=
Received: from unknown (HELO ybironoah04.netvigator.com) ([203.198.23.150])
  by wbironout2v2.netvigator.com with ESMTP; 18 Dec 2019 23:07:50 +0800
Received: from unknown (HELO rhel76) ([42.200.157.25])
  by ybironoah04.netvigator.com with ESMTP/TLS/AES128-GCM-SHA256; 18 Dec 2019 23:07:50 +0800
Date:   Wed, 18 Dec 2019 23:07:37 +0800
From:   "Chan Shu Tak, ALex" <alexchan@task.com.hk>
To:     David Miller <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] llc2: Remove the condition operator in
 llc_stat_ev_rx_null_dsap_xid_c and llc_stat_ev_rx_null_dsap_test_c.
Message-ID: <20191218150737.GA5800@rhel76>
References: <1576340820-4929-1-git-send-email-alexchan@task.com.hk>
 <1576555237-4037-1-git-send-email-alexchan@task.com.hk>
 <20191217.221846.1864258542284733289.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217.221846.1864258542284733289.davem@davemloft.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 10:18:46PM -0800, David Miller wrote:
> From: "Chan Shu Tak, Alex" <alexchan@task.com.hk>
> Date: Tue, 17 Dec 2019 12:00:36 +0800
> 
> > @@ -32,7 +32,7 @@ static int llc_stat_ev_rx_null_dsap_xid_c(struct sk_buff *skb)
> >  	return LLC_PDU_IS_CMD(pdu) &&			/* command PDU */
> >  	       LLC_PDU_TYPE_IS_U(pdu) &&		/* U type PDU */
> >  	       LLC_U_PDU_CMD(pdu) == LLC_1_PDU_CMD_XID &&
> > -	       !pdu->dsap ? 1 : 0;			/* NULL DSAP value */
> > +	       !pdu->dsap;				/* NULL DSAP value */
> 
> This isn't a v2 of your patch, it's a patch against v1 of your patch.
> 
> Please do this properly, thank you.

Thanks for your comments and patience and sorry for the troubles that I caused.

I will revise my patch and try again.

In this case, should I start anew or continue on this thread? 

Thanks again for your time.

