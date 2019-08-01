Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A8AC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 13:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A569020838
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 13:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbfHANmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 09:42:49 -0400
Received: from foss.arm.com ([217.140.110.172]:36214 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbfHANmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 09:42:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE31E337;
        Thu,  1 Aug 2019 06:42:48 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DAC743F71F;
        Thu,  1 Aug 2019 06:42:47 -0700 (PDT)
Date:   Thu, 1 Aug 2019 14:42:45 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] ARM: dts: vexpress: Add missing newline at end of file
Message-ID: <20190801134245.GC23424@e107155-lin>
References: <20190617143547.4721-1-geert+renesas@glider.be>
 <20190801131527.GA23424@e107155-lin>
 <CAMuHMdX+Nd1XH0KDHXmdOa_=UYcBso_EKfugYbZ_Zyd=4e2nGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdX+Nd1XH0KDHXmdOa_=UYcBso_EKfugYbZ_Zyd=4e2nGw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 03:31:34PM +0200, Geert Uytterhoeven wrote:
> Hi Sudeep,
>
> On Thu, Aug 1, 2019 at 3:15 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> > On Mon, Jun 17, 2019 at 04:35:47PM +0200, Geert Uytterhoeven wrote:
> > > "git diff" says:
> > >
> > >     \ No newline at end of file
> > >
> > > after modifying the file.
> >
> > Sorry for missing this earlier. Just found this unread and thought of
> > applying it to v5.4
> >
> > However doing a quick check on the tree revealed more file and wonder
> > why you are addressing only handful of them. Why not all in one go ?
>
> I did address all of them, but sent separate patches per subsystem.
>

Ah OK, may be different mailing lists and hence I failed to see them.
Anyways queued this for v5.4. Thanks for the response.

--
Regards,
Sudeep
