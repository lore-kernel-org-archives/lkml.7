Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF99C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 09:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB9AD20684
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 09:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbfDPJrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 05:47:12 -0400
Received: from mga11.intel.com ([192.55.52.93]:57602 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726739AbfDPJrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 05:47:12 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Apr 2019 02:47:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,357,1549958400"; 
   d="scan'208";a="165157658"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 16 Apr 2019 02:47:09 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 16 Apr 2019 12:47:08 +0300
Date:   Tue, 16 Apr 2019 12:47:08 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Gaurav Kohli <gkohli@codeaurora.org>, gregkh@linuxfoundation.org,
        maxime.ripard@bootlin.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmem: core: add NVMEM_SYSFS Kconfig
Message-ID: <20190416094708.GP2654@lahna.fi.intel.com>
References: <20190415164011.2638-1-srinivas.kandagatla@linaro.org>
 <3a66797d-347d-2414-14e1-edbcd7c39ae8@codeaurora.org>
 <20190416093454.GN2654@lahna.fi.intel.com>
 <66c3794b-ee84-f746-e686-e5477b78e981@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66c3794b-ee84-f746-e686-e5477b78e981@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 10:44:01AM +0100, Srinivas Kandagatla wrote:
> As Kohli suggested we could make NVMEM_SYSFS default to y so that the sysfs
> file is available by default like before and user/board specific can decide
> to deselect it.
> 
> Let me know if thats Okay with you, I can spin that in v2.

Yup, that works for me. Thanks!
