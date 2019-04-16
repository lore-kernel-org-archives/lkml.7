Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D947AC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A77782073F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbfDPLBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 07:01:49 -0400
Received: from mga09.intel.com ([134.134.136.24]:12063 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbfDPLBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 07:01:49 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Apr 2019 04:01:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,357,1549958400"; 
   d="scan'208";a="165171621"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 16 Apr 2019 04:01:45 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 16 Apr 2019 14:01:44 +0300
Date:   Tue, 16 Apr 2019 14:01:44 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     gregkh@linuxfoundation.org, maxime.ripard@bootlin.com,
        gkohli@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nvmem: core: add NVMEM_SYSFS Kconfig
Message-ID: <20190416110144.GS2654@lahna.fi.intel.com>
References: <20190416095924.17428-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416095924.17428-1-srinivas.kandagatla@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 10:59:24AM +0100, Srinivas Kandagatla wrote:
> Many nvmem providers are not very keen on having default sysfs
> nvmem entry, as most of the usecases for them are inside kernel
> itself. And in some cases read/writes to some areas in nvmem are
> restricted and trapped at secure monitor level, so accessing them
> from userspace would result in board reboots.
> 
> This patch adds new NVMEM_SYSFS Kconfig to make binary sysfs entry
> an optional one. This provision will give more flexibility to users.
> This patch also moves existing sysfs code to a new file so that its
> not compiled in when its not really required.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
