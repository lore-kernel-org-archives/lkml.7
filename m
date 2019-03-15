Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC030C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 23:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92AED20700
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 23:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbfCOXPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 19:15:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42118 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726744AbfCOXPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 19:15:50 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A599D307EAA9;
        Fri, 15 Mar 2019 23:15:50 +0000 (UTC)
Received: from redhat.com (ovpn-120-17.rdu2.redhat.com [10.10.120.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 95A3E5C219;
        Fri, 15 Mar 2019 23:15:49 +0000 (UTC)
Date:   Fri, 15 Mar 2019 19:15:47 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Liam Mark <lmark@codeaurora.org>,
        dri-devel@lists.freedesktop.org, "Andrew F . Davis" <afd@ti.com>
Subject: Re: [RFC][PATCH 0/5 v2] DMA-BUF Heaps (destaging ION)
Message-ID: <20190315231547.GB3242@redhat.com>
References: <1551819273-640-1-git-send-email-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1551819273-640-1-git-send-email-john.stultz@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 15 Mar 2019 23:15:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2019 at 12:54:28PM -0800, John Stultz wrote:
> Here is a initial RFC of the dma-buf heaps patchset Andrew and I
> have been working on which tries to destage a fair chunk of ION
> functionality.
> 
> The patchset implements per-heap devices which can be opened
> directly and then an ioctl is used to allocate a dmabuf from the
> heap.
> 
> The interface is similar, but much simpler then IONs, only
> providing an ALLOC ioctl.
> 
> Also, I've provided simple system and cma heaps. The system
> heap in particular is missing the page-pool optimizations ION
> had, but works well enough to validate the interface.
> 
> I've booted and tested these patches with AOSP on the HiKey960
> using the kernel tree here:
>   https://git.linaro.org/people/john.stultz/android-dev.git/log/?h=dev/dma-buf-heap
> 
> And the userspace changes here:
>   https://android-review.googlesource.com/c/device/linaro/hikey/+/909436

What upstream driver will use this eventualy ? And why is it
needed ?

Cheers,
Jérôme
