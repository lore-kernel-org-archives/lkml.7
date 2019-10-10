Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB79BC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFABE218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389823AbfJJI4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 04:56:17 -0400
Received: from mga01.intel.com ([192.55.52.88]:22985 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387890AbfJJI4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 04:56:13 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Oct 2019 01:56:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,279,1566889200"; 
   d="scan'208";a="207147582"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 10 Oct 2019 01:56:10 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id BC1D322C; Thu, 10 Oct 2019 11:56:09 +0300 (EEST)
Date:   Thu, 10 Oct 2019 11:56:09 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     linux-mm@kvack.org, linux-snps-arc@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/3] eldie generated code for folded p4d/pud
Message-ID: <20191010085609.xgwkrbzea253wmfg@black.fi.intel.com>
References: <20191009222658.961-1-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009222658.961-1-vgupta@synopsys.com>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 10:26:55PM +0000, Vineet Gupta wrote:
> Hi,
> 
> This series elides extraneous generate code for folded p4d/pud.
> This came up when trying to remove __ARCH_USE_5LEVEL_HACK from ARC port.
> The code saving are not a while lot, but still worthwhile IMHO.

Agreed.

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
