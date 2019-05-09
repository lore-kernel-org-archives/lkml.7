Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97866C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 15:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 692CF2173B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 15:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfEIPXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 11:23:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59148 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726187AbfEIPXb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 11:23:31 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 06821307EAA9;
        Thu,  9 May 2019 15:23:31 +0000 (UTC)
Received: from krava (unknown [10.40.205.166])
        by smtp.corp.redhat.com (Postfix) with SMTP id 2C4045E7A0;
        Thu,  9 May 2019 15:23:29 +0000 (UTC)
Date:   Thu, 9 May 2019 17:23:28 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 1/8] sysfs: Add sysfs_update_groups function
Message-ID: <20190509152328.GB6904@krava>
References: <20190504125207.24662-1-jolsa@kernel.org>
 <20190504125207.24662-2-jolsa@kernel.org>
 <20190504135344.GB6989@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190504135344.GB6989@kroah.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Thu, 09 May 2019 15:23:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 04, 2019 at 03:53:44PM +0200, Greg Kroah-Hartman wrote:
> On Sat, May 04, 2019 at 02:52:00PM +0200, Jiri Olsa wrote:
> > Adding sysfs_update_groups function to update
> > multiple groups.
> > 
> > TODO:
> > 
> > I'm not sure how to handle error path in here,
> > currently it removes the whole updated group
> > together with already existing (not updated)
> > attributes.
> 
> I think that should be fine.  The chance of an error happening here is
> really slim.
> 
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 

cool, I'll post version with proper changelogs

thanks,
jirka
