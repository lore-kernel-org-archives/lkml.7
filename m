Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3403BC1749C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 14:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00A8B21928
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 14:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572965121;
	bh=elOS7oU3Uzrb0QZSBMDZbfYxkkCXyUh94uhwmyx7M/g=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=qZAY3YDsQFxsp4B3zHyNx89O9aVC6Bf7UAIAOgUdeU+opXKU+LwoiRTBExVhV206F
	 226A+2NZYr8ZyEbloviQ5dTLIVvViATCCZvpaDtsjOkTe1HZhempQTREWn7NDRsRos
	 +YKDxYYHHEf4vQStGPsd8ZxnFw6qg1dx+0hWnpcI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389584AbfKEOpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 09:45:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:55710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389096AbfKEOpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 09:45:19 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [109.144.209.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1CD021928;
        Tue,  5 Nov 2019 14:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572965118;
        bh=elOS7oU3Uzrb0QZSBMDZbfYxkkCXyUh94uhwmyx7M/g=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=XzfnifJ1w4IykFYiIWw3NoffGHdAJp4Ueu7+d9l8GqEMW0wConA1yGSNUl/vkcYtS
         4elSIWs90DgoT7IHE2xM2akDouK91kTIHDJ5CWURxdxkJHg50Y+NZkdVCRtVWoVMqj
         ycC429SHfhQZbBRxe6l7vgTAPTq5KLoOYi8ivtTo=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id F35B335227C0; Tue,  5 Nov 2019 06:45:15 -0800 (PST)
Date:   Tue, 5 Nov 2019 06:45:15 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Amol Grover <frextrite@gmail.com>
Cc:     Phong Tran <tranmanphong@gmail.com>, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org, joel@joelfernandes.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        madhuparnabhowmik04@gmail.com
Subject: Re: [Linux-kernel-mentees] [PATCH] Documentation: RCU: arrayRCU:
 Converted arrayRCU.txt to arrayRCU.rst
Message-ID: <20191105144515.GS20975@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191028202417.13095-1-madhuparnabhowmik04@gmail.com>
 <ac8da2f5-4cda-8985-ff90-061478a4e2c9@gmail.com>
 <20191105140411.GO20975@paulmck-ThinkPad-P72>
 <20191105143344.GA9069@workstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105143344.GA9069@workstation>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2019 at 08:03:44PM +0530, Amol Grover wrote:
> On Tue, Nov 05, 2019 at 06:04:11AM -0800, Paul E. McKenney wrote:
> > On Tue, Nov 05, 2019 at 08:49:47PM +0700, Phong Tran wrote:
> > > On 10/29/19 3:24 AM, madhuparnabhowmik04@gmail.com wrote:
> > > > From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
> > > > 
> > > > This patch converts arrayRCU from txt to rst format.
> > > > arrayRCU.rst is also added in the index.rst file.
> > > > 
> > > > Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
> > > > ---
> > > >   .../RCU/{arrayRCU.txt => arrayRCU.rst}         | 18 +++++++++++++-----
> > > >   Documentation/RCU/index.rst                    |  1 +
> > > >   2 files changed, 14 insertions(+), 5 deletions(-)
> > > >   rename Documentation/RCU/{arrayRCU.txt => arrayRCU.rst} (91%)
> > > > 
> > > > diff --git a/Documentation/RCU/arrayRCU.txt b/Documentation/RCU/arrayRCU.rst
> > > > similarity index 91%
> > > > rename from Documentation/RCU/arrayRCU.txt
> > > > rename to Documentation/RCU/arrayRCU.rst
> > > > index f05a9afb2c39..ed5ae24b196e 100644
> > > > --- a/Documentation/RCU/arrayRCU.txt
> > > > +++ b/Documentation/RCU/arrayRCU.rst
> > > > @@ -1,5 +1,7 @@
> > > > -Using RCU to Protect Read-Mostly Arrays
> > > > +.. _array_rcu_doc:
> > > > +Using RCU to Protect Read-Mostly Arrays
> > > > +=======================================
> > > >   Although RCU is more commonly used to protect linked lists, it can
> > > >   also be used to protect arrays.  Three situations are as follows:
> > > > @@ -26,6 +28,7 @@ described in the following sections.
> > > 
> > > It will be better to have the cross reference for each situation.
> > > 
> > > Hash Tables
> > > Static Arrays
> > > Resizeable Arrays
> > 
> > Madhuparna, could you please put a patch together creating these
> > cross-references and handling Phong's comments below (probably
> > by getting rid of the "." so that the resulting ":" doesn't look
> > strange)?
> > 
> > Then I will fold that patch into your original commit in -rcu and
> > add Phong's Tested-by.
> > 
> > 							Thanx, Paul
> > 
> > > >   Situation 1: Hash Tables
> > > > +------------------------
> > > >   Hash tables are often implemented as an array, where each array entry
> > > >   has a linked-list hash chain.  Each hash chain can be protected by RCU
> > > > @@ -34,6 +37,7 @@ to other array-of-list situations, such as radix trees.
> > > >   Situation 2: Static Arrays
> > > > +--------------------------
> > > >   Static arrays, where the data (rather than a pointer to the data) is
> > > >   located in each array element, and where the array is never resized,
> > > > @@ -41,11 +45,13 @@ have not been used with RCU.  Rik van Riel recommends using seqlock in
> > > >   this situation, which would also have minimal read-side overhead as long
> > > >   as updates are rare.
> > > > -Quick Quiz:  Why is it so important that updates be rare when
> > > > -	     using seqlock?
> > > > +Quick Quiz:
> > > > +		Why is it so important that updates be rare when using seqlock?
> > > > +:ref:`Answer to Quick Quiz <answer_quick_quiz_seqlock>`
> > > >   Situation 3: Resizeable Arrays
> > > > +------------------------------
> > > >   Use of RCU for resizeable arrays is demonstrated by the grow_ary()
> > > >   function formerly used by the System V IPC code.  The array is used
> > > > @@ -60,7 +66,7 @@ the remainder of the new, updates the ids->entries pointer to point to
> > > >   the new array, and invokes ipc_rcu_putref() to free up the old array.
> > > >   Note that rcu_assign_pointer() is used to update the ids->entries pointer,
> > > >   which includes any memory barriers required on whatever architecture
> > > > -you are running on.
> > > > +you are running on.::
> > > 
> > > a redundant ":" in here with html page.
> > > 
> > > 
> > > 
> > > 
> > > >   	static int grow_ary(struct ipc_ids* ids, int newsize)
> > > >   	{
> > > > @@ -112,7 +118,7 @@ a simple check suffices.  The pointer to the structure corresponding
> > > >   to the desired IPC object is placed in "out", with NULL indicating
> > > >   a non-existent entry.  After acquiring "out->lock", the "out->deleted"
> > > >   flag indicates whether the IPC object is in the process of being
> > > > -deleted, and, if not, the pointer is returned.
> > > > +deleted, and, if not, the pointer is returned.::
> > > 
> > > same as above
> > > 
> > > 
> > > Tested-by: Phong Tran <tranmanphong@gmail.com>
> > > 
> > > Regards,
> > > Phong.
> > > 
> > > >   	struct kern_ipc_perm* ipc_lock(struct ipc_ids* ids, int id)
> > > >   	{
> > > > @@ -144,8 +150,10 @@ deleted, and, if not, the pointer is returned.
> > > >   		return out;
> > > >   	}
> > > > +.. _answer_quick_quiz_seqlock:
> > > >   Answer to Quick Quiz:
> > > > +	Why is it so important that updates be rare when using seqlock?
> > > >   	The reason that it is important that updates be rare when
> > > >   	using seqlock is that frequent updates can livelock readers.
> > > > diff --git a/Documentation/RCU/index.rst b/Documentation/RCU/index.rst
> > > > index 5c99185710fa..8d20d44f8fd4 100644
> > > > --- a/Documentation/RCU/index.rst
> > > > +++ b/Documentation/RCU/index.rst
> > > > @@ -7,6 +7,7 @@ RCU concepts
> > > >   .. toctree::
> > > >      :maxdepth: 3
> > > > +   arrayRCU
> > > >      rcu
> > > >      listRCU
> > > >      UP
> > > > 
> > _______________________________________________
> > Linux-kernel-mentees mailing list
> > Linux-kernel-mentees@lists.linuxfoundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/linux-kernel-mentees
> 
> Hey,
> There are a few instances in the document where words are
> emphasized. Example, -not- in the first paragraph. The 
> previous emphasis was correct wrt txt format, but this
> could be converted to italicize/bold to keep up with the
> reST format. Other than this and what Phong suggested,
> everything looks good!
> 
> Tested-by: Amol Grover <frextrite@gmail.com>

Thank you, Amol!

Madhuparna, could you please also include a fix to the "-not-"
text-emphasis issue (and any other occurrences) that Amol located?

I can then add both Phong's and Amol's Tested-by.

							Thanx, Paul
