Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44745C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 17:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E382206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 17:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729456AbfDDRwp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 13:52:45 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:48940 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfDDRwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 13:52:44 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A6BCA146EDBAF;
        Thu,  4 Apr 2019 10:52:43 -0700 (PDT)
Date:   Thu, 04 Apr 2019 10:52:43 -0700 (PDT)
Message-Id: <20190404.105243.1039649838417325989.davem@davemloft.net>
To:     olivier.tilmans@nokia-bell-labs.com
Cc:     koen.de_schepper@nokia-bell-labs.com, research@bobbriscoe.net,
        brakmo@fb.com, fw@strlen.de, borkmann@iogearbox.net,
        ycheng@google.com, ncardwell@google.com, edumazet@google.com,
        agshew@gmail.com, glenn.judd@morganstanley.com,
        kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] tcp: Ensure DCTCP reacts to losses
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190404121731.13917-1-olivier.tilmans@nokia-bell-labs.com>
References: <20190404121731.13917-1-olivier.tilmans@nokia-bell-labs.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 04 Apr 2019 10:52:44 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Tilmans, Olivier (Nokia - BE/Antwerp)" <olivier.tilmans@nokia-bell-labs.com>
Date: Thu, 4 Apr 2019 12:24:02 +0000

> RFC8257 §3.5 explicitly states that "A DCTCP sender MUST react to
> loss episodes in the same way as conventional TCP".
...
> This patch replace the clamping of alpha by setting ssthresh to
> half of cwnd for both fast retransmissions and RTOs, at most once
> per RTT. Consequently, the dctcp_clamp_alpha_on_loss module parameter
> has been removed.

Applied to 'net' and queued up for -stable, thanks.
