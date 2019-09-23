Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10E1C4CEC4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 15:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86B0D207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 15:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731950AbfIWPmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 11:42:32 -0400
Received: from know-smtprelay-omc-7.server.virginmedia.net ([80.0.253.71]:36946
        "EHLO know-smtprelay-omc-7.server.virginmedia.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726922AbfIWPmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 11:42:32 -0400
Received: from mail0.xen.dingwall.me.uk ([82.47.84.47])
        by cmsmtp with ESMTPA
        id CQTsith7SwGUPCQTsi32EH; Mon, 23 Sep 2019 16:42:29 +0100
X-Originating-IP: [82.47.84.47]
X-Authenticated-User: james.dingwall@blueyonder.co.uk
X-Spam: 0
X-Authority: v=2.3 cv=Kc78TzQD c=1 sm=1 tr=0 a=0bfgdX8EJi0Cr9X0x0jFDA==:117
 a=0bfgdX8EJi0Cr9X0x0jFDA==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=J70Eh1EUuV4A:10 a=9I5xiGouAAAA:8
 a=-eLxHANBbmb_oKkDmE8A:9 a=CjuIK1q_8ugA:10 a=LsBnDy39Vf0A:10
 a=ARFN2YZ7Uv8kHtb7LS-q:22
Received: from localhost (localhost [IPv6:::1])
        by mail0.xen.dingwall.me.uk (Postfix) with ESMTP id 18DFA10CA22;
        Mon, 23 Sep 2019 15:42:28 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at dingwall.me.uk
Received: from mail0.xen.dingwall.me.uk ([127.0.0.1])
        by localhost (mail0.xen.dingwall.me.uk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PerVI_4dfRsS; Mon, 23 Sep 2019 15:42:27 +0000 (UTC)
Received: from behemoth.dingwall.me.uk (behemoth.dingwall.me.uk [192.168.1.5])
        by dingwall.me.uk (Postfix) with ESMTP id C475110CA1F;
        Mon, 23 Sep 2019 15:42:27 +0000 (UTC)
Received: by behemoth.dingwall.me.uk (Postfix, from userid 1000)
        id A02A7FB41E; Mon, 23 Sep 2019 15:42:27 +0000 (UTC)
Date:   Mon, 23 Sep 2019 15:42:27 +0000
From:   James Dingwall <james@dingwall.me.uk>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Juergen Gross <jgross@suse.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: pstore does not work under xen
Message-ID: <20190923154227.GA11201@dingwall.me.uk>
References: <20190919102643.GA9400@dingwall.me.uk>
 <3908561D78D1C84285E8C5FCA982C28F7F472015@ORSMSX115.amr.corp.intel.com>
 <20190919161430.GA28042@dingwall.me.uk>
 <ae56e2c0-b2d3-835d-04cb-e4404d979859@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae56e2c0-b2d3-835d-04cb-e4404d979859@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CMAE-Envelope: MS4wfE4oXmqyT72QeWAZjbsLM+xkq2Fzt2uZZ4CavCHSUCMke3HBKWCjRix2a1dNwSWendlgndDQHJ3sK/fpcYeYMUJ2OLuHw067b1YrK3kWhpF9ysvKbEj3
 rloE4cCauDbBhNtLWNmUAu7GwegMxcAR+b6qDBeLHokYhm726XJZjPzhd9nEuNTClZqgavqTG4/8uIWIHll+OcVgWrNhBYskLyg/POgTZsfWLbEUKNBo1lko
 0TJUw19whlyLcfkDgNwsQnuWJd/gD7ob75YqXJOOEIx19h9P0cOVTyMWdbh0YRJ54PFGxO/0usYv8jnWZm+MgGWgTVeRc82UthUr0J8NpLPZZUgrElp0/f24
 cPxyLgSPWxbhz4nTTbmcSiTg9ntdxw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2019 at 12:37:40PM -0400, Boris Ostrovsky wrote:
> On 9/19/19 12:14 PM, James Dingwall wrote:
> > On Thu, Sep 19, 2019 at 03:51:33PM +0000, Luck, Tony wrote:
> >>> I have been investigating a regression in our environment where pstore 
> >>> (efi-pstore specifically but I suspect this would affect all 
> >>> implementations) no longer works after upgrading from a 4.4 to 5.0 
> >>> kernel when running under xen.  (This is an Ubuntu kernel but I don't 
> >>> think there are patches which affect this area.)
> >> I don't have any answer for this ... but want to throw out the idea that
> >> VMM systems could provide some hypercalls to guests to save/return
> >> some blob of memory (perhaps the "save" triggers automagically if the
> >> guest crashes?).
> >>
> >> That would provide a much better pstore back end than relying on emulation
> >> of EFI persistent variables (which have severe contraints on size, and don't
> >> support some pstore modes because you can't dynamically update EFI variables
> >> hundreds of times per second).
> >>
> > For clarification this is a dom0 crash rather than an HVM guest with EFI.  I
> > should probably have also mentioned the xen verion has changed from 4.8.4 to
> > 4.11.2 in case its behaviour on detection of crashed domain has changed.
> >
> > (For capturing guest crashes we have enabled xenconsole logging so the
> > hvc0 log is available in dom0.)
> 
> 
> Do you only see this difference between 4.4 and 5.0 when you crash via
> sysrq?
> 
> Because that's where things changed. On 4.4 we seem to be forcing an
> oops, which eventually calls kmsg_dump() and then panic. On 5.0 we call
> panic() directly from sysrq handler. And because Xen's panic notifier
> doesn't return we never get a chance to call kmsg_dump().
> 

Ok, I see that change in 8341f2f222d729688014ce8306727fdb9798d37e.  I 
hadn't tested it any other way before.  Using the null pointer 
de-reference module code at [1] a pstore record is generated as expected 
when the module is loaded (panic_on_oops=1).

I have also tested swapping the kmsg_dump() / 
atomic_notifier_call_chain() around in panic.c and this also results in 
a pstore record being created with sysrq-c.  I don't know if that would 
be an acceptable solution though since it may break behaviour that other 
things depend on.

James

[1] http://ubuntu.5.x6.nabble.com/How-To-Cause-An-Oops-td3681145.html
