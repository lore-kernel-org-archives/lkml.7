Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DACC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 05:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C29C2205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 05:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfH2FiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 01:38:25 -0400
Received: from mga17.intel.com ([192.55.52.151]:42102 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725847AbfH2FiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 01:38:24 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2019 22:38:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,442,1559545200"; 
   d="scan'208";a="192843631"
Received: from araj-mobl1.jf.intel.com ([10.254.101.231])
  by orsmga002.jf.intel.com with ESMTP; 28 Aug 2019 22:38:22 -0700
Date:   Wed, 28 Aug 2019 22:38:22 -0700
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Mihai Carabas <mihai.carabas@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jon Grimm <Jon.Grimm@amd.com>, kanth.ghatraju@oracle.com,
        konrad.wilk@oracle.com, patrick.colp@oracle.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        x86-ml <x86@kernel.org>, linux-kernel@vger.kernel.org,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH] x86/microcode: Add an option to reload microcode even if
 revision is unchanged
Message-ID: <20190829053822.GA17646@araj-mobl1.jf.intel.com>
References: <1567056803-6640-1-git-send-email-ashok.raj@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567056803-6640-1-git-send-email-ashok.raj@intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

sorry i added the wrong message id in the commit log. 

https://lore.kernel.org/r/20190824085300.GB16813@zn.tnic/

On Wed, Aug 28, 2019 at 10:33:22PM -0700, Ashok Raj wrote:
> During microcode development, its often required to test different versions
> of microcode. Intel microcode loader enforces loading only if the revision is
> greater than what is currently loaded on the cpu. Overriding this behavior
> allows us to reuse the same revision during development cycles.
> This facilty also allows us to share debug microcode with development
> partners for getting feedback before microcode release.
> 
> Microcode developers should have other ways to check which
> of their internal version is actually loaded. For e.g. checking a
> temporary MSR for instance. In order to reload the same microcode do as
> shown below.
> 
>  # echo 2 > /sys/devices/system/cpu/microcode/reload
> 
>  as root.
> 
> 
> I tested this on top of the parallel ucode load patch
> 
> https://lore.kernel.org/r/1566506627-16536-2-git-send-email-mihai.carabas@oracle.com/

Please update with the following: 

https://lore.kernel.org/r/20190824085300.GB16813@zn.tnic/

Cheers,
Ashok
