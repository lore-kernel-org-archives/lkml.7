Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75062C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 10:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53FD5206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 10:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732347AbfETKCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 06:02:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:46452 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725951AbfETKCK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 06:02:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 05869AFBE;
        Mon, 20 May 2019 10:02:08 +0000 (UTC)
Date:   Mon, 20 May 2019 12:02:07 +0200
From:   Cyril Hrubis <chrubis@suse.cz>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, lkp@01.org,
        Roman Gushchin <guro@fb.com>, ltp@lists.linux.it
Subject: Re: [LTP] [mm]  8c7829b04c: ltp.overcommit_memory01.fail
Message-ID: <20190520100207.GC25405@rei.lan>
References: <20190520032018.GW31424@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520032018.GW31424@shao2-debian>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> commit: 8c7829b04c523cdc732cb77f59f03320e09f3386 ("mm: fix false-positive OVERCOMMIT_GUESS failures")

This has been reported on the LTP ML already, LTP tests needs to be
adjusted, see:

http://lists.linux.it/pipermail/ltp/2019-May/011962.html

-- 
Cyril Hrubis
chrubis@suse.cz
