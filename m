Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0843C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 10:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF11F20811
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 10:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730515AbfDYKvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 06:51:03 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58462 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729031AbfDYKvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 06:51:02 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hJbxq-0003Cs-2m; Thu, 25 Apr 2019 12:50:50 +0200
Date:   Thu, 25 Apr 2019 12:50:49 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
cc:     "Li, Aubrey" <aubrey.li@linux.intel.com>, mingo@redhat.com,
        peterz@infradead.org, hpa@zytor.com, ak@linux.intel.com,
        tim.c.chen@linux.intel.com, dave.hansen@intel.com,
        arjan@linux.intel.com, adobriyan@gmail.com,
        akpm@linux-foundation.org, aubrey.li@intel.com,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v17 1/3] proc: add /proc/<pid>/arch_status
In-Reply-To: <ee1620d5-9650-5bfa-c458-fa2d051522b1@metux.net>
Message-ID: <alpine.DEB.2.21.1904251249200.1960@nanos.tec.linutronix.de>
References: <20190421183529.9141-1-aubrey.li@linux.intel.com> <alpine.DEB.2.21.1904242310040.1762@nanos.tec.linutronix.de> <da1fcb4f-e856-d31f-7c72-76c969af3935@linux.intel.com> <6a9e6bd9-8e1a-9fe5-135d-c7a49697b5a4@metux.net> <4456cc68-5120-e820-90ed-cb5b5dfcd760@linux.intel.com>
 <ee1620d5-9650-5bfa-c458-fa2d051522b1@metux.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Apr 2019, Enrico Weigelt, metux IT consult wrote:

> On 25.04.19 12:42, Li, Aubrey wrote:
> > 
> > Yep, I'll make it disabled by default and not switchable and let arch select it.
> > 
> 
> That's not quite what I've suggested. Instead:
> 
> #1: make the switch depend on the arch's that support it

No. That's what select is for.

> #2: still leave it selectable to the user, so somebody who doesn't need
>     it, can just disable it.

Well, the number of knobs is exploding over time and the number of people
actually tweaking them is close to 0. So no, we don't want to have the
extra tunable for everything and the world.

Thanks,

	tglx
