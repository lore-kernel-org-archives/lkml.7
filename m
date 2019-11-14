Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0C7C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 14:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49AA22070E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 14:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfKNOfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 09:35:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:42282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726214AbfKNOfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 09:35:10 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03A0520709;
        Thu, 14 Nov 2019 14:35:08 +0000 (UTC)
Date:   Thu, 14 Nov 2019 09:35:06 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     Piotr Maziarz <piotrx.maziarz@linux.intel.com>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        andriy.shevchenko@intel.com, gustaw.lewandowski@intel.com
Subject: Re: [PATCH v2 1/2] seq_buf: Add printing formatted hex dumps
Message-ID: <20191114093506.4c5e9991@gandalf.local.home>
In-Reply-To: <8d937230-9890-aabc-b268-c3a2e1f799b0@intel.com>
References: <1573130738-29390-1-git-send-email-piotrx.maziarz@linux.intel.com>
        <20191113160237.6b8efe12@gandalf.local.home>
        <8d937230-9890-aabc-b268-c3a2e1f799b0@intel.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Nov 2019 09:00:40 +0100
Cezary Rojewski <cezary.rojewski@intel.com> wrote:

> >> Signed-off-by: Piotr Maziarz <piotrx.maziarz@linux.intel.com>
> >> Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>  
> > 
> > I'm curious about the two signed off bys? Was Cezary a co-author?
> >   
> 
> Hello Steven,
> 
> Code is done by Piotr. I merely took part in shaping this idea and doing 
> initial reviews. Kudos to Andy for helping us out here.
> 
> As a dev lead and maintainer for Intel ASoC team, patches coming from my 
> team are also being signed off me so any reviewer has a person to 
> complain to in case of any issues for extended period of time.

That's fine. Just was curious about it.

I have this queued, but due to other patches failing some of my tests,
I haven't pushed to linux-next yet.

-- Steve
