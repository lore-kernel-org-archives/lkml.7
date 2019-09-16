Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045C0C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 14:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5BCD214D9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 14:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388539AbfIPOQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 10:16:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39366 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbfIPOQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 10:16:14 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i9rnX-0008P1-Su; Mon, 16 Sep 2019 16:16:12 +0200
Date:   Mon, 16 Sep 2019 16:16:11 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Alex Williamson <alex.williamson@redhat.com>
cc:     Ben Luo <luoben@linux.alibaba.com>, linux-kernel@vger.kernel.org,
        tao.ma@linux.alibaba.com, gerry@linux.alibaba.com,
        nanhai.zou@linux.alibaba.com
Subject: Re: [PATCH v6 0/3] genirq/vfio: Introduce irq_update_devid() and
 optimize VFIO irq ops
In-Reply-To: <20190913114452.5e05d8c4@x1.home>
Message-ID: <alpine.DEB.2.21.1909161615230.1887@nanos.tec.linutronix.de>
References: <cover.1567394624.git.luoben@linux.alibaba.com> <abb4080f-dfe2-1882-4bde-51bb7e660d4a@linux.alibaba.com> <20190913114452.5e05d8c4@x1.home>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Sep 2019, Alex Williamson wrote:

> On Tue, 10 Sep 2019 14:30:16 +0800
> Ben Luo <luoben@linux.alibaba.com> wrote:
> 
> > A friendly reminder.
> 
> The vfio patch looks ok to me.  Thomas, do you have further comments or
> a preference on how to merge these?  I'd tend to prefer the vfio
> changes through my branch for testing and can pull the irq changes with
> your approval, but we could do the reverse or split them and I could
> follow with the vfio change once the irq changes are in mainline.

I can provide you a branch, once I looked again at that stuff. It's
somewhere in that huge conference induced backlog.

Thanks,

	tglx
