Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3722CC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 20:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 129FA214D8
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 20:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfKGUAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 15:00:54 -0500
Received: from ms.lwn.net ([45.79.88.28]:39382 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbfKGUAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 15:00:53 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 34FC52C1;
        Thu,  7 Nov 2019 20:00:53 +0000 (UTC)
Date:   Thu, 7 Nov 2019 13:00:52 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: process: Add base-commit trailer usage
Message-ID: <20191107130052.21290e73@lwn.net>
In-Reply-To: <20191030140050.GA16353@pure.paranoia.local>
References: <20191030140050.GA16353@pure.paranoia.local>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Oct 2019 10:00:50 -0400
Konstantin Ryabitsev <konstantin@linuxfoundation.org> wrote:

> One of the recurring complaints from both maintainers and CI system
> operators is that performing git-am on received patches is difficult
> without knowing the parent object in the git history on which the
> patches are based. Without this information, there is a high likelihood
> that git-am will fail due to conflicts, which is particularly
> frustrating to CI operators.
> 
> Git versions starting with v2.9.0 are able to automatically include
> base-commit information using the --base flag of git-format-patch.
> Document this usage in process/submitting-patches, and add the rationale
> for its inclusion, plus instructions for those not using git on where
> the "base-commit:" trailer should go.
> 
> Signed-off-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>

I really wish we could find a way to make submitting-patches.rst shorter
rather than longer - it's a lot for a first-time submitter to work
through.  But this is useful information, so I've applied it.

Thanks,

jon
