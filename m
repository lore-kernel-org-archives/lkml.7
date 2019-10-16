Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4764CECE59D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 00:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 174182084B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 00:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732397AbfJPACO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 20:02:14 -0400
Received: from namei.org ([65.99.196.166]:54426 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbfJPACN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 20:02:13 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x9G027ce023723;
        Wed, 16 Oct 2019 00:02:07 GMT
Date:   Wed, 16 Oct 2019 11:02:07 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Daniel Colascione <dancol@google.com>
cc:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        lokeshgidra@google.com, nnk@google.com, nosh@google.com,
        timmurray@google.com
Subject: Re: [PATCH 0/7] Harden userfaultfd
In-Reply-To: <20191012191602.45649-1-dancol@google.com>
Message-ID: <alpine.LRH.2.21.1910161100590.23617@namei.org>
References: <20191012191602.45649-1-dancol@google.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Oct 2019, Daniel Colascione wrote:

>  Documentation/admin-guide/sysctl/vm.rst | 19 +++++-
>  fs/anon_inodes.c                        | 89 +++++++++++++++++--------
>  fs/userfaultfd.c                        | 47 +++++++++++--
>  include/linux/anon_inodes.h             | 27 ++++++--
>  include/linux/lsm_hooks.h               |  8 +++
>  include/linux/security.h                |  2 +
>  include/linux/userfaultfd_k.h           |  3 +
>  include/uapi/linux/userfaultfd.h        | 14 ++++
>  kernel/sysctl.c                         |  9 +++
>  security/security.c                     |  8 +++
>  security/selinux/hooks.c                | 68 +++++++++++++++++++
>  security/selinux/include/classmap.h     |  2 +
>  12 files changed, 256 insertions(+), 40 deletions(-)

For any changes to security/ please include the linux-security-module 
list.

-- 
James Morris
<jmorris@namei.org>

