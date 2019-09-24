Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B857C432C2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 12:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47AA02146E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 12:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440944AbfIXMJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 08:09:24 -0400
Received: from mga17.intel.com ([192.55.52.151]:13426 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440932AbfIXMJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 08:09:23 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2019 05:09:23 -0700
X-IronPort-AV: E=Sophos;i="5.64,544,1559545200"; 
   d="scan'208";a="179462836"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2019 05:09:20 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 7FEAA20E30; Tue, 24 Sep 2019 15:09:18 +0300 (EEST)
Date:   Tue, 24 Sep 2019 15:09:18 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Subject: Re: [PATCH v2] media: v4l2-fwnode: fix location of acpi/dsd
 documentation
Message-ID: <20190924120918.GI9467@paasikivi.fi.intel.com>
References: <20190924105038.GH9467@paasikivi.fi.intel.com>
 <1da96f12303328833d4f4064bc127337770bc4a7.1569326471.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1da96f12303328833d4f4064bc127337770bc4a7.1569326471.git.mchehab+samsung@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 09:03:56AM -0300, Mauro Carvalho Chehab wrote:
> This got moved to the firmware-guide.
> 
> Fixes: f2dde1ed0f28 ("Documentation: ACPI: move dsd/graph.txt to firmware-guide/acpi and convert to reST")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

> ---
> 
> v2: 
> 
> - Also replace *.txt -> *.rst. I opted to place the full file names there, as this allows
>   ./scripts/documentation-file-ref-check to check if those files gets renamed. It
>   also helps if some Sphinx would later convert those to hyperlinks (with was
>   already discussed at linux-doc ML, although not implemented yet).
> 
>  drivers/media/v4l2-core/v4l2-fwnode.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-fwnode.c b/drivers/media/v4l2-core/v4l2-fwnode.c
> index 3bd1888787eb..9387dcba8b59 100644
> --- a/drivers/media/v4l2-core/v4l2-fwnode.c
> +++ b/drivers/media/v4l2-core/v4l2-fwnode.c
> @@ -819,8 +819,10 @@ static int v4l2_fwnode_reference_parse(struct device *dev,
>   *
>   * THIS EXAMPLE EXISTS MERELY TO DOCUMENT THIS FUNCTION. DO NOT USE IT AS A
>   * REFERENCE IN HOW ACPI TABLES SHOULD BE WRITTEN!! See documentation under
> - * Documentation/acpi/dsd instead and especially graph.txt,
> - * data-node-references.txt and leds.txt .
> + * Documentation/firmware-guide/acpi/dsd instead and especially
> + * Documentation/firmware-guide/acpi/dsd/graph.rst,
> + * Documentation/firmware-guide/acpi/dsd/data-node-references.rst and
> + * Documentation/firmware-guide/acpi/dsd/leds.rst.
>   *
>   *	Scope (\_SB.PCI0.I2C2)
>   *	{
> -- 
> 2.21.0
> 
> 

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
