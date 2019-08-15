Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A10FC3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 13:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44DF2208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 13:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732614AbfHONwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 09:52:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:57502 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732481AbfHONwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 09:52:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BDE16AF8A;
        Thu, 15 Aug 2019 13:52:44 +0000 (UTC)
Date:   Thu, 15 Aug 2019 15:52:21 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/8] printk: Replace strncmp with str_has_prefix
Message-ID: <20190815135221.qcgerido7aahmpgn@pathway.suse.cz>
References: <20190809071034.17279-1-hslester96@gmail.com>
 <20190814104941.qt66ozcau5fdswcs@pathway.suse.cz>
 <20190815075033.GA26479@tigerII.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815075033.GA26479@tigerII.localdomain>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2019-08-15 16:50:33, Sergey Senozhatsky wrote:
> On (08/14/19 12:49), Petr Mladek wrote:
> > On Fri 2019-08-09 15:10:34, Chuhong Yuan wrote:
> > > strncmp(str, const, len) is error-prone because len
> > > is easy to have typo.
> > > The example is the hard-coded len has counting error
> > > or sizeof(const) forgets - 1.
> > > So we prefer using newly introduced str_has_prefix()
> > > to substitute such strncmp to make code better.
> > > 
> > > Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> > 
> > Reviewed-by: Petr Mladek <pmladek@suse.com>
> 
> Reviewed-by:  Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

Chuong Yuan, should I take this patch via printk.git? Or will
the entire series go via some other tree, please?

Best Regards,
Petr
