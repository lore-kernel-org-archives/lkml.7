Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25F0C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 15:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE7CC20665
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 15:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389469AbfIXP3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 11:29:16 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:52912 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbfIXP3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 11:29:16 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iCmkc-00068z-BI; Tue, 24 Sep 2019 09:29:14 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iCmkb-0003bd-K5; Tue, 24 Sep 2019 09:29:14 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <20190922115247.GA2679387@kroah.com>
        <20190923200818.GA116090@gmail.com> <20190924113135.GA82089@gmail.com>
Date:   Tue, 24 Sep 2019 10:28:45 -0500
In-Reply-To: <20190924113135.GA82089@gmail.com> (Ingo Molnar's message of
        "Tue, 24 Sep 2019 13:31:35 +0200")
Message-ID: <874l11u30y.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1iCmkb-0003bd-K5;;;mid=<874l11u30y.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+mve6moSKjF+aBwF5knbG1Diii4/8YKDM=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [Tree, v2] De-clutter the top level directory, move ipc/ => kernel/ipc/, samples/ => Documentation/samples/ and sound/ => drivers/sound/
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@kernel.org> writes:

>  - Split it into finer grained steps (3 instead of 2 patches per 
>    movement), for easier review and bisection testing:
>
>      toplevel: Move ipc/ to kernel/ipc/: move the files
>      toplevel: Move ipc/ to kernel/ipc/: adjust the build system
>      toplevel: Move ipc/ to kernel/ipc/: adjust comments and documentation

Can we not mess with ipc/ please.

I know that will mess with my muscle memory and I don't see the point.
Especially as long as it is named ipc and not sysvipc.

A half cleanup really looks worse than a real cleanup.

SysV IPC really is a side car on the kernel and on unix in general
and having the directory structure reflect that seems completely sensible.

Eric
