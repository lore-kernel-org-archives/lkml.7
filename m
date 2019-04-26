Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955DFC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67F0E2146E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfDZRaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 13:30:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45160 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbfDZRai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 13:30:38 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AEB2259466;
        Fri, 26 Apr 2019 17:30:38 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.159])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5EE6A1001E6C;
        Fri, 26 Apr 2019 17:30:37 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 26 Apr 2019 19:30:37 +0200 (CEST)
Date:   Fri, 26 Apr 2019 19:30:36 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Roman Gushchin <guroan@gmail.com>, Tejun Heo <tj@kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 4/9] cgroup: cgroup v2 freezer
Message-ID: <20190426173035.GA24755@redhat.com>
References: <20190405174708.1010-1-guro@fb.com>
 <20190405174708.1010-5-guro@fb.com>
 <20190424160237.GH16167@redhat.com>
 <20190424221034.GB22896@tower.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424221034.GB22896@tower.DHCP.thefacebook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 26 Apr 2019 17:30:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/24, Roman Gushchin wrote:
>
> of the patchset. In the current iteration I'd replace it with:
> 
> 	WARN_ON_ONCE(cgroup_task_frozen(tsk));
> 
> just to make sure we're not leaking the frozen bit.
> Do you agree?

Yes sure,

Oleg.

