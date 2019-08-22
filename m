Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E9CC3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 09:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57414233FC
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 09:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731943AbfHVJgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 05:36:11 -0400
Received: from shell.v3.sk ([90.176.6.54]:35995 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbfHVJgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 05:36:11 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id BE832D7556;
        Thu, 22 Aug 2019 11:36:09 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 1v5Ri6TRypyq; Thu, 22 Aug 2019 11:36:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 3B668D755A;
        Thu, 22 Aug 2019 11:36:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jvTFurhOyODo; Thu, 22 Aug 2019 11:36:04 +0200 (CEST)
Received: from belphegor (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 009DDD7556;
        Thu, 22 Aug 2019 11:36:03 +0200 (CEST)
Message-ID: <1e13a307539b47b8d874bdc5c36b705ba7a72f7e.camel@v3.sk>
Subject: Re: [PATCH] clk: tidy up the help tags in Kconfig
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 22 Aug 2019 11:36:02 +0200
In-Reply-To: <20190816192707.DCC022133F@mail.kernel.org>
References: <20190816185716.530013-1-lkundrak@v3.sk>
         <20190816192707.DCC022133F@mail.kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-08-16 at 12:27 -0700, Stephen Boyd wrote:
> Quoting Lubomir Rintel (2019-08-16 11:57:16)
> > Sometimes an extraneous "---help---" follows "help". That is probably a
> > copy&paste error stemming from their inconsistent use. Let's just replace
> > them all with "help", removing the extra ones along the way.
> 
> Can you just send the patch to remove the extra ones? I don't really
> care to make it consistent in the same patch.

Sure. Just done so.

Do you also care about making it consistent, or is it okay to just
leave it as it is?

Thanks
Lubo

