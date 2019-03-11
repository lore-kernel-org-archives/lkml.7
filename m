Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F041C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 285092075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfCKNFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:05:51 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:38346 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfCKNFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:05:51 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h3KcE-0004Il-E3; Mon, 11 Mar 2019 14:05:14 +0100
Date:   Mon, 11 Mar 2019 14:05:07 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Pavel Machek <pavel@ucw.cz>
cc:     corbet@lwn.net, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Tony Luck <tony.luck@intel.com>,
        Salvatore Bonaccorso <carnil@debian.org>,
        linux-doc@vger.kernel.org
Subject: Re: [patch] Fix up l1ft documentation was Re: Taking a break - time
 to look back
In-Reply-To: <20190311102109.GA14118@amd>
Message-ID: <alpine.DEB.2.21.1903111403330.1691@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1812200022580.1651@nanos.tec.linutronix.de> <20190102235152.GA24163@amd> <20190311102109.GA14118@amd>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Mar 2019, Pavel Machek wrote:
> On Thu 2019-01-03 00:51:52, Pavel Machek wrote:
> > Hi!
> > 
> > > The next round of speculation-related issues including the scary L1TF
> > > hardware bug was a way more "pleasant" experience to work on. While for
> > > obvious reasons the mitigation development happened behind closed doors in
> > > a smaller group of people, we were at least able to collaborate in a way
> > > which is somehow close to what we are used to.
> > 
> > Ok, I guess L1TF was a lot of fun, and there was not time for a good
> > documentation.
> > 
> > There's admin guide that is written as an advertisment, and

What's advertisement there?

> > unfortunately is slightly "inaccurate" at places (to the point of
> > lying).

Huch? Care to tell what's a lie instead of making bold statements?

Thanks,

	tglx


