Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 438E2C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 06:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15BE720674
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 06:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbfDWGg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 02:36:26 -0400
Received: from mga05.intel.com ([192.55.52.43]:37818 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbfDWGgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 02:36:25 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Apr 2019 23:36:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,384,1549958400"; 
   d="scan'208";a="145036303"
Received: from dixitsau-mobl.gar.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.252.63.40])
  by fmsmga007.fm.intel.com with ESMTP; 22 Apr 2019 23:36:21 -0700
Received: by kekkonen.fi.intel.com (Postfix, from userid 1000)
        id D59DE21E9B; Tue, 23 Apr 2019 09:36:19 +0300 (EEST)
Date:   Tue, 23 Apr 2019 09:36:19 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     MosesChristopher <moseschristopherb@gmail.com>
Cc:     mchehab@kernel.org, gregkh@linuxfoundation.org,
        slongerbeam@gmail.com, p.zabel@pengutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, laurent.pinchart@ideasonboard.com,
        linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] staging: media: use help instead of ---help--- in Kconfig
Message-ID: <20190423063619.7gkbnemmq5xrx6dl@kekkonen.localdomain>
References: <20190420110407.20215-1-moseschristopherb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190420110407.20215-1-moseschristopherb@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 20, 2019 at 11:04:07AM +0000, MosesChristopher wrote:
> From: Moses Christopher <moseschristopherb@gmail.com>
> 
>   - Resolve the following warning from the Kconfig,
>     "WARNING: prefer 'help' over '---help---' for new help texts"
> 
> Signed-off-by: Moses Christopher <moseschristopherb@gmail.com>

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
