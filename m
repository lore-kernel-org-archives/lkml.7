Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8A5C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BCFA20840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551971951;
	bh=+AHp0RucQjCfAIAYJGoA6OeFHqTVPnwS4ZyRJVethww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Yh+fWqwleueEVkYAZ10ir0rAigqUn0UQndesNe7xwUd0GKp2ejqfTor4887XXwLSx
	 eeL2/fz2lsvmeOXtdI9BSUZPX+06vQALkAN1Ddz+G6woF8T1espUG2wAXI63/0p0he
	 kes3Mzn+Xc49k9+Km5DaAMAJkC+MJUIXUFZUKv2I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfCGPTJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 10:19:09 -0500
Received: from mga14.intel.com ([192.55.52.115]:38733 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726259AbfCGPTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 10:19:09 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Mar 2019 07:19:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,451,1544515200"; 
   d="scan'208";a="150180347"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga004.fm.intel.com with ESMTP; 07 Mar 2019 07:19:08 -0800
Date:   Thu, 7 Mar 2019 08:19:38 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Brice Goglin <Brice.Goglin@inria.fr>
Cc:     "Busch, Keith" <keith.busch@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [PATCHv6 07/10] acpi/hmat: Register processor domain to its
 memory
Message-ID: <20190307151938.GC1844@localhost.localdomain>
References: <20190214171017.9362-1-keith.busch@intel.com>
 <20190214171017.9362-8-keith.busch@intel.com>
 <8fb27d2c-2165-7029-6ea1-94fc379b3be7@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fb27d2c-2165-7029-6ea1-94fc379b3be7@inria.fr>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brice,

Please see v7 of this series from last week instead for reviews:

 https://patchwork.kernel.org/cover/10832365/
