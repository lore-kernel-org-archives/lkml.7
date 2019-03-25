Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F345C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3F1521473
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553544766;
	bh=zT7hyeF7U5b4pqyNBbtP4AsLn6u9mwqL+b2KBgQvA70=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xbYf+povnjG+eJeNr4obdCEUAuMjRShjMArlOiRDFYCWbyvHU6YqUNekrZuXjdmp9
	 4ftqaoyPNjbN0b9+7iVmlEUMmX0jtsoz66/cb4fistVQvVpSBcwIk90a6ykHrdpi9b
	 xDks3mqjUdlF1gs1yxmlLLNzFE/sCIG9vPTeYZzI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730298AbfCYUMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 16:12:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:49874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729283AbfCYUMo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 16:12:44 -0400
Received: from localhost (unknown [218.237.54.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C46E2087E;
        Mon, 25 Mar 2019 20:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553544763;
        bh=zT7hyeF7U5b4pqyNBbtP4AsLn6u9mwqL+b2KBgQvA70=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c2lLuZ3/5TFpbbomB01M1Z7b7ZGn5AyTO4HPp8qTNe29HWDoDo8Hvt5NMhOF3rUOz
         grrIUNRfOvjCpvNrrd/w2fqSxhHeWFoPh0W46IWvZrCjwrWbCPih6EAYmVj/QoQraB
         goomOa9AqUEYWK3o1zr2jWz/yoI0wuu5dWL4ZViw=
Date:   Tue, 26 Mar 2019 04:38:51 +0900
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ojaswin Mujoo <ojaswin25111998@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Forest Bond <forest@alittletooquiet.net>
Subject: Re: [PATCH] drivers/staging: fix styling of the comment related to
 SPDX-License-Identifier in vt6656/*.h
Message-ID: <20190325193851.GB27571@kroah.com>
References: <20190324195714.GA8262@kroah.com>
 <1553522934-7366-1-git-send-email-ojaswin25111998@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553522934-7366-1-git-send-email-ojaswin25111998@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 07:36:53PM +0530, Ojaswin Mujoo wrote:
> From: ojaswin <ojaswin25111998@gmail.com>
> 
> Fix checkpatch.pl styling error related to SPDX-License-Identifier comment 
> in vt6656/*.h
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin25111998@gmail.com>

This also has to match the "From:" line :)

And you have trailing whitespace in your changelog comment :(

And finally, when resending a patch, please properly "version" it, as
described in the Documentation for how to do this.

thanks,

greg k-h
