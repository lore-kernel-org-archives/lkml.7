Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E75C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 17:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B180320830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 17:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729628AbfDJRhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 13:37:08 -0400
Received: from namei.org ([65.99.196.166]:33502 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727659AbfDJRhI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 13:37:08 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x3AHb3O2026782;
        Wed, 10 Apr 2019 17:37:03 GMT
Date:   Thu, 11 Apr 2019 03:37:03 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Mukesh Ojha <mojha@codeaurora.org>
cc:     keescook@chromium.org, jannh@google.com,
        linux-kernel@vger.kernel.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH] Yama: mark function as static
In-Reply-To: <1553673018-19234-1-git-send-email-mojha@codeaurora.org>
Message-ID: <alpine.LRH.2.21.1904110336550.25754@namei.org>
References: <1553673018-19234-1-git-send-email-mojha@codeaurora.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Mar 2019, Mukesh Ojha wrote:

> Sparse complains yama_task_prctl can be static. Fix it by making
> it static.
> 
> Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general

-- 
James Morris
<jmorris@namei.org>

