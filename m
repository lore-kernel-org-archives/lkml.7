Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFCBC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 15:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8EA620706
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 15:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfKVPGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 10:06:19 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:50603 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbfKVPGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 10:06:19 -0500
X-Originating-IP: 153.3.140.100
Received: from localhost (unknown [153.3.140.100])
        (Authenticated sender: fly@kernel.page)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id C0A674001B;
        Fri, 22 Nov 2019 15:06:01 +0000 (UTC)
Date:   Fri, 22 Nov 2019 23:05:43 +0800
From:   Pengfei Li <fly@kernel.page>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        vbabka@suse.cz, cl@linux.com, iamjoonsoo.kim@lge.com, guro@fb.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC v1 00/19] Modify zonelist to nodelist v1
Message-ID: <20191122230543.2f106c80.fly@kernel.page>
In-Reply-To: <20191121180401.GL23213@dhcp22.suse.cz>
References: <20191121151811.49742-1-fly@kernel.page>
        <20191121180401.GL23213@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Nov 2019 19:04:01 +0100
Michal Hocko <mhocko@kernel.org> wrote:

> On Thu 21-11-19 23:17:52, Pengfei Li wrote:
> [...]
> > Since I don't currently have multiple node NUMA systems, I would be
> > grateful if anyone would like to test this series of patches.
> 
> I didn't really get to think about the actual patchset. From a very
> quick glance I am wondering whether we need to optimize as there are
> usually only small amount of numa nodes. But I am quite busy so I
> cannot really do any claims.

Thanks for your comments.

I think it's time to modify the zonelist to nodelist because the
zonelist is always in node order and the page reclamation is based on
node.

I will do more performance testing to show that multi-node systems will
benefit from this series of patches.

> Anyway, you can test this even without NUMA HW. Have a look at
> numa=fake option (numa_emu_cmdline). Or you can use kvm/qemu which
> provides easy ways to setup a NUMA capable virtual machine.

Thanks a lot. I will use the numa=fake option to do more performance
testing.


