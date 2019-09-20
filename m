Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99193C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 19:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73E8C2080F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 19:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729674AbfITTkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 15:40:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37478 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbfITTkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 15:40:41 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 27477308213F;
        Fri, 20 Sep 2019 19:40:41 +0000 (UTC)
Received: from treble (ovpn-123-153.rdu2.redhat.com [10.10.123.153])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4E784614C2;
        Fri, 20 Sep 2019 19:40:40 +0000 (UTC)
Date:   Fri, 20 Sep 2019 14:40:35 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool: bump function name limit to 256 characters
Message-ID: <20190920194035.mwsvz7nyc4peph2j@treble>
References: <20190920182503.GA15073@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190920182503.GA15073@avx2>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 20 Sep 2019 19:40:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 09:25:03PM +0300, Alexey Dobriyan wrote:
> Fix the following warning:
> 
> net/core/devlink.o: warning: objtool: _ZL31devlink_nl_sb_tc_pool_bind_fillP7sk_buffP7devlinkP12devlink_portP10devlink_sbt20devlink_sb_pool_type15devlink_commandjji.constprop.0.cold(): parent function name exceeds maximum length of 128 characters

Hm, since when do we have mangled symbols in the kernel?

-- 
Josh
