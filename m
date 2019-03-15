Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD14C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 11:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71745218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 11:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbfCOLe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 07:34:58 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:59768 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbfCOLe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 07:34:57 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1h4l6t-0006nU-Pu; Fri, 15 Mar 2019 11:34:47 +0000
Date:   Fri, 15 Mar 2019 11:34:47 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     David Howells <dhowells@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        fenghua.yu@intel.com, linux-kernel@vger.kernel.org
Subject: Re: fs_context-related oops in mainline
Message-ID: <20190315113447.GX2217@ZenIV.linux.org.uk>
References: <20190315074307.GA31430@light.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190315074307.GA31430@light.dominikbrodowski.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 08:43:07AM +0100, Dominik Brodowski wrote:
> David, Al,
> 
> commit 23bf1b6be9c2 ("kernfs, sysfs, cgroup, intel_rdt: Support fs_context")
> seems to have introduced a bug; at least that's the commit I bisected the
> following oops down to:

> This occurs while trying to mount sysfs in initramfs
> 
> 	mount -n -t sysfs sysfs /sys
> 
> All this obviously runs in qemu; config and further information are available upon request.

.config, please?
