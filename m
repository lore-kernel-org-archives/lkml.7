Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5342CC282CE
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 03:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28C902175B
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 03:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbfEYD5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 23:57:05 -0400
Received: from namei.org ([65.99.196.166]:34400 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbfEYD5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 23:57:05 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x4P3v2RL032377;
        Sat, 25 May 2019 03:57:02 GMT
Date:   Sat, 25 May 2019 13:57:02 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     David Howells <dhowells@redhat.com>
cc:     keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] keys: sparse: Fix incorrect RCU accesses
In-Reply-To: <155856409697.10428.15024260088836364169.stgit@warthog.procyon.org.uk>
Message-ID: <alpine.LRH.2.21.1905251356520.32154@namei.org>
References: <155856408314.10428.17035328117829912815.stgit@warthog.procyon.org.uk> <155856409697.10428.15024260088836364169.stgit@warthog.procyon.org.uk>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 May 2019, David Howells wrote:

> Fix a pair of accesses that should be using RCU protection.
> 
> rcu_dereference_protected() is needed to access task_struct::real_parent.
> 
> current_cred() should be used to access current->cred.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>


Reviewed-by: James Morris <jamorris@linux.microsoft.com>


-- 
James Morris
<jmorris@namei.org>

