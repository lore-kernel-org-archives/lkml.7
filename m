Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56B9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B0BC2183F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZNpG2q2t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732457AbfB1Mbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 07:31:31 -0500
Received: from merlin.infradead.org ([205.233.59.134]:44050 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbfB1Mb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 07:31:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=46Mdbc6zisktlpEqFsTs2YUVh1TPl6ipdzogmTwO7qY=; b=ZNpG2q2tnUa89LrIwz/GGLy7Y
        q4+s26qDuTRLzsd4bCFmEiGsd5Q5O/XE5qV6ZGxWoebdpRYl9ryZJ6BgF09Qbsy0fJ+GneSEggQqR
        Z4fkc9M4ccvTADkFaDquD/5aROa9zFMWjMkVFifp0PdCjF4HM1Flrssjf16wDlY2Q0V3iEXMLY6UA
        rHl5uKac1WQKFfkWuAzGS3xR0jlJO8zS+VnJ97H/DqvFBedPDKLN8pvciFbueOS6ifhr/ajCoxg6/
        fa6spdD2XKgcLbOCd+fZ+sWbFQLwpzxXw+ThjHS57IV0OaYpM2jj51R8lptKrB61f/tisXJSIY9Bm
        mPgXJW5Fg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gzKqS-0003MZ-5J; Thu, 28 Feb 2019 12:31:24 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B41642869FE88; Thu, 28 Feb 2019 13:31:20 +0100 (CET)
Date:   Thu, 28 Feb 2019 13:31:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sachin Nikam <Snikam@nvidia.com>
Cc:     Ketan Patil <ketanp@nvidia.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Bharat Nihalani <bnihalani@nvidia.com>,
        Bo Yan <byan@nvidia.com>,
        Sai Gurrappadi <sgurrappadi@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Timo Alho <talho@nvidia.com>
Subject: Re: [PATCH] sched/cputime: Remove unnecessary assignment statement
Message-ID: <20190228123120.GA32494@hirez.programming.kicks-ass.net>
References: <1551248002-27303-1-git-send-email-ketanp@nvidia.com>
 <20190227103230.GM32494@hirez.programming.kicks-ass.net>
 <9bce6378-2221-f358-dc97-f15ee7ab546b@nvidia.com>
 <20190228094733.GY32494@hirez.programming.kicks-ass.net>
 <MN2PR12MB3278E52D04119DC55597A293BB750@MN2PR12MB3278.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR12MB3278E52D04119DC55597A293BB750@MN2PR12MB3278.namprd12.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Clearly, because reading comprehension isn't your strong point:

A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

On Thu, Feb 28, 2019 at 12:14:09PM +0000, Sachin Nikam wrote:

> This isn't a security fix.
> However, I see this is kind of code cleanup.

As I've explained previously, it makes conceptual sense to have it in
the code, and any halfway sane compiler will observe the same double
store and eliminate it in its DCE pass.
