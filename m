Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD95C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 13:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D908E222D0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 13:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728710AbfCXNVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 09:21:11 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:43591 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfCXNVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 09:21:10 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h833R-0001Zk-40; Sun, 24 Mar 2019 14:20:49 +0100
Date:   Sun, 24 Mar 2019 14:20:47 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     syzbot <syzbot+b358909d8d01556b790b@syzkaller.appspotmail.com>
cc:     alexander.h.duyck@intel.com, amritha.nambiar@intel.com,
        andrew@lunn.ch, avagin@gmail.com, danielj@mellanox.com,
        davem@davemloft.net, dledford@redhat.com,
        dmitry.torokhov@gmail.com, gregory.clement@bootlin.com,
        jason@lakedaemon.net, jeffrey.t.kirsher@intel.com, jgg@ziepe.ca,
        joe@perches.com, leon@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, marc.zyngier@arm.com,
        miquel.raynal@bootlin.com, netdev@vger.kernel.org,
        parav@mellanox.com, sebastian.hesselbarth@gmail.com,
        swise@opengridcomputing.com, syzkaller-bugs@googlegroups.com,
        tyhicks@canonical.com
Subject: Re: KASAN: use-after-free Read in addr_handler
In-Reply-To: <0000000000001f5bce0584d5b095@google.com>
Message-ID: <alpine.DEB.2.21.1903241419510.1798@nanos.tec.linutronix.de>
References: <0000000000001f5bce0584d5b095@google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Mar 2019, syzbot wrote:

> syzbot has bisected this bug to:
> 
> commit 4f4c867c91e644fc9d461c8c5cf2f09d6d5bcac2
> Author: Miquel Raynal <miquel.raynal@bootlin.com>
> Date:   Tue Oct 2 08:54:16 2018 +0000
> 
>    irqchip/irq-mvebu-icu: Support ICU subnodes

Yet another bogus bisect result. Why? That code is ARM only and cannot
influence x86 by any means.

Thanks,

	tglx
