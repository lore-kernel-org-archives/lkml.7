Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FAKE_REPLY_C,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A9BBCA9EB0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 16:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17A282086D
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 16:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbfKCQAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 11:00:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:53164 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727523AbfKCQAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 11:00:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BC454B1F7;
        Sun,  3 Nov 2019 16:00:31 +0000 (UTC)
Date:   Sun, 3 Nov 2019 17:00:30 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     flameeyes@flameeyes.com
Cc:     axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: Re: cdrom: make debug logging rely on pr_debug and debugfs only.
Message-ID: <20191103160030.GO1384@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826151640.5036-3-flameeyes@flameeyes.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

can you change cd_dbg to a macro that always prints the device name
using pr_debug instead of removing it?

That way you will get much more useful debug messages. That's also what
many other subsystems do.

Also consider adding some relevant mailinglist to cc. I think the
MAINTAINERS even specifies linux-scsi for cdrom and/or sr.

Thanks

Michal
