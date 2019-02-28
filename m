Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C217AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BD712171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551355338;
	bh=jInlxQ266wZ5QfEWk5k9mVQwDtP10yn7B6vUcFc1LHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pSOY0moMDypHFYNfnHvwq1zHlm27tcXY8X3uuOf2B5YvL+oBRfFJSasllJ/bh0DfC
	 QS+pScIRXr9GpkuSJtYz5AZGd8L6JmISP44zLBbXQVFLw4pSULMKQ+H+Cuw8TLrCMv
	 N0XUWj76ht0UFcTuvOx/zhlXeNIVnbjdUm7V5yGE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732679AbfB1MCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 07:02:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:46210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731238AbfB1MCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 07:02:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4872B20863;
        Thu, 28 Feb 2019 12:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551355335;
        bh=jInlxQ266wZ5QfEWk5k9mVQwDtP10yn7B6vUcFc1LHQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mWf5dZzrXIFwX1hXyOwdhgSZR9aX46fEXwTyGoky5I4aE0t9s2U0IHQtyXF75GIYi
         PcJpucMQLoHDPdvfqFN5pChI29gqzOdXKYnaSSH2F3Gy+pIR3TkYFAmEYx16RDw7l3
         yD7Sg5HNcdMXKMIgvomOd63HNqzwfP5T4hYFtY8Y=
Date:   Thu, 28 Feb 2019 13:01:50 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/15] habanalabs: print pointer using %p
Message-ID: <20190228120150.GB7489@kroah.com>
References: <20190228095545.30842-1-oded.gabbay@gmail.com>
 <20190228095545.30842-2-oded.gabbay@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228095545.30842-2-oded.gabbay@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 11:55:45AM +0200, Oded Gabbay wrote:
> Don't cast pointer to u64 to print it. Instead, print the pointer using
> %p.
> 
> Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
> ---
> Changes in v2:
>   - Add changelog in the commit message

This isn't marked "v2" :(

Anyway, I'll try to piece this all together, next time it's easier to
just resend the whole series...

greg k-h
