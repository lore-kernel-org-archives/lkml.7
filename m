Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DAB1C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 21:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46D6721848
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 21:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730910AbfJCVIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 17:08:18 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58302 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbfJCVIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 17:08:18 -0400
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iG8Kd-0002Eh-Gw; Thu, 03 Oct 2019 21:08:15 +0000
Date:   Thu, 3 Oct 2019 23:08:14 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, Jann Horn <jannh@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Helge Deller <deller@gmx.de>
Subject: Re: [RFC][PATCH] sysctl: Remove the sysctl system call
Message-ID: <20191003210814.gh7rbbv6bpxlhz3w@wittgenstein>
References: <8736gcjosv.fsf@x220.int.ebiederm.org>
 <201910011140.EA0181F13@keescook>
 <87y2y271ws.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87y2y271ws.fsf@mid.deneb.enyo.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 08:56:19AM +0200, Florian Weimer wrote:
> Is anyone else getting a very incomplete set of messages in this
> thread?
> 
> These changes likely matter to glibc, and I've yet to see the actual
> patch.  Would someone please forward it to me?
> 
> The original message didn't make it into the lore.kernel.org archives
> (the cross-post to linux-kernel should have taken care of that).

Yeah, I didn't get it either and the repost too weirdly enough.

Christian
