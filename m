Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC715C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 16:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB35F22CEC
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 16:43:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436836AbfHWQnE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 12:43:04 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:35900 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2436778AbfHWQnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 12:43:04 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 00F237EA5DA45134DDB5;
        Sat, 24 Aug 2019 00:42:54 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Sat, 24 Aug 2019
 00:42:45 +0800
Date:   Fri, 23 Aug 2019 17:42:36 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     zhangfei <zhangfei.gao@linaro.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Zaibo Xu <xuzaibo@huawei.com>,
        <linux-kernel@vger.kernel.org>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        "Kenneth Lee" <liguozhu@hisilicon.com>,
        <linux-accelerators@lists.ozlabs.org>
Subject: Re: [PATCH 2/2] uacce: add uacce module
Message-ID: <20190823174236.00005868@huawei.com>
In-Reply-To: <b5d9fe84-abfd-c8ca-d059-e186e1609e06@linaro.org>
References: <1565775265-21212-1-git-send-email-zhangfei.gao@linaro.org>
        <1565775265-21212-3-git-send-email-zhangfei.gao@linaro.org>
        <20190815175424.00002256@huawei.com>
        <b5d9fe84-abfd-c8ca-d059-e186e1609e06@linaro.org>
Organization: Huawei
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Aug 2019 17:21:33 +0800
zhangfei <zhangfei.gao@linaro.org> wrote:

> Hi, Jonathan
> 
> Thanks for your careful review and good suggestion.
> Sorry for late response, I am checking one detail.
> 
> On 2019/8/16 上午12:54, Jonathan Cameron wrote:
> > On Wed, 14 Aug 2019 17:34:25 +0800
> > Zhangfei Gao <zhangfei.gao@linaro.org> wrote:
> >  
> >> From: Kenneth Lee <liguozhu@hisilicon.com>
> >>
> >> Uacce is the kernel component to support WarpDrive accelerator
> >> framework. It provides register/unregister interface for device drivers
> >> to expose their hardware resource to the user space. The resource is
> >> taken as "queue" in WarpDrive.  
> > It's a bit confusing to have both the term UACCE and WarpDrive in here.
> > I'd just use the uacce name in all comments etc.  
> Yes, make sense
> >  
> >> Uacce create a chrdev for every registration, the queue is allocated to
> >> the process when the chrdev is opened. Then the process can access the
> >> hardware resource by interact with the queue file. By mmap the queue
> >> file space to user space, the process can directly put requests to the
> >> hardware without syscall to the kernel space.
> >>
> >> Uacce also manages unify addresses between the hardware and user space
> >> of the process. So they can share the same virtual address in the
> >> communication.
> >>
> >> Signed-off-by: Kenneth Lee <liguozhu@hisilicon.com>
> >> Signed-off-by: Zaibo Xu <xuzaibo@huawei.com>
> >> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
> >> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>  
> > I would strip this back to which ever case is of most interest (SVA I guess?)
> > and only think about adding support for the others if necessary at a later date.
> > (or in later patches).  
> Do you mean split the patch and send sva part first?

Yes.  Either send them as two series with SVA only in the first one, or
a single series with SVA only in the early patches.

I want to be able to review one case first then only consider what needs
to be added for the others.

Thanks,

Jonathan


