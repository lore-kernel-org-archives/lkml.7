Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E98B7C10F05
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 02:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0C3D2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 02:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732429AbfC0CWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 22:22:49 -0400
Received: from namei.org ([65.99.196.166]:58802 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731619AbfC0CWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 22:22:48 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x2R2MNuU023364;
        Wed, 27 Mar 2019 02:22:24 GMT
Date:   Wed, 27 Mar 2019 13:22:23 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Denis Efremov <efremov@ispras.ru>
cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Eric Paris <eparis@parisplace.org>,
        John Johansen <john.johansen@canonical.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/11] LSM documentation update
In-Reply-To: <cover.1551213058.git.efremov@ispras.ru>
Message-ID: <alpine.LRH.2.21.1903271322120.9951@namei.org>
References: <cover.1551213058.git.efremov@ispras.ru>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Feb 2019, Denis Efremov wrote:

> Recent "New LSM Hooks" discussion has led me to the
> thought that it might be a good idea to slightly
> update the current documentation. The patchset adds
> nothing new to the documentation, only fixes the old
> description of hooks to reflect their current state.
> 
> V2 adds the clarification on arguments for some hooks.
> The format of the documentation is also slightly updated
> for better html. However, there are still 10 hooks without
> documentation at all. I think that this should be fixed
> separatedly.

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general

Thanks!

-- 
James Morris
<jmorris@namei.org>

