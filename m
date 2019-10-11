Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA013ECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 13:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE5C9214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 13:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbfJKNSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 09:18:42 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41467 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728447AbfJKNSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 09:18:42 -0400
Received: from v22018046084765073.goodsrv.de ([185.183.158.195] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iIuoY-0000ld-Vb; Fri, 11 Oct 2019 13:18:39 +0000
Date:   Fri, 11 Oct 2019 15:18:37 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Christian Kellner <ckellner@redhat.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Christian Kellner <christian@kellner.me>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 2/2] pidfd: add tests for NSpid info in fdinfo
Message-ID: <20191011131835.xzxxncgo67kzbemd@wittgenstein>
References: <20191009160532.20674-1-ckellner@redhat.com>
 <20191011122323.7770-1-ckellner@redhat.com>
 <20191011122323.7770-2-ckellner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191011122323.7770-2-ckellner@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 02:23:21PM +0200, Christian Kellner wrote:
> From: Christian Kellner <christian@kellner.me>
> 
> Add tests that check that if pid namespaces are configured the fdinfo
> file of a pidfd contains an NSpid: entry containing the process id
> in the current and additionally all nested namespaces.
> 
> Signed-off-by: Christian Kellner <christian@kellner.me>

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

Shuah, can I get an Ack for you from this. If you have no objections I'd
queue up this patchset for the 5.5 merge window.

Thanks!
Christian
