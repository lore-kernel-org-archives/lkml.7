Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E65FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD65D2147C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbfCKTlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:41:10 -0400
Received: from verein.lst.de ([213.95.11.211]:43143 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727027AbfCKTlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:41:10 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 7B73468C7B; Mon, 11 Mar 2019 20:41:02 +0100 (CET)
Date:   Mon, 11 Mar 2019 20:41:02 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        David Miller <davem@davemloft.net>,
        Jason Baron <jbaron@akamai.com>, kgraul@linux.ibm.com,
        ktkhai@virtuozzo.com, kyeongdon kim <kyeongdon.kim@lge.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        zhengbin <zhengbin13@huawei.com>, bcrl@kvack.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-aio@kvack.org, houtao1@huawei.com, yi.zhang@huawei.com
Subject: Re: [PATCH 1/8] aio: make sure file is pinned
Message-ID: <20190311194102.GA12602@lst.de>
References: <CAHk-=wghRmdYKRAwakeHmjcpbLt9fJAHyU2x8s_NZONhz6RTOw@mail.gmail.com> <20190307000316.31133-1-viro@ZenIV.linux.org.uk> <CAHk-=wjzJSnQaj5b02aAjFdVMrKOp8UpyfQcoquRjem=X+SgTA@mail.gmail.com> <20190307004159.GY2217@ZenIV.linux.org.uk> <20190307004828.GZ2217@ZenIV.linux.org.uk> <20190307012036.GA2217@ZenIV.linux.org.uk> <CAHk-=whn7iJsbr=_ab3Ghvd1pzxvio3sktrBuMr6aG=gFLFtEg@mail.gmail.com> <20190308033650.GD2217@ZenIV.linux.org.uk> <20190310070606.GA10138@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190310070606.GA10138@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 10, 2019 at 07:06:18AM +0000, Al Viro wrote:
> OK, refactored, cleaned up and force-pushed.  Current state:

This survives the libaio test suite at least.
