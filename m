Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B239C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BC6C2075E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbfDCNfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 09:35:17 -0400
Received: from mga07.intel.com ([134.134.136.100]:31482 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbfDCNfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 09:35:16 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Apr 2019 06:35:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,304,1549958400"; 
   d="scan'208";a="334632378"
Received: from rajeev-desktop.iind.intel.com (HELO intel.com) ([10.223.84.39])
  by fmsmga005.fm.intel.com with ESMTP; 03 Apr 2019 06:35:13 -0700
Date:   Wed, 3 Apr 2019 19:05:11 +0530
From:   Rushikesh S Kadam <rushikesh.s.kadam@intel.com>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     srinivas.pandruvada@linux.intel.com, benjamin.tissoires@redhat.com,
        ncrews@chromium.org, jettrink@chromium.org, gwendal@google.com,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v5] HID: intel-ish-hid: ISH firmware loader client driver
Message-ID: <20190403133510.GA12574@intel.com>
References: <1554184061-2872-1-git-send-email-rushikesh.s.kadam@intel.com>
 <nycvar.YFH.7.76.1904031510430.9803@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1904031510430.9803@cbobk.fhfr.pm>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 03:11:02PM +0200, Jiri Kosina wrote:
> On Tue, 2 Apr 2019, Rushikesh S Kadam wrote:
> 
> > This driver adds support for loading Intel Integrated
> > Sensor Hub (ISH) firmware from host file system to ISH
> > SRAM and start execution.
> > 
> > At power-on, the ISH subsystem shall boot to an interim
> > Shim loader-firmware, which shall expose an ISHTP loader
> > device.
> > 
> > The driver implements an ISHTP client that communicates
> > with the Shim ISHTP loader device over the intel-ish-hid
> > stack, to download the main ISH firmware.
> > 
> > Signed-off-by: Rushikesh S Kadam <rushikesh.s.kadam@intel.com>
> > Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > Acked-by: Nick Crews <ncrews@chromium.org>
> > Tested-by: Jett Rink <jettrink@chromium.org>
> 
> Now queued in for-5.2/ish. Thanks,
> 
> -- 
> Jiri Kosina
> SUSE Labs
> 

Thanks Jirk & all for help with this. 

Rushikesh

-- 
