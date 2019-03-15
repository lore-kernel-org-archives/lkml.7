Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E43C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 17:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38DDD218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 17:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552672217;
	bh=A5xhj2FEytWRKHeyYO2csICL/EL3s1rTh/48RKr6pRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wcwHKtznTe6RWMwQuxZrTuBtkk08F4sAF2PgUv6m1lLGOI4YgQVAAhhmqrIZbRJWD
	 S1cI+i9XGKSgD8mugE8IHH/DwfzbMHRTx1aHLF5tajO+G4O5qNLDjlkGSMOnMJeMBC
	 beC1/w/4boNul933h8oIk46ku4r6P0FTK4ahAxS8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfCORuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 13:50:16 -0400
Received: from mga18.intel.com ([134.134.136.126]:4025 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbfCORuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 13:50:15 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Mar 2019 10:50:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,482,1544515200"; 
   d="scan'208";a="152724750"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga004.fm.intel.com with ESMTP; 15 Mar 2019 10:50:09 -0700
Date:   Fri, 15 Mar 2019 11:50:57 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Keith Busch <keith.busch@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org,
        Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Brice Goglin <Brice.Goglin@inria.fr>
Subject: Re: [PATCHv8 00/10] Heterogenous memory node attributes
Message-ID: <20190315175049.GA18389@localhost.localdomain>
References: <20190311205606.11228-1-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311205606.11228-1-keith.busch@intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Just wanted to check with you on how we may proceed with this series.
The main feature is exporting new sysfs attributes through driver core,
so I think it makes most sense to go through you unless you'd prefer
this go through a different route.

The proposed interface has been pretty stable for a while now, and we've
received reviews, acks and tests on all patches. Please let me know if
there is anything else you'd like to see from this series, or if you
just need more time to get around to this.

Thanks,
Keith
