Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4C6C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 09:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E34FA20828
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 09:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729330AbfCFJDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 04:03:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38214 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726391AbfCFJDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 04:03:17 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 93BC130917A8;
        Wed,  6 Mar 2019 09:03:16 +0000 (UTC)
Received: from localhost (ovpn-12-21.pek2.redhat.com [10.72.12.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C6D355C28C;
        Wed,  6 Mar 2019 09:03:09 +0000 (UTC)
Date:   Wed, 6 Mar 2019 17:03:07 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Kairui Song <kasong@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Jiri Bohac <jbohac@suse.cz>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Omar Sandoval <osandov@fb.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v2] x86/gart/kcore: Exclude GART aperture from kcore
Message-ID: <20190306090307.GG14858@MiWiFi-R3L-srv>
References: <20190102105408.7124-1-kasong@redhat.com>
 <20190123141432.GA19177@MiWiFi-R3L-srv>
 <CACPcB9faut+9p8oJ_4nUv6ZnQ42=N4b9vqjCFtbyrs1K1SCWvg@mail.gmail.com>
 <20190124021744.GB19177@MiWiFi-R3L-srv>
 <CACPcB9cL_YfwORAhZEzz-C0QdVfXD6UrJ1Dc-eLQjDTJ8zP60A@mail.gmail.com>
 <CACPcB9e5+-3TrZ-nQc37-0nayU0RSMo-T4V+h4nEaHJ8Mqryqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPcB9e5+-3TrZ-nQc37-0nayU0RSMo-T4V+h4nEaHJ8Mqryqw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 06 Mar 2019 09:03:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/06/19 at 04:48pm, Kairui Song wrote:
> On Tue, Feb 19, 2019 at 4:00 PM Kairui Song <kasong@redhat.com> wrote:
> Hi Baoquan, after second thought, vmcore and kcore are doing similar
> thing but still quite independent of each, didn't see any simple way
> to share the logic.
> And for the following naming issue I think considering the context
> there is no problem, "exclude_from_vmcore(aper_alloc, aper_order)" is
> clearly doing what it literally means, excluding the aperture from
> vmcore.
> 
> Let me know if anything is wrong, will send V4 later reuse this approach.

Thanks for the effort.

Yes, saw your v3. I kept quiet because I personally prefer the v2 method
which is similar to vmcore handling. So if you have investigated and
decided to do v2 way after deliberate thought, feel free to post v4. I
will make time to review.

Thanks
Baoquan
