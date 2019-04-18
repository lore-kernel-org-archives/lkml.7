Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD35FC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6D9F206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389153AbfDRPCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 11:02:54 -0400
Received: from mga14.intel.com ([192.55.52.115]:12637 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388528AbfDRPCy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 11:02:54 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Apr 2019 08:02:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,366,1549958400"; 
   d="scan'208";a="150471242"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Apr 2019 08:02:53 -0700
Date:   Thu, 18 Apr 2019 08:56:40 -0600
From:   Keith Busch <keith.busch@intel.com>
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     rjw@rjwysocki.net, robert.moore@intel.com, erik.schmauss@intel.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] acpi/hmat: Update acpi_hmat_type enum with
 ACPI_HMAT_TYPE_PROXIMITY
Message-ID: <20190418145640.GA7659@localhost.localdomain>
References: <20190417181310.27613-1-alison.schofield@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417181310.27613-1-alison.schofield@intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 11:13:10AM -0700, Alison Schofield wrote:
> ACPI 6.3 changed the subtable "Memory Subsystem Address Range Structure"
> to "Memory Proximity Domain Attributes Structure".
> 
> Updating and renaming of the structure was included in commit:
> ACPICA: ACPI 6.3: HMAT updates (9a8d961f1ef835b0d338fbe13da03cb424e87ae5)

I was not really happy with that HMAT update. Platforms implementing
6.2's HMAT continue to exist even if 6.3 isn't backward compatible. We
just lost the original subtable definition.
