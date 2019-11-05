Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34697C17489
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 14:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B30921882
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 14:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572962740;
	bh=vQxBQ0EAzzICHxv5rPXPpBob4gEq2oHIQaAHTGT0/p8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=ZK1FoQ18jCHVJh2iFgdLzezYrO9C4MiEBT7J3XcXqfWfvx73VfjJzztQegcU1SPrX
	 BOVWQIWp6q9efS+6CvFHNMd8Q/T9MfQG809WRELmQacc+U/fTmsgQ1jPxsY7NXS8Gl
	 apDd2lYTjS0cDIy9QV+ar62/Brc28BAfJd4HcxZg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389402AbfKEOFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 09:05:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:40516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388428AbfKEOFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 09:05:38 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [109.144.209.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D908521882;
        Tue,  5 Nov 2019 14:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572962737;
        bh=vQxBQ0EAzzICHxv5rPXPpBob4gEq2oHIQaAHTGT0/p8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=mITltpIsZm/TzaXrNgBEy3wxth02B7nfLt/FWGmcPEHPp7hKxgzU6tZfVzHBypvfV
         I69WJLXziWvfy/SVqwZXeRbjn6nsAvrlTcneMLs8uEGKHS2EZXkrmd/oumdHz0Fi+q
         F3NQJ/VdNuHjgwPVjd/PzdRTnr1zmzFlKDiyHiBQ=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 1005C35227C0; Tue,  5 Nov 2019 06:05:35 -0800 (PST)
Date:   Tue, 5 Nov 2019 06:05:35 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Phong Tran <tranmanphong@gmail.com>
Cc:     madhuparnabhowmik04@gmail.com, joel@joelfernandes.org,
        corbet@lwn.net, rcu@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [Linux-kernel-mentees] [PATCH] Documentation: RCU: NMI-RCU:
 Converted NMI-RCU.txt to NMI-RCU.rst.
Message-ID: <20191105140535.GP20975@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191028214252.17580-1-madhuparnabhowmik04@gmail.com>
 <5bab8828-76e4-c67f-5855-ea4e4f43eaa5@gmail.com>
 <20191105135524.GN20975@paulmck-ThinkPad-P72>
 <7b9f5499-bd03-8405-52f5-1fb94e9d85dc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b9f5499-bd03-8405-52f5-1fb94e9d85dc@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2019 at 09:02:46PM +0700, Phong Tran wrote:
> On 11/5/19 8:55 PM, Paul E. McKenney wrote:
> > On Tue, Nov 05, 2019 at 08:40:05PM +0700, Phong Tran wrote:
> > > On 10/29/19 4:42 AM, madhuparnabhowmik04@gmail.com wrote:
> > > > From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
> > > > 
> > > > This patch converts NMI-RCU from txt to rst format.
> > > > Also adds NMI-RCU in the index.rst file.
> > > > 
> > > > Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
> > > > -- >   .../RCU/{NMI-RCU.txt => NMI-RCU.rst}          | 53 ++++++++++---------
> > > >    Documentation/RCU/index.rst                   |  1 +
> > > >    2 files changed, 29 insertions(+), 25 deletions(-)
> > > >    rename Documentation/RCU/{NMI-RCU.txt => NMI-RCU.rst} (73%)
> > > > 
> > > > diff --git a/Documentation/RCU/NMI-RCU.txt b/Documentation/RCU/NMI-RCU.rst
> > > > similarity index 73%
> > > > rename from Documentation/RCU/NMI-RCU.txt
> > > > rename to Documentation/RCU/NMI-RCU.rst
> > > > index 881353fd5bff..da5861f6a433 100644
> > > > --- a/Documentation/RCU/NMI-RCU.txt
> > > > +++ b/Documentation/RCU/NMI-RCU.rst
> > > > @@ -1,4 +1,7 @@
> > > > +.. _NMI_rcu_doc:
> > > > +
> > > >    Using RCU to Protect Dynamic NMI Handlers
> > > > +=========================================
> > > >    Although RCU is usually used to protect read-mostly data structures,
> > > > @@ -9,7 +12,7 @@ work in "arch/x86/oprofile/nmi_timer_int.c" and in
> > > >    "arch/x86/kernel/traps.c".
> > > >    The relevant pieces of code are listed below, each followed by a
> > > > -brief explanation.
> > > > +brief explanation.::
> > > there is just a minor ":" redundant in html page.There are some same in this
> > > patch.
> > > eg:
> > >   brief explanation.:
> > > 
> > > Other things look good to me.
> > > 
> > > Tested-by: Phong Tran <tranmanphong@gmail.com>
> > 
> > Thank you, Phong!
> > 
> > I queued a commit to be squashed into Madhuparna's original as shown below
> > which adds your Tested-by and attempts a fix.  Does this work for you?
> 
> Yes, Paul.

Very good, thank you!

							Thanx, Paul

> Regards,
> Phong.
> 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > commit 2c29f1c481f74f5e5aaaab195042f4df6a0b8119
> > Author: Paul E. McKenney <paulmck@kernel.org>
> > Date:   Tue Nov 5 05:51:12 2019 -0800
> > 
> >      squash! Documentation: RCU: NMI-RCU: Converted NMI-RCU.txt to NMI-RCU.rst.
> >      [ paulmck: Apply feedback from Phong Tran. ]
> >      Tested-by: Phong Tran <tranmanphong@gmail.com>
> >      Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > 
> > diff --git a/Documentation/RCU/NMI-RCU.rst b/Documentation/RCU/NMI-RCU.rst
> > index da5861f..1809583 100644
> > --- a/Documentation/RCU/NMI-RCU.rst
> > +++ b/Documentation/RCU/NMI-RCU.rst
> > @@ -12,7 +12,7 @@ work in "arch/x86/oprofile/nmi_timer_int.c" and in
> >   "arch/x86/kernel/traps.c".
> >   The relevant pieces of code are listed below, each followed by a
> > -brief explanation.::
> > +brief explanation::
> >   	static int dummy_nmi_callback(struct pt_regs *regs, int cpu)
> >   	{
> > @@ -21,12 +21,12 @@ brief explanation.::
> >   The dummy_nmi_callback() function is a "dummy" NMI handler that does
> >   nothing, but returns zero, thus saying that it did nothing, allowing
> > -the NMI handler to take the default machine-specific action.::
> > +the NMI handler to take the default machine-specific action::
> >   	static nmi_callback_t nmi_callback = dummy_nmi_callback;
> >   This nmi_callback variable is a global function pointer to the current
> > -NMI handler.::
> > +NMI handler::
> >   	void do_nmi(struct pt_regs * regs, long error_code)
> >   	{
> > @@ -61,7 +61,7 @@ Quick Quiz:
> >   :ref:`Answer to Quick Quiz <answer_quick_quiz_NMI>`
> > -Back to the discussion of NMI and RCU...::
> > +Back to the discussion of NMI and RCU::
> >   	void set_nmi_callback(nmi_callback_t callback)
> >   	{
> > 
