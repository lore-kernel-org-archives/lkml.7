Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32BEC5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 23:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A123C21881
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 23:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbfGCXzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 19:55:08 -0400
Received: from mga05.intel.com ([192.55.52.43]:17632 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbfGCXzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 19:55:08 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2019 16:55:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,449,1557212400"; 
   d="scan'208";a="169293598"
Received: from hao-dev.bj.intel.com (HELO localhost) ([10.238.157.65])
  by orsmga006.jf.intel.com with ESMTP; 03 Jul 2019 16:55:05 -0700
Date:   Thu, 4 Jul 2019 07:38:22 +0800
From:   Wu Hao <hao.wu@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Xu Yilun <yilun.xu@intel.com>, Alan Tull <atull@kernel.org>
Subject: Re: [PATCH 05/15] Documentation: fpga: dfl: add descriptions for
 virtualization and new interfaces.
Message-ID: <20190703233822.GB15825@hao-dev>
References: <20190628004951.6202-1-mdf@kernel.org>
 <20190628004951.6202-6-mdf@kernel.org>
 <20190703175926.GA14649@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703175926.GA14649@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 03, 2019 at 07:59:26PM +0200, Greg KH wrote:
> On Thu, Jun 27, 2019 at 05:49:41PM -0700, Moritz Fischer wrote:
> > From: Wu Hao <hao.wu@intel.com>
> > 
> > This patch adds virtualization support description for DFL based
> > FPGA devices (based on PCIe SRIOV), and introductions to new
> > interfaces added by new dfl private feature drivers.
> > 
> > [mdf@kernel.org: Fixed up to make it work with new reStructuredText docs]
> > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > Signed-off-by: Wu Hao <hao.wu@intel.com>
> > Acked-by: Alan Tull <atull@kernel.org>
> > Signed-off-by: Moritz Fischer <mdf@kernel.org>
> > ---
> >  Documentation/fpga/dfl.rst | 100 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 100 insertions(+)
> 
> This doesn't apply to my tree, where is this file created?

Hi Greg,

From the cover-letter, Moritz mentioned, dfl.txt has been converted to .rst
in linux-next. I think this patch is created on top of that by Moritz.

"Note: I've seen that Mauro touched Documentation/fpga/dfl.rst in linux-next
commit c220a1fae6c5d ("docs: fpga: convert docs to ReST and rename to *.rst")"

Thanks
Hao

> 
> thanks,
> 
> greg k-h
