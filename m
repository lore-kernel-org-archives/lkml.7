Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9115CC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 16:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BA1C2053B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 16:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391828AbfISQOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 12:14:35 -0400
Received: from know-smtprelay-omc-7.server.virginmedia.net ([80.0.253.71]:42762
        "EHLO know-smtprelay-omc-7.server.virginmedia.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391814AbfISQOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 12:14:35 -0400
Received: from mail0.xen.dingwall.me.uk ([82.47.84.47])
        by cmsmtp with ESMTPA
        id Az4hiXCT9wGUPAz4ii0U28; Thu, 19 Sep 2019 17:14:32 +0100
X-Originating-IP: [82.47.84.47]
X-Authenticated-User: james.dingwall@blueyonder.co.uk
X-Spam: 0
X-Authority: v=2.3 cv=Kc78TzQD c=1 sm=1 tr=0 a=0bfgdX8EJi0Cr9X0x0jFDA==:117
 a=0bfgdX8EJi0Cr9X0x0jFDA==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=J70Eh1EUuV4A:10
 a=Up2SM8xWjtv0cdOD_0EA:9 a=CjuIK1q_8ugA:10
Received: from localhost (localhost [IPv6:::1])
        by mail0.xen.dingwall.me.uk (Postfix) with ESMTP id A1B3D10B982;
        Thu, 19 Sep 2019 16:14:31 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at dingwall.me.uk
Received: from mail0.xen.dingwall.me.uk ([IPv6:::1])
        by localhost (mail0.xen.dingwall.me.uk [IPv6:::1]) (amavisd-new, port 10024)
        with ESMTP id wIlhLp6unAav; Thu, 19 Sep 2019 16:14:31 +0000 (UTC)
Received: from ubuild.dingwall.me.uk (ubuild.dingwall.me.uk [IPv6:2001:470:695c:302::c0a8:175])
        by dingwall.me.uk (Postfix) with ESMTP id 5AD0D10B97F;
        Thu, 19 Sep 2019 16:14:31 +0000 (UTC)
Received: by ubuild.dingwall.me.uk (Postfix, from userid 1000)
        id 155CFEDBAE; Thu, 19 Sep 2019 16:14:31 +0000 (UTC)
Date:   Thu, 19 Sep 2019 16:14:30 +0000
From:   James Dingwall <james@dingwall.me.uk>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        "Luck, Tony" <tony.luck@intel.com>
Subject: Re: pstore does not work under xen
Message-ID: <20190919161430.GA28042@dingwall.me.uk>
References: <20190919102643.GA9400@dingwall.me.uk>
 <3908561D78D1C84285E8C5FCA982C28F7F472015@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7F472015@ORSMSX115.amr.corp.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CMAE-Envelope: MS4wfAt5r1KnVoDs+eBuRcobGW8ZKcVognsfhZ1lcDZPy0IyOr0Rxz3a4KXoRqU9G4IcYf93ZqXJlOC6C1NPKmcStqOhHzBQKH1ENw6ZV5phg7HdarlGummL
 YwckzAXm6SpNNTdgRJntDi/NW/gQPkOzXZK2PrT6APaRHJkOLzxVpUdWJRdE3dmSaa4ju9C50A3jua03HU4r/fM+kT/560crfYU1RlCk+TMfiICayZyEzrpe
 ecTJVqo7Y+z5AGOir7/SFdVYQqwN4BCJL35QvzYL4V9aDDbUIB+1Wd/HSWdMly2Oc8IhgyxolzSp/+GK3/DiSN+Ydv25NiS2LF3ffgtdx3C2hqi5/PoZrSI8
 8cndDfZYnZXq8802mt1mTmuhi4YHgQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2019 at 03:51:33PM +0000, Luck, Tony wrote:
> > I have been investigating a regression in our environment where pstore 
> > (efi-pstore specifically but I suspect this would affect all 
> > implementations) no longer works after upgrading from a 4.4 to 5.0 
> > kernel when running under xen.  (This is an Ubuntu kernel but I don't 
> > think there are patches which affect this area.)
> 
> I don't have any answer for this ... but want to throw out the idea that
> VMM systems could provide some hypercalls to guests to save/return
> some blob of memory (perhaps the "save" triggers automagically if the
> guest crashes?).
> 
> That would provide a much better pstore back end than relying on emulation
> of EFI persistent variables (which have severe contraints on size, and don't
> support some pstore modes because you can't dynamically update EFI variables
> hundreds of times per second).
> 

For clarification this is a dom0 crash rather than an HVM guest with EFI.  I
should probably have also mentioned the xen verion has changed from 4.8.4 to
4.11.2 in case its behaviour on detection of crashed domain has changed.

(For capturing guest crashes we have enabled xenconsole logging so the
hvc0 log is available in dom0.)

Thanks,
James
