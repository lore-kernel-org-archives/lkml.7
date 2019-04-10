Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F15DC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 17:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 282A52083E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 17:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729205AbfDJR0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 13:26:39 -0400
Received: from namei.org ([65.99.196.166]:33442 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728749AbfDJR0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 13:26:38 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x3AHQXPd026231;
        Wed, 10 Apr 2019 17:26:33 GMT
Date:   Thu, 11 Apr 2019 03:26:33 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Jann Horn <jannh@google.com>
cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH] Yama: mark local symbols as static
In-Reply-To: <20190326230841.87834-1-jannh@google.com>
Message-ID: <alpine.LRH.2.21.1904110326220.25754@namei.org>
References: <20190326230841.87834-1-jannh@google.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Mar 2019, Jann Horn wrote:

> sparse complains that Yama defines functions and a variable as non-static
> even though they don't exist in any header. Fix it by making them static.
> 
> Signed-off-by: Jann Horn <jannh@google.com>

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general

-- 
James Morris
<jmorris@namei.org>

