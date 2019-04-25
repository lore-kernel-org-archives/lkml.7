Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CEBC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 22:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B98D120717
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 22:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbfDYWeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 18:34:44 -0400
Received: from namei.org ([65.99.196.166]:35848 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726040AbfDYWen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 18:34:43 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x3PMYTXI008976;
        Thu, 25 Apr 2019 22:34:29 GMT
Date:   Fri, 26 Apr 2019 08:34:29 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     prsriva <prsriva@linux.microsoft.com>,
        Nayna <nayna@linux.vnet.ibm.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        inux-security-module@vger.kernel.org, zohar@linux.ibm.com,
        "Eric W. Biederman" <ebiederm@xmission.com>, vgoyal@redhat.com,
        Prakhar Srivastava <prsriva@microsoft.com>
Subject: Re: [PATCH v2 2/5 RFC] use event name instead of enum to make the
 call generic
In-Reply-To: <CAADWXX8NC-PFJmuvQbNXn49CYjvyn-e0rtH_EoUfCvuJHTwHAQ@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1904260833140.7315@namei.org>
References: <20190424001544.7188-1-prsriva02@gmail.com> <20190424001544.7188-2-prsriva02@gmail.com> <d38f32f8-7078-f205-ba11-9c4266ee40e8@linux.vnet.ibm.com> <4c313367-22dc-9532-54b5-cd3a79deb625@linux.microsoft.com>
 <CAADWXX8NC-PFJmuvQbNXn49CYjvyn-e0rtH_EoUfCvuJHTwHAQ@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Apr 2019, Linus Torvalds wrote:

> On Thu, Apr 25, 2019 at 10:19 AM prsriva <prsriva@linux.microsoft.com> wrote:
> >
> > I will fix the comments and send out the patchset with a cover letter.
> > Thankyou for pointing this out.
> 
> Please trim the emails you reply to rather than quoting everything.
> 
> But the real reason I'm reacting to this email is because it was
> marked as spam, because your SMTP setup is incorrect, and you don't go
> through the proper MS SMTP server. As a result, you don't get the
> proper DKIM signature for verification of the microsoft.com email
> address, and sane email clients will mark your emails as spam.
> 
> Please fix.

It's the correct SMTP server for linux.microsoft.com.

linux.microsoft.com.	3600	IN	TXT	"v=spf1 ip4:13.77.154.182 -all"
linux.microsoft.com.	3600	IN	TXT	"v=DMARC1;p=none;pct=100;rua=mailto:jamorris@microsoft.com"


We don't have DKIM set up yet.

-- 
James Morris
<jmorris@namei.org>

