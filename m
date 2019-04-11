Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD62BC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 07:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8925D217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 07:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfDKHsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 03:48:02 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:39479 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726121AbfDKHsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 03:48:02 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1697789|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.105179-0.00301162-0.891809;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03306;MF=han_mao@c-sky.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.EJoNtGn_1554968879;
Received: from localhost(mailfrom:han_mao@c-sky.com fp:SMTPD_---.EJoNtGn_1554968879)
          by smtp.aliyun-inc.com(10.147.42.198);
          Thu, 11 Apr 2019 15:47:59 +0800
Date:   Thu, 11 Apr 2019 15:40:29 +0800
From:   Mao Han <han_mao@c-sky.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] perf: use hweight64 instead of hweight_long
Message-ID: <20190411074024.GA8981@vmh-VirtualBox>
References: <cover.1554883878.git.han_mao@c-sky.com>
 <29ad7947dc8fd1ff0abd2093a72cc27a2446be9f.1554883878.git.han_mao@c-sky.com>
 <20190410130841.GE13888@kernel.org>
 <20190410131042.GF13888@kernel.org>
 <20190410132837.GG13888@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410132837.GG13888@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 10:28:37AM -0300, Arnaldo Carvalho de Melo wrote:
> > > You forgot to convert that one, doing it for you,
> > 
> > Also in perf_event__sample_event_size() we need to do the same thing,
> > right?
> 
> and perf_event__synthesize_sample()
> 
> Done, resulting patch is at the end of this messages, and matches the
> kernel, that uses only hweight64().
> 
> I've also added Fixes tags to the patches that used hweight_long() in
> various places, to help with the stable trees backporting process,
> please consider doing it next time.
> 
> - Arnaldo
>

Thanks for help improving the patch and the suggestion.
Tested with the new patch on C-SKY, seems work fine.

Mao Han
