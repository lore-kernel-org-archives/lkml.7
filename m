Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3A0C3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 06:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E18E20659
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 06:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbfH3G3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 02:29:06 -0400
Received: from mga02.intel.com ([134.134.136.20]:20770 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbfH3G3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 02:29:06 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2019 23:29:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,446,1559545200"; 
   d="scan'208";a="381910899"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.13.128])
  by fmsmga006.fm.intel.com with ESMTP; 29 Aug 2019 23:29:01 -0700
Date:   Fri, 30 Aug 2019 14:33:26 +0800
From:   Philip Li <philip.li@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Borislav Petkov <bp@suse.de>, kbuild test robot <lkp@intel.com>,
        linux-input@vger.kernel.org,
        Thomas Hellstrom <thellstrom@vmware.com>,
        x86-ml <x86@kernel.org>, linux-tip-commits@vger.kernel.org,
        pv-drivers@vmware.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org,
        tip-bot2 for Thomas Hellstrom <tip-bot2@linutronix.de>,
        Doug Covelli <dcovelli@vmware.com>,
        Ingo Molnar <mingo@redhat.com>,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        kbuild-all@01.org, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [kbuild-all] [tip: x86/vmware] input/vmmouse: Update the
 backdoor call with support for new instructions
Message-ID: <20190830063326.GB2598@intel.com>
References: <156699905611.5321.15444519862547054670.tip-bot2@tip-bot2>
 <201908292325.aLXyyzEx%lkp@intel.com>
 <20190829163353.GC2132@zn.tnic>
 <20190830010349.GD857@intel.com>
 <alpine.DEB.2.21.1908300802390.1938@nanos.tec.linutronix.de>
 <20190830062053.GA2598@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830062053.GA2598@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 02:20:53PM +0800, Philip Li wrote:
> On Fri, Aug 30, 2019 at 08:06:27AM +0200, Thomas Gleixner wrote:
> > Philip,
> > 
> > On Fri, 30 Aug 2019, Philip Li wrote:
> > 
> > > > wanna test trees, I'd suggest simply testing TIP's tip/master branch
> > > > which gets redone on a daily basis instead of testing patches in the
> > > > tip-bot{,2} notification mails.
> > >
> > > Thanks Boris for the input. Besides the repo monitoring, we also check the patches
> > > in mailing lists, and try to apply patch to a suitable base. Do you think we can
> > > skip the mailing list of tip-bot{,2}?
> > 
> > As I just explained in a reply to another random build failure caused by this.
> > 
> > tip-bot2 is a notification mechanism to let people know that a particular
> > patch has been merged into one of the tip tree branches. These mails are
> > also properly threaded most of the time and reply to the patch which was
> > sent to the mailing list.
> > 
> > So yes, randomly picking patches from tip-bot2 is not useful at all. The
> > mails contain the information to which tip branch the patch has been
> > applied, so the only useful information for your bot is to select the
> > branch which got the new patches and start testing on that one.
> thanks for your patience. I just realize we actually block tip-bot, but
> not tip-bot2. I will update the logic to avoid this issue, and we will
> keep monitor for a while to fix new issue if any.
BTW: the related service need some time to be upgraded after code change,
some already fetched patches will continue sending out noisy mails until
they are consumed. Sorry about this.

> 
> > 
> > Thanks,
> > 
> > 	tglx
