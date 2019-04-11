Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010E4C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 21:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EF4D2146F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 21:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfDKVaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 17:30:16 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:32836 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbfDKVaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 17:30:15 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hEhGv-0003Tj-IZ; Thu, 11 Apr 2019 21:30:13 +0000
Date:   Thu, 11 Apr 2019 22:30:13 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        axboe@kernel.dk
Subject: Re: [PATCH REPOST] docs: Add struct file refcounting and SCM_RIGHTS
 mess info
Message-ID: <20190411213013.GI2217@ZenIV.linux.org.uk>
References: <20190411142308.179247a4@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411142308.179247a4@lwn.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 02:23:08PM -0600, Jonathan Corbet wrote:
> docs: Add struct file refcounting and SCM_RIGHTS mess info
> 
> Work up some text posted by Al and add it to the filesystem manual.
> 
> Co-developed-by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
> This is the third sending of this patch.  Al, you *did* ask me to run it
> past you before putting it in; do you think you might get a chance to have
> a look sometime soon?

Will do, hopefully tonight...
