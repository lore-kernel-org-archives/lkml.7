Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA83C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 23:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0691821019
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 23:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391655AbfGRXRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 19:17:54 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:53880 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727972AbfGRXRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 19:17:54 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hoFeq-0002m1-6a; Thu, 18 Jul 2019 23:17:52 +0000
Date:   Fri, 19 Jul 2019 00:17:52 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Benjamin LaHaise <bcrl@kvack.org>, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] aio: Support read/write with non-iter file-ops
Message-ID: <20190718231751.GV17978@ZenIV.linux.org.uk>
References: <20190718231054.8175-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718231054.8175-1-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 04:10:54PM -0700, Bjorn Andersson wrote:
> Implement a wrapper for aio_read()/write() to allow async IO on files
> not implementing the iter version of read/write, such as sysfs. This
> mimics how readv/writev uses non-iter ops in do_loop_readv_writev().

IDGI.  How would that IO manage to be async?  And what's the point
using aio in such situations in the first place?
