Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B304C28CC6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 11:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F394260C7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 11:17:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbfFCLRh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 07:17:37 -0400
Received: from mga14.intel.com ([192.55.52.115]:60286 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726701AbfFCLRg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 07:17:36 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jun 2019 04:17:25 -0700
X-ExtLoop1: 1
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 03 Jun 2019 04:17:22 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 03 Jun 2019 14:17:21 +0300
Date:   Mon, 3 Jun 2019 14:17:21 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Emanuel Bennici <benniciemanuel78@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Joe Perches <joe@perches.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH 1/2] pci: shpchp: Correct usage of 'return'
Message-ID: <20190603111721.GB2781@lahna.fi.intel.com>
References: <20190602153804.15063-1-benniciemanuel78@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190602153804.15063-1-benniciemanuel78@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 02, 2019 at 05:38:01PM +0200, Emanuel Bennici wrote:
> Replace 'return(1)' with 'return 1' because return is not a function.
> 
> Signed-off-by: Emanuel Bennici <benniciemanuel78@gmail.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
