Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70E0C3A5A4
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 10:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8261217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 10:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731008AbfHZKeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 06:34:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:51236 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727176AbfHZKeS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 06:34:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0C684ABC4;
        Mon, 26 Aug 2019 10:34:16 +0000 (UTC)
Date:   Mon, 26 Aug 2019 12:41:27 +0200
From:   Cyril Hrubis <chrubis@suse.cz>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     ltp@lists.linux.it,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        alexey.kodanev@oracle.com, the_hoang0709@yahoo.com,
        Jan Stancek <jstancek@redhat.com>
Subject: Re: Linux-next-20190823: x86_64/i386: prot_hsymlinks.c:325: Failed
 to run cmd: useradd hsym
Message-ID: <20190826104127.GA14729@haruka>
References: <CA+G9fYtN2tjHZtjtc8isdsD5hF76teeh2-pngUp+uj3WYdj7jA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYtN2tjHZtjtc8isdsD5hF76teeh2-pngUp+uj3WYdj7jA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> Do you see this LTP prot_hsymlinks failure on linux next 20190823 on
> x86_64 and i386 devices?
> 
> test output log,
> useradd: failure while writing changes to /etc/passwd
> useradd: /home/hsym was created, but could not be removed

This looks like an unrelated problem, failure to write to /etc/passwd
probably means that filesystem is full or some problem happend and how
is remounted RO.

I do not see the kernel messages from this job anywhere at the job
pages, is it stored somewhere?

-- 
Cyril Hrubis
chrubis@suse.cz
