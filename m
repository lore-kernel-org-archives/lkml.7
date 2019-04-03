Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB7BC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08AEF2082C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbfDCJiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 05:38:03 -0400
Received: from mga06.intel.com ([134.134.136.31]:61192 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbfDCJiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 05:38:03 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Apr 2019 02:38:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,304,1549958400"; 
   d="scan'208";a="333344948"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga006.fm.intel.com with ESMTP; 03 Apr 2019 02:37:59 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id CBAB120892; Wed,  3 Apr 2019 12:37:58 +0300 (EEST)
Date:   Wed, 3 Apr 2019 12:37:58 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH v4 3/5] media: sunxi: Add A10 CSI driver
Message-ID: <20190403093758.z2wlnx5ck6ck36ib@paasikivi.fi.intel.com>
References: <cover.2aba8cbd95630d87f927465cc2beb881936c83d9.1553010938.git-series.maxime.ripard@bootlin.com>
 <bf348ec10d4444dd80eab0caddc4e2d3ce3131d4.1553010938.git-series.maxime.ripard@bootlin.com>
 <20190403091221.qd5ivgcoviazccv7@paasikivi.fi.intel.com>
 <20190403092655.engthyfinpxvndh4@flea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403092655.engthyfinpxvndh4@flea>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 11:26:55AM +0200, Maxime Ripard wrote:
> Hi Sakari,
> 
> On Wed, Apr 03, 2019 at 12:12:21PM +0300, Sakari Ailus wrote:
> > Thanks for the update and my apologies for the late review.
> >
> > On Tue, Mar 19, 2019 at 04:55:46PM +0100, Maxime Ripard wrote:
> > > The older CSI drivers have camera capture interface different from the one
> > > in the newer ones.
> > >
> > > This IP is pretty simple. Some variants (one controller out of two
> > > instances on some SoCs) have an ISP embedded, but there's no code that make
> > > use of it, so we ignored that part for now.
> > >
> > > Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> >
> > Could you add a sub-device for the CSI-2 receiver, please?
> >
> > See e.g. drivers/media/pci/intel/ipu3/ipu3-cio2.c for an example.
> 
> It's confusing, I know, but this isn't a MIPI-CSI receiver. The IP is
> called CSI, but it's only capable of handling parallel and BT656.

Right, for the parallel (or Bt.656) receiver then.

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
