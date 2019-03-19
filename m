Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F0AEC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 18:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D89AE206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 18:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553018560;
	bh=/qKCRkp+afYzQIajYsnig7hMAczuEj9ulglbh4u9/44=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ulujzR4d1rcMn8tR0X1idqCBv6ku4QGe/sE0HTu1kmIV1srDRTgXvZlIt+UvTbogY
	 IPW5qE1DlhYjgYRyETg6Qe1zGP5tKL5MPX2XN0++Aj5HYgLACERvoTnZHpaFs4diKa
	 zZcju5pfcPAISEl5DOoSF8Tufpwfgu15ivWnQalE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbfCSSCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 14:02:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59726 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727237AbfCSSCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 14:02:38 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3CA3F3802;
        Tue, 19 Mar 2019 18:02:37 +0000 (UTC)
Date:   Tue, 19 Mar 2019 11:02:36 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Maxime Coquelin <maxime.coquelin@redhat.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Martin Cracauer <cracauer@cons.org>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>, linux-mm@kvack.org,
        Marty McFadden <mcfadden8@llnl.gov>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v2 1/1] userfaultfd/sysctl: add
 vm.unprivileged_userfaultfd
Message-Id: <20190319110236.b6169d6b469a587a852c7e09@linux-foundation.org>
In-Reply-To: <20190319030722.12441-2-peterx@redhat.com>
References: <20190319030722.12441-1-peterx@redhat.com>
        <20190319030722.12441-2-peterx@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Mar 2019 11:07:22 +0800 Peter Xu <peterx@redhat.com> wrote:

> Add a global sysctl knob "vm.unprivileged_userfaultfd" to control
> whether userfaultfd is allowed by unprivileged users.  When this is
> set to zero, only privileged users (root user, or users with the
> CAP_SYS_PTRACE capability) will be able to use the userfaultfd
> syscalls.

Please send along a full description of why you believe Linux needs
this feature, for me to add to the changelog.  What is the benefit to
our users?  How will it be used?

etcetera.  As it was presented I'm seeing no justification for adding
the patch!
