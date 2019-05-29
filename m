Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF00C46470
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 07:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E4B9208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 07:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfE2HnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 03:43:16 -0400
Received: from mga02.intel.com ([134.134.136.20]:17550 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726101AbfE2HnQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 03:43:16 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 May 2019 00:43:16 -0700
X-ExtLoop1: 1
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 29 May 2019 00:43:12 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 29 May 2019 10:43:11 +0300
Date:   Wed, 29 May 2019 10:43:11 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     wsa@the-dreams.de, jarkko.nikula@linux.intel.com,
        andriy.shevchenko@linux.intel.com, linux-i2c@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        benjamin.tissoires@redhat.com, jbroadus@gmail.com,
        patches@opensource.cirrus.com
Subject: Re: [PATCH v3 4/6] i2c: core: Move ACPI IRQ handling to probe time
Message-ID: <20190529074311.GU2781@lahna.fi.intel.com>
References: <20190528142900.24147-1-ckeepax@opensource.cirrus.com>
 <20190528142900.24147-4-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528142900.24147-4-ckeepax@opensource.cirrus.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 03:28:58PM +0100, Charles Keepax wrote:
> Bring the ACPI path in sync with the device tree path and handle all the
> IRQ fetching at probe time. This leaves the only IRQ handling at device
> registration time being that which is passed directly through the board
> info as either a resource or an actual IRQ number.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
