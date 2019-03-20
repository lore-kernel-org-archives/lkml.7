Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D00C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF7DC2186A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfCTPUp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 11:20:45 -0400
Received: from mga04.intel.com ([192.55.52.120]:60179 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726846AbfCTPUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 11:20:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Mar 2019 08:20:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,249,1549958400"; 
   d="scan'208";a="127080834"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga008.jf.intel.com with ESMTP; 20 Mar 2019 08:20:44 -0700
Received: from FMSMSX110.amr.corp.intel.com (10.18.116.10) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 20 Mar 2019 08:20:44 -0700
Received: from fmsmsx117.amr.corp.intel.com ([169.254.3.142]) by
 FMSMSX110.amr.corp.intel.com ([169.254.14.3]) with mapi id 14.03.0415.000;
 Wed, 20 Mar 2019 08:20:43 -0700
From:   "Jiang, Dave" <dave.jiang@intel.com>
To:     Yue Haibing <yuehaibing@huawei.com>,
        "jdmason@kudzu.us" <jdmason@kudzu.us>,
        "allenbh@gmail.com" <allenbh@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>
Subject: RE: [PATCH -next] ntb: intel: Make intel_ntb3_peer_db_addr static
Thread-Topic: [PATCH -next] ntb: intel: Make intel_ntb3_peer_db_addr static
Thread-Index: AQHU3yZ3uGDKLKo0d0SBvFbL1g+z5aYUonfw
Date:   Wed, 20 Mar 2019 15:20:43 +0000
Message-ID: <112A412BB11A1242B37129D931BCE5348445D71E@fmsmsx117.amr.corp.intel.com>
References: <20190320140812.5952-1-yuehaibing@huawei.com>
In-Reply-To: <20190320140812.5952-1-yuehaibing@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.1.200.107]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Yue Haibing [mailto:yuehaibing@huawei.com]
> Sent: Wednesday, March 20, 2019 7:08 AM
> To: Jiang, Dave <dave.jiang@intel.com>; jdmason@kudzu.us;
> allenbh@gmail.com
> Cc: linux-kernel@vger.kernel.org; linux-ntb@googlegroups.com; YueHaibing
> <yuehaibing@huawei.com>
> Subject: [PATCH -next] ntb: intel: Make intel_ntb3_peer_db_addr static
> 
> From: YueHaibing <yuehaibing@huawei.com>
> 
> Fix sparse warning:
> 
> drivers/ntb/hw/intel/ntb_hw_gen3.c:535:5: warning:
>  symbol 'intel_ntb3_peer_db_addr' was not declared. Should it be static?

For now yes. Thanks!

Acked-by: Dave Jiang <dave.jiang@intel.com>

> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/ntb/hw/intel/ntb_hw_gen3.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ntb/hw/intel/ntb_hw_gen3.c
> b/drivers/ntb/hw/intel/ntb_hw_gen3.c
> index f475b56..c339716 100644
> --- a/drivers/ntb/hw/intel/ntb_hw_gen3.c
> +++ b/drivers/ntb/hw/intel/ntb_hw_gen3.c
> @@ -532,9 +532,9 @@ static int intel_ntb3_mw_set_trans(struct ntb_dev
> *ntb, int pidx, int idx,
>  	return 0;
>  }
> 
> -int intel_ntb3_peer_db_addr(struct ntb_dev *ntb, phys_addr_t *db_addr,
> -				resource_size_t *db_size,
> -				u64 *db_data, int db_bit)
> +static int intel_ntb3_peer_db_addr(struct ntb_dev *ntb, phys_addr_t
> *db_addr,
> +				   resource_size_t *db_size,
> +				   u64 *db_data, int db_bit)
>  {
>  	phys_addr_t db_addr_base;
>  	struct intel_ntb_dev *ndev = ntb_ndev(ntb);
> --
> 2.7.0
> 

