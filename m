Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB00C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 21:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E2E42332A
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 21:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730793AbfHUV2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 17:28:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57744 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728062AbfHUV2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 17:28:10 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i0Y95-0005p8-K3; Wed, 21 Aug 2019 23:27:55 +0200
Date:   Wed, 21 Aug 2019 23:27:53 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Luck, Tony" <tony.luck@intel.com>
cc:     Peter Zijlstra <peterz@infradead.org>,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "alan@linux.intel.com" <alan@linux.intel.com>,
        "ricardo.neri-calderon@linux.intel.com" 
        <ricardo.neri-calderon@linux.intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Wu, Qiming" <qi-ming.wu@intel.com>,
        "Kim, Cheol Yong" <cheol.yong.kim@intel.com>,
        "Tanwar, Rahul" <rahul.tanwar@intel.com>
Subject: Re: [PATCH v2 2/3] x86/cpu: Add new Intel Atom CPU model name
In-Reply-To: <20190821201845.GA29589@agluck-desk2.amr.corp.intel.com>
Message-ID: <alpine.DEB.2.21.1908212324580.1983@nanos.tec.linutronix.de>
References: <cover.1565940653.git.rahul.tanwar@linux.intel.com> <83345984845d24b6ce97a32bef21cd0bbdffc86d.1565940653.git.rahul.tanwar@linux.intel.com> <20190820122233.GN2332@hirez.programming.kicks-ass.net> <1D9AE27C-D412-412D-8FE8-51B625A7CC98@intel.com>
 <20190820145735.GW2332@hirez.programming.kicks-ass.net> <20190821201845.GA29589@agluck-desk2.amr.corp.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-392479363-1566422875=:1983"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-392479363-1566422875=:1983
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Wed, 21 Aug 2019, Luck, Tony wrote:
> On Tue, Aug 20, 2019 at 04:57:35PM +0200, Peter Zijlstra wrote:
> > On Tue, Aug 20, 2019 at 12:48:05PM +0000, Luck, Tony wrote:
> > > 
> > > >> +#define INTEL_FAM6_ATOM_AIRMONT_NP    0x75 /* Lightning Mountain */
> > > > 
> > > > What's _NP ?
> > > 
> > > Network Processor. But that is too narrow a descriptor. This is going to be used in
> > > other areas besides networking. 
> > > 
> > > I’m contemplating calling it AIRMONT2
> > 
> > What would describe the special sause that warranted a new SOC? If this
> > thing is marketed as 'Network Processor' then I suppose we can actually
> > use it, esp. if we're going to see this more, like the MID thing -- that
> > lived for a while over multiple uarchs.
> 
> The reasons for allocating a new model number are a mystery.
> I've seen cases where I thought we'd get a new numnber for sure,
> but then just bumped the stepping. I've also seen us allocate a
> new number when it didn't look needed (to me, from my OS perspective).
> 
> As I mentioned above, there are some folks internally that think
> NP == Network Processor is too narrow a pigeonhole for this CPU.
> 
> But _NPAOS (Network Processor And Other Stuff) doesn't sound helpful.
> 
> > Note that for the big cores we added the NNPI thing, which was for
> > Neural Network Processing something.
> 
> I'm sure that we will invent all sorts of strings for the "OPTDIFF"
> part of the name (many of which will only be used once or twice).
> 
> Rationale for "AIRMONT2" is that this is derived from Airmont. So
> you'd expect many model specific bits of code to do the same for
> this as they did for plain AIRMONT. But in a few corner cases there
> will be separate code.
> 
> Perhaps I need to update the rubric that I just added to the
> head on intel-family.h to say that the MICROARCH element may
> be followed by an optional number to differentiate SOCs that
> use essentially the same core, but have different model numbers
> because of SOC differences outside of the core.

Well, that kinda defeats the idea that the MICROARCH element is about the
micro architecture. If the uarch is the same and it's just the SOC which is
different then it would be better to say AIRMONT_CLIENT_V2 or such

Thanks,

	tglx
--8323329-392479363-1566422875=:1983--
