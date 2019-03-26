Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B8BC10F05
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9288A20823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732328AbfCZSQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:16:28 -0400
Received: from namei.org ([65.99.196.166]:58624 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731467AbfCZSQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 14:16:28 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x2QIG2V5005742;
        Tue, 26 Mar 2019 18:16:02 GMT
Date:   Wed, 27 Mar 2019 05:16:02 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Jonathan Corbet <corbet@lwn.net>
cc:     Denis Efremov <efremov@ispras.ru>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Eric Paris <eparis@parisplace.org>,
        John Johansen <john.johansen@canonical.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v2 00/11] LSM documentation update
In-Reply-To: <20190326085350.4de2c68d@lwn.net>
Message-ID: <alpine.LRH.2.21.1903270515510.5235@namei.org>
References: <cover.1551213058.git.efremov@ispras.ru>        <f89f1335-a76a-b364-d426-b0fe3423ad0a@ispras.ru> <20190326085350.4de2c68d@lwn.net>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Mar 2019, Jonathan Corbet wrote:

> On Tue, 26 Mar 2019 15:38:21 +0100
> Denis Efremov <efremov@ispras.ru> wrote:
> 
> > Is there something more I could do so that these changes are accepted?
> > At least this patchset fixes the documentation format for better html
> > generation.
> 
> I had assumed that this would go through the security tree, but can
> certainly pick it up if that works better.

I'll take them for 5.2.

> 
> jon
> 

-- 
James Morris
<jmorris@namei.org>

