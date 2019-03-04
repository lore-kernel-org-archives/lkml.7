Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C208AC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E48920835
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551730161;
	bh=BrJn8W4okZC4WwF0eQXBpmYMYrTJm061zGxSMSaEC7M=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=jdezwQh65AdRcKA2pIQuRMapqC1HdNz1/fhScnsqgCZvQzeWjGvRGM6M2RW3AxvKN
	 /JmV8BYeOtCRngWfq2f0pXT42FKmebp6YGzde4Gx+XT/QuSG+yRHnYyyWEK9NtS5Hu
	 bdcYxT9IjPRffgpVYlaL0z85lFB+RTr2da8YYBw4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfCDUJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 15:09:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:53452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726101AbfCDUJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 15:09:19 -0500
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A041120830;
        Mon,  4 Mar 2019 20:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551730159;
        bh=BrJn8W4okZC4WwF0eQXBpmYMYrTJm061zGxSMSaEC7M=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=nbCP66Tmq89VSIFvtRn5mBi9p8cX3qh1Ull2pf5Bz0GiZnWMIF1uYZ18Ak54+GhTU
         sIH5qGLm6f/8B8zHw7hjJYDLfzjxD0bJsaj5M+Cx5xrhaipH08C2QFNSR1SO9zChiY
         /gUuljopfHcZPdk4EhoPLjEFwd8BXuOxhG/VCOZI=
Message-ID: <1551730157.4658.0.camel@kernel.org>
Subject: Re: [PATCH] sefltests/ftrace: Use /bin/echo for output with options
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>, shuah@kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel =?ISO-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>
Date:   Mon, 04 Mar 2019 14:09:17 -0600
In-Reply-To: <20181129114911.7dcc8905@gandalf.local.home>
References: <20181129235407.9788e718a4ae7830f9e5d225@kernel.org>
         <154350406317.4422.7595059658374071660.stgit@devbox>
         <1543509793.2018.2.camel@kernel.org>
         <20181129114911.7dcc8905@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-11-29 at 11:49 -0500, Steven Rostedt wrote:
> On Thu, 29 Nov 2018 10:43:13 -0600
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > I tried this on the three systems mentioned before, and it worked
> > fine
> > on all of them.
> > 
> > Tested-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> 
> 
> Shuah,
> 
> Can you take this in your tree. I already acked it.
> 

Ping...


> Thanks!
> 
> -- Steve
