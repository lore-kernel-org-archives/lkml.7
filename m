Return-Path: <SRS0=64FT=XQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFBAC3A5A2
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 01:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBE3B20C01
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 01:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394127AbfIUBAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 21:00:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41728 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394077AbfIUBAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 21:00:09 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 22530308FC4B;
        Sat, 21 Sep 2019 01:00:09 +0000 (UTC)
Received: from optiplex-lnx (ovpn-125-22.rdu2.redhat.com [10.10.125.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0DCE31001281;
        Sat, 21 Sep 2019 01:00:07 +0000 (UTC)
Date:   Fri, 20 Sep 2019 21:00:05 -0400
From:   Rafael Aquini <aquini@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>, Joel Savitz <jsavitz@redhat.com>,
        linux-kernel@vger.kernel.org, David Rientjes <rientjes@google.com>,
        linux-mm@kvack.org
Subject: Re: [RESEND PATCH v2] mm/oom_killer: Add task UID to info message on
 an oom kill
Message-ID: <20190921010005.GC15594@optiplex-lnx>
References: <1560362273-534-1-git-send-email-jsavitz@redhat.com>
 <20190613082318.GB9343@dhcp22.suse.cz>
 <20190920171340.7591fd2899a06b5e7c390b76@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190920171340.7591fd2899a06b5e7c390b76@linux-foundation.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Sat, 21 Sep 2019 01:00:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 05:13:40PM -0700, Andrew Morton wrote:
> On Thu, 13 Jun 2019 10:23:18 +0200 Michal Hocko <mhocko@kernel.org> wrote:
> 
> > On Wed 12-06-19 13:57:53, Joel Savitz wrote:
> > > In the event of an oom kill, useful information about the killed
> > > process is printed to dmesg. Users, especially system administrators,
> > > will find it useful to immediately see the UID of the process.
> > 
> > Could you be more specific please? We already print uid when dumping
> > eligible tasks so it is not overly hard to find that information in the
> > oom report. Well, except when dumping of eligible tasks is disabled. Is
> > this what you are after?
> > 
> > Please always be specific about usecases in the changelog. A terse
> > statement that something is useful doesn't tell much very often.
> > 
> 
> <crickets?>
> I'll add this to the chagnelog:
> 
> : We already print uid when dumping eligible tasks so it is not overly hard
> : to find that information in the oom report.  However this information is
> : unavailable then dumping of eligible tasks is disabled.
                ^^^^ 

Thanks Andrew! just a minor nit there: 's/then/when/'


Acked-by: Rafael Aquini <aquini@redhat.com>
> 
