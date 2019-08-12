Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C987C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 08:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26B532085A
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 08:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfHLIY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 04:24:57 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:40730 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726834AbfHLIY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 04:24:57 -0400
X-UUID: e2401d4e653c481e87b5cab55e7c4c14-20190812
X-UUID: e2401d4e653c481e87b5cab55e7c4c14-20190812
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0707 with TLS)
        with ESMTP id 2145448533; Mon, 12 Aug 2019 16:24:48 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 12 Aug 2019 16:24:48 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 12 Aug 2019 16:24:48 +0800
Message-ID: <1565598290.5872.6.camel@mtkswgap22>
Subject: Re: [RFC PATCH v2] mm: slub: print kernel addresses in slub debug
 messages
From:   Miles Chen <miles.chen@mediatek.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        "Tobin C . Harding" <me@tobin.cc>,
        Kees Cook <keescook@chromium.org>
Date:   Mon, 12 Aug 2019 16:24:50 +0800
In-Reply-To: <20190809142617.GO5482@bombadil.infradead.org>
References: <20190809010837.24166-1-miles.chen@mediatek.com>
         <20190809024644.GL5482@bombadil.infradead.org>
         <1565359918.12824.20.camel@mtkswgap22>
         <20190809142617.GO5482@bombadil.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-08-09 at 07:26 -0700, Matthew Wilcox wrote:
> On Fri, Aug 09, 2019 at 10:11:58PM +0800, Miles Chen wrote:
> > On Thu, 2019-08-08 at 19:46 -0700, Matthew Wilcox wrote:
> > > On Fri, Aug 09, 2019 at 09:08:37AM +0800, miles.chen@mediatek.com wrote:
> > > > INFO: Slab 0x(____ptrval____) objects=25 used=10 fp=0x(____ptrval____)
> > > 
> > > ... you don't have any randomness on your platform?
> > 
> > We have randomized base on our platforms.
> 
> Look at initialize_ptr_random().  If you have randomness, then you
> get a siphash_1u32() of the address.  With no randomness, you get this
> ___ptrval___ string instead.
> 
You are right. There is no randomness in this platform. (I ran my test
code on Qemu with no randomness)


thanks again

