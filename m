Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED7CC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 00:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27AB2206B6
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 00:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551746263;
	bh=4Od1j1lKepXt/hZj9gSV6dD64DRZLbxq1gZPJIG6wYU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Jr/9ezFtVqQI2mYvhLnk6xvSqqSM+r0P6HJXiqmgeN9ycwdyXSsTzWuXaMb4lDvd/
	 pnGCKHeF1LUVOyTC7Nx5t3oLlmNThMYEop3oDLq+QV2mtgeeAJ3tT3qsuta501tMPY
	 g8eGAisetBnYVFujxd9DKx3aCkFBHVG9GtJQdL2c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfCEAhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 19:37:41 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:50906 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfCEAhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 19:37:41 -0500
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id ABE99ECE0;
        Tue,  5 Mar 2019 00:37:40 +0000 (UTC)
Date:   Mon, 4 Mar 2019 16:37:39 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     adobriyan@gmail.com, shuah@kernel.org, sabyasachi.linux@gmail.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftest/proc: Remove duplicate header
Message-Id: <20190304163739.fbd2e5a508cfcf087a117620@linux-foundation.org>
In-Reply-To: <20190304182719.GA6606@jordon-HP-15-Notebook-PC>
References: <20190304182719.GA6606@jordon-HP-15-Notebook-PC>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Mar 2019 23:57:19 +0530 Souptick Joarder <jrdr.linux@gmail.com> wrote:

> Remove duplicate header which is included twice.
> 
> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

This signoff order makes me suspect that Sabyasachi was the author.  If
so, the patch should have had Sabyasachi's From: line at the start of
the changelog.

Please clafify?

