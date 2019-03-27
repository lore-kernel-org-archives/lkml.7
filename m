Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103E8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 01:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE45F2075D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 01:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732266AbfC0BIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 21:08:16 -0400
Received: from mga18.intel.com ([134.134.136.126]:56511 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731701AbfC0BIP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 21:08:15 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Mar 2019 18:08:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,274,1549958400"; 
   d="scan'208";a="155508782"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga002.fm.intel.com with ESMTP; 26 Mar 2019 18:08:14 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 9A0DA301BD4; Tue, 26 Mar 2019 18:08:14 -0700 (PDT)
Date:   Tue, 26 Mar 2019 18:08:14 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/17] x86, lto: Mark all top level asm statements as
 .text
Message-ID: <20190327010814.GR18020@tassilo.jf.intel.com>
References: <20190321220009.29334-1-andi@firstfloor.org>
 <20190321220009.29334-3-andi@firstfloor.org>
 <alpine.DEB.2.21.1903261751490.1789@nanos.tec.linutronix.de>
 <20190326213803.GN18020@tassilo.jf.intel.com>
 <alpine.DEB.2.21.1903262321390.1789@nanos.tec.linutronix.de>
 <20190327005523.bbxxittqf4d5bdz5@two.firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327005523.bbxxittqf4d5bdz5@two.firstfloor.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following up to myself here...

> > If it's the former, then we must backport those fixes.
> > 
> > Could you please verify with the GCC people as you seem to have a
> > reproducer of some sort.
> 
> Okay. I filed https://gcc.gnu.org/bugzilla/show_bug.cgi?id=89839
> 
> I thought I had already done that, but it seems I didn't.

Looks like they think the kernel should be fixed.

 https://gcc.gnu.org/bugzilla/show_bug.cgi?id=89839

             Status|UNCONFIRMED                 |RESOLVED
         Resolution|---                         |INVALID


--- Comment #1 from Andrew Pinski <pinskia at gcc dot gnu.org> ---
No, toplevel inline-asm should never assume what section it is in.


-Andi

