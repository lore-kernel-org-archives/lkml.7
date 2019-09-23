Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5336DC432C1
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 21:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FDA220673
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 21:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503096AbfIWV2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 17:28:15 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:35019 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732345AbfIWV2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 17:28:14 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iCVsT-0001pQ-Cr; Mon, 23 Sep 2019 15:28:13 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iCVsS-0000Vb-NH; Mon, 23 Sep 2019 15:28:13 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     "Michael Kerrisk \(man-pages\)" <mtk.manpages@gmail.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        Daniel Colascione <dancol@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <f21dbd73-5ef4-fb5b-003f-ff4fec34a1de@gmail.com>
Date:   Mon, 23 Sep 2019 16:27:45 -0500
In-Reply-To: <f21dbd73-5ef4-fb5b-003f-ff4fec34a1de@gmail.com> (Michael
        Kerrisk's message of "Mon, 23 Sep 2019 11:12:00 +0200")
Message-ID: <87ftkmu2i6.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1iCVsS-0000Vb-NH;;;mid=<87ftkmu2i6.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/SQE2thKRm/QLiTB53mCy2cfZL6O/p/LI=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: For review: pidfd_send_signal(2) manual page
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com> writes:

> Hello Christian and all,
>
> Below, I have the rendered version of the current draft of
> the pidfd_send_signal(2) manual page that I have written.
> The page source can be found in a Git branch at:
> https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/log/?h=draft_pidfd
>
> I would be pleased to receive corrections and notes on any
> details that should be added. (For example, are there error
> cases that I have missed?)
>
> Would you be able to review please?
>
> Thanks,
>
> Michael
>
>
> NAME
>        pidfd_send_signal - send a signal to a process specified by a file
>        descriptor
>
> SYNOPSIS
>        int pidfd_send_signal(int pidfd, int sig, siginfo_t info,

 This needs to be "siginfo_t *info," -----------------------^

>                              unsigned int flags);
>

Eric
