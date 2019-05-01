Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3EDC004C9
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 17:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A32FD208C3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 17:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbfEARHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 13:07:14 -0400
Received: from namei.org ([65.99.196.166]:36874 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725973AbfEARHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 13:07:14 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x41H7BMs015634;
        Wed, 1 May 2019 17:07:11 GMT
Date:   Thu, 2 May 2019 03:07:11 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     David Howells <dhowells@redhat.com>
cc:     dwalsh@redhat.com, vgoyal@redhat.com, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [GIT PULL] keys: Namespacing
In-Reply-To: <561.1556663960@warthog.procyon.org.uk>
Message-ID: <alpine.LRH.2.21.1905020306290.14696@namei.org>
References: <561.1556663960@warthog.procyon.org.uk>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Apr 2019, David Howells wrote:

> Hi James,
> 
> Can you pull this set of patches into the security tree and pass them along
> to Linus in the next merge window?  The primary thrust is to add
> namespacing to keyrings.

Not for this merge window, it's too close. Something like this would need 
to be in -rc2 or so.


-- 
James Morris
<jmorris@namei.org>

