Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96566C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 17:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7488D21842
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 17:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387948AbfGZR5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 13:57:40 -0400
Received: from mga03.intel.com ([134.134.136.65]:65513 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727321AbfGZR5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 13:57:39 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2019 10:57:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,311,1559545200"; 
   d="scan'208";a="198470507"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.41])
  by fmsmga002.fm.intel.com with ESMTP; 26 Jul 2019 10:57:38 -0700
Date:   Fri, 26 Jul 2019 10:57:38 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paul Bolle <pebolle@tiscali.nl>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [VDSO] [x86_32] v5-3-rc1 needs vdso32=0 to get systemd-journald
 running
Message-ID: <20190726175738.GD3188@linux.intel.com>
References: <618de21a4510f20f1b38a894517b5e9011f0da69.camel@tiscali.nl>
 <20190726162044.GA5978@linux.intel.com>
 <349f9bb3f0c56be1ea43789eab10046d044ce960.camel@tiscali.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <349f9bb3f0c56be1ea43789eab10046d044ce960.camel@tiscali.nl>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 07:12:41PM +0200, Paul Bolle wrote:
> Sean Christopherson schreef op vr 26-07-2019 om 09:20 [-0700]:
> > More than likely it's this:
> > 
> > https://lkml.kernel.org/r/20190719170343.GA13680@linux.intel.com
> 
> Yes.
> 
> systemctl --version prints +SECCOMP so I guess systemd-journald has it enabled
> too. So I now know which thread I should check. (The subject of that thread
> contains "[5.2 REGRESSION]", but I'd say "[5.3-rc1 REGRESSION]" would more
> accurate, but whatever.)

Doh, that's my bad.  The commit happened to show up right next to
the v5.2-rc6 tag in the log and I didn't bother checking to see if it was
actually in v5.2.
