Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CB0C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 17:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C39C9206C2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 17:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbfJHRHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 13:07:54 -0400
Received: from utopia.booyaka.com ([74.50.51.50]:60682 "EHLO
        utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbfJHRHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 13:07:53 -0400
Received: (qmail 6504 invoked by uid 1019); 8 Oct 2019 17:07:52 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 8 Oct 2019 17:07:52 -0000
Date:   Tue, 8 Oct 2019 17:07:52 +0000 (UTC)
From:   Paul Walmsley <paul@pwsan.com>
To:     Vincent Chen <vincent.chen@sifive.com>
cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH 4/4] riscv: remove the switch statement in
 do_trap_break()
In-Reply-To: <CABvJ_xiHJSB7P5QekuLRP=LBPzXXghAfuUpPUYb=a_HbnOQ6BA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.999.1910081707220.4786@utopia.booyaka.com>
References: <1569199517-5884-1-git-send-email-vincent.chen@sifive.com> <1569199517-5884-5-git-send-email-vincent.chen@sifive.com> <20190927224711.GI4700@infradead.org> <alpine.DEB.2.21.9999.1910070906570.10936@viisi.sifive.com> <20191007161050.GA20596@infradead.org>
 <alpine.DEB.2.21.9999.1910070930270.10936@viisi.sifive.com> <CABvJ_xiHJSB7P5QekuLRP=LBPzXXghAfuUpPUYb=a_HbnOQ6BA@mail.gmail.com>
User-Agent: Alpine 2.21.999 (DEB 260 2018-02-26)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Oct 2019, Vincent Chen wrote:

> Sorry,  I missed the comment. Christoph's suggestion is also good to me.
> I will modify it as you suggested.

Thanks - no need to resend, I'll queue the modified patch up here.


- Paul
