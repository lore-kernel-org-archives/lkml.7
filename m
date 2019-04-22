Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA0EDC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 17:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8E2B214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 17:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbfDVRBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 13:01:16 -0400
Received: from mga03.intel.com ([134.134.136.65]:13252 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbfDVRBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 13:01:16 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Apr 2019 10:01:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,382,1549958400"; 
   d="scan'208";a="144735400"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.181])
  by orsmga003.jf.intel.com with ESMTP; 22 Apr 2019 09:56:15 -0700
Date:   Mon, 22 Apr 2019 09:56:15 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Like Xu <like.xu@linux.intel.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: x86: Add Intel CPUID.1F cpuid emulation support
Message-ID: <20190422165615.GD1236@linux.intel.com>
References: <1555915234-2536-1-git-send-email-like.xu@linux.intel.com>
 <20190422155333.GB32647@char.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190422155333.GB32647@char.us.oracle.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 11:53:33AM -0400, Konrad Rzeszutek Wilk wrote:
> On Mon, Apr 22, 2019 at 02:40:34PM +0800, Like Xu wrote:
> > Expose Intel V2 Extended Topology Enumeration Leaf to guest only when
> > host system has multiple software-visible die within each package.
> 
> Is there some doc on this?

It's in recent versions of the SDM, in the massive "Information Returned
by CPUID Instruction" table.
