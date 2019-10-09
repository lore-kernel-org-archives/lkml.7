Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0E0ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 18:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2896821848
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 18:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731623AbfJISoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 14:44:05 -0400
Received: from smtprelay0072.hostedemail.com ([216.40.44.72]:34834 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731254AbfJISoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 14:44:05 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 1D54C100E86C3;
        Wed,  9 Oct 2019 18:44:04 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: mist32_5d7188b702942
X-Filterd-Recvd-Size: 1584
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Wed,  9 Oct 2019 18:44:02 +0000 (UTC)
Message-ID: <cf1934f2668eea9d35dea1d16bb26cf911d4f831.camel@perches.com>
Subject: Re: [PATCH] x86/mce: Lower throttling MCE messages to warnings
From:   Joe Perches <joe@perches.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Benjamin Berg <bberg@redhat.com>, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Christian Kellner <ckellner@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-edac@vger.kernel.org
Date:   Wed, 09 Oct 2019 11:44:00 -0700
In-Reply-To: <20191009182246.GL10395@zn.tnic>
References: <20191009155424.249277-1-bberg@redhat.com>
         <20191009175608.GK10395@zn.tnic>
         <1dfc2bf57335b7eb9f130cc791db76655fb5b8f4.camel@perches.com>
         <20191009182246.GL10395@zn.tnic>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-10-09 at 20:22 +0200, Borislav Petkov wrote:
> On Wed, Oct 09, 2019 at 11:05:37AM -0700, Joe Perches wrote:
> > Perhaps this should be
> > 
> > 	pr_warn_ratelimited(...)
> > 
> > as the temperature changes can be relatively quick.
> 
> There's already ratelimiting machinery a bit above in the same function.

right, thanks, nevermind...

