Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA58C282E3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 05:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5423B217FA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 05:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729170AbfDYFan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 01:30:43 -0400
Received: from namei.org ([65.99.196.166]:35716 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbfDYFan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 01:30:43 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x3P5Ufvp024983;
        Thu, 25 Apr 2019 05:30:41 GMT
Date:   Thu, 25 Apr 2019 15:30:41 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Kees Cook <keescook@chromium.org>
cc:     Tycho Andersen <tycho@tycho.ws>, stable@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] seccomp: Make NEW_LISTENER and TSYNC flags
 exclusive
In-Reply-To: <20190424163756.40001-3-keescook@chromium.org>
Message-ID: <alpine.LRH.2.21.1904251530200.26472@namei.org>
References: <20190424163756.40001-1-keescook@chromium.org> <20190424163756.40001-3-keescook@chromium.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Apr 2019, Kees Cook wrote:

> Reported-by: syzbot+b562969adb2e04af3442@syzkaller.appspotmail.com
> Fixes: 6a21cc50f0c7 ("seccomp: add a return code to trap to userspace")
> CC: stable@vger.kernel.org # v5.0+
> Signed-off-by: Tycho Andersen <tycho@tycho.ws>
> Signed-off-by: Kees Cook <keescook@chromium.org>


Acked-by: James Morris <jamorris@linux.microsoft.com>


-- 
James Morris
<jmorris@namei.org>

