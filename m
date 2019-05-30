Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FA0C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 20:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53B3D26140
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 20:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbfE3UL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 16:11:57 -0400
Received: from namei.org ([65.99.196.166]:35500 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbfE3UL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 16:11:57 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x4UKBiW1000760;
        Thu, 30 May 2019 20:11:44 GMT
Date:   Fri, 31 May 2019 06:11:44 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Ke Wu <mikewu@google.com>
cc:     Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2] Allow to exclude specific file types in LoadPin
In-Reply-To: <20190530192208.99773-1-mikewu@google.com>
Message-ID: <alpine.LRH.2.21.1905310611190.26428@namei.org>
References: <20190529224350.6460-1-mikewu@google.com> <20190530192208.99773-1-mikewu@google.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 May 2019, Ke Wu wrote:

> Linux kernel already provide MODULE_SIG and KEXEC_VERIFY_SIG to
> make sure loaded kernel module and kernel image are trusted. This
> patch adds a kernel command line option "loadpin.exclude" which
> allows to exclude specific file types from LoadPin. This is useful
> when people want to use different mechanisms to verify module and
> kernel image while still use LoadPin to protect the integrity of
> other files kernel loads.
> 
> Signed-off-by: Ke Wu <mikewu@google.com>
> ---
> Changelog since v1:
> - Mark ignore_read_file_id with __ro_after_init.
> - Mark parse_exclude() with __init.
> - Use ARRAY_SIZE(ignore_read_file_id) instead of READING_MAX_ID.

Looks good!

Reviewed-by: James Morris <jamorris@linux.microsoft.com>


-- 
James Morris
<jmorris@namei.org>

