Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD344C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 13:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F296020857
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 13:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbfCRN4g convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 09:56:36 -0400
Received: from mga17.intel.com ([192.55.52.151]:14074 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726626AbfCRN4f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 09:56:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Mar 2019 06:56:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,494,1544515200"; 
   d="scan'208";a="308184534"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by orsmga005.jf.intel.com with ESMTP; 18 Mar 2019 06:56:35 -0700
Received: from fmsmsx122.amr.corp.intel.com (10.18.125.37) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 18 Mar 2019 06:56:34 -0700
Received: from fmsmsx124.amr.corp.intel.com ([169.254.8.86]) by
 fmsmsx122.amr.corp.intel.com ([169.254.5.36]) with mapi id 14.03.0415.000;
 Mon, 18 Mar 2019 06:56:34 -0700
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Kangjie Lu <kjlu@umn.edu>
CC:     "Latif, Faisal" <faisal.latif@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] infiniband: i40iw: fix potential NULL pointer
 dereferences
Thread-Topic: [PATCH v2] infiniband: i40iw: fix potential NULL pointer
 dereferences
Thread-Index: AQHU2vxkzdhE0Y3As0aAX3uS/2M7W6YRbOyQ
Date:   Mon, 18 Mar 2019 13:56:34 +0000
Message-ID: <9DD61F30A802C4429A01CA4200E302A7A5A75387@fmsmsx124.amr.corp.intel.com>
References: <9DD61F30A802C4429A01CA4200E302A7A5A6FAA8@fmsmsx124.amr.corp.intel.com>
 <20190315065715.18249-1-kjlu@umn.edu>
In-Reply-To: <20190315065715.18249-1-kjlu@umn.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.1.200.107]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>Subject: [PATCH v2] infiniband: i40iw: fix potential NULL pointer dereferences

Something like "RDMA/i40iw: Handle workqueue allocation failure" is a more appropriate subject line. 
>
>alloc_ordered_workqueue may fail and return NULL.
>The fix captures the failure and handles it properly to avoid potential NULL pointer
>dereferences.
>
>Signed-off-by: Kangjie Lu <kjlu@umn.edu>
>---
>V2: add return value to capture the error code
>---
> drivers/infiniband/hw/i40iw/i40iw.h      |  2 +-
> drivers/infiniband/hw/i40iw/i40iw_cm.c   | 19 ++++++++++++++++---
> drivers/infiniband/hw/i40iw/i40iw_main.c |  5 ++++-
> 3 files changed, 21 insertions(+), 5 deletions(-)
>
The patch itself looks ok to me now. Thanks!

Shiraz
